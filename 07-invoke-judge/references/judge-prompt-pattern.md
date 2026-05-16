# 지피티 [Judge] 호출 입력 자료 양식

`judge-input.md`에 다음 구조로 작성. 마누스가 *task-card·PROJECT.md·handoff·gate-review에서 추출*해서 사전 작성.

## 양식

```
# Run ID
<run_id>

# Tier·카테고리
- Tier: <A/B/C>
- 카테고리: <1~5>

# [Owner] 원 발화 (task-card §1)
"<원문 인용>"

# 의도 정렬 증거 블록 (task-card §3)
- 한 문장 목표: <...>
- Looks Like: <...>
- Looks Wrong: <...>
- 가정: <3가지>

# 산출물 + 완료 기준 (task-card §5)
<목록>

# PROJECT.md §C.[N] 연결 모듈 맥락
<해당 모듈의 사업적 맥락>

# handoff §1 의도 정렬 증거 블록 대조
<task-card §3과 1:1 매칭 결과 — [Builder]가 작성한 부분>

# gate-review §1 [Reviewer] 결과 요약
- 종합 판정: <PASS/CONDITIONAL/HOLD/BLOCK>
- 주요 지적 사항 (코드 영역):
  - <...>
- 코드 영역 권고 사항:
  - <...>

# 검토 요청
위 자료를 바탕으로 4단 응답해주세요:

1. 의도 정렬 판정
   - handoff §1이 task-card §3과 1:1 매칭되는가?
   - 매칭 누락·왜곡 항목 명시
2. 사업 영향 평가
   - 변경이 [Owner] 발화의 진짜 의도와 부합?
   - PROJECT.md §C.[N] 맥락에서 사이드 이펙트는?
3. Devil's Advocate (강제)
   - 반대 논리 3가지 이상
   - 놓친 리스크 3가지 이상
   - "가정 중 의심스러운 것" 1가지 이상
4. 종합 판정
   - Status: 진행 / 수정 / 보류 / 중단
   - 사유 1~2 단락

# 금지
- 코드 디테일·diff 영역 검토 시도 금지 ([Reviewer]가 이미 함)
- 추상적 "괜찮아 보임" 응답 금지
```

## 응답 재호출 기준

- Devil's Advocate 부분이 *추상적*이거나 *3가지 미만*이면 → 재호출 ("구체 리스크 3가지 명시" 강제)
- 사업 영향 평가가 *코드 영역으로 흐름* → 재호출 ("사업·기획 영역만" 강제)
