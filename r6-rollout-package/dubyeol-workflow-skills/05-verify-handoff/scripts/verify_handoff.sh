#!/bin/zsh
# verify_handoff.sh — handoff 수신 후 10개 항목 자동 검증
# 두별 워크플로우 v3.6.0 r1 베타 — Manus Agent Skill
#
# 호출: zsh 05-verify-handoff/scripts/verify_handoff.sh <run_id>

set -e

RUN_ID="${1:?usage: verify_handoff.sh <run_id>}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
REPO_ROOT="${REPO_ROOT:-$(dirname "$SKILL_DIR")}"

if [[ ! -d "$REPO_ROOT/.git" ]]; then
    echo "[ERROR] REPO_ROOT is not a git repository: $REPO_ROOT"
    echo "Set REPO_ROOT environment variable or run from within the repository."
    exit 1
fi

RUN_DIR="${REPO_ROOT}/.harness/runs/${RUN_ID}"
HANDOFF="${RUN_DIR}/handoff.md"
TASK_CARD="${RUN_DIR}/task-card.md"
REPORT="${RUN_DIR}/handoff-verification.md"

cd "${REPO_ROOT}"

if [ ! -f "${HANDOFF}" ]; then
  echo "ERROR: handoff.md 없음 — ${HANDOFF}"
  exit 1
fi

echo "===== handoff 자동 검증 시작: $(date) =====" | tee "${REPORT}"
echo "Run ID: ${RUN_ID}" | tee -a "${REPORT}"
echo "" | tee -a "${REPORT}"

FAIL_COUNT=0
WARN_COUNT=0

# A. git push 흔적
echo "## A. git push 흔적" | tee -a "${REPORT}"
PUSH_TRACE=$(git reflog 2>&1 | grep -i "push" | head -5 || true)
if [ -z "${PUSH_TRACE}" ]; then
  echo "  [PASS] reflog에 push 흔적 없음" | tee -a "${REPORT}"
else
  echo "  [WARN] reflog에 push 관련 항목:" | tee -a "${REPORT}"
  echo "${PUSH_TRACE}" | sed 's/^/    /' | tee -a "${REPORT}"
  WARN_COUNT=$((WARN_COUNT+1))
fi
echo "" | tee -a "${REPORT}"

# B. 파괴적 git 명령 흔적
echo "## B. 파괴적 git 명령 흔적" | tee -a "${REPORT}"
DESTRUCT=$(git reflog 2>&1 | grep -iE "reset --hard|rebase -i|force|filter-branch|--amend" | head -5 || true)
if [ -z "${DESTRUCT}" ]; then
  echo "  [PASS] 파괴적 git 흔적 없음" | tee -a "${REPORT}"
else
  echo "  [FAIL] reflog에 파괴적 git 흔적:" | tee -a "${REPORT}"
  echo "${DESTRUCT}" | sed 's/^/    /' | tee -a "${REPORT}"
  FAIL_COUNT=$((FAIL_COUNT+1))
fi
echo "" | tee -a "${REPORT}"

# C. 운영 문서 변경
echo "## C. 운영 문서 변경" | tee -a "${REPORT}"
OPS_CHANGED=$(git status --short 2>&1 | grep -E "AGENTS\.md|CLAUDE\.md|PROJECT\.md|\.harness/templates/|SUB-[0-9]" || true)
if [ -z "${OPS_CHANGED}" ]; then
  echo "  [PASS] 운영 문서 변경 없음" | tee -a "${REPORT}"
else
  echo "  [FAIL] 운영 문서 변경 발견:" | tee -a "${REPORT}"
  echo "${OPS_CHANGED}" | sed 's/^/    /' | tee -a "${REPORT}"
  echo "    → [Owner] 명시 승인 없이는 권한 천장 위반" | tee -a "${REPORT}"
  FAIL_COUNT=$((FAIL_COUNT+1))
fi
echo "" | tee -a "${REPORT}"

