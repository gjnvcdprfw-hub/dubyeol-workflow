# external-tool-diagnostics: Reviewer/Judge 외부 도구 오류 진단

**run ID**: 20260516_skills-github-register  
**작성일시**: 2026-05-17 01:05 KST  
**작성자**: [Foreman]  

---

## 1. 결론

코덱스 Reviewer 호출 실패는 단일 원인으로 묶으면 부정확하다. 보존된 로그 기준으로는 `reviewer-stderr.log`의 세션 `019e3159-f768-7943-abff-b15713433f42`는 정상 Reviewer 입력을 받은 뒤 백엔드 transport 오류로 중단되었고, `reviewer-stderr-retry.log`의 세션 `019e315b-b8a6-77c2-8c87-0e6a3fadc4cf`는 입력 텍스트가 손상된 상태에서 시작된 뒤 같은 계열의 백엔드 transport 오류도 함께 발생했다.

지피티 API backend는 별도 로컬 SOCKS5 경로에서 간단 호출이 정상 동작했다. `socks5h://127.0.0.1:12481` 경로로 `/v1/models`가 HTTP 200을 반환했고, `gpt-5.5` chat ping도 HTTP 200 및 `pong`을 반환했다. 따라서 본 run은 [Owner] 조건부 지시에 따라 옵션 A, 즉 지피티 Reviewer 폴백과 별도 Judge 호출로 진행할 수 있다.

---

## 2. 코덱스 호출별 진단

| 로그 파일 | 세션 ID | 입력 상태 | 백엔드 상태 | 판정 |
|---|---|---|---|---|
| `reviewer-stderr.log` | `019e3159-f768-7943-abff-b15713433f42` | 정상 Reviewer input 확인됨. 첫 user 본문이 `# Reviewer Input — 20260516_skills-github-register`로 시작함 | `failed to refresh available models`, `Transport channel closed`, `turn interrupted` | 백엔드/transport 장애 |
| `reviewer-stderr-retry.log` | `019e315b-b8a6-77c2-8c87-0e6a3fadc4cf` | 손상됨. Reviewer prompt 대신 `cd . && sleep 10 ... osascript ... window id 941 ...` 형태의 터미널 점검 명령이 섞임 | `failed to refresh available models`, `Transport channel closed`, `stream disconnected before completion` | 입력 전달 무결성 실패 + 백엔드/transport 장애 |

현재 보존된 파일명 기준으로는 정상 입력 세션이 먼저 생성되었고, 입력 손상 세션이 재시도 로그에 남아 있다. 다만 핵심 운영 교훈은 동일하다. Reviewer 호출 결과를 수용하기 전에는 **도구가 실제로 받은 user 입력이 의도한 프롬프트와 일치하는지**를 반드시 확인해야 한다.

---

## 3. 입력 손상 원인 가설

입력 손상은 코덱스 모델의 판단 문제가 아니라 **호출 전달 경로** 문제로 보인다. `reviewer-stderr-retry.log`의 user 블록에는 Reviewer short prompt 일부와 함께, 이전 터미널 상태 확인용 명령(`osascript ... get contents of selected tab ...`, `pgrep ...`)이 혼입되어 있다. 이는 다음 중 하나의 가능성이 높다.

| 가능성 | 설명 | 근거 | 조치 |
|---|---|---|---|
| 쉘 세션 상태 오염 | 이전 장기 실행·중단된 shell session의 입력 버퍼 또는 표시 내용이 다음 호출에 섞임 | retry 로그의 user 블록에 Reviewer prompt가 아닌 터미널 조회 명령이 포함됨 | 외부 도구 호출은 새 shell session + 프롬프트 파일 stdin 전달 + 호출 직후 stderr의 user 블록 spot-check 의무화 |
| 복잡한 한 줄 명령/인용 문제 | heredoc, command substitution, 긴 인용이 섞이며 prompt가 의도와 다르게 전달됨 | 첫 시도에서는 `$(cat ...)` 방식 오류도 있었고, retry 시 command/log 혼입 발생 | `codex exec - < input.md`처럼 파일 stdin 고정. 긴 prompt를 command argument로 전달 금지 |
| 백엔드 transport 장애와 결합 | 호출 직후 backend 오류가 발생해 정상 응답 전 검증 기회를 잃음 | 두 로그 모두 ChatGPT backend transport 오류 포함 | backend ping 또는 짧은 test call 후 장문 감리 호출 |

---

## 4. 지피티 backend ping 결과

| 항목 | 결과 |
|---|---|
| 로컬 키 | `KEY_SET=yes` |
| 유효 SOCKS5 경로 | `socks5h://127.0.0.1:12481` |
| `/v1/models` | HTTP 200, 약 7.64초 |
| `gpt-5.5` chat ping | HTTP 200, 약 8.02초 |
| 응답 본문 | `pong` |
| 실패 SOCKS 경로 | `socks5h://127.0.0.1:12224`는 connection refused |

증거 파일은 `gpt-ping-exec.log`, `gpt-ping-payload.json`, `gpt-ping-raw-12481.json`, `gpt-ping-result.txt`에 저장했다.

---

## 5. 분기 결정

[Owner] 지시 기준은 “지피티 간단 테스트 호출에서 응답 받으면 옵션 A 진행”이었다. ping이 성공했으므로 본 run은 **옵션 A**로 진행한다. 단 gate-review에는 코덱스 Reviewer 표준 호출 실패, 지피티 Reviewer 폴백, Judge 별도 호출, 백엔드 공유 리스크, 입력 무결성 검증 필요를 모두 명시한다.

---

## 6. r7 회고 메모 후보 반영 예정

| 번호 | 제목 | 반영 요지 |
|---:|---|---|
| 10 | 외부 도구 일시 장애 처리 패턴 | gh TLS timeout과 코덱스 backend 실패가 연속 발생했으므로 대체 검증 경로를 매뉴얼화한다. |
| 11 | Reviewer·Judge 호출 입력 자료 전달 무결성 검증 의무 | 외부 도구가 실제 받은 user 입력을 spot-check하지 않으면 깨진 prompt를 감리로 오인할 수 있다. |
| 12 | 폴백 절차의 백엔드 공유 리스크 | 코덱스 실패 후 지피티 폴백은 같은 backend 장애 영향을 받을 수 있으므로 ping 후 진행한다. |

---

**external-tool-diagnostics 끝.**
