# 마누스 task 프롬프트 — AGENTS.md Appendix 호출 절차 검증

> ⚠️ **상태: 일부 검증 완료 (2026-05-16) — 본 프롬프트는 *참고 자료*로 보존**.
> 클로드코드 지시 전달 검증 (Appendix B 관련)은 별도 task로 완료됨 — 결과는 `.harness/runs/test_claude_dispatch/dispatch-comparison-report.md` 참조.
> Codex 호출 (Appendix A 일부)도 일반 zsh 단일 do script로 동작 확인됨.
> 남은 검증 영역 — Codex·ChatGPT 실호출 + 결과 정리는 *scripts/ 작성 task* 또는 *스킬화 task*에서 진행. 본 프롬프트는 그때 참고 자료로 활용.

> 이 문서는 [Owner]가 마누스에게 전달하는 task 프롬프트.
> 두별 워크트리 카테고리: **4 (문서·운영)**
> Tier: **A** (운영 문서 검증 — 모든 향후 [Reviewer]·[Judge] 호출의 기반)
> 진행 순서: 본 task **1순위**. scripts/ 작성·CLAUDE.md 갱신보다 *먼저*. 본 검증이 통과해야 다른 task의 안전판 확보됨.

---

## task 개요

**목표**: AGENTS.md Appendix A·B·C에 박힌 호출 절차들이 *현재 환경*에서 *실제로 동작*하는지 검증. 실패 시 정정안 보고.

**배경**: r6 AGENTS.md의 Appendix A·B·C는 r5 시점 검증 결과를 *그대로 복사*한 것이다. macOS·Codex CLI·Claude Code 버전 변경 가능성이 있어 *재검증 필수*. 미검증 상태로 [Reviewer]·[Judge] 호출 진행 금지.

**검증 대상 4가지**:
1. Codex 호출 (osascript + heredoc stdin)
2. ChatGPT_Reviewer 세션 호출 (Codex와 *분리 검증*)
3. ChatGPT_Judge 세션 호출 ([Reviewer]와 *반드시 다른 세션*)
4. Claude Code 새 세션 열기 + 명령 전달

**범위**: 검증·정정안 작성까지. 실제 AGENTS.md 변경 *commit*은 본 task 산출 후 별도 [Owner] 명시 승인 받고 진행 (SUB-5 §7.6 안전 행동).

---

## Step 1 — 환경 기본 확인

```bash
cd /Users/twostars/ClaudeAi/silkroadhub
sw_vers
echo "---"
echo "Codex:"
which codex && codex --version 2>&1 | head -3
echo "---"
echo "Claude Code:"
which claude && claude --version 2>&1 | head -3
echo "---"
echo "PATH:"
echo $PATH | tr ':' '\n' | grep -i node
echo "---"
echo "OpenAI 키 로딩 스크립트:"
ls -la scripts/load_openai_key.sh
echo "---"
echo "도구 (curl, jq, python3):"
which curl jq python3
```

결과를 `.harness/runs/<run_id>/env-survey.md`에 기록.

---

## Step 2 — Codex 호출 검증 (Appendix A)

### 2.1 새 Terminal 창 열기

AGENTS.md Appendix A Step 1 절차 그대로 실행:

```applescript
osascript << 'APPLESCRIPT'
tell application "Terminal"
  activate
  do script "cd /Users/twostars/ClaudeAi/silkroadhub"
end tell
APPLESCRIPT
```

**확인 사항**:
- 새 Terminal 창이 *열렸는가*?
- 디렉터리가 *정확히 이동*했는가?

### 2.2 창 ID 조회

```bash
osascript -e 'tell application "Terminal" to get {id, name} of every window' 2>&1
```

**확인 사항**:
- 창 ID·이름이 *명확히 출력*되는가?
- 방금 연 창을 *식별 가능*한가?

### 2.3 Codex 테스트 호출 — 최소 프롬프트

테스트 run 디렉터리 생성:
```bash
TEST_RUN_ID="test_codex_$(date +%Y%m%d_%H%M%S)"
mkdir -p .harness/runs/$TEST_RUN_ID
```