# D. scope 침범 — task-card §5.2 제외 범위 확인 (수동 점검 안내)
echo "## D. scope 침범 (수동 점검 권고)" | tee -a "${REPORT}"
if [ -f "${TASK_CARD}" ]; then
  echo "  task-card §5.2 제외 범위:" | tee -a "${REPORT}"
  sed -n '/§5.2 제외 범위/,/^## §6\|^## §7\|^### §6/p' "${TASK_CARD}" | head -20 | sed 's/^/    /' | tee -a "${REPORT}"
  echo "  변경 파일 목록 (git status):" | tee -a "${REPORT}"
  git status --short | head -20 | sed 's/^/    /' | tee -a "${REPORT}"
  echo "  [INFO] 위 두 목록 대조하여 마누스 수동 판단" | tee -a "${REPORT}"
else
  echo "  [WARN] task-card 없음 — scope 점검 불가" | tee -a "${REPORT}"
  WARN_COUNT=$((WARN_COUNT+1))
fi
echo "" | tee -a "${REPORT}"

# E. 마스킹 위반 — commit 메시지·diff에서 운송장·BL·키 패턴
echo "## E. 마스킹 위반" | tee -a "${REPORT}"
RECENT_COMMITS=$(git log --since="6 hours ago" --pretty=format:"%H %s" 2>&1 | head -10 || true)

# 운송장 패턴: 10~14자리 숫자
MASK_VIOLATIONS=""
if [ -n "${RECENT_COMMITS}" ]; then
  MASK_VIOLATIONS=$(git log --since="6 hours ago" -p 2>&1 | grep -E "\b[0-9]{10,14}\b|P[0-9]{12,13}|sk-[a-zA-Z0-9]{20,}" | head -5 || true)
fi

if [ -z "${MASK_VIOLATIONS}" ]; then
  echo "  [PASS] 최근 commit에서 마스킹 위반 패턴 미발견" | tee -a "${REPORT}"
else
  echo "  [FAIL] 마스킹 위반 의심 패턴:" | tee -a "${REPORT}"
  echo "${MASK_VIOLATIONS}" | sed 's/^/    /' | tee -a "${REPORT}"
  echo "    → git history 진입 여부 확인 + SUB-4 카테고리 D 처리" | tee -a "${REPORT}"
  FAIL_COUNT=$((FAIL_COUNT+1))
fi
echo "" | tee -a "${REPORT}"

# F. handoff §1 의도 정렬 (마누스 수동 대조 안내)
echo "## F. handoff §1 의도 정렬 (수동 대조 권고)" | tee -a "${REPORT}"
if grep -q "## §1\|## 1\." "${HANDOFF}"; then
  echo "  [INFO] handoff §1 발견. 마누스가 task-card §3과 1:1 매칭 수동 대조" | tee -a "${REPORT}"
  echo "    - 한 문장 목표 일치?" | tee -a "${REPORT}"
  echo "    - Looks Like 항목 일치?" | tee -a "${REPORT}"
  echo "    - Looks Wrong 항목 방어 확인?" | tee -a "${REPORT}"
  echo "    - 가정 중 틀린 것 발견 시 보고?" | tee -a "${REPORT}"
else
  echo "  [WARN] handoff §1 의도 정렬 블록 형식 미발견" | tee -a "${REPORT}"
  WARN_COUNT=$((WARN_COUNT+1))
fi
echo "" | tee -a "${REPORT}"

# G. uncommitted secret 스캔
echo "## G. uncommitted secret 스캔" | tee -a "${REPORT}"
secret_pattern='(api_key|apikey|secret|password|token|credential|private_key).*=.*[A-Za-z0-9+/]{20,}'
SECRET_FOUND=$(git diff HEAD -- . | grep -iE "${secret_pattern}" | grep -v "^-" | head -5 || true)
if [[ -z "${SECRET_FOUND}" ]]; then
  echo "  [PASS] uncommitted 변경에서 민감 패턴 미발견" | tee -a "${REPORT}"
else
  echo "  [WARN] uncommitted 변경에 민감 패턴 의심 항목:" | tee -a "${REPORT}"
  echo "${SECRET_FOUND}" | sed 's/^/    /' | tee -a "${REPORT}"
  echo "    → 마누스 수동 확인 후 [Owner] 보고 검토" | tee -a "${REPORT}"
  WARN_COUNT=$((WARN_COUNT+1))
