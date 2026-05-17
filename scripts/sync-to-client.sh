#!/bin/zsh
# sync-to-client.sh
# Sync dubyeol-workflow master to a client git repository.
# CLI: ./scripts/sync-to-client.sh <client-path> [--dry-run] [--force] [--client-name <name>] [--help]

# ── MASTER_ROOT detection (policy.md §4.2, Option D) ──────────────────────────
# Use $DUBYEOL_MASTER_ROOT if set; otherwise derive from script location (macOS-safe)
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
MASTER_ROOT="${DUBYEOL_MASTER_ROOT:-$(dirname "$SCRIPT_DIR")}"
EXCLUDE_FILE="$MASTER_ROOT/.harness/sync-exclude.txt"
# DUBYEOL_SYNC_REPORT_DIR lets callers redirect reports (e.g., task run directories)
SYNC_REPORT_DIR="${DUBYEOL_SYNC_REPORT_DIR:-$MASTER_ROOT/.harness/sync-reports}"

# Directories treated as sync targets — used for conflict detection only.
# rsync syncs everything not excluded; these are checked for client-side modifications.
SYNC_DIRS=(
  01-load-sub-manual
  02-create-task-card
  03-dispatch-to-builder
  04-invoke-plan-review
  05-verify-handoff
  06-invoke-reviewer
  07-invoke-judge
  08-write-final-report
  09-update-project-md
  .harness/templates
  .harness/manuals
)

# ── Usage ──────────────────────────────────────────────────────────────────────
show_usage() {
  cat <<'USAGE'
Usage: ./scripts/sync-to-client.sh <client-path> [options]

Syncs dubyeol-workflow master to a client git repository.

Arguments:
  <client-path>          Path to client git repository (required)

Options:
  --dry-run              Show files that would be synced, without copying
  --force                Back up conflicted files and proceed with sync
  --client-name <name>   Client name label for the sync report
  --help                 Show this usage message

Exit codes:
  0    Success or dry-run complete
  1    Argument or path validation failure
  2    Conflict detected and aborted (use --force to override)
  3    Verification failure (secret/key file detected in sync output)
  127  Required tool missing

Examples:
  ./scripts/sync-to-client.sh /path/to/client --dry-run
  ./scripts/sync-to-client.sh /path/to/client --client-name myproject
  ./scripts/sync-to-client.sh /path/to/client --force --client-name myproject
USAGE
}

# ── Argument parsing ───────────────────────────────────────────────────────────
CLIENT_PATH=""
DRY_RUN=0
FORCE=0
CLIENT_NAME=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --help|-h)
      show_usage
      exit 0
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    --force)
      FORCE=1
      shift
      ;;
    --client-name)
      if [[ $# -lt 2 || -z "$2" ]]; then
        echo "[ERROR] --client-name requires a non-empty value." >&2
        exit 1
      fi
      CLIENT_NAME="$2"
      shift 2
      ;;
    -*)
      echo "[ERROR] Unknown option: $1" >&2
      echo >&2
      show_usage >&2
      exit 1
      ;;
    *)
      if [[ -z "$CLIENT_PATH" ]]; then
        CLIENT_PATH="$1"
      else
        echo "[ERROR] Unexpected argument: $1" >&2
        echo >&2
        show_usage >&2
        exit 1
      fi
      shift
      ;;
  esac
done

# ── Tool check ─────────────────────────────────────────────────────────────────
if ! command -v rsync >/dev/null 2>&1; then
  echo "[ERROR] rsync is required but not found in PATH." >&2
  exit 127
fi

# ── Client path validation ─────────────────────────────────────────────────────

# 1. Argument provided
if [[ -z "$CLIENT_PATH" ]]; then
  echo "[ERROR] Missing required argument: <client-path>" >&2
  echo >&2
  show_usage >&2
  exit 1
fi

# 2. Path exists
if [[ ! -d "$CLIENT_PATH" ]]; then
  echo "[ERROR] Client path does not exist: $CLIENT_PATH" >&2
  exit 1
fi

# Resolve to absolute path (macOS-safe, no GNU readlink -f needed)
CLIENT_PATH=$(cd "$CLIENT_PATH" && pwd)

# 3. .git directory exists
if [[ ! -d "$CLIENT_PATH/.git" ]]; then
  echo "[ERROR] No .git directory found — not a git repository: $CLIENT_PATH" >&2
  exit 1
fi

# 4. Client path is not master root
MASTER_ROOT=$(cd "$MASTER_ROOT" && pwd)
if [[ "$CLIENT_PATH" == "$MASTER_ROOT" ]]; then
  echo "[ERROR] Client path is the same as master root. Cannot sync to itself." >&2
  exit 1
fi

