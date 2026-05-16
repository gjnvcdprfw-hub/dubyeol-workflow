#!/bin/zsh
# invoke_judge.sh — [Judge] 호출 (지피티 단독, 별도 세션)
# 두별 워크플로우 v3.6.0 r1 베타 — Manus Agent Skill
#
# 호출: bash invoke_judge.sh <run_id>
# 입력: .harness/runs/<run_id>/judge-input.md (마누스가 사전 작성)
# 출력: .harness/runs/<run_id>/judge-raw.md

set -e

RUN_ID="${1:?usage: invoke_judge.sh <run_id>}"

REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"
RUN_DIR="${REPO_ROOT}/.harness/runs/${RUN_ID}"
INPUT_FILE="${RUN_DIR}/judge-input.md"
OUTPUT_FILE="${RUN_DIR}/judge-raw.md"
LOG_FILE="${RUN_DIR}/judge-exec.log"

cd "${REPO_ROOT}"

if [ ! -f "${INPUT_FILE}" ]; then
  echo "ERROR: 입력 자료 없음 — ${INPUT_FILE}"
  echo "마누스 사전 작성 필요: task-card §1/§3/§5 + PROJECT.md §C.N + handoff §1 + gate-review §1"
  exit 1
fi

if [ -z "${OPENAI_API_KEY}" ]; then
  echo "ERROR: OPENAI_API_KEY 미설정 — source scripts/load_openai_key.sh 먼저"
  exit 2
fi

echo "=== [Judge] 호출 시작: $(date) ===" | tee "${LOG_FILE}"
echo "Run ID: ${RUN_ID}" | tee -a "${LOG_FILE}"
echo "주의: [Reviewer] 세션과 *반드시 다른* 지피티 세션 사용" | tee -a "${LOG_FILE}"

SYSTEM_PROMPT='당신은 silkroadhub의 [Judge] — Devil"'"'"'s Advocate + 종합 판정자입니다.

역할:
- 코드 디테일을 보지 않음. 의도·기획·사업·논리 영역만 판정
- [Reviewer] 세션과 완전히 분리. 같은 task-card라도 다른 시각으로 검토
- 반대 논리·놓친 리스크 최소 3가지 명시 강제

응답 4단 의무:
1. 의도 정렬 판정 — handoff §1 의도 정렬 증거 블록이 task-card §3 의도와 1:1 매칭되는가
2. 사업 영향 평가 — 변경이 [Owner] 발화의 진짜 의도와 부합하는가
3. Devil"'"'"'s Advocate — 반대 논리·놓친 리스크 최소 3가지
4. 종합 판정 — Status: 진행 / 수정 / 보류 / 중단

금지:
- 코드 직접 수정 금지
- Tier 분류 시도 금지
- 추상적 "괜찮아 보임"만 응답하지 말 것. 항상 구체 근거'

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
            f.write("# [Judge] 응답 — 지피티 별도 세션\n\n")
            f.write(text)
        print(f"호출 성공. 응답 길이: {len(text)} chars")
        print(f"사용 토큰: {data.get('usage', {})}")
except Exception as e:
    print(f"호출 실패: {e}")
    exit(3)
PYEOF

echo "=== [Judge] 호출 종료: $(date) ===" | tee -a "${LOG_FILE}"
echo ""
echo "다음 단계 (마누스):"
echo "  1. judge-raw.md 검토"
echo "  2. Devil's Advocate 부분이 추상적이면 *재호출* (구체 리스크 3개 강제)"
echo "  3. gate-review.md §2 작성"
echo "  4. [Owner] 보고"
