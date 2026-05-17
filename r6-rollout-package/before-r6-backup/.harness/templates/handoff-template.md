# 두별워크플로우 v3.5.0 Handoff Template

> 이 문서는 **Claude Code가 작성**하고, 마누스가 검수하는 실행 결과 인수인계 문서입니다. Claude Code는 이 문서에서 Gate 통과나 최종 승인 판단을 하지 않습니다.

| 필드 | 값 |
|---|---|
| run_id | `<task-card와 동일>` |
| 작성일 | `<YYYY-MM-DD>` |
| 작성자 | `Claude Code` |
| 주 편집자 | `Claude Code` |
| 검수자 | `마누스` |
| 최종 상태 | `ready_for_review / blocked` |

## 1. task-card 준수 여부

| 항목 | 결과 | 근거 |
|---|---|---|
| 목표 준수 | `예 / 아니오 / 부분` | `<근거>` |
| 성공 기준 충족 | `예 / 아니오 / 부분` | `<근거>` |
| 제외 범위 준수 | `예 / 아니오` | `<범위 이탈 여부>` |
| 금지사항 준수 | `예 / 아니오` | `<Codex/ChatGPT 직접 호출 없음 등>` |
| Tier 변경 필요 | `없음 / 있음` | `<위험 발견 시 설명>` |

## 2. Superpowers 사용 기록

| skill | 사용 여부 | 증거/산출물 | 미사용 시 사유 |
|---|---:|---|---|
| `using-superpowers` | `예 / 아니오` | `<명령 또는 화면 근거>` | `<사유>` |
| `brainstorming` | `예 / 아니오` | `<질문·결론 요약>` | `<사유>` |
| `writing-plans` | `예 / 아니오` | `<plan 파일 또는 요약>` | `<사유>` |
| `using-git-worktrees` | `예 / 아니오 / 예외` | `<worktree 또는 예외 사유>` | `<사유>` |
| `test-driven-development` | `예 / 아니오 / 부분` | `<RED/GREEN 증거>` | `<사유>` |
| `subagent-driven-development / executing-plans` | `예 / 아니오` | `<task별 요약>` | `<사유>` |
| `requesting-code-review / receiving-code-review` | `예 / 아니오` | `<blocking 및 수정 요약>` | `<사유>` |
| `verification-before-completion` | `예 / 아니오` | `<fresh command output, exit code>` | `<사유>` |
| `finishing-a-development-branch` | `예 / 아니오` | `<merge/PR/keep/discard 선택지>` | `<사유>` |

`finishing-a-development-branch`는 push, merge, cleanup, discard 실행 권한이 아니라 선택지 기록 절차입니다. Claude Code는 선택지를 남긴 뒤 마누스 승인 대기 상태로 멈춥니다.

## 3. Context7 / Code Simplifier 사용 증거

| 항목 | 값 | 근거 |
|---|---|---|
| Context7 사용 여부 | `예 / 아니오 / 해당 없음` | `<구체적인 docs uncertainty 또는 not applicable 사유>` |
| Context7 uncertainty | `<library/API/setup/config/version 질문>` | `<repository/project docs만으로 부족했던 이유>` |
| Context7 query | `<library ID, query/topic, version>` | `<docs 요약 또는 결과 파일>` |
| Context7 적용 decision | `<어떤 구현·설정·테스트 결정에 반영했는지>` | `<관련 파일/라인/테스트>` |
| Code Simplifier 사용 여부 | `예 / 아니오 / 해당 없음` | `<post-green 여부>` |
| Code Simplifier precondition | `<green focused verification 명령과 exit code>` | `<로그 또는 결과>` |
| Code Simplifier 범위 | `<최근 수정 파일·함수·컴포넌트>` | `<범위가 최근 수정분에 한정됨>` |
| Code Simplifier post-verification | `<재실행한 focused test/build와 exit code>` | `<로그 또는 결과>` |
| behavior 보존 확인 | `pass / concern / fail / not_applicable` | `<API/DB/migration/security/user-visible behavior 변경 없음>` |
| 권한 경계 | `준수 / 위반 / 예외 승인` | `<직접 Codex/ChatGPT 호출, push/merge/deploy/cleanup/discard/scope expansion 없음>` |

Context7은 문서 근거일 뿐 최종 검증이 아닙니다. Code Simplifier는 green 이후 기능 보존형 후처리일 뿐 debugging, feature 구현, broad cleanup, scope expansion 권한이 아닙니다.

## 4. 변경 요약

`<무엇을 구현·수정·검증했는지 3~7문장으로 요약합니다.>`

## 5. 변경 파일 목록

| 파일 | 변경 유형 | 설명 |
|---|---|---|
| `<path>` | `created / modified / deleted / not_changed` | `<변경 내용>` |

## 6. 실행 명령과 결과

| 명령 | 위치 | 결과 | 로그/근거 |
|---|---|---|---|
| `<command>` | `<directory>` | `pass / fail / not_run` | `<요약 또는 로그 경로>` |

## 7. 미실행·실패 사유

| 항목 | 사유 | 영향 | 필요한 조치 |
|---|---|---|---|
| `<명령 또는 검증>` | `<의존성, 권한, 환경변수, 네트워크, 명령 부재 등>` | `<영향>` | `<마누스 확인 / 대표님 확인 / 재시도 등>` |

## 8. 자체 리뷰 결과

| 점검 항목 | 결과 | 설명 |
|---|---|---|
| 코드 품질 | `pass / concern / fail / not_applicable` | `<설명>` |
| 보안·민감정보 | `pass / concern / fail / not_applicable` | `<설명>` |
| API·DB 영향 | `pass / concern / fail / not_applicable` | `<설명>` |
| 도메인 정합성 | `pass / concern / fail / not_applicable` | `<설명>` |
| 테스트 충분성 | `pass / concern / fail / not_applicable` | `<설명>` |

## 9. 남은 리스크

| 리스크 | 심각도 | 설명 | 권장 조치 |
|---|---|---|---|
| `<리스크>` | `low / medium / high / blocking` | `<설명>` | `<조치>` |

## 10. 범위 변경 또는 발견 사항

| 유형 | 내용 | 처리 |
|---|---|---|
| 범위 이탈 후보 | `<있으면 기록>` | `진행 안 함 / 마누스 확인 필요` |
| 추가 발견 버그 | `<있으면 기록>` | `별도 task 권장 / 즉시 대응 필요` |
| 문서·지침 충돌 | `<있으면 기록>` | `마누스 확인 필요` |

## 11. 마누스 확인 필요점

| 확인 항목 | 이유 | 추천 상태 |
|---|---|---|
| `<확인할 것>` | `<이유>` | `Codex 필요 / ChatGPT 필요 / 대표님 확인 필요 / 추가 수정 필요` |

## 12. 최종 선언

| 항목 | 값 |
|---|---|
| 최종 상태 | `ready_for_review / blocked` |
| 다음 단계 제안 | `마누스 Codex/ChatGPT Gate 진행 / 마누스 확인 필요 / 대표님 확인 필요 / 추가 구현 필요` |

Claude Code는 이 handoff 이후 Codex, ChatGPT, 대표님에게 직접 진행하지 않습니다. 이후 분기는 마누스가 담당합니다.
