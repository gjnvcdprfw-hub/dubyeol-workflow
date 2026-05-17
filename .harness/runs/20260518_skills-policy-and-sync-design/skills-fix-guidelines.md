# 스킬 수정 가이드라인: 9개 Manus Agent Skills 수정 task 입력

**run ID**: 20260518_skills-policy-and-sync-design  
**작성일시**: 2026-05-18 KST  
**작성자**: [Builder] (클로드코드)  
**상태**: 초안 (SUB-3 감리 전)  
**용도**: 9개 스킬 수정 task의 입력 기준 문서 (본 문서에서 스킬을 수정하지 않음)  
**입력 근거**: G-2 검증 결과 (run ID: 20260518_g2-skills-verification-execution)

---

## 1. 범위와 비범위

### 1.1 본 가이드라인의 범위

- G-2 검증에서 발견된 9개 스킬 공통 결함과 스킬별 결함의 **수정 방향 정의**.
- 후속 9개 스킬 수정 task가 **재해석 없이 바로 사용할 수 있는 기준** 제공.
- `policy.md`에서 확정한 환경변수 정책과 `sync-design.md`의 경로 정책을 스킬 수정에 적용하는 방법.
- 수정 후 검증 방법과 task 순서.

### 1.2 본 가이드라인의 비범위

- 9개 스킬의 SKILL.md 또는 scripts/ 실제 수정 (→ 별도 수정 task).
- `sync-to-client.sh` 실제 구현 (→ 별도 구현 task).
- G-2에서 이미 확인된 양호한 부분 재검토 (9개 핵심 로직, 권한 천장 원칙, 정보 격리 설계는 유지).
- `silkroadhub` 사업 자산 접근.

---

## 2. SKILL.md 호출 경로 정렬 가이드라인

### 2.1 현재 문제

G-2 COMMON-DEFECT-B: SKILL.md에서 `bash scripts/<script>.sh` 형태로 안내하지만, 실제 스크립트는 `<skill-dir>/scripts/`에 위치한다. 저장소 루트에서 실행 시 "No such file or directory" 오류가 발생한다.

### 2.2 수정 방향

각 SKILL.md의 실행 예시를 다음 중 하나로 통일한다:

**방식 A (권고)**: 스킬 디렉토리 기준 상대 경로 명시

```bash
# SKILL.md 예시 (01-load-sub-manual 기준)
cd /path/to/repo
bash 01-load-sub-manual/scripts/load_sub.sh
```

**방식 B**: 실행 디렉토리를 스킬 디렉토리로 이동 후 실행

```bash
cd 01-load-sub-manual
bash scripts/load_sub.sh
```

**권고**: 방식 A. 저장소 루트에서 실행하는 것이 더 일반적이고, 전체 경로가 명시되어 실수 여지가 적다.

### 2.3 적용 대상

모든 9개 스킬의 SKILL.md에서 스크립트 실행 예시를 방식 A로 통일한다.

---

## 3. zsh/bash 런타임 통일 가이드라인

### 3.1 현재 문제

G-2 Reviewer 발견 (finding 4): 스크립트 shebang은 `#!/bin/zsh`이지만 SKILL.md에서는 `bash`로 실행한다.

### 3.2 수정 방향

**결정**: 모든 스킬 scripts를 **zsh 기준**으로 통일한다.

근거:
- 현재 운영 환경이 macOS + zsh이다.
- 마누스의 기본 쉘이 zsh이다.
- shebang을 `#!/bin/zsh`으로 유지하고, SKILL.md 실행 예시도 `zsh`으로 변경한다.

```bash
# 변경 전 (SKILL.md)
bash scripts/load_sub.sh

# 변경 후 (SKILL.md)
zsh 01-load-sub-manual/scripts/load_sub.sh
# 또는 직접 실행 (shebang 사용)
./01-load-sub-manual/scripts/load_sub.sh
```

### 3.3 예외 처리

미래에 bash 호환성이 필요한 경우를 대비해:
- zsh 전용 문법(`=`, `[[` 등)을 최소화하고 POSIX 호환 문법을 우선 사용한다.
- zsh 전용 기능이 필요한 경우 shebang과 함께 주석으로 명시한다.

---

## 4. `REPO_ROOT` 제거 및 루트 감지 가이드라인

### 4.1 현재 문제

