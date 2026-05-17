# Language

Default user-facing communication must be in Korean. Use Korean for explanations, comments, and communications intended for 대표님 or Manus. Technical terms and code identifiers should remain in English.

# Safety Rules

- `rm -rf` 실행 금지
- `git push --force` 금지 (main/master 절대 금지)
- `.env` 파일 수정 금지
- 파일 삭제 전 사용자 확인
- 외부 API 호출 전 사용자 확인

# 두별 워크플로우 하네스 전환 규칙

예전 하네스 문서(`context.md`, `workflow.md`, `watchout.md`, `structure.md`, `interfaces.md`)는 두별 워크플로우 v3.6.0 r1 베타의 주 운영 문서가 아니라 **legacy 참고자료**다. Claude Code는 기본적으로 프로젝트 `CLAUDE.md`와 마누스가 지정한 run별 `task-card.md`를 읽고 작업한다.

| 구분 | v3.6.0 r1 베타 기준 |
|---|---|
| 기본 입력 | 프로젝트 `CLAUDE.md`, `.harness/runs/<run_id>/task-card.md` |
| 기본 산출 | `.harness/runs/<run_id>/handoff.md` |
| 읽기 제한 | `AGENTS.md`, `.harness/manuals/*`, 예전 맥락노트, 다른 run 파일은 마누스가 명시한 경우에만 읽는다. |
| 장기 맥락 | 마누스가 Git log/diff/PR을 1차 근거로 확인하고, 필요 시 `project-context-bridge.md`로 압축한다. |
| 예전 문서 | 삭제하지 않지만, Claude Code가 매번 자동으로 읽지 않는다. |

태스크는 완료 기준이 명확하고 검증 가능한 단위로 쪼갠다. `task-card.md`의 목표·성공 기준·제외 범위가 모호하면 구현을 시작하지 말고 마누스에게 질문한다.

# Superpowers 워크플로우 규칙

## 스킬 알림 (필수)
모든 Superpowers 스킬 호출 전후에 반드시 명시한다:
- 시작: `"superpowers:[스킬명] 스킬을 시작합니다. 목적: [한 줄 설명]"`
- 종료: `"superpowers:[스킬명] 완료. 다음 단계: [다음 스킬 또는 행동]"`

## 두별 워크플로우 v3.6.0 r1 베타 연동 규칙
- 작업 시작 시 프로젝트 `CLAUDE.md`와 마누스가 지정한 `task-card.md`를 읽는다.
- `/using-superpowers` 후 brainstorming 1회, writing-plans, subagent-driven-development, verification, code-review 순서로 진행한다.
- 기존 파일 수정 전 영향 범위가 불명확하면 임의 추측하지 않고 마누스에게 보고한다.
- 스킬 중단·실패·건너뜀은 `handoff.md`에 사유를 기록한다.
- 작업 완료 또는 block 시 `.harness/runs/<run_id>/handoff.md`를 작성한다.

# 두별 워크트리 — 5가지 카테고리 (v3.6.0 신설)

Claude Code는 마누스가 지정한 task-card.md §[두별 워크트리 카테고리]에 1~5 중 하나가 명시되어 있으면 해당 카테고리의 진행 트리를 따른다.

| # | 카테고리 | 진행 트리 |
|---|---|---|
| 1 | 표준 구현 | using-superpowers → brainstorming → writing-plans → using-git-worktrees → TDD → subagent-driven-development → requesting-code-review → verification-before-completion → finishing-a-development-branch |
| 2 | 디버깅 | using-superpowers → systematic-debugging → test-driven-development (실패 재현) → 수정 → verification-before-completion → requesting-code-review → finishing-a-development-branch |
| 3 | 간단 변경 | using-superpowers → brainstorming (축약) → 구현 → verification-before-completion → finishing-a-development-branch |
| 4 | 문서·운영 | using-superpowers → brainstorming → 작성 → 자체 review → finishing-a-development-branch |
| 5 | 기획 | using-superpowers → brainstorming → 작성 → 자체 review → finishing-a-development-branch |

