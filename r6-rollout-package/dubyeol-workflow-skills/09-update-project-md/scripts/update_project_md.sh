#!/bin/zsh
# update_project_md.sh — PROJECT.md 자동 갱신 (commit 안 함)
# 두별 워크플로우 v3.6.0 r1 베타 — Manus Agent Skill
#
# 호출: zsh 09-update-project-md/scripts/update_project_md.sh <run_id> [--no-interactive]
# 자동 commit 절대 금지 — diff 제시 후 approval-first 원칙. [Owner] 승인 후 별도 commit.

set -e

RUN_ID="${1:?usage: update_project_md.sh <run_id> [--no-interactive]}"
NO_INTERACTIVE=false
if [[ "${2}" == "--no-interactive" ]]; then
  NO_INTERACTIVE=true
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
REPO_ROOT="${REPO_ROOT:-$(dirname "$SKILL_DIR")}"

if [[ ! -d "$REPO_ROOT/.git" ]]; then
    echo "[ERROR] REPO_ROOT is not a git repository: $REPO_ROOT"
    echo "Set REPO_ROOT environment variable or run from within the repository."
    exit 1
fi

RUN_DIR="${REPO_ROOT}/.harness/runs/${RUN_ID}"
TASK_CARD="${RUN_DIR}/task-card.md"
PROJECT_MD="${REPO_ROOT}/PROJECT.md"
BACKUP="${RUN_DIR}/PROJECT-before.md"
DRAFT_FILE="${REPO_ROOT}/tmp/project-md-draft-${RUN_ID}.md"
DIFF_FILE="${RUN_DIR}/project-md-diff.patch"

cd "${REPO_ROOT}"
NOW=$(date "+%Y-%m-%d %H:%M %Z")

if [[ ! -f "${TASK_CARD}" ]]; then
  echo "[ERROR] task-card.md 없음 — ${TASK_CARD}"
  exit 1
fi

if [[ ! -f "${PROJECT_MD}" ]]; then
  echo "[ERROR] PROJECT.md 없음 — ${PROJECT_MD}"
  exit 2
fi

# task-card §10 추출
TASK_CARD_S10=$(sed -n '/## 10\. PROJECT\|## §10\. PROJECT/,/^---\|^## [0-9§]/p' "${TASK_CARD}" | head -60 || true)
if [[ -z "${TASK_CARD_S10}" ]]; then
  echo "[ERROR] task-card §10 PROJECT.md 갱신 사항 비어있음"
  echo "마누스가 §10 수동 채운 후 재실행"
  exit 3
fi

# 백업
cp "${PROJECT_MD}" "${BACKUP}"
echo "[OK] 백업 생성: ${BACKUP}"

# diff-first: 드래프트 파일로 먼저 변경안 생성
mkdir -p "${REPO_ROOT}/tmp"

# §10.1 (§C 모듈 갱신) 추출
SECTION_C_CONTENT=$(echo "${TASK_CARD_S10}" | sed -n '/§10\.1\|§C 모듈\|10\.1/,/§10\.2\|10\.2\|^$/p' | head -20 || true)
# §10.2 (§D 결정 이력) 추출
SECTION_D_CONTENT=$(echo "${TASK_CARD_S10}" | sed -n '/§10\.2\|§D 결정\|10\.2/,/§10\.3\|10\.3\|^---\|^$/p' | head -20 || true)

# 드래프트: 현재 PROJECT.md를 복사 후 §C·§D 적절 위치에 삽입 시도
cp "${PROJECT_MD}" "${DRAFT_FILE}"

# §C 삽입: "## §C" 섹션 끝 또는 파일 끝에 추가
if [[ -n "${SECTION_C_CONTENT}" ]]; then
  if grep -q "^## §C\|^## C\." "${DRAFT_FILE}" 2>/dev/null; then
    # §C 섹션이 존재 — §D 또는 파일 끝 전에 삽입
    awk -v content="<!-- §C 갱신 — Run ${RUN_ID}, ${NOW} -->