G-2 COMMON-DEFECT-A: 9개 스킬 모든 스크립트에 `REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"` 하드코딩. `dubyeol-workflow` 마스터에서 독립 실행 불가, wrong-repo write 위험.

### 4.2 수정 방향 (policy.md §4.2 적용)

모든 스킬 scripts 첫 부분에 다음 패턴을 적용한다:

```zsh
#!/bin/zsh

# REPO_ROOT: 환경변수 우선, 없으면 스크립트 위치 기반 자동 감지
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"         # <skill-dir>/scripts/ → <skill-dir>/
REPO_ROOT="${REPO_ROOT:-$(dirname "$SKILL_DIR")}"  # <skill-dir>/ → repo root

# 검증: REPO_ROOT가 git 저장소인지 확인
if [[ ! -d "$REPO_ROOT/.git" ]]; then
    echo "[ERROR] REPO_ROOT is not a git repository: $REPO_ROOT"
    echo "Set REPO_ROOT environment variable or run from within the repository."
    exit 1
fi
```

### 4.3 기존 하드코딩 제거

각 스크립트에서 다음 패턴을 찾아 제거한다:

```zsh
# 제거 대상 패턴
REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"
# 또는
REPO_ROOT="/Users/twostars/ClaudeAi/dubyeol-workflow"
```

이후 스크립트에서 사용하는 경로를 `$REPO_ROOT` 기준으로 수정한다.

---

## 5. `run_id` 검증 및 출력 경로 제한 가이드라인

### 5.1 현재 문제

G-2 Reviewer 발견 (finding): `run_id` 미검증 시 output path가 의도치 않은 위치를 가리킬 수 있다. 특히 `REPO_ROOT`가 잘못된 경우 wrong-repo write 위험이 있다.

### 5.2 `run_id` 검증 설계

스크립트가 `run_id` 또는 출력 경로를 받는 경우:

```zsh
# run_id 검증 패턴
if [[ -z "$RUN_ID" ]]; then
    echo "[ERROR] RUN_ID is required. Set RUN_ID environment variable."
    exit 1
fi

# 패턴 검증: YYYYMMDD_ 로 시작하는지 확인
if [[ ! "$RUN_ID" =~ ^[0-9]{8}_ ]]; then
    echo "[ERROR] RUN_ID format is invalid: $RUN_ID"
    echo "Expected format: YYYYMMDD_<description>"
    exit 1
fi

# 출력 경로 confinement
OUTPUT_DIR="$REPO_ROOT/.harness/runs/$RUN_ID"
if [[ ! "$OUTPUT_DIR" == "$REPO_ROOT"* ]]; then
    echo "[ERROR] OUTPUT_DIR is outside REPO_ROOT. Aborting."
    exit 1
fi
```

### 5.3 적용 대상 스킬

`.harness/runs/` 또는 `tmp/`에 파일을 쓰는 모든 스킬:
- `02-create-task-card` (task-card 생성)
- `04-invoke-plan-review` (plan-review 결과 저장)
- `06-invoke-reviewer` (reviewer 결과 저장)
- `07-invoke-judge` (judge 결과 저장)
- `08-write-final-report` (final-report 저장)
- `09-update-project-md` (PROJECT.md 수정)

---

## 6. `04`, `06`, `07` 입력 격리 강화 가이드라인

### 6.1 현재 문제

G-2 Reviewer finding 7: `04-invoke-plan-review`, `06-invoke-reviewer`, `07-invoke-judge` scripts는 격리된 입력 파일을 생성하지 않고, 기존 파일의 존재 여부만 확인한다. 입력 격리가 스크립트 수준에서 강제되지 않는다.

### 6.2 수정 방향

**옵션 A (권고)**: 스크립트가 입력 파일 생성을 명시적 사전 조건(prerequisite)으로 문서화하고, 입력 파일이 없으면 즉시 오류로 종료한다.

```zsh
# 04-invoke-plan-review 예시
INPUT_FILE="$REPO_ROOT/.harness/runs/$RUN_ID/plan-review-input.md"

if [[ ! -f "$INPUT_FILE" ]]; then
    echo "[ERROR] Input file not found: $INPUT_FILE"
    echo "Prerequisite: Create $INPUT_FILE before running this script."
    echo "Content should contain the task-card and handoff for review."
    exit 1
fi
```

**옵션 B**: 스크립트가 입력 파일을 자동 생성한다. 단, 자동 생성 내용이 정보 격리 원칙을 깰 수 있어 비권고.

