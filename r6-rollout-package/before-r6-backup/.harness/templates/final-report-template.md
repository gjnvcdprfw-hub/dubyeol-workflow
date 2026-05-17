# 두별워크플로우 v3.5.0 Final Report Template

> 이 문서는 **마누스가 작성**하고 대표님께 보고하는 최종 결과물 보고서입니다. 원칙적으로 모든 run 종료 시 작성합니다. 다만 초소형 Tier C 작업에서 `task-card.md`에 파일형 final-report 생략이 명시 승인된 경우에는 채팅 최종 보고로 대체할 수 있으며, 그 경우에도 요청 요약·완료 결과·검증 여부·남은 리스크·다음 단계를 반드시 포함합니다. Claude Code는 이 문서를 작성하지 않습니다.

| 필드 | 값 |
|---|---|
| run_id | `<task-card와 동일>` |
| 작성일 | `<YYYY-MM-DD>` |
| 작성자 | `마누스` |
| 주 편집자 | `마누스` |
| 보고 대상 | `대표님` |
| 최종 상태 | `완료 / 수정 필요 / 보류 / 중단` |

## 1. 요청 요약

`<대표님 요청과 의도를 3~5문장으로 요약합니다. 사업 목적, 원하는 결과, 성공 기준을 포함합니다.>`

## 2. 완료 결과

| 항목 | 결과 |
|---|---|
| 완료된 작업 | `<실제 완료분>` |
| 미완료 또는 제외된 작업 | `<미완료분 또는 제외 범위>` |
| 최종 산출물 | `<파일, 기능, 문서, 화면, 브랜치 등>` |
| 대표님 관점 요약 | `<비전공자도 이해할 수 있는 결과 요약>` |

## 3. 산출물 위치

| 산출물 | 위치 | 설명 |
|---|---|---|
| task-card | `.harness/runs/<run_id>/task-card.md` | 작업 지시와 성공 기준 |
| handoff | `.harness/runs/<run_id>/handoff.md` | Claude Code 실행 결과 |
| gate-review | `.harness/runs/<run_id>/gate-review.md` | Tier A/B 또는 필요 시 Gate 검토 |
| 변경 파일 | `<path>` | `<설명>` |

## 4. 변경 파일

| 파일 | 변경 유형 | 설명 |
|---|---|---|
| `<path>` | `created / modified / deleted` | `<무엇이 바뀌었는지>` |

## 5. 검증 결과

| 검증 항목 | 결과 | 근거 |
|---|---|---|
| 테스트 | `pass / fail / not_run / not_applicable` | `<명령, 로그, 사유>` |
| 빌드 | `pass / fail / not_run / not_applicable` | `<명령, 로그, 사유>` |
| 자체 리뷰 | `pass / concern / fail` | `<handoff 요약>` |
| 실행 증거 충분성 | `충분 / 부족 / 없음` | `<근거>` |

## 6. Codex 감리 요약

| 항목 | 값 |
|---|---|
| Codex 호출 여부 | `예 / 아니오` |
| Codex 상태 | `approved / changes_requested / blocking / inconclusive / not_run` |
| blocking 여부 | `있음 / 없음` |
| 주요 지적 | `<요약>` |
| 조치 결과 | `<수정 완료 / 보류 / 대표님 확인 필요 / 해당 없음>` |

## 7. ChatGPT 판정 요약

| 항목 | 값 |
|---|---|
| ChatGPT 호출 여부 | `예 / 아니오 / task-card상 생략 승인` |
| 모델 | `gpt-5.5 / 해당 없음` |
| 판정 | `진행 / 수정 / 보류 / 중단 / 해당 없음` |
| 생략 근거 | `<Tier C에서 생략된 경우 task-card 근거와 사유>` |
| Devil’s Advocate 리스크 | `<요약 또는 해당 없음>` |
| 조치 결과 | `<수정 완료 / 보류 / 대표님 확인 필요 / 해당 없음>` |

## 8. 수정 루프 기록

| 루프 | 원인 | 조치 | 결과 |
|---:|---|---|---|
| 1 | `<Codex/ChatGPT/검증 실패 등>` | `<수정 지시 또는 조치>` | `<결과>` |
| 2 | `<필요 시>` | `<필요 시>` | `<필요 시>` |
| 3 | `<필요 시>` | `<필요 시>` | `<필요 시>` |

## 9. Superpowers 준수 요약

| 항목 | 결과 | 근거 |
|---|---|---|
| Superpowers skill 체인 | `완료 / 부분 / 미완료 / 해당 없음` | `<using-superpowers, brainstorming, writing-plans, TDD, subagent, review, verification, finishing 사용 요약>` |
| fresh verification | `충분 / 부족 / 없음` | `<verification-before-completion 기준으로 마지막에 실행한 명령과 결과>` |
| finishing 선택지 | `제시 / 미제시 / 해당 없음` | `<finishing-a-development-branch 기준 merge / PR / keep / discard 선택지와 대표님 결정 필요 여부>` |
| 권한 경계 | `준수 / 위반 / 예외 승인` | `<commit, push, merge, deploy 실행 여부와 승인 근거>` |

## 10. Context7 / Code Simplifier 준수 요약

| 항목 | 결과 | 근거 |
|---|---|---|
| Context7 사용 판단 | `사용 / 미사용 / 해당 없음 / concern` | `<docs uncertainty, library ID, query/topic, decision affected 또는 미사용 사유>` |
| Context7 본 체인 방해 여부 | `없음 / 있음 / 해당 없음` | `<routine pre-step 또는 Superpowers skill 대체로 사용되지 않았는지>` |
| Code Simplifier 사용 판단 | `사용 / 미사용 / 해당 없음 / concern` | `<post-green 여부, 최근 수정 범위, 적용 사유>` |
| Code Simplifier 재검증 | `pass / fail / not_run / not_applicable` | `<pre-green verification과 post-simplification verification 명령·exit code>` |
| behavior 보존 | `pass / concern / fail / not_applicable` | `<API/DB/migration/security/user-visible behavior 변경 여부>` |
| 도구 권한 경계 | `준수 / 위반 / 예외 승인` | `<직접 Codex/ChatGPT 호출, push/merge/deploy/cleanup/discard/scope expansion 여부>` |

## 11. 남은 리스크

| 리스크 | 심각도 | 설명 | 권장 조치 |
|---|---|---|---|
| `<리스크>` | `low / medium / high / blocking` | `<설명>` | `<조치>` |

## 12. 대표님 확인 필요 사항

| 확인 사항 | 이유 | 선택지 |
|---|---|---|
| `<확인할 내용>` | `<왜 필요한지>` | `승인 / 수정 / 보류 / 중단` |

## 13. 다음 단계

| 우선순위 | 다음 작업 | 담당 | 비고 |
|---:|---|---|---|
| 1 | `<후속 작업>` | `대표님 / 마누스 / Claude Code` | `<비고>` |

## 14. 최종 결론

`<마누스가 사실 기반으로 최종 상태를 보고합니다. 검증되지 않은 내용은 [미확인]으로 표기합니다. 최종 승인, 수정, 보류, 중단 중 대표님이 판단해야 할 선택지를 명확히 제시합니다.>`
