# Codex 호출 운영 정정 메모 — Phase H SUB-3

**일시**: 2026-05-17 KST  
**작성자**: [Foreman] Manus  
**상태**: 적용 대기 — Reviewer 재호출 전 절차 재정렬 완료 필요

## 1. 즉시 중단 처리

[Owner]가 `USER REQUESTED IMMEDIATE FORCE STOP` 지시를 내렸으므로, 진행 중이던 Codex Reviewer 2차 시도는 즉시 중단했다.

| 항목 | 결과 |
|---|---|
| 중단 전 프로세스 | `run_codex_phase_h_reviewer_retry2.sh`, `codex exec --sandbox read-only --output-last-message -` |
| 중단 후 프로세스 | 관련 `codex exec` 프로세스 없음 |
| `reviewer-raw-retry2.md` | 0 bytes |
| `codex-exec-retry2.log` | 존재, 2930 bytes |
| Reviewer 판정 | 확보 안 됨 |

## 2. 정정된 운영 지침

[Owner]는 Codex도 Claude Code와 같은 **로컬 CLI 도구**이므로, 마누스가 직접 macOS Terminal 새 창을 열어 세션을 시작해야 한다고 정정했다. 따라서 이후 Reviewer 호출은 기존의 백그라운드 shell 실행 방식이 아니라 다음 절차로 진행한다.

| 단계 | 정정 절차 |
|---:|---|
| 1 | 마누스가 macOS Terminal 새 창을 직접 연다. |
| 2 | 작업 디렉터리는 `silkroadhub` 또는 `dubyeol-workflow` 중 감리 목적에 맞게 선택한다. |
| 3 | 새 창에서 `codex` 또는 환경에 설치된 Codex 실행 명령을 시작한다. |
| 4 | AGENTS.md §7.3 표준 세팅인 `--sandbox read-only --output-last-message`를 적용한다. |
| 5 | Reviewer 입력 자료는 `.harness/runs/<run_id>/reviewer-input.md`로 저장하고, 파일 경유 + 짧은 명령 + 2단계 확정 실행 절차를 준용한다. |
| 6 | 응답·로그·산출물을 확인한다. |

## 3. 폴백 조건

Codex가 2~3회 시도 후 도구·환경 문제로 실패한 것이 명확할 때만 [Reviewer] 폴백을 검토한다. 폴백 전에는 [Foreman]이 [Owner]에게 폴백 진입 사실을 보고하고 명시 승인을 받아야 한다. 이후 지피티 ping으로 가용성을 확인하고, `Reviewer_Fallback` 별도 세션을 사용하며, [Judge] 세션과 분리한다.

## 4. 회고 후보

r7 매뉴얼 정비 시 AGENTS.md §12 베타 운영 절차를 “Claude Code 터미널 표준 절차”로만 두지 말고, **로컬 CLI 도구 호출 표준 절차**로 일반화하는 것이 필요하다. Codex 역시 로컬 CLI이므로 Claude Code와 같은 책임 주체·창 생성·창 ID 조회·파일 경유 전달·응답 확인 원칙을 적용해야 한다.

## 5. 다음 행동

Reviewer 재호출 전, [Foreman]은 새 Terminal 창 기반 Codex 호출 절차를 준비하고, 필요 시 [Owner]에게 “재호출 진행” 확인을 받은 뒤 실행한다. 기존 retry2 산출물은 실패·중단 증거로 보존한다.

---

## 6. [Owner] 폴백 승인 기록

**승인 일시**: 2026-05-17 KST  
**Owner 응답 원문**: “폴백으로 하자”

[Foreman]은 Codex 1차 직접 실행, 2차 중단 처리, 3차 새 Terminal 기반 Codex REPL 실행을 모두 시도했으나 Reviewer 응답을 확보하지 못했다. 이후 네트워크 진단에서 `chatgpt.com/backend-api/wham/apps`와 `api.openai.com/v1/models`가 각각 15초 timeout을 보였고, DNS 해석은 정상임을 확인했다. 따라서 실패 원인은 입력 자료나 task 구조가 아니라 현재 대표님 Mac의 VPN 또는 네트워크 경로가 OpenAI/ChatGPT 계열 endpoint 연결을 막거나 과도하게 지연시키는 문제로 분류한다.

이에 따라 AGENTS.md §7.5 폴백 절차에 따라 이번 run 한정으로 **지피티 Reviewer_Fallback**을 승인받았다. 다음 단계에서는 Reviewer_Fallback 입력을 Reviewer 전용 정보로 유지하고, 이후 Judge 세션과 분리한다.

---

## 7. GPT 폴백 가용성 ping 결과

[Owner]가 “폴백으로 하자”라고 승인한 뒤, [Foreman]은 폴백 실행 전 GPT API 가용성을 점검했다. 원격 macOS 환경에서는 VPN/네트워크 경로 문제로 `chatgpt.com` 및 `api.openai.com` HTTPS 연결이 timeout 되었으므로, sandbox의 preconfigured OpenAI-compatible client를 사용해 가용성을 확인했다.

| 점검 방식 | 결과 | 해석 |
|---|---|---|
| 원본 OpenAI `/v1/models` curl | invalid API key | sandbox 환경의 raw curl 경로는 사용할 수 없음 |
| preconfigured client `models.list()` | 404 | 해당 proxy는 models list endpoint를 지원하지 않음 |
| preconfigured client `chat.completions` with `gpt-5.5` | 400 unsupported model | 현재 sandbox proxy에서 `gpt-5.5` 직접 호출 불가 |
| 허용 모델 목록 | `gemini-2.5-flash`, `gpt-4.1-mini`, `gpt-4.1-nano` | Reviewer_Fallback을 계속하려면 [Owner]의 모델 예외 승인이 필요 |

따라서 엄격한 r6 지침의 `gpt-5.5` 조건을 그대로 적용하면 GPT Reviewer_Fallback도 현재 환경에서는 차단된다. 진행하려면 이번 run 한정으로 `gpt-4.1-mini` 또는 `gemini-2.5-flash` 사용에 대한 [Owner]의 명시적 risk 인수가 필요하다.

---

## 8. GPT 호출 경로 정정

[Owner]가 “지피티는 로컬에서 우리 스킬대로 진행하면 문제없어”라고 정정했다. 이에 따라 [Foreman]은 sandbox preconfigured client의 모델 제한을 근거로 GPT 폴백을 보류 판단한 것을 철회한다. r6 운영에서 GPT 호출은 sandbox API가 아니라 **대표님 로컬 환경의 우리 스킬 절차**를 사용해야 하며, `gpt-5.5` 원칙도 그 경로에서 적용한다.

따라서 다음 Reviewer_Fallback 및 Judge 호출은 sandbox API가 아니라 로컬 GPT 호출 절차로 진행한다. 정보 격리는 유지하며, Reviewer_Fallback과 Judge는 서로 다른 입력 파일과 다른 세션 라벨로 분리한다.
