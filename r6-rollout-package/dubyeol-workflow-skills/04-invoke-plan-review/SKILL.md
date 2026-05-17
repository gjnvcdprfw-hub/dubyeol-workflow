---
name: 04-invoke-plan-review
description: 마누스가 지피티에 plan-review를 요청하는 스킬. SUB-2 §2.5 진입 시점 사용 (writing-plans 직후, 구현 진입 전). Tier A 또는 큰 task에 권고. 클로드코드 writing-plans 산출물을 지피티 Devil's Advocate가 검토해서 구현 진입 전 plan 약점 발견. 입력은 의도·plan·연결 모듈 맥락. 코드 디테일 없음. 통과·수정 권고·보류·중단 4단 판정. silkroadhub 두별 워크플로우 v3.6.0 r1 베타 SUB-2 §2.5 표준 절차.
---

# 04-invoke-plan-review

마누스가 [Judge](지피티)에 *구현 진입 전 plan 검토*를 요청. r6 베타에서 신설된 안전선.

## 언제 호출하는가

- 클로드코드가 `writing-plans` skill 완료 후 plan 산출
- *구현 진입 전*에 plan-review 분기 판정 통과 시:
  - Tier A → 권고
  - Tier B → 마누스 판단
  - Tier C → 일반적으로 생략
  - 카테고리 1 큰 변경 / 4 큰 운영 문서 / 5 기획 → 권고

## 입력 자료 — 정보 격리 원칙

**[Judge]에게 전달**:
- `task-card.md` §1 [Owner] 발화 원문
- `task-card.md` §3 의도 정렬 증거 블록
- 클로드코드 `writing-plans` 산출물 (plan 본문)
- `PROJECT.md` §C.[N] 연결 모듈 맥락

**전달 금지**:
- 구현 코드 디테일 (아직 구현 안 됨)
- 다른 task의 task-card·plan

## 동작 순서

1. `scripts/invoke_plan_review.sh` 실행
2. 입력 자료를 `.harness/runs/<run_id>/plan-review-input.md`에 저장
3. 지피티 plan-review 전용 새 세션 호출 (SUB-3 [Judge] 세션과도 *분리* — 시점·자료 다름)
4. 응답을 `plan-review.md`에 저장
5. 마누스가 판정 확인 후 [Builder]에 통과/수정 지시

## 호출

```bash
# 저장소 루트에서 실행
zsh 04-invoke-plan-review/scripts/invoke_plan_review.sh <run_id>
```

## 핵심 안전선

- *코드 디테일 검토 금지* — plan 수준의 검토만 (지피티가 코드 보면 외부성 손상)
- *SUB-3 [Judge] 세션과 별도 세션 권고* — 시점·자료가 다름. 혼동 방지
- 통과 판정 받기 *전*에 구현 진입 금지

## 산출물

- `.harness/runs/<run_id>/plan-review-input.md` — 입력 자료
- `.harness/runs/<run_id>/plan-review.md` — 판정 + 권고

## 판정 형식 (4단)

1. **의도 정렬** — plan이 [Owner] 의도와 정렬되는가?
2. **Looks Wrong 방어** — plan이 task-card §3 Looks Wrong을 *진짜로* 방어하는가?
3. **가정 검증** — task-card §3.5 가정 중 *실제 검증 안 된* 것은?
4. **종합** — Status: 통과 / 수정 권고 / 보류 / 중단

## 처리

- **통과** → [Builder] 구현 진입
- **수정 권고** → [Builder]에 plan 수정 지시 + 재검토
- **보류·중단** → [Owner] 에스컬레이션

## 참조

- silkroadhub `SUB-2-워크플로우.md` §2.4·§2.5
