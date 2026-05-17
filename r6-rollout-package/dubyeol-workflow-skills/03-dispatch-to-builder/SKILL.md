---
name: 03-dispatch-to-builder
description: 마누스가 클로드코드(Builder) 세션에 진입 명령을 전달하는 표준 스킬. SUB-2 진입 시점에 사용. 파일 경유 + 짧은 명령 + 2단계 확정 실행 방식으로 한글·특수문자 깨짐 없이 안전 전달. activate 사용 금지·단일 do script 금지·Builder 친절 제안 무시 등 r6 검증으로 확인된 안전선이 박혀있음. silkroadhub의 두별 워크플로우 v3.6.0 r1 베타에서 SUB-2 §2 표준 진입 절차.
---

# 03-dispatch-to-builder

마누스가 클로드코드 세션에 *SUB-2 진입 명령*을 전달하는 표준 스킬.

## 언제 호출하는가

- `task-card.md` 작성 완료 (SUB-1 종료) 후
- `[Owner]`가 "워크플로우 매뉴얼 봐" 또는 *SUB-2 진입 신호* 발화 시
- 클로드코드 새 세션이 열려 있고 `WINDOW_ID` 확보된 상태

## 입력

| 필드 | 설명 |
|---|---|
| `run_id` | 예: `20260516_manifest-fix` |
| `window_id` | osascript으로 조회한 클로드코드 창 ID |
| `tier` | `A` / `B` / `C` |
| `category` | 두별 워크트리 카테고리 `1`~`5` |

## 동작 순서

1. `scripts/dispatch.sh` 실행
2. `tmp/claude-entry-<run_id>.md` 파일에 *표준 진입 명령 양식* 저장
3. osascript로 짧은 명령 전달 + `do script ""`로 Enter 확정 (2단계)
4. 클로드코드 첫 응답 5~10초 내 확인
5. 응답에서 다음 4가지 점검:
   - task-card 경로 인지
   - 카테고리·Tier 인지
   - `/using-superpowers` 진입 명시
   - 진입 명령 파일 정확히 읽음

## 호출

```bash
bash scripts/dispatch.sh <run_id> <window_id> <tier> <category>
```

## 핵심 안전선 (r6 검증 발견 반영)

- `activate` *절대 사용 금지* — 포커스 탈취·중복 창 위험
- 단일 `do script` *절대 사용 금지* — Enter 미확정으로 입력 대기에 머묾. *반드시* 2단계 확정 실행
- 클로드코드가 task 완료 후 `git commit` 등을 *자동 제안*해도 *명령으로 해석 금지*. 마누스는 *입력 필드 비우고* 정지

## 산출물

- `tmp/claude-entry-<run_id>.md` — 진입 명령 원문 보존 (재실행·회고 자료)
- 클로드코드 응답 캡처 (마누스 작업 메모)

## 실패 모드

| 신호 | 처리 |
|---|---|
| 클로드코드가 응답 없음 (10초 이상) | `do script ""` 한 번 더 시도. 그래도 응답 없으면 새 세션 |
| 응답에 task-card 경로 누락 | 진입 명령 파일 재확인 후 재전달 |
| `/using-superpowers` 진입 안 함 | 명시 재요청 |
| 한글·특수문자 깨짐 | 진입 명령 파일을 *직접 cat으로 확인* 후 재전달 |

## 참조

- `references/standard-entry-prompt.md` — 표준 진입 명령 양식 (영문 ASCII)
- `references/agents-md-appendix-b.md` — AGENTS.md Appendix B 절차 사본 (참고)
- silkroadhub `AGENTS.md` §7.2 + Appendix B
- silkroadhub `SUB-2-워크플로우.md` §2