테스트 스크립트 작성 (Appendix A Step 3 절차):
```bash
cat > tmp/test_codex.sh << SCRIPT
#!/bin/zsh
export PATH="/Users/twostars/.local/node/bin:\$PATH"
source ~/.zshrc 2>/dev/null || true
cd /Users/twostars/ClaudeAi/silkroadhub

OUTPUT_FILE=".harness/runs/$TEST_RUN_ID/test-output.md"
LOG_FILE=".harness/runs/$TEST_RUN_ID/test-exec.log"

echo "=== Codex Test Start: \$(date) ===" | tee "\$LOG_FILE"

codex exec \\
  --sandbox read-only \\
  --output-last-message \\
  - << 'PROMPT' > "\$OUTPUT_FILE" 2>> "\$LOG_FILE"
Status: TEST
Simple connectivity test. Respond with exactly two lines:
Status: PASS
Test connectivity verified at <current date>
PROMPT

EXIT_CODE=\$?
echo "=== Codex Test End: \$(date), exit=\$EXIT_CODE ===" | tee -a "\$LOG_FILE"
head -5 "\$OUTPUT_FILE"
SCRIPT
chmod +x tmp/test_codex.sh
```

Appendix A Step 4 절차로 실행 (창 ID는 §2.2 결과 사용):
```applescript
osascript << APPLESCRIPT
tell application "Terminal"
  activate
  do script "zsh /Users/twostars/ClaudeAi/silkroadhub/tmp/test_codex.sh" in window id <창ID>
end tell
APPLESCRIPT
```

대기 후 결과 확인:
```bash
sleep 60
cat .harness/runs/$TEST_RUN_ID/test-output.md
cat .harness/runs/$TEST_RUN_ID/test-exec.log
```

**검증 통과 기준**:
- ✅ `test-output.md`의 첫 줄이 *"Status: PASS"* 로 시작
- ✅ exit code 0
- ✅ heredoc 입력이 *깨짐 없이* 전달됨
- ✅ PATH 보정이 *정상 동작* (codex 명령 찾음)

**실패 모드별 대응**:
| 실패 신호 | 가능 원인 | 마누스 정정안 |
|---|---|---|
| `codex: command not found` | PATH 미설정 | 정확한 codex 경로 찾아서 AGENTS.md PATH 행 갱신 |
| heredoc 입력이 깨짐 | macOS 버전 / 쉘 변경 | 다른 형태 (파일 입력 등) 시도 후 정정안 |
| `--sandbox read-only` 옵션 없음 | Codex 버전 변경 | 현재 버전 옵션 확인, AGENTS.md 갱신 |
| `--output-last-message` 옵션 없음 | 동상 | 동상 |
| 응답이 *프롬프트 인젝션*으로 보임 | 입력 escape 문제 | heredoc 인용 강화 |

---

## Step 3 — ChatGPT API 호출 검증 (AGENTS.md §7.3 모델·세팅)

### 3.1 OpenAI 키 로딩

```bash
source scripts/load_openai_key.sh
echo "Key loaded (first 7 chars): ${OPENAI_API_KEY:0:7}"
```

**확인**:
- 키가 환경변수에 *로드*됐는가?
- 첫 7글자가 *sk-* 형태로 시작하는가?

키 *전체 출력 절대 금지*.

### 3.2 모델 가용성 확인

```bash
curl -s https://api.openai.com/v1/models \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  | python3 -c "import sys, json; data=json.load(sys.stdin); models=[m['id'] for m in data.get('data', [])]; print('Total models:', len(models)); print('gpt-5.5 available:', 'gpt-5.5' in models); print('Sample:', [m for m in models if 'gpt-5' in m][:5])"
```

**확인**:
- ✅ API 응답이 정상
- ✅ `gpt-5.5` 또는 가까운 모델명 가용
- ❌ 401 인증 오류 → 키 문제
- ❌ 모델 없음 → 모델 이름 변경됐을 가능성, *현재 권고 모델* 보고

### 3.3 ChatGPT_Reviewer 세션 테스트 호출

