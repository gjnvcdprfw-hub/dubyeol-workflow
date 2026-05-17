# 두별워크플로우 v3.5.0 Task Card Template

> 이 문서는 **마누스가 작성**하고, Claude Code가 해당 run에서 기본으로 읽는 작업 카드입니다. Claude Code는 이 문서에 없는 범위를 임의로 확장하지 않습니다.

| 필드 | 값 |
|---|---|
| run_id | `<YYYYMMDD-HHMM-short-slug>` |
| 작성일 | `<YYYY-MM-DD>` |
| 작성자 | `마누스` |
| 주 편집자 | `마누스` |
| 실행자 | `Claude Code` |
| 최종 승인자 | `대표님` |
| 상태 | `draft / approved / in_progress / blocked / ready_for_review / done` |

## 1. 대표님 요청 요약

`<대표님이 요청한 내용을 3~5문장으로 요약합니다. 사업 목적, 원하는 결과, 우선순위를 포함합니다.>`

## 2. 작업 배경과 현재 맥락

| 항목 | 내용 |
|---|---|
| Git 기준 현재 상태 | `<현재 HEAD, 관련 커밋, 관련 diff 또는 확인 필요 사항>` |
| 보조 맥락 | `<project-context-bridge, next-task-handoff, 관련 문서 등. 없으면 없음>` |
| 이번 run이 필요한 이유 | `<이 작업을 지금 하는 이유>` |

## 3. 목표와 성공 기준

| 구분 | 내용 |
|---|---|
| 목표 | `<이번 run에서 달성할 단일 목표>` |
| 성공 기준 1 | `<검증 가능한 기준>` |
| 성공 기준 2 | `<검증 가능한 기준>` |
| 성공 기준 3 | `<검증 가능한 기준, 필요 시>` |

## 4. 제외 범위

| 제외 항목 | 이유 |
|---|---|
| `<이번 run에서 하지 않을 작업>` | `<범위 확장 방지 이유>` |

## 5. Tier 및 Gate 기준

| 항목 | 값 |
|---|---|
| Tier | `A / B / C` |
| Tier 판정 근거 | `<API, DB, 개인정보, 적하목록, UI 문구 등 근거>` |
| Codex 감리 필요 여부 | `필수 / 조건부 / 생략 사유` |
| ChatGPT Gate 필요 여부 | `필수 / 조건부 / 생략 사유` |
| ChatGPT 판정 강제력 | `Tier A/B 강제, Tier C 권고 또는 task-card상 생략 가능` |
| gate-review.md 필요 여부 | `Tier A/B 필수, Tier C 선택` |

## 6. Gate 용어 기준

이 템플릿에서는 예전 `Gate 1 / Gate 2`라는 모호한 표현 대신 아래 기준을 사용합니다.

| 용어 | 의미 |
|---|---|
| Codex 감리 | 코드·diff·테스트·실행 증거 기반 외부 감리 |
| ChatGPT Gate | Gate Judge + Devil’s Advocate의 진행·수정·보류·중단 판정 |
| gate-review.md | Codex 감리와 ChatGPT Gate 결과를 마누스가 분리 기록하는 문서 |

## 7. 자동 수정 루프 기준

| 항목 | 값 |
|---|---|
| 자동 수정 허용 여부 | `Tier A는 대표님 확인 후 / Tier B,C는 최대 3회 허용` |
| 최대 루프 | `3회` |
| 4회째 처리 | `자동 진행 금지. 마누스가 대표님께 원인·완료분·대안·확인 필요 사항 보고` |

## 8. Claude Code 실행 지시