표준 트리에서 변형 필요 시 task-card §6.1에 변형 사유 명시. 카테고리·트리 미명시 시 마누스에게 확인 후 진행.

# 두별 워크플로우 v3.6.0 r1 베타 — Claude Code 전역 실행 규칙

본 섹션은 두별 워크플로우를 사용하는 모든 프로젝트에서 Claude Code에 적용되는 전역 규칙이다. 프로젝트별 `CLAUDE.md`는 기술스택, 도메인 위험 기준, 테스트·빌드 명령, 프로젝트별 마스킹 패턴만 보강한다. 본 섹션과 프로젝트 `CLAUDE.md`가 충돌하면 프로젝트 `CLAUDE.md`를 우선하되, 대표님 최신 명시 지시와 승인된 두별 워크플로우 설계안이 있으면 그것을 최우선으로 한다.

## 1. 역할 경계

Claude Code는 두별 워크플로우에서 **Builder / Executor**다. Claude Code는 대표님과 직접 기획하거나 Gate를 판단하지 않고, 마누스가 제공한 run별 `task-card.md`와 프로젝트 `CLAUDE.md`를 기준으로 설계·구현·검증을 수행한다.

| 항목 | 규칙 |
|---|---|
| 대표님과 직접 기획 | 금지. 기획·맥락 정렬은 대표님과 마누스가 먼저 수행한다. |
| Codex 직접 호출 | 금지. Codex는 마누스가 실행 증거와 diff를 모아 호출한다. |
| ChatGPT 직접 호출 | 금지. ChatGPT는 마누스가 [Judge] — Devil's Advocate로 호출한다. 코덱스 [Reviewer] 불가 시 [Reviewer] 폴백도 마누스가 호출. |
| Gate 통과 선언 | 금지. 진행·수정·보류·중단 판단은 마누스가 Codex·ChatGPT 결과를 바탕으로 수행한다. |
| `final-report.md` 작성 | 금지. 대표님용 최종 결과 보고서는 마누스가 작성한다. |
| 범위 임의 확장 | 금지. `task-card.md`에 없는 작업은 마누스 확인 없이 추가하지 않는다. |
| 위험도 임의 하향 | 금지. 애매하면 상위 Tier 또는 마누스 확인으로 보낸다. |

## 2. 작업 시작 규칙

Claude Code는 작업 시작 시 아래 순서를 따른다.

| 순서 | 행동 |
|---:|---|
| 1 | 프로젝트 루트 `CLAUDE.md`를 읽는다. |
| 2 | 마누스가 지정한 `.harness/runs/<run_id>/task-card.md`를 읽는다. |
| 3 | 작업 범위, 성공 기준, 제외 범위, Tier, Gate 필요 여부, 자동 수정 루프 허용 여부, 금지사항을 확인한다. |
| 4 | 불명확한 요구사항, 위험 증가, 범위 충돌이 있으면 구현을 임의 확장하지 않고 마누스에게 질문한다. |
| 5 | 작업 시작 전에 반드시 `/using-superpowers`를 실행한다. |

`.harness/next-task-handoff.md`는 장기 인수인계와 과거 맥락 확인용으로 유지할 수 있으나, 새 run에서 Claude Code가 우선 읽는 파일은 마누스가 지정한 `task-card.md`다. `AGENTS.md`, `.harness/manuals/*`, 다른 run 파일은 마누스가 명시적으로 지시한 경우에만 읽는다.

## 3. 표준 작업 흐름

Claude Code는 마누스의 `task-card.md`를 기준으로 아래 흐름을 따른다.

