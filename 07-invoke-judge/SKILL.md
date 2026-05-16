---
name: 07-invoke-judge
description: 마누스가 지피티(별도 세션)를 호출해 종합 판정·Devil's Advocate 검토를 수행하는 표준 스킬. SUB-3 §4 진입 시점 사용. 입력은 의도·기획·사업 맥락에 한정, 코드 디테일은 절대 전달 금지 (정보 격리). 모든 Tier A/B는 필수. Reviewer 세션과 반드시 다른 세션. silkroadhub 두별 워크플로우 v3.6.0 r1 베타 SUB-3 §4 표준 절차.
---

# 07-invoke-judge

마누스가 [Judge] 역할을 *지피티에 위임*해 종합 판정 + Devil's Advocate 검토 수행.

## 언제 호출하는가

- [Reviewer] 호출·결과 정리 완료 (SUB-3 §3 종료) 후
- Tier A/B → *필수*
- Tier C → 생략 가능 (task-card §4에 사유 명시)
- *반드시 [Reviewer] 세션과 분리된 새 지피티 세션*

## 입력 자료 — 정보 격리 원칙 ★

**[Judge]에게 전달**:
- `task-card.md` §1 [Owner] 발화 원문
- `task-card.md` §3 의도 정렬 증거 블록 (Looks Like / Looks Wrong / 가정)
- `task-card.md` §5 산출물 + 완료 기준
- `PROJECT.md` §C.[N] 연결 모듈 정보
- `handoff.md` §1 의도 정렬 증거 블록 대조 (1:1 매칭)
- `gate-review.md §1` [Reviewer] 결과 요약 (코덱스의 코드 영역 판정)

**전달 금지**:
- diff 본문 (코드 디테일)
- [Builder] 구현 내부 로직 디테일
- 마스킹되지 않은 운영 데이터

## 동작 순서

1. `scripts/invoke_judge.sh` 실행
2. 입력 자료를 `.harness/runs/<run_id>/judge-input.md`에 저장
3. 지피티 [Judge] 전용 새 세션 호출 (모델 `gpt-5.5`, temperature 파라미터 생략)
4. 응답을 `judge-raw.md`에 저장
5. 마누스가 `gate-review.md §2`로 정리

## 호출

```bash
bash scripts/invoke_judge.sh <run_id>
```

## 핵심 안전선

- *[Reviewer] 세션과 동일 세션 사용 절대 금지* — 정보 격리 위반
- 코드 디테일·diff 전달 금지 — [Judge]가 코드 보면 *외부성 손상*
- 응답이 *추상적*이면 *Devil's Advocate 부분* 재호출 — "리스크 5가지 명시" 같은 강제 프롬프트

## 산출물

- `.harness/runs/<run_id>/judge-input.md` — 입력 자료 (정보 격리 검증용)
- `.harness/runs/<run_id>/judge-raw.md` — 응답 원문
- `.harness/runs/<run_id>/gate-review.md §2` — 마누스 정리 결과

## 판정 형식

[Judge]는 다음 4단 응답 의무:

1. **의도 정렬 판정** — handoff §1 의도 정렬 증거 블록이 task-card §3 의도와 *1:1 매칭*되는가
2. **사업 영향 평가** — 변경이 [Owner] 발화의 *진짜 의도*와 부합하는가
3. **Devil's Advocate** — 반대 논리·놓친 리스크 *최소 3가지* 명시 강제
4. **종합 판정** — 진행 / 수정 / 보류 / 중단

## 참조

- `references/judge-prompt-pattern.md` — 지피티 호출 프롬프트 패턴
- silkroadhub `AGENTS.md` §1·§7
- silkroadhub `SUB-3-외부감리.md` §4
