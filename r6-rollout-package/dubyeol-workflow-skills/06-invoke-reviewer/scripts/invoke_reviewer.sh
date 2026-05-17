#!/bin/zsh
# invoke_reviewer.sh — [Reviewer] 호출 (코덱스 우선, 지피티 폴백)
# 두별 워크플로우 v3.6.0 r1 베타 — Manus Agent Skill
#
# 호출: zsh 06-invoke-reviewer/scripts/invoke_reviewer.sh <run_id>
# 입력 필수 (사전 작성): .harness/runs/<run_id>/reviewer-input.md
# 출력: .harness/runs/<run_id>/reviewer-raw.md + codex-exec.log

set -e

RUN_ID="${1:?usage: invoke_reviewer.sh <run_id>}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
REPO_ROOT="${REPO_ROOT:-$(dirname "$SKILL_DIR")}"

if [[ ! -d "$REPO_ROOT/.git" ]]; then
    echo "[ERROR] REPO_ROOT is not a git repository: $REPO_ROOT"
    echo "Set REPO_ROOT environment variable or run from within the repository."
    exit 1
fi

RUN_DIR="${REPO_ROOT}/.harness/runs/${RUN_ID}"
INPUT_FILE="${RUN_DIR}/reviewer-input.md"
OUTPUT_FILE="${RUN_DIR}/reviewer-raw.md"
LOG_FILE="${RUN_DIR}/codex-exec.log"

cd "${REPO_ROOT}"

# 입력 격리 강제: 입력 파일이 없으면 즉시 오류 종료
if [[ ! -f "${INPUT_FILE}" ]]; then
  echo "[ERROR] 입력 자료 없음 — ${INPUT_FILE}"
  echo "Prerequisite: 마누스가 사전 작성 필요."
  echo "  내용: handoff §2.2 변경 파일·§3 진행 이력·diff 발췌·task-card §5 (사업 맥락 제외)"
  echo "  형식: .harness/runs/<run_id>/reviewer-input.md"
  exit 1
fi

echo "=== [Reviewer] 호출 시작: $(date) ===" | tee "${LOG_FILE}"
echo "Run ID: ${RUN_ID}" | tee -a "${LOG_FILE}"

# === 1차: 코덱스 시도 ===
echo "" | tee -a "${LOG_FILE}"
echo "1차 시도: 코덱스 ([Reviewer] 표준 도구)" | tee -a "${LOG_FILE}"

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

if [[ "${CODEX_OK}" = "true" ]]; then
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

if [[ -z "${OPENAI_API_KEY}" ]]; then
  echo "[ERROR] OPENAI_API_KEY 미설정" | tee -a "${LOG_FILE}"
  echo "  export OPENAI_API_KEY=<your_key>  # ~/.zshrc 또는 현재 세션에서 설정" | tee -a "${LOG_FILE}"
  exit 2
fi

# 파일 기반 Python 호출 — heredoc 특수문자 injection 방지
python3 - "${INPUT_FILE}" "${OUTPUT_FILE}" <<'PYEOF' | tee -a "${LOG_FILE}"
import json, os, sys, urllib.request

input_file = sys.argv[1]
output_file = sys.argv[2]

with open(input_file, 'r', encoding='utf-8') as f:
    prompt_content = f.read()

system_prompt = """당신은 [Reviewer] 폴백 세션입니다. 코덱스 불가로 임시 대체.
코드·기술 정합성만 감사하세요. 사업·기획 판단 금지.
입력 자료의 코드·diff·기술 명세를 봐서 통과/조건부 통과/보류/차단 중 하나 판정.
구체 파일·라인 근거 명시 필수."""

api_key = os.environ.get("OPENAI_API_KEY")
payload = {
    "model": "gpt-5.5",
    "messages": [
        {"role": "system", "content": system_prompt},
        {"role": "user", "content": prompt_content}
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
        with open(output_file, "w", encoding="utf-8") as f:
            f.write("# [Reviewer] 폴백 (지피티) — 코덱스 불가로 임시 대체\n\n")
            f.write(text)
        print(f"폴백 호출 성공. 응답 길이: {len(text)} chars")
        print(f"사용 토큰: {data.get('usage', {})}")
except Exception as e:
    print(f"폴백 호출 실패: {e}")
    sys.exit(3)
PYEOF

echo "=== [Reviewer] 호출 종료: $(date) ===" | tee -a "${LOG_FILE}"
echo ""
echo "⚠️  폴백 진입 완료."
echo "마누스 다음 행동:"
echo "  1. [Owner]께 폴백 진입 보고"
echo "  2. gate-review.md §1.1에 폴백 사실·사유 명시"
echo "  3. [Judge] 호출 시 *반드시 다른 지피티 세션* 사용"
echo "  4. SUB-5 §12 회고에 폴백 누적 기록"
