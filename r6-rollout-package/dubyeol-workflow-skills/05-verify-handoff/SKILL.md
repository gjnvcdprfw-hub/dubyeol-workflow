---
name: 05-verify-handoff
description: 마누스가 [Builder] handoff 수신 후 권한 천장 위반·scope 위반·마스킹 위반·증거 부족을 자동 점검하는 스킬. SUB-2 §4 진입 시점 사용. git 명령 6개 자동 실행해서 push 시도·파괴적 git·운영 문서 변경 등 위반 신호 검출. 위반 발견 시 즉시 멈춤 + [Owner] 보고. silkroadhub 두별 워크플로우 v3.6.0 r1 베타 SUB-2 §4 표준 절차.
---

# 05-verify-handoff

handoff 수신 후 *마누스 직접 검증* 자동화. handoff만 믿지 않고 *실제 git·로그* 확인.

## 언제 호출하는가

- [Builder]가 handoff.md 작성 완료
- SUB-2 §4 [Foreman] 검증 단계 진입 시

## 동작 순서

1. `05-verify-handoff/scripts/verify_handoff.sh <run_id>` 실행
2. 10개 검증 항목 자동 실행:
   - **A. git push 흔적** — 로컬 commit 외 push 발생 여부
   - **B. 파괴적 git 명령 흔적** — reflog에 reset --hard·force push 등
   - **C. 운영 문서 변경** — AGENTS.md·CLAUDE.md·PROJECT.md·.harness/templates/ diff
   - **D. scope 침범** — task-card §5.2 제외 범위 파일 변경
   - **E. 마스킹 위반** — commit 메시지·코드 안 운송장·BL·키 노출 패턴
   - **F. handoff §1 의도 정렬 대조** — task-card §3과 항목별 1:1 매칭
   - **G. uncommitted secret 스캔** — 미커밋 변경에서 민감 패턴 검출
   - **H. push 금지 확인** — 원격과의 동기 상태 확인
   - **I. .env staged 여부** — 민감 파일 staged 여부
   - **J. 파괴적 git 명령 감지** — bash history에서 위험 명령 패턴
3. 각 항목 PASS/WARN/FAIL 표 출력
4. FAIL 발견 시 즉시 멈춤 + [Owner] 보고 안내

## 호출

```bash
# 저장소 루트에서 실행
zsh 05-verify-handoff/scripts/verify_handoff.sh <run_id>
```

## 핵심 안전선

- 자동 검증이 *PASS*여도 마누스가 *추가 점검* — 자동 검증은 *형식적 신호*만 잡음
- 의미적 위반 (예: handoff §1 의도 정렬이 *겉으로는 매칭하지만 실제 의도 어긋남*)은 *마누스 판단*
- FAIL 발견 시 *handoff 통과 처리 절대 금지*. SUB-4 진입 후보

## 산출물

- `.harness/runs/<run_id>/handoff-verification.md` — 검증 결과 표

## 결과 처리

| 결과 | 다음 행동 |
|---|---|
| 10개 모두 PASS | SUB-3 진입 (Tier A/B) 또는 SUB-5 진입 (Tier C) |
| 1개 이상 WARN | 마누스 추가 점검 + [Owner] 보고 검토 |
| 1개 이상 FAIL | SUB-4 진입 또는 [Owner] 즉시 보고 |

## 참조

- silkroadhub `SUB-2-워크플로우.md` §4
- silkroadhub `AGENTS.md` §6 권한 천장