${SECTION_C_CONTENT}" '
    /^## §D|^## D\./ { print content; print ""; }
    { print }
    END { if (!found) print content }
    ' "${DRAFT_FILE}" > "${DRAFT_FILE}.tmp" && mv "${DRAFT_FILE}.tmp" "${DRAFT_FILE}"
  else
    # §C 섹션 없음 — 파일 끝에 추가
    printf "\n\n<!-- §C 갱신 — Run %s, %s -->\n%s\n" "${RUN_ID}" "${NOW}" "${SECTION_C_CONTENT}" >> "${DRAFT_FILE}"
  fi
fi

# §D 삽입: §D 결정 이력 추가
if [[ -n "${SECTION_D_CONTENT}" ]]; then
  if grep -q "^## §D\|^## D\." "${DRAFT_FILE}" 2>/dev/null; then
    # §D 섹션 존재 — §E 또는 파일 끝 전에 삽입
    awk -v content="<!-- §D 결정 이력 추가 — Run ${RUN_ID}, ${NOW} -->
${SECTION_D_CONTENT}" '
    /^## §E|^## E\./ { print content; print ""; }
    { print }
    ' "${DRAFT_FILE}" > "${DRAFT_FILE}.tmp" && mv "${DRAFT_FILE}.tmp" "${DRAFT_FILE}"
  else
    printf "\n\n<!-- §D 결정 이력 — Run %s, %s -->\n%s\n" "${RUN_ID}" "${NOW}" "${SECTION_D_CONTENT}" >> "${DRAFT_FILE}"
  fi
fi

# §E 갱신: 마지막 task run ID 및 갱신 시각 업데이트
if grep -q "^## §E\|^## E\.\|마지막 갱신 task" "${DRAFT_FILE}" 2>/dev/null; then
  sed -i.bak \
    -e "s/마지막 갱신 task run ID.*/마지막 갱신 task run ID: ${RUN_ID}/" \
    -e "s/마지막 갱신 일시.*/마지막 갱신 일시: ${NOW}/" \
    "${DRAFT_FILE}" && rm -f "${DRAFT_FILE}.bak"
fi

echo ""
echo "===== [REVIEW REQUIRED] 변경 사항 diff ====="
diff "${PROJECT_MD}" "${DRAFT_FILE}" > "${DIFF_FILE}" 2>&1 || true
diff "${PROJECT_MD}" "${DRAFT_FILE}" || true
echo ""
echo "전체 diff: ${DIFF_FILE}"
echo ""

if [[ "${NO_INTERACTIVE}" == "true" ]]; then
  echo "[non-interactive] --no-interactive 모드: draft 생성만 하고 PROJECT.md 적용하지 않음."
  echo "드래프트: ${DRAFT_FILE}"
  echo "적용하려면 다시 실행 (--no-interactive 없이)"
  exit 0
fi

# approval-first: 마누스 확인 후 적용
echo "===== 다음 행동 (마누스 수동) ====="
echo "1. 위 diff를 검토하세요."
echo "2. 승인하면 Enter를 눌러 PROJECT.md에 적용합니다."
echo "   (Ctrl-C로 중단 — PROJECT.md 변경 없음)"
read -r _CONFIRM

cp "${DRAFT_FILE}" "${PROJECT_MD}"
echo ""
echo "[OK] PROJECT.md 업데이트 완료 (작업 디렉터리)"
echo ""
echo "===== 다음 행동 (마누스 수동) ====="
echo "1. §C.N 모듈·§D 결정 이력 위치를 수동 검토·정리"
echo "2. §E 운영 정보 수동 갱신 (마지막 task ID·갱신 시각)"
echo "3. [Owner]께 PROJECT.md 갱신 사실 + 주요 변경 보고"
echo "4. [Owner] 명시 승인 후 별도 단계로 git commit"
echo ""
echo "===== 거부 시 복원 ====="
echo "cp ${BACKUP} ${PROJECT_MD}"