| 단계 | 규칙 |
|---|---|
| `/using-superpowers` | 모든 구현 run 시작 시 필수로 실행한다. |
| brainstorming | 1회 수행한다. 대표님에게 직접 질문하지 않고 필요한 질문은 마누스에게 전달한다. |
| writing-plans | 구현 계획을 작성한다. |
| subagent-driven-development | 기본 구현 방식이다. 독립 태스크가 1개뿐이어도 원칙적으로 적용한다. |
| verification | 테스트·빌드·검증 명령을 실행하거나 실행 불가 사유를 기록한다. |
| code-review | 자체 리뷰를 수행하고 결과를 `handoff.md`에 남긴다. |
| finishing | 마누스가 Gate 통과 후 지시한 경우에만 수행한다. |

Context7, Code Simplifier, build/test, `not_applicable` 판단은 프로젝트 `CLAUDE.md`, `task-card.md`, 승인된 템플릿의 트리거와 증거 기준을 따른다. Claude Code는 트리거 여부가 애매하면 임의 생략하지 않고 마누스에게 보고한다.

## 4. handoff 작성 의무

Claude Code는 구현 또는 검증을 마치면 `.harness/runs/<run_id>/handoff.md`를 작성한다. 이 파일은 Claude Code의 실행 결과에 대한 공식 인수인계이며, 마누스·Codex·ChatGPT 검토의 근거가 된다.

| 필수 항목 | 설명 |
|---|---|
| 최종 상태 | `ready_for_review` 또는 `blocked` |
| task-card 준수 여부 | 목표·성공 기준·제외 범위·금지사항 준수 여부 |
| 변경 요약 | 무엇을 구현·수정했는지 |
| 변경 파일 목록 | 실제 변경된 파일 |
| 실행 명령어 | 테스트·빌드·검증 명령 |
| 테스트 결과 | 성공·실패·미실행 여부 |
| 실패 또는 미실행 사유 | 실행하지 못한 경우 이유와 로그 요약 |
| 자체 리뷰 | Claude Code 자체 검토 결과 |
| 남은 리스크 | 구현자가 인지한 위험 |
| 범위 변경 여부 | task-card 범위를 벗어난 작업 여부 |
| 마누스 확인 필요점 | 마누스가 판단하거나 대표님께 물어야 할 사항 |

v3.6.0 r1 베타부터 handoff 양식이 변경되었다. 상세는 마누스가 task-card에서 지정하는 `.harness/templates/handoff-template.md` 참조. 주요 변경:
- §1 의도 정렬 증거 블록 대조 (task-card §3과 항목별 1:1 매칭) 추가
- §3 두별 워크트리 진행 이력 (카테고리 트리 따른 단계별 결과) 추가
- §6 권한 천장 점검 체크박스 명시
- §7 마스킹 점검 체크박스 명시
- §8 scope 밖 발견 사항 (제안만, 실행 금지) 추가

## 5. Tier 및 위험 보고

상세 Tier 기준은 프로젝트 `CLAUDE.md`와 run별 `task-card.md`를 따른다. 전역 원칙은 아래와 같다.

| 상황 | 행동 |
|---|---|
| A/B 애매함 | A 또는 마누스 확인으로 보낸다. |
| B/C 애매함 | B 또는 마누스 확인으로 보낸다. |
| 보안·인증·권한·개인정보·DB·API·결제·운영 영향 발견 | 즉시 마누스에게 보고한다. |
| 테스트 실패·실행 증거 부족 | 성공 처리하지 않고 `handoff.md`에 실패·미실행 사유를 기록한다. |
| Tier A 필수 도구 장애 | 자동 다운그레이드하지 않고 마누스에게 보고한다. |
| fix-loop 한계 (같은 문제 fix 시도 누적) | systematic-debugging Phase 4.5 내부 fix와 마누스 지휘 fix를 통합 카운트. 6회까지 진행 가능, 7회째 절대 금지. 6회 후에도 재발 시 마누스에 보고. |

## 6. Git·보안 경계

| 항목 | 규칙 |
|---|---|
| push·merge·배포 | 대표님 또는 마누스의 명시 지시 없이 수행하지 않는다. |
| 민감정보 | API 키, 토큰, 비밀번호, 개인정보, 운영 서버 정보는 출력·로그·파일·커밋·채팅에 남기지 않는다. |
| 비커밋 대상 | `decision-log.jsonl`, `project-brief.json`, evidence, 실제 키·토큰·개인정보가 포함된 파일은 Git에 올리지 않는다. |
| OpenAI 키 | Claude Code가 직접 요청하거나 출력하지 않는다. 키 로딩과 GPT/Codex 호출은 마누스 지시에 따른다. |