**선택 근거**: Reviewer와 Judge의 입력 격리는 정보 격리 원칙의 핵심이다. 자동 생성보다는 마누스가 명시적으로 입력 파일을 준비하는 방식이 안전하다.

### 6.3 입력 파일 명명 규칙

| 스킬 | 입력 파일명 | 내용 |
|---|---|---|
| `04-invoke-plan-review` | `plan-review-input.md` | task-card + Builder handoff (기술 내용) |
| `06-invoke-reviewer` | `reviewer-input.md` | 스킬 코드, evidence, 기술 결과 (사업 판단 제외) |
| `07-invoke-judge` | `judge-input.md` | task-card 의도, Reviewer 판정 요약 (코드 상세 제외) |

---

## 7. `04`, `06`, `07` Python heredoc 안전성 가이드라인

### 7.1 현재 문제

G-2 Reviewer finding (missed risk): `04-invoke-plan-review`, `06-invoke-reviewer`, `07-invoke-judge`는 shell-expanded heredoc 안에 Python triple-quoted prompt를 삽입한다. 입력 내용에 특수 문자(`'`, `"`, `\`)가 포함되면 heredoc이 malformed되어 오류가 발생하거나 prompt 내용이 의도치 않게 변경될 수 있다.

### 7.2 수정 방향

**권고**: Python heredoc 방식에서 **파일 기반 입력**으로 전환한다.

```zsh
# 변경 전 (heredoc 방식 — 취약)
python3 - <<'PYEOF'
import anthropic
prompt = """
$(cat "$INPUT_FILE")
"""
PYEOF

# 변경 후 (파일 기반 방식 — 안전)
INPUT_CONTENT=$(cat "$INPUT_FILE")
python3 - "$INPUT_FILE" <<'PYEOF'
import sys
import anthropic

input_file = sys.argv[1]
with open(input_file, 'r') as f:
    prompt = f.read()

# ... API 호출
PYEOF
```

또는 Python 스크립트를 별도 파일로 분리한다:

```zsh
# 스크립트에서 Python 파일 호출
python3 "$SCRIPT_DIR/invoke_api.py" --input "$INPUT_FILE" --output "$OUTPUT_FILE"
```

### 7.3 검증 포인트

수정 후 다음을 확인한다:
- 입력 파일에 한국어, 특수문자, 멀티라인 텍스트가 포함된 경우에도 정상 동작하는가.
- heredoc 종료 마커(`PYEOF`)가 입력 내용에 포함된 경우 처리가 되는가.

---

## 8. `09-update-project-md` diff-first·approval-first 가이드라인

### 8.1 현재 문제

G-2 Reviewer finding (10~11) + evidence: `09-update-project-md` 스크립트는 승인 전에 PROJECT.md에 내용을 append한다. §C·§D·§E 자동 배치도 실제로 구현되지 않고 끝에 추가 후 수동 이동을 요구한다.

### 8.2 수정 방향

**diff-first 패턴**:

```zsh
# 1단계: 변경 사항을 임시 파일로 생성
DRAFT_FILE="$REPO_ROOT/tmp/project-md-draft-$RUN_ID.md"
generate_project_md_update > "$DRAFT_FILE"

# 2단계: 마누스에게 diff 제시
echo "[REVIEW REQUIRED] 아래 변경 사항을 검토하세요:"
diff "$REPO_ROOT/PROJECT.md" "$DRAFT_FILE"
echo ""
echo "승인하면 PROJECT.md에 적용합니다. 계속하려면 Enter를 누르세요. (Ctrl-C로 중단)"
read -r CONFIRM

# 3단계: 마누스 확인 후 적용
cp "$DRAFT_FILE" "$REPO_ROOT/PROJECT.md"
echo "[OK] PROJECT.md 업데이트 완료."
```

**approval-first 원칙**:
- 스크립트는 PROJECT.md를 직접 수정하기 전에 반드시 마누스의 확인을 받는다.
- 자동 커밋은 수행하지 않는다 (기존 원칙 유지).
- 비대화형 환경(CI 등)에서는 `--no-interactive` 플래그로 draft만 생성하고 종료한다.

### 8.3 §C·§D·§E 자동 배치

자동 배치 구현 방향:
- `sed`/`awk`로 각 섹션의 위치를 찾아 정확히 삽입한다.
- 섹션이 없는 경우 파일 끝에 추가한다.
- 삽입 위치와 내용을 diff로 먼저 확인한다.

---

## 9. `05-verify-handoff` 강화 가이드라인

### 9.1 현재 문제

G-2 Reviewer finding (P1): `05-verify-handoff`의 기본 점검은 가능하지만, push·파괴적 명령·uncommitted secret 스캔이 강화되어야 한다.

### 9.2 추가 점검 항목 설계

기존 6개 항목(A~F)에 다음을 추가한다:

| 추가 항목 | 점검 방법 | 실패 시 |
|---|---|---|
| **G. uncommitted secret 스캔** | `git diff HEAD` + `grep -i "key\|secret\|password\|token"` | 경고 출력, 마누스 확인 요청 |
| **H. push 금지 확인** | 마지막 git 명령 이력 확인 (가능한 경우) | 경고 출력 |
| **I. `.env` staged 여부** | `git diff --cached --name-only | grep -i ".env\|key\|secret"` | **즉시 중단, 오류** |
| **J. 파괴적 git 명령 감지** | 최근 bash history에서 `reset --hard`, `push --force` 패턴 확인 (선택) | 경고 출력 |

### 9.3 비밀 스캔 구현 패턴

```zsh
# uncommitted 변경에서 민감 패턴 검색
echo "[G] Scanning for potential secrets in uncommitted changes..."
secret_pattern='(api_key|apikey|secret|password|token|credential|private_key).*=.*[A-Za-z0-9+/]{20,}'
if git diff HEAD -- . | grep -iE "$secret_pattern" | grep -v "^-" | grep -q .; then
    echo "[WARN] Potential secret found in uncommitted changes."
    echo "Review the following lines:"
    git diff HEAD -- . | grep -iE "$secret_pattern" | grep -v "^-"
fi
```

---

## 10. `02`·`08` 템플릿 연동 가이드라인

### 10.1 현재 문제

- `02-create-task-card`: `task-card-template.md`가 존재하지만 스크립트는 heredoc으로 독립 생성한다 (DEFECT-02-B).
- `08-write-final-report`: `final-report-template.md`가 존재하지만 실제 사용하지 않는다 (DEFECT-08-B).

### 10.2 수정 방향

**옵션 A (권고)**: 템플릿을 직접 사용한다.

```zsh
# 02-create-task-card 예시
TEMPLATE="$REPO_ROOT/.harness/templates/task-card-template.md"
OUTPUT="$REPO_ROOT/.harness/runs/$RUN_ID/task-card.md"

if [[ ! -f "$TEMPLATE" ]]; then
    echo "[ERROR] Template not found: $TEMPLATE"
    exit 1
fi

# 템플릿 복사 후 변수 치환
sed \
  -e "s/{{RUN_ID}}/$RUN_ID/g" \
  -e "s/{{DATE}}/$(date '+%Y-%m-%d')/g" \
  "$TEMPLATE" > "$OUTPUT"
```

**옵션 B**: 템플릿 참조 claim을 제거하고 heredoc 독립 생성을 공식화한다. 단, 템플릿과 실제 생성 내용 간 drift가 발생할 수 있어 비권고.

### 10.3 템플릿 변수 규칙

| 변수 | 의미 |
|---|---|
| `{{RUN_ID}}` | 현재 run ID |
| `{{DATE}}` | 작성 날짜 (YYYY-MM-DD) |
| `{{TASK_TITLE}}` | task 제목 |
| `{{TIER}}` | Tier (A/B/C) |
| `{{CATEGORY}}` | 두별 워크트리 카테고리 (1~5) |

---

## 11. 9개 스킬 수정 방향 테이블 (G-2 evidence 근거)

| # | 스킬 | G-2 판정 | 우선순위 | 수정 방향 | G-2 evidence 근거 |
|---:|---|---|---|---|---|
| 1 | `01-load-sub-manual` | PARTIAL PASS | P0 | `REPO_ROOT` 하드코딩 제거 + 스크립트 경로 정렬 | COMMON-DEFECT-A·B, DEFECT-01-C (전체 로드 미수행) |
| 2 | `02-create-task-card` | PARTIAL PASS | P0 | `REPO_ROOT` 제거 + 템플릿 직접 사용 + §11 섹션 추가 | COMMON-DEFECT-A, DEFECT-02-B·C |
| 3 | `03-dispatch-to-builder` | PARTIAL PASS | P0 | `REPO_ROOT` 제거 + references/ 파일 작성 | COMMON-DEFECT-A·B, DEFECT-03-B |
| 4 | `04-invoke-plan-review` | PARTIAL PASS | P0 | `REPO_ROOT` 제거 + 입력 격리 강제 + Python heredoc → 파일 기반 | COMMON-DEFECT-A, Reviewer finding 7, missing risk |
| 5 | `05-verify-handoff` | PARTIAL PASS | P1 | `REPO_ROOT` 제거 + uncommitted secret 스캔 + push 확인 강화 | COMMON-DEFECT-A, Reviewer finding (P1) |
| 6 | `06-invoke-reviewer` | PARTIAL PASS | P0 | `REPO_ROOT` + PATH 하드코딩 제거 + references/ 작성 + Python heredoc → 파일 기반 | COMMON-DEFECT-A, DEFECT-06-B·C, missing risk |
| 7 | `07-invoke-judge` | PARTIAL PASS | P0 | `REPO_ROOT` 제거 + references/ 작성 + Python heredoc → 파일 기반 | COMMON-DEFECT-A, DEFECT-07-B, missing risk |
| 8 | `08-write-final-report` | PARTIAL PASS | P1 | `REPO_ROOT` 제거 + 템플릿 직접 사용 + extract_section 안정성 개선 | COMMON-DEFECT-A, DEFECT-08-B·C |
| 9 | `09-update-project-md` | PARTIAL PASS | P0 | `REPO_ROOT` 제거 + diff-first·approval-first 전환 + §C·§D·§E 자동 배치 구현 | COMMON-DEFECT-A, DEFECT-09-B, Reviewer finding 10~11 |

---

## 12. 후속 task 순서 (명시적, [Owner] 정정 우선)

본 정책+sync 설계서의 초안 권고 순서는 참고용이며, 실제 운영 순서는 [Owner]가 운영 인프라 의존성 위에서 재결정한다. [Owner] 정정에 따라 후속 task 순서는 다음과 같다.

| 순서 | task | 내용 | 선행 조건 |
|---:|---|---|---|
| 1 | **Task 2 — sync 스크립트 구현 task** | `sync-design.md` 기반으로 `sync-to-client.sh` 실제 구현. 우선 dry-run 중심으로 정책 검증 수단을 확보한다. | 본 설계 task 종료 |
| 2 | **Task 3 — 9개 스킬 수정 task** | 본 가이드라인 기반으로 9개 스킬 SKILL.md + scripts 수정. P0 항목 우선. | sync 구현 또는 dry-run 검증 인프라 확보 |
| 2 | **r7 정비** | 회고 1~34 일괄 반영, 운영 문서 정비, 감리 대체 절차 명문화. 9개 스킬 수정 task와 동시 진행 가능. | 본 설계 task 종료, [Owner] 별도 task-card 승인 |
| 3 | **Task 4 — silkroadhub 첫 클라이언트 적용 task** | sync 실행 및 동작 확인. silkroadhub 사업 자산 손대지 않음. | sync 구현 완료 및 9개 스킬 수정 결과 준비 |
| 4 | **Task 5 — G-2 v2 또는 부분 재검증** | 수정된 9개 스킬과 client 적용 경로 재검증. | Task 3·Task 4 완료 |

### 12.1 순서 근거 ([Owner] 정정 반영)

sync 구현은 단순 배포 수단이 아니라 정책 검증 수단이다. 실제 sync를 강제하지 않아도 dry-run 모드로 경로 검증, 제외 규칙, 충돌 처리, 비밀 파일 차단 설계를 안전하게 검증할 수 있다. 9개 스킬 수정 결과를 silkroadhub로 전달하려면 sync 인프라가 먼저 작동해야 하므로, sync 구현을 Task 2로 우선 진행한다.

9개 스킬 수정과 r7 정비는 직접 수정 대상이 상당히 분리되어 있다. Task 3은 SKILL.md와 scripts 중심이고, r7은 AGENTS.md·SUB 매뉴얼·PROJECT.md 등 운영 문서 중심이다. 따라서 두 task는 [Owner] 별도 task-card 아래에서 동시 진행 가능하다.

silkroadhub 적용은 sync 구현과 9개 스킬 수정 결과가 준비된 뒤 진행해야 한다. G-2 v2 또는 부분 재검증은 실제 수정과 적용 경로가 마련된 뒤 의미가 있다.

---

**스킬 수정 가이드라인 끝.**