1. 글로벌 `~/.claude/CLAUDE.md`와 프로젝트 `CLAUDE.md`를 기준으로 작업합니다.
2. 이 `task-card.md`의 목표, 성공 기준, 제외 범위, Tier, 금지사항을 확인합니다.
3. **Superpowers 전체 프로세스**를 명시적으로 사용합니다.
   1. 시작 시 `/using-superpowers`를 실행하고, 관련 skill이 1%라도 적용 가능하면 해당 skill을 먼저 사용합니다.
   2. 구현 전 `brainstorming`을 1회 수행하고, 대표님에게 직접 질문하지 말고 필요한 질문을 마누스에게 전달합니다.
   3. 설계 승인 또는 마누스 지시 후 `writing-plans`로 task 단위 계획을 작성합니다.
   4. 원칙적으로 `using-git-worktrees`를 검토합니다. 단, 이 task-card에서 main repo 직접 작업 또는 기존 작업트리 사용을 명시한 경우 그 결정을 따르고 `handoff.md`에 예외 사유를 기록합니다.
   5. 코드 구현은 가능한 경우 `test-driven-development`의 RED/GREEN/REFACTOR를 따릅니다. 테스트 선행이 부적절하거나 불가능하면 사유를 `handoff.md`에 기록합니다.
   6. 구현 실행은 `subagent-driven-development` 또는 task-card가 허용한 `executing-plans`를 사용합니다.
   7. 각 주요 task 후 `requesting-code-review`와 `receiving-code-review` 흐름으로 spec compliance와 code quality 리뷰를 처리합니다.
   8. 완료·통과·`ready_for_review`·commit 가능 상태를 말하기 전 `verification-before-completion` 기준으로 fresh command output과 exit code를 확인합니다.
   9. 구현과 검증이 끝나면 `finishing-a-development-branch` 관점으로 merge/PR/keep/discard 선택지를 정리하되, merge/push/cleanup/discard는 실행하지 말고 마누스 승인 대기 상태로 `handoff.md`에 기록합니다.
4. Codex 또는 ChatGPT를 직접 호출하지 않습니다.
5. 완료 또는 block 시 `handoff.md`를 작성합니다.

## 9. Context7 / Code Simplifier 규칙

Claude Code는 Context7과 Code Simplifier를 Superpowers 본 체인에 routine하게 끼워 넣지 않습니다.

| 도구 | 사용 기준 | 증거 |
|---|---|---|
| Context7 | 구체적인 구현·debugging·setup·configuration·migration·test decision이 외부 library/API/SDK/framework/version-specific documentation에 의존하고, repository 또는 project docs만으로 명확하지 않을 때만 사용 | library ID, query/topic, 관련 version, 필요 사유, evidence summary, decision affected |
| Code Simplifier | 구현 또는 fix가 relevant focused verification green이 된 뒤 post-green preservation step으로만 사용 | pre-green verification, 수정 범위, post-simplification verification, behavior 보존 확인 |

Code Simplifier는 debugging, failing test 수리, feature implementation, behavior change, API redesign, database semantics 변경, migration 변경, security/authorization behavior 변경, opportunistic cleanup에 사용하지 않습니다. 버그·테스트 실패 루프에서는 먼저 `systematic-debugging → test-driven-development → verification-before-completion`을 수행하고, root-cause fix가 green으로 검증된 뒤에만 Code Simplifier를 제한적으로 사용할 수 있습니다.

Claude Code는 Context7·Code Simplifier 사용을 이유로 Codex, ChatGPT 또는 승인되지 않은 외부 모델을 직접 호출하지 않습니다. push, merge, deploy, discard, branch reset, history rewrite, 승인 범위 밖 cleanup/file deletion, broad refactor, task scope expansion도 대표님 또는 마누스의 명시 승인 없이는 수행하지 않습니다.

## 10. 관련 파일과 영역

| 경로/영역 | 목적 | 읽기/수정 여부 |
|---|---|---|
| `<path>` | `<관련 이유>` | `읽기 / 수정 가능 / 수정 금지` |

## 11. 금지사항

| 금지사항 | 이유 |
|---|---|
| task-card 밖 범위 임의 확장 금지 | 맥락 유지와 효율적 목표 달성 |
| Codex·ChatGPT 직접 호출 금지 | 독립 감리·판정 구조 보존 |
| 대표님과 직접 기획 금지 | 마누스 Orchestrator 구조 보존 |
| 검증 실패를 성공으로 보고 금지 | 최종 결과물 신뢰성 보존 |
| 승인 없는 commit/push/merge/deploy 금지 | 권한 경계 보존 |

## 12. 대표님 확인 필요 사항

| 질문 | 필요한 이유 | 선택지 |
|---|---|---|
| `<질문>` | `<이유>` | `<승인 / 수정 / 보류 / 중단 등>` |

## 13. handoff 작성 위치

Claude Code는 작업 종료 시 아래 파일을 작성합니다.

```text
.harness/runs/<run_id>/handoff.md
```

