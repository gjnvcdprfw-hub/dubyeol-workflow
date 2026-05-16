#!/bin/zsh
# invoke_plan_review.sh — plan-review 호출 (지피티, SUB-2 §2.5)
# 두별 워크플로우 v3.6.0 r1 베타 — Manus Agent Skill
#
# 호출: bash invoke_plan_review.sh <run_id>
# 입력: .harness/runs/<run_id>/plan-review-input.md
# 출력: .harness/runs/<run_id>/plan-review.md

set -e

RUN_ID="${1:?usage: invoke_plan_review.sh <run_id>}"

REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"
RUN_DIR="${REPO_ROOT}/.harness/runs/${RUN_ID}"
INPUT_FILE="${RUN_DIR}/plan-review-input.md"
OUTPUT_FILE="${RUN_DIR}/plan-review.md"
LOG_FILE="${RUN_DIR}/plan-review-exec.log"

cd "${REPO_ROOT}"

if [ ! -f "${INPUT_FILE}" ]; then
  echo "ERROR: 입력 자료 없음 — ${INPUT_FILE}"
  echo "마누스 사전 작성 필요: task-card §1/§3 + plan 본문 + PROJECT.md §C.N"
  exit 1
fi

if [ -z "${OPENAI_API_KEY}" ]; then
  echo "ERROR: OPENAI_API_KEY 미설정 — source scripts/load_openai_key.sh 먼저"
  exit 2
fi

echo "=== plan-review 호출 시작: $(date) ===" | tee "${LOG_FILE}"

SYSTEM_PROMPT='당신은 silkroadhub의 [Judge] — Devil"'"'"'s Advocate (plan 검토 시점).

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
- "가정 다 OK" 같은 무비판 응답 금지 — 항상 의심점 1개 이상'

PROMPT_CONTENT=$(cat "${INPUT_FILE}")

python3 << PYEOF | tee -a "${LOG_FILE}"
import json, os, urllib.request

api_key = os.environ.get("OPENAI_API_KEY")
payload = {
    "model": "gpt-5.5",
    "messages": [
        {"role": "system", "content": """${SYSTEM_PROMPT}"""},
        {"role": "user", "content": """${PROMPT_CONTENT}"""}
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
        with open("${OUTPUT_FILE}", "w") as f:
            f.write("# plan-review 결과 (지피티, SUB-2 §2.5)\n\n")
            f.write(text)
        print(f"호출 성공. 응답 길이: {len(text)} chars")
        print(f"사용 토큰: {data.get('usage', {})}")
except Exception as e:
    print(f"호출 실패: {e}")
    exit(3)
PYEOF

echo "=== plan-review 호출 종료: $(date) ===" | tee -a "${LOG_FILE}"
echo ""
echo "다음 단계:"
echo "  통과 → [Builder] 구현 진입"
echo "  수정 권고 → [Builder]에 plan 수정 지시 + 재검토"
echo "  보류·중단 → [Owner] 에스컬레이션"