fi
echo "" | tee -a "${REPORT}"

# H. push 금지 확인
echo "## H. push 금지 확인" | tee -a "${REPORT}"
RECENT_PUSH=$(git log --oneline --since="24 hours ago" 2>&1 | head -3 || true)
echo "  [INFO] 최근 24시간 commit 이력 (push 여부 수동 확인):" | tee -a "${REPORT}"
if [[ -n "${RECENT_PUSH}" ]]; then
  echo "${RECENT_PUSH}" | sed 's/^/    /' | tee -a "${REPORT}"
else
  echo "    최근 commit 없음" | tee -a "${REPORT}"
fi
REMOTE_AHEAD=$(git status 2>&1 | grep "Your branch is ahead" | head -1 || true)
if [[ -n "${REMOTE_AHEAD}" ]]; then
  echo "  [PASS] 로컬 브랜치가 원격보다 앞서있음 (push 미실행 확인)" | tee -a "${REPORT}"
else
  echo "  [INFO] 브랜치 상태 확인 필요 (수동 점검)" | tee -a "${REPORT}"
fi
echo "" | tee -a "${REPORT}"

# I. .env staged 여부
echo "## I. .env staged 여부" | tee -a "${REPORT}"
ENV_STAGED=$(git diff --cached --name-only 2>&1 | grep -iE "\.env|key|secret|credential" | head -5 || true)
if [[ -z "${ENV_STAGED}" ]]; then
  echo "  [PASS] 민감 파일 staged 없음" | tee -a "${REPORT}"
else
  echo "  [FAIL] 민감 파일이 staged 상태:" | tee -a "${REPORT}"
  echo "${ENV_STAGED}" | sed 's/^/    /' | tee -a "${REPORT}"
  echo "    → 즉시 unstage 후 [Owner] 보고" | tee -a "${REPORT}"
  FAIL_COUNT=$((FAIL_COUNT+1))
fi
echo "" | tee -a "${REPORT}"

# J. 파괴적 git 명령 bash history 감지 (선택)
echo "## J. 파괴적 git 명령 감지 (최근 bash history 참고)" | tee -a "${REPORT}"
HIST_DESTRUCT=$(history 2>/dev/null | grep -iE "reset --hard|push --force|git clean -f" | tail -5 || true)
if [[ -z "${HIST_DESTRUCT}" ]]; then
  echo "  [PASS] history에서 파괴적 git 명령 미발견" | tee -a "${REPORT}"
else
  echo "  [WARN] history에서 파괴적 git 명령 의심 항목:" | tee -a "${REPORT}"
  echo "${HIST_DESTRUCT}" | sed 's/^/    /' | tee -a "${REPORT}"
  echo "    → 실행 여부 수동 확인" | tee -a "${REPORT}"
  WARN_COUNT=$((WARN_COUNT+1))
fi
echo "" | tee -a "${REPORT}"

# 종합
echo "===== 검증 종합 =====" | tee -a "${REPORT}"
echo "FAIL: ${FAIL_COUNT}, WARN: ${WARN_COUNT}" | tee -a "${REPORT}"
echo "" | tee -a "${REPORT}"

if [ ${FAIL_COUNT} -gt 0 ]; then
  echo "[차단] FAIL 발견 — handoff 통과 금지" | tee -a "${REPORT}"
  echo "다음: SUB-4 진입 또는 [Owner] 즉시 보고" | tee -a "${REPORT}"
  exit 10
elif [ ${WARN_COUNT} -gt 0 ]; then
  echo "[주의] WARN 발견 — 마누스 추가 점검 후 [Owner] 보고 검토" | tee -a "${REPORT}"
  exit 5
else
  echo "[통과] 10개 항목 모두 PASS" | tee -a "${REPORT}"
  echo "다음: Tier A/B → SUB-3 진입 / Tier C → SUB-5 진입" | tee -a "${REPORT}"
  exit 0
fi
