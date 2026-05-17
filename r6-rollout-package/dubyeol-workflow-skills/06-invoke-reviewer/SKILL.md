---
name: 06-invoke-reviewer
description: 마누스가 코덱스를 호출해 코드 감리(Reviewer)를 수행하는 표준 스킬. 코덱스 불가 시 지피티(별도 세션)로 자동 폴백. SUB-3 §3 진입 시점 사용. 입력은 코드·기술 명세에 한정, 의도·사업 맥락은 절대 전달 금지 (정보 격리 원칙). 코드 변경 task의 Tier A는 필수. silkroadhub 두별 워크플로우 v3.6.0 r1 베타에서 SUB-3 §3 표준 절차.
---

# 06-invoke-reviewer

마누스가 [Reviewer] 역할을 *코덱스에 위임*해 코드 감리를 수행. 코덱스 불가 시 지피티 폴백.

## 언제 호출하는가

- `handoff.md` 작성 완료 (SUB-2 종료) 후
- Tier A 코드 변경 task → *필수*
- Tier B 코드 변경 task → *권고*
- Tier C → 생략 가능

## 입력 자료 — 정보 격리 원칙 ★

**[Reviewer]에게 전달**:
- `handoff.md` §2.2 변경 파일 목록
- `handoff.md` §3 진행 이력
- diff 발췌 (마스킹 적용 후)
- `task-card.md` §5 산출물 목록 (기술 명세)

**전달 금지**:
- `task-card.md` §1 [Owner] 발화 원문
- `task-card.md` §3 의도 정렬 증거 블록 (Looks Like/Wrong)
- `PROJECT.md` 내용
- 사업 맥락·우선순위

## 동작 순서

1. `scripts/invoke_reviewer.sh` 실행
2. 입력 자료를 `.harness/runs/<run_id>/reviewer-input.md`에 저장
3. 코덱스 호출 시도 (1차)
4. **코덱스 성공** → 응답을 `reviewer-raw.md`에 저장 → `gate-review.md §1` 자동 작성
5. **코덱스 실패** (CLI 오류·환경·rate limit) → 폴백 진입:
   - [Owner] 폴백 진입 보고
   - 지피티 [Reviewer] 전용 세션 호출 (별도 세션 — [Judge]와 분리)
   - 응답을 `reviewer-raw.md`에 저장 + 폴백 사실 명시

## 호출

```bash
bash scripts/invoke_reviewer.sh <run_id>
```

## 핵심 안전선

- *코덱스 자동 재시도 2~3회* 후에만 폴백 진입. *처음부터 폴백 사용 금지*
- 폴백 시 *지피티 [Judge] 세션과 반드시 다른 세션* 사용 (세션 라벨링: `Reviewer_Fallback`)
- 폴백 진행 시 `gate-review.md §1.1`에 *폴백 사실·사유 명시*
- 입력 자료에 *의도·사업 맥락 절대 포함 금지* (정보 격리)
- 마스킹 규칙 적용 후 전달

## 산출물

- `.harness/runs/<run_id>/reviewer-input.md` — 입력 자료 (정보 격리 검증용)
- `.harness/runs/<run_id>/reviewer-raw.md` — 응답 원문
- `.harness/runs/<run_id>/codex-exec.log` — 호출 로그
- `.harness/runs/<run_id>/gate-review.md §1` — 마누스가 정리한 감리 결과

## 폴백 사후 처리

- 폴백 진행 사실은 SUB-5 §12 회고에 누적
- 폴백 반복 시 [Owner]께 코덱스 환경 점검 권고
- 다음 task는 *코덱스 우선*으로 복귀

## 참조

- `references/codex-prompt-pattern.md` — 코덱스 호출 프롬프트 패턴
- `references/fallback-procedure.md` — 폴백 절차 상세
- silkroadhub `AGENTS.md` §7.1·§7.5
- silkroadhub `SUB-3-외부감리.md` §3