# 5. Forbidden paths: /, $HOME, /tmp and children (including macOS /private/tmp symlink)
REAL_HOME=$(cd "$HOME" && pwd)
case "$CLIENT_PATH" in
  /)
    echo "[ERROR] System root (/) is not a valid client path." >&2
    exit 1
    ;;
  "$REAL_HOME")
    echo "[ERROR] Home directory (\$HOME: $REAL_HOME) is not a valid client path." >&2
    exit 1
    ;;
  /tmp|/tmp/*|/private/tmp|/private/tmp/*)
    echo "[ERROR] /tmp and subdirectories are not valid client paths: $CLIENT_PATH" >&2
    exit 1
    ;;
esac

# 6. Optional additional forbidden paths from SYNC_FORBIDDEN_PATHS (colon-separated)
if [[ -n "${SYNC_FORBIDDEN_PATHS:-}" ]]; then
  for _fp in "${(@s/:/)SYNC_FORBIDDEN_PATHS}"; do
    _fp_abs="$_fp"
    [[ -d "$_fp" ]] && _fp_abs=$(cd "$_fp" && pwd)
    if [[ "$CLIENT_PATH" == "$_fp_abs" ]]; then
      echo "[ERROR] Client path is in SYNC_FORBIDDEN_PATHS: $CLIENT_PATH" >&2
      exit 1
    fi
  done
fi

# ── Conflict detection ─────────────────────────────────────────────────────────
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
CONFLICT_FOUND=0
CONFLICT_FILES_LOG=""
BACKUP_DIR=""

# Collect sync target dirs that already exist in the client (nothing to conflict if absent)
existing_targets=()
for _d in "${SYNC_DIRS[@]}"; do
  [[ -e "$CLIENT_PATH/$_d" ]] && existing_targets+=("$_d")
done

if [[ ${#existing_targets[@]} -gt 0 ]]; then
  # --no-color prevents ANSI codes from breaking the ?? pattern match
  _git_status_raw=$(git --no-color -C "$CLIENT_PATH" status --short -- "${existing_targets[@]}" 2>/dev/null || true)
  # Only treat tracked-but-modified files as conflicts; ignore untracked files (??)
  # Untracked files are newly synced files the client hasn't committed yet — not conflicts.
  _git_status=$(printf '%s\n' "$_git_status_raw" | grep -v '^??' || true)
  if [[ -n "$_git_status" ]]; then
    CONFLICT_FOUND=1
    echo "[WARN] Modified sync-target files detected in client:" >&2
    echo "$_git_status" >&2

    if [[ $FORCE -eq 0 ]]; then
      echo "[ERROR] Conflict detected. Aborting. Use --force to back up and continue." >&2
      exit 2
    fi

    # --force: back up conflicted files before overwriting
    BACKUP_DIR="$CLIENT_PATH/.sync-backups/$TIMESTAMP"
    mkdir -p "$BACKUP_DIR"
    echo "[INFO] Backing up conflicted files → $BACKUP_DIR" >&2
    while IFS= read -r _line; do
      [[ -z "$_line" ]] && continue
      # git status --short: first 2 chars = status codes, char 3 = space, rest = filename
      _rel="${_line:3}"
      _rel="${_rel## }"
      if [[ -f "$CLIENT_PATH/$_rel" ]]; then
        _bak_parent=$(dirname "$BACKUP_DIR/$_rel")
        mkdir -p "$_bak_parent"
        cp "$CLIENT_PATH/$_rel" "$BACKUP_DIR/$_rel"
        CONFLICT_FILES_LOG+="  $_rel"$'\n'
      fi
    done <<< "$_git_status"
    echo "[INFO] Backup complete." >&2
  fi
fi

# ── rsync ──────────────────────────────────────────────────────────────────────
RSYNC_OPTS=(--archive --checksum --human-readable --verbose)
[[ $DRY_RUN -eq 1 ]] && RSYNC_OPTS+=(--dry-run)

# .env.template must be included before the exclude-from rules so .env.* doesn't catch it
RSYNC_OPTS+=(--include=".env.template")

if [[ -f "$EXCLUDE_FILE" ]]; then
  RSYNC_OPTS+=(--exclude-from="$EXCLUDE_FILE")
else
  echo "[WARN] Exclude file not found: $EXCLUDE_FILE — proceeding without exclusions." >&2
fi

if [[ $DRY_RUN -eq 1 ]]; then
  echo "[DRY-RUN] Preview sync: $MASTER_ROOT/ → $CLIENT_PATH/"
else
  echo "[SYNC] $MASTER_ROOT/ → $CLIENT_PATH/"
fi

# Run rsync: tee to terminal (live) and temp file (for report)
_rsync_tmp=$(mktemp)
rsync "${RSYNC_OPTS[@]}" "$MASTER_ROOT/" "$CLIENT_PATH/" 2>&1 | tee "$_rsync_tmp"
RSYNC_EXIT=${pipestatus[1]}
RSYNC_OUTPUT=$(< "$_rsync_tmp")
rm -f "$_rsync_tmp"

if [[ $RSYNC_EXIT -ne 0 ]]; then
  echo "[ERROR] rsync failed (exit $RSYNC_EXIT)." >&2
  exit 1
fi

# ── Post-sync verification (skip on dry-run) ───────────────────────────────────
VERIFY_STATUS="OK"
CHECKSUM_LOG=""
SECRET_FILES_LOG=""

if [[ $DRY_RUN -eq 0 ]]; then
  # Scan sync target directories for secret/key files.
  # .env.template is intentionally excluded from this check.
  for _d in "${SYNC_DIRS[@]}"; do
    [[ ! -d "$CLIENT_PATH/$_d" ]] && continue
    while IFS= read -r -d '' _found; do
      SECRET_FILES_LOG+="  $_found"$'\n'
    done < <(find "$CLIENT_PATH/$_d" \
      -not -path "*/.git/*" \
      -not -name ".env.template" \
      \( -name ".env" -o -name ".env.*" -o -name "*key*" -o -name "*secret*" -o -name "*credentials*" \) \
      -type f -print0 2>/dev/null)
  done

  if [[ -n "$SECRET_FILES_LOG" ]]; then
    echo "[ERROR] Secret/key files detected in sync output:" >&2
    printf "%s" "$SECRET_FILES_LOG" >&2
    VERIFY_STATUS="FAILED"
  fi

  # Representative checksum verification for key skill files
  for _skill_dir in 01-load-sub-manual 02-create-task-card 03-dispatch-to-builder; do
    _skill_file="$_skill_dir/SKILL.md"
    if [[ -f "$MASTER_ROOT/$_skill_file" && -f "$CLIENT_PATH/$_skill_file" ]]; then
      _msum=$(shasum -a 256 "$MASTER_ROOT/$_skill_file" | awk '{print $1}')
      _csum=$(shasum -a 256 "$CLIENT_PATH/$_skill_file" | awk '{print $1}')
      if [[ "$_msum" == "$_csum" ]]; then
        echo "[OK] Checksum match: $_skill_file"
        CHECKSUM_LOG+="  OK: $_skill_file"$'\n'
      else
        echo "[WARN] Checksum mismatch: $_skill_file" >&2
        CHECKSUM_LOG+="  MISMATCH: $_skill_file"$'\n'
      fi
    fi
  done
fi

# ── Sync report ────────────────────────────────────────────────────────────────
mkdir -p "$SYNC_REPORT_DIR"

if [[ $DRY_RUN -eq 1 ]]; then
  REPORT_FILE="$SYNC_REPORT_DIR/sync-report-dryrun-${TIMESTAMP}.md"
  MODE_LABEL="dry-run"
else
  REPORT_FILE="$SYNC_REPORT_DIR/sync-report-${TIMESTAMP}.md"
  MODE_LABEL="실제 sync"
fi

CLIENT_DISPLAY="${CLIENT_NAME:-$(basename "$CLIENT_PATH")}"
DATE_LABEL=$(date '+%Y-%m-%d %H:%M KST')
RSYNC_TAIL=$(printf "%s" "$RSYNC_OUTPUT" | tail -10)

# Pre-compute report sections
if [[ $CONFLICT_FOUND -eq 1 ]]; then
  CONFLICT_SECTION="충돌 감지됨."
  if [[ -n "$BACKUP_DIR" ]]; then
    CONFLICT_SECTION+=$'\n'"백업 위치: $BACKUP_DIR"$'\n'"$CONFLICT_FILES_LOG"
  fi
else
  CONFLICT_SECTION="충돌 없음."
fi

if [[ $DRY_RUN -eq 0 ]]; then
  _checksum_section="${CHECKSUM_LOG:-체크섬 검증 대상 없음 (대상 SKILL.md 미존재)}"
  _secret_section="${SECRET_FILES_LOG:-비밀 파일 없음 (PASS)}"
else
  _checksum_section="dry-run 모드 — 검증 미수행"
  _secret_section="dry-run 모드 — 검증 미수행"
fi

cat > "$REPORT_FILE" <<REPORT
# sync 보고서

**실행 일시**: $DATE_LABEL
**마스터**: $MASTER_ROOT
**클라이언트**: $CLIENT_PATH
**클라이언트 이름**: $CLIENT_DISPLAY
**모드**: $MODE_LABEL
**검증 결과**: $VERIFY_STATUS

## rsync 출력 요약 (마지막 10줄)

\`\`\`
$RSYNC_TAIL
\`\`\`

## 충돌 처리

$CONFLICT_SECTION

## 체크섬 검증

$_checksum_section

## 비밀 파일 감지

$_secret_section
REPORT

echo "[INFO] Report saved: $REPORT_FILE"

# ── Final exit ─────────────────────────────────────────────────────────────────
if [[ "$VERIFY_STATUS" == "FAILED" ]]; then
  echo "[ERROR] Verification failed. See report: $REPORT_FILE" >&2
  exit 3
fi

if [[ $DRY_RUN -eq 1 ]]; then
  echo "[OK] Dry-run complete. No files were copied."
else
  echo "[OK] Sync complete."
fi

exit 0
