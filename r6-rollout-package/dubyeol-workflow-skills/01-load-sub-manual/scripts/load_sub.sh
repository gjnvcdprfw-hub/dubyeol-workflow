#!/bin/zsh
# load_sub.sh — SUB-N 매뉴얼 로드 (경로 출력 + 전체 내용 안내)
# 두별 워크플로우 v3.6.0 r1 베타 — Manus Agent Skill
#
# 호출: zsh 01-load-sub-manual/scripts/load_sub.sh <sub_num>
# 예:   zsh 01-load-sub-manual/scripts/load_sub.sh 1   # SUB-1
#       zsh 01-load-sub-manual/scripts/load_sub.sh 2   # SUB-2

set -e

SUB_NUM="${1:?usage: load_sub.sh <sub_num: 1~5>}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
REPO_ROOT="${REPO_ROOT:-$(dirname "$SKILL_DIR")}"

if [[ ! -d "$REPO_ROOT/.git" ]]; then
    echo "[ERROR] REPO_ROOT is not a git repository: $REPO_ROOT"
    echo "Set REPO_ROOT environment variable or run from within the repository."
    exit 1
fi

declare -A SUB_FILES
SUB_FILES[1]="SUB-1-기획의도.md"
SUB_FILES[2]="SUB-2-워크플로우.md"
SUB_FILES[3]="SUB-3-외부감리.md"
SUB_FILES[4]="SUB-4-수정.md"
SUB_FILES[5]="SUB-5-종료.md"

FILE="${SUB_FILES[$SUB_NUM]}"

if [ -z "${FILE}" ]; then
  echo "ERROR: SUB-${SUB_NUM} 없음. 1~5 중 선택"
  exit 1
fi

FULL_PATH="${REPO_ROOT}/${FILE}"

if [ ! -f "${FULL_PATH}" ]; then
  echo "ERROR: 파일 없음 — ${FULL_PATH}"
  exit 2
fi

echo "===== SUB-${SUB_NUM} 매뉴얼 로드 ====="
echo "경로: ${FULL_PATH}"
echo "분량: $(wc -l < "${FULL_PATH}") 줄 / $(wc -c < "${FULL_PATH}") chars"
echo ""
echo "[WARN] 매뉴얼은 *전체 로드* 필수 — 부분만 읽으면 §0 강제력 손실"
echo "아래 명령으로 전체 로드:"
echo "  cat \"${FULL_PATH}\""
echo ""
echo "===== 첫 30줄 미리보기 (참고용 — 전체 로드 후 진입할 것) ====="
head -30 "${FULL_PATH}"
echo ""
echo "===== 진입 안내 ====="
echo "매뉴얼 전체 읽기: cat \"${FULL_PATH}\""
echo "마누스 다음 행동:"
echo "  1. 매뉴얼 전체 로드 (미리보기만 읽으면 §0 강제력 손실)"
echo "  2. §0 강제력 + §1 진입 첫 행동 인지"
echo "  3. [Owner]에 진입 완료 응답"
