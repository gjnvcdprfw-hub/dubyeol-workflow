#!/bin/zsh
# invoke_reviewer.sh — [Reviewer] 호출 (코덱스 우선, 지피티 폴백)
# 두별 워크플로우 v3.6.0 r1 베타 — Manus Agent Skill
#
# 호출: bash invoke_reviewer.sh <run_id>
# 입력: .harness/runs/<run_id>/reviewer-input.md (마누스가 사전 작성)
# 출력: .harness/runs/<run_id>/reviewer-raw.md + codex-exec.log

set -e

RUN_ID="${1:?usage: invoke_reviewer.sh <run_id>}"

REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"
RUN_DIR="${REPO_ROOT}/.harness/runs/${RUN_ID}"
INPUT_FILE="${RUN_DIR}/reviewer-input.md"
OUTPUT_FILE="${RUN_DIR}/reviewer-raw.md"
LOG_FILE="${RUN_DIR}/codex-exec.log"

cd "${REPO_ROOT}"

# 입력 자료 점검
if [ ! -f "${INPUT_FILE}" ]; then
  echo "ERROR: 입력 자료 없음 — ${INPUT_FILE}"
  echo "마누스가 사전 작성 필요: handoff §2.2 변경 파일·§3 진행 이력·diff 발췌·task-card §5"
  exit 1
fi

echo "=== [Reviewer] 호출 시작: $(date) ===" | tee "${LOG_FILE}"
echo "Run ID: ${RUN_ID}" | tee -a "${LOG_FILE}"

# === 1차: 코덱스 시도 ===
echo "" | tee -a "${LOG_FILE}"
echo "1차 시도: 코덱스 ([Reviewer] 표준 도구)" | tee -a "${LOG_FILE}"

export PATH="/Users/twostars/.local/node/bin:$PATH"
source ~/.zshrc 2>/dev/null || true

CODEX_MAX_RETRY=2
CODEX_OK=false

for attempt in $(seq 1 ${CODEX_MAX_RETRY}); do
  echo "코덱스 시도 ${attempt}/${CODEX_MAX_RETRY}" | tee -a "${LOG_FILE}"

  codex exec --sandbox read-only --output-last-message \
    - < "${INPUT_FILE}" > "${OUTPUT_FILE}.tmp" 2>> "${LOG_FILE}" && {
    mv "${OUTPUT_FILE}.tmp" "${OUTPUT_FILE}"
    CODEX_OK=true
    break
  }

  echo "코덱스 시도 ${attempt} 실패" | tee -a "${LOG_FILE}"
  rm -f "${OUTPUT_FILE}.tmp"
  sleep 3
done

if [ "${CODEX_OK}" = "true" ]; then
  echo "" | tee -a "${LOG_FILE}"
  echo "코덱스 호출 성공" | tee -a "${LOG_FILE}"
  head -5 "${OUTPUT_FILE}" | tee -a "${LOG_FILE}"
  echo "=== [Reviewer] 호출 종료: $(date) ===" | tee -a "${LOG_FILE}"
  echo ""
  echo "다음: gate-review.md §1 작성 (마누스)"
  exit 0
fi

# === 2차: 지피티 폴백 ===
echo "" | tee -a "${LOG_FILE}"
echo "코덱스 ${CODEX_MAX_RETRY}회 시도 모두 실패. 지피티 폴백 진입." | tee -a "${LOG_FILE}"
echo "⚠️  폴백 진입 — [Owner] 보고 필요. gate-review.md §1.1에 폴백 사실 명시 의무" | tee -a "${LOG_FILE}"

if [ -z "${OPENAI_API_KEY}" ]; then
  echo "ERROR: OPENAI_API_KEY 미설정 — source scripts/load_openai_key.sh 먼저" | tee -a "${LOG_FILE}"
  exit 2
fi

PROMPT_CONTENT=$(cat "${INPUT_FILE}")
SYSTEM_PROMPT="당신은 silkroadhub의 [Reviewer] 폴백 세션입니다. 코덱스 불가로 임시 대체. 코드·기술 정합성만 감사하세요. 사업·기획 판단 금지. 입력 자료의 코드·diff·기술 명세를 봐서 통과/조건부 통과/보류/차단 중 하나 판정. 구체 파일·라인 근거 명시 필수."

python3 << PYEOF | tee -a "${LOG_FILE}"
import json, os, urllib.request

api_key = os.environ.get("OPENAI_API_KEY")
payload = {
    "model": "gpt-5.5",
    "messages": [
        {"role": "system", "content": """${SYSTEM_PROMPT}"""},
        {"role": "user", "content": """${PROMPT_CONTENT}"""}
    ],
    "max_tokens": 4000
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
            f.write("# [Reviewer] 폴백 (지피티) — 코덱스 불가로 임시 대체\n\n")
            f.write(text)
        print(f"폴백 호출 성공. 응답 길이: {len(text)} chars")
        print(f"사용 토큰: {data.get('usage', {})}")
except Exception as e:
    print(f"폴백 호출 실패: {e}")
    exit(3)
PYEOF

echo "=== [Reviewer] 호출 종료: $(date) ===" | tee -a "${LOG_FILE}"
echo ""
echo "⚠️  폴백 진입 완료."
echo "마누스 다음 행동:"
echo "  1. [Owner]께 폴백 진입 보고"
echo "  2. gate-review.md §1.1에 폴백 사실·사유 명시"
echo "  3. [Judge] 호출 시 *반드시 다른 지피티 세션* 사용"
echo "  4. SUB-5 §12 회고에 폴백 누적 기록"
