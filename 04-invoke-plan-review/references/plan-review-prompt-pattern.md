# plan-review 호출 프롬프트 패턴 (지피티 Devil's Advocate)

본 문서는 `invoke_plan_review.sh`가 지피티에 보내는 *프롬프트 양식*. 변경 시 본 파일과 스크립트 모두 동기화.

## 프롬프트 양식

```
당신은 silkroadhub 프로젝트의 [Judge] — Devil's Advocate입니다.

다음 [Owner] 발화에 대해, [Builder]가 작성한 구현 plan을 검토하세요.
중요: 코드 디테일은 검토하지 마세요. plan 수준의 검토만.

=== [Owner] 원 발화 ===
"<task-card §1 인용>"

=== 기획 의도 (task-card §3) ===
- 한 문장 목표: <§3.1>
- Looks Like (성공 시 보이는 것):
  - <§3.2 항목들>
- Looks Wrong (피해야 할 것):
  - <§3.3 항목들>
- 가정 (검증 안 된 전제):
  - <§3.5 항목들>

=== PROJECT.md §C.[N] 연결 맥락 ===
<관련 모듈 정보 요약>

=== [Builder] writing-plans 산출물 ===
<plan 본문 그대로>

=== 검토 기준 ===
1. plan이 [Owner] 의도와 정렬되는가?
2. plan이 Looks Wrong을 진짜로 방어하는가?
3. 가정 중 plan에서 검증되지 않고 그대로 *지나간* 것이 있는가?
4. plan에서 빠진 단계나 과도한 단계는?
5. plan 진행 시 발생 가능한 사업 사이드이펙트 우려는?

=== 응답 형식 ===
응답 머리에 다음 한 줄을 반드시 박으세요:
Status: 통과 / 수정 권고 / 보류 / 중단

이어서 5개 기준 각각에 대한 평가를 짧게 (1~3 문장).
마지막에 종합 권고 (구체 행동 지시 또는 "통과 — 구현 진입 가능").

코드 디테일을 검토하려 시도하지 마세요. plan의 *논리·구조·정렬*만 검토.
```

## 응답 처리 가이드

### Status: 통과
- 마누스가 `plan-review.md`에 응답 저장
- 클로드코드에 *구현 진입 지시*
- 인용해서 [Builder] 진입 명령에 첨부 가능

### Status: 수정 권고
- 응답의 *구체 수정 사항* 추출
- 클로드코드에 *plan 수정 지시* 전달:
  ```
  plan-review에서 다음 수정 권고가 나왔다. plan을 갱신해라.

  수정 권고:
  - <항목 1>
  - <항목 2>
  ...

  수정 후 다시 writing-plans 산출. 본 plan-review는 재검토 진행.
  ```
- 재검토 시 새 plan-review.md 생성 (덮어쓰기 아님 — `plan-review-v2.md`)

### Status: 보류
- plan의 *전제 자체*에 문제 발견. [Owner] 에스컬레이션 의무
- 마누스가 [Owner]께 보고 양식:
  ```
  [plan-review 보류 보고]
  run_id: <run_id>
  보류 사유: <지피티 응답 요약>
  옵션:
  A) task-card §3 재검토 후 plan 재작성
  B) task 자체 폐기 또는 분할
  C) [Owner] 추가 의도 입력 후 재정렬
  ```

### Status: 중단
- task 자체의 합리성 의문. 즉시 작업 중단
- [Owner] 에스컬레이션. 자율 진행 절대 금지

## 정보 격리 점검 (호출 후)

호출 직후 마누스 자가 점검:
- [ ] 지피티에 *코드 diff·구현 디테일* 전달 안 함
- [ ] 지피티에 *다른 task의 자료* 섞이지 않음
- [ ] plan-review 세션이 SUB-3 [Judge] 세션과 *분리됨* (시점·자료 다름)
- [ ] `plan-review-input.md`에 마스킹 규칙 적용

## SUB-3 [Judge]와의 관계

| 항목 | plan-review | SUB-3 [Judge] |
|---|---|---|
| 호출 시점 | 구현 진입 *전* | 구현 완료 *후* |
| 입력 자료 | 의도 + plan (코드 없음) | 의도 + 산출물 요약 (코드 있되 핵심만) |
| 검토 영역 | plan 논리·구조·정렬 | 의도↔결과 매칭, 사업 영향 |
| 세션 | 별도 (`plan-review-<run_id>`) | 별도 (`judge-<run_id>`) |
| 산출 | `plan-review.md` | `gate-review.md §2` |
