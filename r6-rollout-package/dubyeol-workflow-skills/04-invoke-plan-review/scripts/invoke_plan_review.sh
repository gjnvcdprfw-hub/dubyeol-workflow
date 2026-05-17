#!/bin/zsh
# invoke_plan_review.sh — plan-review 호출 (지피티, SUB-2 §2.5)
# 두별 워크플로우 v3.6.0 r1 베타 — Manus Agent Skill
#
# 호출: zsh 04-invoke-plan-review/scripts/invoke_plan_review.sh <run_id>
# 입력 필수 (사전 작성): .harness/runs/<run_id>/plan-review-input.md
# 출력: .harness/runs/<run_id>/plan-review.md

set -e

RUN_ID="${1:?usage: invoke_plan_review.sh <run_id>}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
REPO_ROOT="${REPO_ROOT:-$(dirname "$SKILL_DIR")}"

if [[ ! -d "$REPO_ROOT/.git" ]]; then
    echo "[ERROR] REPO_ROOT is not a git repository: $REPO_ROOT"
    echo "Set REPO_ROOT environment variable or run from within the repository."
    exit 1
fi

RUN_DIR="${REPO_ROOT}/.harness/runs/${RUN_ID}"
INPUT_FILE="${RUN_DIR}/plan-review-input.md"
OUTPUT_FILE="${RUN_DIR}/plan-review.md"
LOG_FILE="${RUN_DIR}/plan-review-exec.log"

# 입력 격리 강제: 입력 파일이 없으면 즉시 오류 종료
if [[ ! -f "${INPUT_FILE}" ]]; then
  echo "[ERROR] 입력 자료 없음 — ${INPUT_FILE}"
  echo "Prerequisite: 마누스가 사전 작성 필요."
  echo "  내용: task-card §1/§3 + plan 본문 + PROJECT.md §C.N"
  echo "  형식: .harness/runs/<run_id>/plan-review-input.md"
  exit 1
fi

if [[ -z "${OPENAI_API_KEY}" ]]; then
  echo "[ERROR] OPENAI_API_KEY 미설정"
  echo "  export OPENAI_API_KEY=<your_key>  # ~/.zshrc 또는 현재 세션에서 설정"
  exit 2
fi

echo "=== plan-review 호출 시작: $(date) ===" | tee "${LOG_FILE}"

# 파일 기반 Python 호출 — heredoc 특수문자 injection 방지
python3 - "${INPUT_FILE}" "${OUTPUT_FILE}" <<'PYEOF' | tee -a "${LOG_FILE}"
import json, os, sys, urllib.request

input_file = sys.argv[1]
output_file = sys.argv[2]

with open(input_file, 'r', encoding='utf-8') as f:
    prompt_content = f.read()

system_prompt = """당신은 [Judge] — Devil's Advocate (plan 검토 시점).

역할:
- 구현 *전* plan 단계 검토. 코드 디테일 없음
- [Builder] writing-plans 산출물을 [Owner] 의도·Looks Wrong·가정과 대조
- 빠진 단계·과도한 단계·검증 안 된 가정 발견

응답 4단:
1. 의도 정렬 — plan이 [Owner] 의도와 정렬되는가?
2. Looks Wrong 방어 — task-card §3 Looks Wrong을 plan이 진짜 방어하는가?
3. 가정 검증 — 가정 중 실제 검증 안 된 것은? (1개 이상 강제 발견)
4. 종합 — Status: 통과 / 수정 권고 / 보류 / 중단

금지:
- 코드 디테일 검토 시도 금지
- 추상적 "괜찮아 보임" 응답 금지
- "가정 다 OK" 같은 무비판 응답 금지 — 항상 의심점 1개 이상"""

api_key = os.environ.get("OPENAI_API_KEY")
payload = {
    "model": "gpt-5.5",
    "messages": [
        {"role": "system", "content": system_prompt},
        {"role": "user", "content": prompt_content}
    ],
    "max_tokens": 3000
}
req = urllib.request.Request(
    "https://api.openai.com/v1/chat/completions",
    data=json.dumps(payload).encode("utf-8"),
    headers={"Authorization": f"Bearer {api_key}", "Content-Type": "application/json"},
    method="POST"
)
try:
    with urllib.request.urlopen(req, timeout=120) as resp:
        data = json.loads(resp.read().decode("utf-8"))
        text = data["choices"][0]["message"]["content"]
        with open(output_file, "w", encoding="utf-8") as f:
            f.write("# plan-review 결과 (지피티, SUB-2 §2.5)\n\n")
            f.write(text)
        print(f"호출 성공. 응답 길이: {len(text)} chars")
        print(f"사용 토큰: {data.get('usage', {})}")
except Exception as e:
    print(f"호출 실패: {e}")
    sys.exit(3)
PYEOF

echo "=== plan-review 호출 종료: $(date) ===" | tee -a "${LOG_FILE}"
echo ""
echo "다음 단계:"
echo "  통과 → [Builder] 구현 진입"
echo "  수정 권고 → [Builder]에 plan 수정 지시 + 재검토"
echo "  보류·중단 → [Owner] 에스컬레이션"
