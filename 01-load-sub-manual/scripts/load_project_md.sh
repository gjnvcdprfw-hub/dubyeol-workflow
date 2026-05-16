#!/bin/zsh
# load_project_md.sh — PROJECT.md 진입 점검
# 두별 워크플로우 v3.6.0 r1 베타 — Manus Agent Skill

set -e

REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"
FILE="${REPO_ROOT}/PROJECT.md"

if [ ! -f "${FILE}" ]; then
  echo "ERROR: PROJECT.md 없음 — ${FILE}"
  exit 1
fi

echo "===== PROJECT.md 진입 점검 ====="
echo "경로: ${FILE}"
echo "분량: $(wc -l < "${FILE}") 줄"
echo ""
echo "===== §B 현재 분기 목표 ====="
sed -n '/^## §B\|^## B\./,/^## §C\|^## C\./p' "${FILE}" | head -30 || head -50 "${FILE}"
echo ""
echo "===== 진입 안내 ====="
echo "전체 로드: cat \"${FILE}\""
echo "마누스 다음 행동:"
echo "  1. §B 현재 분기 목표 확인"
echo "  2. §C 모듈 지도에서 이번 task 연결 모듈 식별 (§C.N)"
echo "  3. §D 최근 결정 이력 확인"
echo "  4. SUB-1 로드 → 의도 정렬 진입"