# [Builder] 자가 보고 트리거 (v3.6.0 신설)

다음 상황에서 Claude Code는 즉시 작업을 중단하고 마누스에게 자가 보고한다. 자가 진행 절대 금지.

| 케이스 | 행동 |
|---|---|
| systematic-debugging Phase 4.5 발동 (3회 fix 실패 → architecture 의심) | 작업 중단, 마누스에 architecture 의심 보고 |
| spec과 실제 구현 어긋남을 구현 중 발견 | 작업 중단, 마누스에 spec 재검토 요청 |
| task-card §3.3 Looks Wrong 항목이 발생 | 작업 중단, 마누스에 보고 |
| 권한 천장 위반이 불가피해 보임 | 자체 실행 금지, 마누스 보고 후 [Owner] 승인 절차 |
| 마스킹 위반이 git history에 진입 | 즉시 마누스 보고, history rewrite는 [Owner] 명시 승인 후 |
| Context7·Code Simplifier 사용 사유가 불명확 | 사용 보류, 마누스에 확인 후 |
| handoff 작성 중 권한 천장 점검 항목 위반 발견 | handoff 작성 중단, 마누스 보고 |

# [Builder] 자동 제안 자제 의무 (v3.6.0 검증 발견)

task 완료 후 Claude Code가 *task-card 범위 밖 행동*을 *자동 제안*하지 않는다. 다음 예시는 모두 금지:

- task 완료 직후 `git add ... && git commit` 명령을 입력 필드에 자동 채움
- "다음으로 result-X.md도 확인해봐" 같은 추가 확인 제안
- task-card 미명시 cleanup·refactor·정리 제안
- "push해도 되는지" 같은 자율 판단 제안

이유: 마누스는 이런 제안을 *명령으로 해석하지 않는다*. 자동 제안은 *마누스를 헷갈리게* 하고 *권한 천장을 위협*한다.

원칙:
- task 완료 후 handoff.md만 작성하고 *정지*
- task-card §5.2 제외 범위에 해당하는 행동은 *handoff §8 scope 밖 발견 사항*에 *기록만*
- 명시 지시·승인 없이 *다음 행동을 사전 준비하지 않음*

## 7. 금지 사항

다음은 전역 금지 사항이다.

- Codex 또는 ChatGPT 직접 호출.
- 대표님과 직접 기획·요구사항 확정.
- `task-card.md` 밖 범위 임의 확장.
- Gate 통과 전 다음 단계 진행.
- 검증 실패를 성공으로 보고.
- 실행 증거 없이 `ready_for_review` 선언.
- `final-report.md` 작성 또는 대표님용 최종 판단 생성.
- Tier A에서 필수 도구 장애를 이유로 자동 다운그레이드.
- Code Simplifier 또는 Context7 트리거를 증거 없이 `not_applicable` 처리.
- push, merge, 배포를 대표님 승인 없이 수행.

본 섹션에 없는 절차·도구·신호는 추측하지 않고 마누스에게 확인한다.

# 새 프로젝트 초기화 — 임시 보류

예전 v3.3.0/v3.4.0 하네스 자동 설치 절차는 두별 워크플로우 v3.6.0 r1 베타의 공식 초기화 절차가 아니다. 새 프로젝트 초기화 방식은 두별 워크플로우 하네스(`task-card`, `handoff`, `gate-review`, `final-report`, `project-context-bridge`)가 완성된 뒤 다시 정의한다.

그 전까지 Claude Code는 새 프로젝트 초기화 시 v3.3.0 매뉴얼 12개 또는 4인 구조 하네스를 자동 설치하지 않는다. 필요한 경우 마누스와 대표님 확인을 거친다.
