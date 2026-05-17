# Codex Reviewer 호출 절차 정정 기록

**run ID**: 20260518_g2-skills-verification-execution  
**작성일시**: 2026-05-17 KST  
**작성자**: [Foreman]

---

## 1. 정정 사유

[Foreman]이 SUB-3 [Reviewer] 호출에서 `codex exec --sandbox read-only --output-last-message - < reviewer-input.md` 방식으로 먼저 실행을 시도했다. 그러나 [Owner]가 즉시 정정했다.

> 코덱스는 터미널열고 codex호출후에 진행해야지

따라서 기존 `codex exec` 직접 호출은 본 run에서 **절차 오류**로 기록하고 중단했다. 이 호출은 `reviewer-raw.md`에 유효 결과를 남기지 않았으며, `reviewer-raw.md` 파일 크기는 0 byte 상태였다.

---

## 2. 중단 처리

| 항목 | 처리 결과 |
|---|---|
| 진행 중 `codex exec` 프로세스 | `pkill -f 'codex exec'`로 중단 |
| `reviewer-raw.md` | 0 byte, 유효 Reviewer 판정 없음 |
| `codex-exec.log` | 실패·중단 로그 보존 |
| 권한 천장 | 파일 수정·commit·push 없음 |

---

## 3. 정정된 Reviewer 호출 절차

정정 후 절차는 다음과 같다.

| 단계 | 정정 절차 |
|---|---|
| 1 | 새 Terminal 창을 연다. |
| 2 | `/Users/twostars/ClaudeAi/dubyeol-workflow`로 이동한다. |
| 3 | 먼저 `codex`를 호출해 Codex REPL에 진입한다. |
| 4 | Reviewer 입력은 파일 경유 방식으로 유지하되, REPL 안에서 `reviewer-input.md`를 읽고 기술 감리를 수행하라고 지시한다. |
| 5 | 응답 원문은 `.harness/runs/20260518_g2-skills-verification-execution/reviewer-raw.md`에 저장한다. |
| 6 | Reviewer가 사업·의도 판단을 시도하지 않았는지 확인한다. |

---

## 4. 회고 후보

본 건은 회고 17·Phase H 회고 메모 15의 재발 사례다. r7에서는 Codex 호출 절차를 `codex exec` 직접 실행 방식과 `codex` REPL 선진입 방식으로 명확히 구분하고, [Owner]가 지정한 프로젝트 운영 방식에서는 **REPL 선진입 방식 우선**으로 문서화할 필요가 있다.

---

**정정 기록 끝.**