```bash
TEST_RUN_ID="test_reviewer_$(date +%Y%m%d_%H%M%S)"
mkdir -p .harness/runs/$TEST_RUN_ID

# temperature 파라미터 *생략*. max_tokens 적정.
curl -s https://api.openai.com/v1/chat/completions \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "gpt-5.5",
    "max_tokens": 200,
    "messages": [
      {"role": "system", "content": "You are a test reviewer. Respond exactly with: Status: PASS - reviewer session connectivity verified."},
      {"role": "user", "content": "Connectivity test."}
    ]
  }' > .harness/runs/$TEST_RUN_ID/reviewer-test.json

cat .harness/runs/$TEST_RUN_ID/reviewer-test.json | python3 -m json.tool
```

**확인**:
- ✅ 응답에 `choices[0].message.content` 존재
- ✅ 내용이 *"Status: PASS"* 포함
- ❌ `error.code: model_not_found` → 모델명 변경, 정정안에 *권고 모델* 박음
- ❌ `error.code: unsupported_parameter` 또는 temperature 관련 오류 → temperature 처리 정정

### 3.4 ChatGPT_Judge 세션 테스트 호출 — **반드시 다른 세션**

§3.3과 *별도*로 호출:

```bash
# 별도 run 디렉터리 + 별도 호출 — 세션 분리 의도 명시
TEST_RUN_ID_JUDGE="test_judge_$(date +%Y%m%d_%H%M%S)"
mkdir -p .harness/runs/$TEST_RUN_ID_JUDGE

curl -s https://api.openai.com/v1/chat/completions \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "gpt-5.5",
    "max_tokens": 200,
    "messages": [
      {"role": "system", "content": "You are a test judge (Devil Advocate). Respond exactly with: Status: PASS - judge session connectivity verified."},
      {"role": "user", "content": "Connectivity test for judge session."}
    ]
  }' > .harness/runs/$TEST_RUN_ID_JUDGE/judge-test.json

cat .harness/runs/$TEST_RUN_ID_JUDGE/judge-test.json | python3 -m json.tool
```

**확인**:
- ✅ 응답 정상 수신
- ✅ §3.3의 reviewer 호출과 *별도 응답*
- ✅ 두 호출이 *서로 컨텍스트 공유 안 함* (각각 독립 API 호출이므로 자동 격리)

**검증 의의**: API는 *호출마다 stateless*이므로 *별도 호출 = 별도 세션*. 정보 격리는 *프롬프트(input) 단계에서* 마누스가 *서로 다른 정보만 전달*함으로써 달성. 본 §3.4는 *API 자체가 stateless하다*는 점만 확인.

---

## Step 4 — Claude Code 새 세션 검증 (Appendix B)

### 4.1 새 세션 열기

```applescript
osascript << 'APPLESCRIPT'
tell application "Terminal"
  activate
  do script "cd /Users/twostars/ClaudeAi/silkroadhub && claude"
end tell
APPLESCRIPT
```

**확인**:
- ✅ 새 Terminal 창이 열림
- ✅ `claude` REPL이 *시작됨*
- ✅ 디렉터리가 silkroadhub로 *이동됨*

### 4.2 한글·특수문자 명령 전달 검증

Appendix B 마지막 절 "한글·특수문자 명령은 파일로 저장 후 경로 전달" 절차:

```bash
mkdir -p tmp
cat > tmp/test_instruction.txt << 'EOF'
This is a test instruction file.
한글 테스트 — 마누스가 작성하는 지시문 예시.
Special chars: $@#&*()
EOF
```

위 파일을 Claude Code 세션에 *읽으라*는 지시 전달:

```applescript
osascript << APPLESCRIPT
tell application "Terminal"
  activate
  do script "Read the file at /Users/twostars/ClaudeAi/silkroadhub/tmp/test_instruction.txt and summarize in one line." in window id <claude창ID>
end tell
APPLESCRIPT
```

**확인**:
- ✅ Claude Code가 *파일을 읽음*
- ✅ 한글이 *깨지지 않고* 인식됨
- ❌ keystroke 직접 입력으로 한글 *깨짐* → 정정 불필요 (이미 파일 경유로 우회)

---

