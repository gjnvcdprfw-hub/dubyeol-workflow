#!/bin/zsh
# update_project_md.sh — PROJECT.md 자동 갱신 (commit 안 함)
# 두별 워크플로우 v3.6.0 r1 베타 — Manus Agent Skill
#
# 호출: bash update_project_md.sh <run_id>
# 자동 commit 절대 금지 — diff 출력만, [Owner] 승인 후 별도 commit

set -e

RUN_ID="${1:?usage: update_project_md.sh <run_id>}"
REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"
RUN_DIR="${REPO_ROOT}/.harness/runs/${RUN_ID}"
TASK_CARD="${RUN_DIR}/task-card.md"
PROJECT_MD="${REPO_ROOT}/PROJECT.md"
BACKUP="${RUN_DIR}/PROJECT-before.md"
DIFF_FILE="${RUN_DIR}/project-md-diff.patch"

cd "${REPO_ROOT}"
NOW=$(date "+%Y-%m-%d %H:%M %Z")

if [ ! -f "${TASK_CARD}" ]; then
  echo "ERROR: task-card.md 없음 — ${TASK_CARD}"
  exit 1
fi

if [ ! -f "${PROJECT_MD}" ]; then
  echo "ERROR: PROJECT.md 없음 — ${PROJECT_MD}"
  exit 2
fi

# task-card §10 추출
TASK_CARD_S10=$(sed -n '/§10\. PROJECT/,/^---\|^$/p' "${TASK_CARD}")
if [ -z "${TASK_CARD_S10}" ]; then
  echo "ERROR: task-card §10 PROJECT.md 갱신 사항 비어있음"
  echo "마누스가 §10 수동 채운 후 재실행"
  exit 3
fi

# 백업
cp "${PROJECT_MD}" "${BACKUP}"
echo "백업 생성: ${BACKUP}"

# §10 내용을 PROJECT.md 끝부분 §C·§D에 추가하는 후크
# (실제 §C.N 모듈 위치는 마누스가 task-card §10.1에 명시했어야 함 — 자동 위치 검색은 위험)

cat >> "${PROJECT_MD}" << UPDATE_EOF

<!-- update-project-md 스킬 자동 추가, ${NOW}, Run ID ${RUN_ID} -->
<!-- 마누스 수동 검토 후 §C·§D 적절 위치로 이동 필요 -->

## [SUB-5 자동 추가 — Run ${RUN_ID}]

${TASK_CARD_S10}

UPDATE_EOF

echo ""
echo "PROJECT.md 갱신 완료 (작업 디렉터리)"
echo ""
echo "===== diff =====" 
git diff "${PROJECT_MD}" > "${DIFF_FILE}" 2>&1 || true
git diff --stat "${PROJECT_MD}" 2>&1 | head -10
echo ""
echo "전체 diff: ${DIFF_FILE}"
echo ""
echo "===== 다음 행동 (마누스 수동) ====="
echo "1. diff 검토: cat ${DIFF_FILE}"
echo "2. 자동 추가된 [SUB-5 자동 추가 ...] 블록을 §C.N 모듈·§D 결정 이력 적절 위치로 *수동 이동*"
echo "3. §E 운영 정보 수동 갱신 (마지막 task ID·갱신 시각)"
echo "4. [Owner]께 PROJECT.md 갱신 사실 + 주요 변경 보고"
echo "5. [Owner] 명시 승인 후 별도 단계로 git commit"
echo ""
echo "===== 거부 시 복원 ====="
echo "cp ${BACKUP} ${PROJECT_MD}"
