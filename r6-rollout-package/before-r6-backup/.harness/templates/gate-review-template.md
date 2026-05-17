# 두별워크플로우 v3.5.0 Gate Review Template

> 이 문서는 **마누스가 작성**합니다. Tier A/B에서는 필수이고, Tier C에서는 Codex blocking, 보안, 맥락 불일치, 실행 실패, 증거 부족이 있을 때 작성합니다. Codex와 ChatGPT 결과를 섞어 최종 판단하지 않고, 먼저 증거와 판정을 분리 기록합니다.

| 필드 | 값 |
|---|---|
| run_id | `<task-card와 동일>` |
| 작성일 | `<YYYY-MM-DD>` |
| 작성자 | `마누스` |
| 주 편집자 | `마누스` |
| 대상 handoff | `.harness/runs/<run_id>/handoff.md` |
| Tier | `A / B / C` |
| Gate 단계 | `Gate 1 / Gate 2 / ad-hoc review` |
| 최종 gate 상태 | `proceed / changes_requested / hold / stop / not_applicable` |

## 1. 검토 대상 요약

| 항목 | 내용 |
|---|---|
| 대표님 요청 요약 | `<task-card 기준 요약>` |
| Claude Code 최종 상태 | `ready_for_review / blocked` |
| 변경 파일 수 | `<number>` |
| 실행 증거 존재 여부 | `있음 / 없음 / 일부` |
| gate-review 작성 사유 | `Tier A/B 필수 / Tier C 승격 / blocking 발생 / 기타` |

## 2. 입력 증거 목록

| 증거 | 경로 또는 요약 | 확인 상태 |
|---|---|---|
| task-card | `.harness/runs/<run_id>/task-card.md` | `확인 / 미확인` |
| handoff | `.harness/runs/<run_id>/handoff.md` | `확인 / 미확인` |
| Git diff | `<commit range 또는 working tree diff 요약>` | `확인 / 미확인` |
| 실행 명령 로그 | `<명령 또는 로그 위치>` | `확인 / 미확인 / 없음` |
| 테스트 결과 | `<요약>` | `pass / fail / not_run / unknown` |

## 3. Codex 감리 요약

| 항목 | 값 |
|---|---|
| Codex 호출 여부 | `예 / 아니오` |
| 호출자 | `마누스` |
| 감리 대상 | `<diff, 파일, handoff, 실행 증거>` |
| Codex 상태 | `approved / changes_requested / blocking / inconclusive / not_run` |
| blocking 여부 | `있음 / 없음` |
| 주요 지적 | `<요약>` |
| 원문 위치 | `<codex-review.md 또는 로그 경로>` |

### Codex 주요 이슈

| 번호 | 심각도 | 내용 | 필요한 조치 |
|---:|---|---|---|
| 1 | `blocking / high / medium / low` | `<이슈>` | `<조치>` |

## 4. ChatGPT 5.5 판정 요약

| 항목 | 값 |
|---|---|
| ChatGPT 호출 여부 | `예 / 아니오` |
| 호출자 | `마누스` |
| 모델 | `gpt-5.5` |
| 판정 형식 | `JSON` |
| 최종 verdict | `진행 / 수정 / 보류 / 중단` |
| Devil’s Advocate 리스크 | `<반대 논리와 위험 요약>` |
| 원문 위치 | `<raw response 또는 결과 파일 경로>` |

### ChatGPT 주요 리스크

| 번호 | 리스크 | 영향 | 보완 조건 |
|---:|---|---|---|
| 1 | `<리스크>` | `<영향>` | `<조건>` |

## 5. 마누스 Gate 해석

마누스는 Codex와 ChatGPT 결과를 임의로 무시하지 않습니다. Tier A/B에서 ChatGPT가 `수정`, `보류`, `중단`을 판정하면 다음 Gate로 진행하지 않습니다. Tier C에서 권고라도 blocking, 보안, 맥락 불일치, 실행 실패, 증거 부족이 있으면 Tier B로 승격합니다.

| ChatGPT verdict | gate_status |
|---|---|
| `진행` | `proceed` |
| `수정` | `changes_requested` |
| `보류` | `hold` |
| `중단` | `stop` |
| `해당 없음` | `not_applicable` |

`해당 없음`은 Tier C에서 `task-card.md`상 ChatGPT 생략이 승인된 경우에만 사용하며, 생략 근거를 본 문서 또는 final-report에 기록합니다.

| 판단 항목 | 결과 | 근거 |
|---|---|---|
| task-card 목표 충족 | `예 / 아니오 / 부분` | `<근거>` |
| 성공 기준 충족 | `예 / 아니오 / 부분` | `<근거>` |
| 제외 범위 준수 | `예 / 아니오` | `<근거>` |
| 실행 증거 충분성 | `충분 / 부족 / 없음` | `<근거>` |
| Codex blocking | `있음 / 없음` | `<근거>` |
| ChatGPT 강제 판정 위반 여부 | `있음 / 없음 / 해당 없음` | `<근거>` |
| Tier 승격 필요 | `없음 / B로 승격 / A로 승격` | `<근거>` |

## 6. 수정 루프 상태

| 항목 | 값 |
|---|---|
| 현재 루프 번호 | `0 / 1 / 2 / 3 / 4+` |
| 자동 수정 가능 여부 | `가능 / 불가` |
| 불가 사유 | `Tier A 대표님 확인 필요 / 4회째 / 보류 / 중단 / 기타` |
| 다음 지시 대상 | `Claude Code / 대표님 / 보류 / 중단` |

## 7. Gate 결론

| 결론 | 값 |
|---|---|
| gate_status | `proceed / changes_requested / hold / stop / not_applicable` |
| 대표님 확인 필요 여부 | `필요 / 불필요` |
| Claude Code 재작업 필요 여부 | `필요 / 불필요` |
| 다음 단계 | `<수정 지시 / 대표님 보고 / final-report 작성 / 중단>` |

## 8. 대표님 보고용 요약

`<대표님께 보고할 수 있는 쉬운 말 요약을 3~7문장으로 작성합니다. 기술 판단을 대표님께 떠넘기지 않고, 원인·완료분·대안·확인 필요 사항을 명확히 씁니다.>`