## Step 5 — 검증 결과 종합

`.harness/runs/<run_id>/appendix-verification-report.md` 작성:

```markdown
# AGENTS.md Appendix 호출 절차 검증 결과

**검증 일시**: YYYY-MM-DD HH:MM
**환경**: macOS [버전], Codex [버전], Claude Code [버전]

## 검증 표

| Appendix | 절차 | 결과 | 비고 |
|---|---|---|---|
| A | Codex 새 Terminal 창 열기 | ✅ / ❌ | [비고] |
| A | 창 ID 조회 | ✅ / ❌ | [비고] |
| A | heredoc stdin Codex 호출 | ✅ / ❌ | [비고] |
| A | --sandbox read-only 옵션 | ✅ / ❌ | [비고] |
| A | --output-last-message 옵션 | ✅ / ❌ | [비고] |
| A | PATH 보정 (/Users/twostars/.local/node/bin) | ✅ / ❌ | 현재 경로 확인 결과 |
| §7.3 | OpenAI 키 로딩 (load_openai_key.sh) | ✅ / ❌ | [비고] |
| §7.3 | gpt-5.5 모델 가용 | ✅ / ❌ | 없으면 권고 모델 |
| §7.3 | ChatGPT_Reviewer 호출 (temperature 생략) | ✅ / ❌ | [비고] |
| §7.3 | ChatGPT_Judge 호출 (별도 호출) | ✅ / ❌ | [비고] |
| B | Claude Code 새 세션 열기 | ✅ / ❌ | [비고] |
| B | 한글 명령 파일 경유 전달 | ✅ / ❌ | [비고] |

## 발견된 문제

(있으면 항목별로)

### 문제 1: [한 줄 요약]
- 증상:
- 원인 추정:
- AGENTS.md 정정안:

(없으면 "발견된 문제 없음. AGENTS.md Appendix A·B·C 절차 그대로 적용 가능.")

## AGENTS.md 갱신 권고

검증 통과 시:
- Appendix A 머리 경고문 *제거* — "베타 가동 전 검증 필요" → "검증 완료 YYYY-MM-DD"

검증 실패 시:
- 정정안 적용 후 재검증
- 정정안을 SUB-5 §7.6 안전 행동 절차로 [Owner] 승인 후 commit

## 다음 단계

- [ ] [Owner] 승인 후 AGENTS.md Appendix 정정
- [ ] scripts/ 작성 task 진입 (검증 통과한 절차를 스크립트화)
```

---

## Step 6 — handoff 작성

`.harness/runs/<run_id>/handoff.md` 작성:

- 본 task의 검증 결과 (§5 보고서 인용)
- 발견된 문제 + 정정안
- AGENTS.md 갱신 권고 사항
- 마누스 확인 필요점: 정정안 적용 여부 [Owner] 결정 요청

---

## 권한·금지

- 본 task는 *검증* + *정정안 작성*까지. AGENTS.md *실제 변경 commit*은 [Owner] 명시 승인 후 별도 단계
- OpenAI 키 *전체 출력 절대 금지*. 첫 7글자만
- 테스트 호출 비용 발생 — 최소 호출만 (각 도구 1~2회)
- 검증 결과가 실패해도 *임의 정정 후 적용 금지*. [Owner] 결정 받음

---

## 검증 통과 조건

- [ ] Step 1 환경 기본 확인 완료
- [ ] Step 2 Codex 호출 검증 완료 (통과 또는 실패+정정안)
- [ ] Step 3 ChatGPT_Reviewer + ChatGPT_Judge 호출 검증 완료
- [ ] Step 4 Claude Code 새 세션 검증 완료
- [ ] Step 5 검증 결과 보고서 작성 (`appendix-verification-report.md`)
- [ ] Step 6 handoff 작성
- [ ] OpenAI 키 노출 없음
- [ ] 테스트 호출 비용 최소화

---

**프롬프트 끝.**

본 검증이 통과(또는 정정안 [Owner] 승인)되어야 다음 task(scripts/ 작성, CLAUDE.md 갱신, AGENTS.md 본문 적용)가 *안전판 위*에서 진행됨.
