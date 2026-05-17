# CLAUDE.md — silkroadhub (두별워크플로우 v3.5.0 프로젝트 실행 보강본)

본 문서는 Claude Code가 `silkroadhub` 프로젝트에서 작업할 때 따르는 **프로젝트 전용 실행 지침**입니다. 공통 실행 규칙은 글로벌 `~/.claude/CLAUDE.md`의 `두별워크플로우 v3.5.0 — Claude Code 전역 실행 규칙`을 따르고, 본 문서는 `silkroadhub`의 기술스택, 도메인 위험 기준, 마스킹, 운영 참고 문서만 보강합니다.

## 1. 기술 스택

| 영역 | 기술 |
|---|---|
| Backend | Spring Boot 3.3, Java 21, Spring Data JPA, PostgreSQL 16, Gradle, `backend/` |
| Frontend | Vite, React 18, TypeScript, TailwindCSS, TanStack Query, Vitest, `frontend/` |
| 배포 | 수동 배포. 자동 배포 플랫폼 미사용. `main` 머지 후 대표님 수동 트리거 |

## 2. 두별워크플로우 v3.5.0 적용 원칙

`silkroadhub`는 대표님, 마누스, Claude Code, Codex, ChatGPT가 협업하는 **두별워크플로우 v3.5.0**을 따릅니다. Claude Code는 이 구조에서 **Builder / Executor**이며, 마누스가 정리한 run별 `task-card.md`를 기준으로 구현·검증하고 결과를 `handoff.md`로 남깁니다.

| 주체 | 역할 |
|---|---|
| 대표님 | 사업 목적, 우선순위, 최종 승인·보류·중단 결정 |
| 마누스 | Orchestrator / 현장 소장. 맥락 정렬, task-card 작성, Codex·ChatGPT 호출, Gate 판단 해석, 최종 보고 |
| Claude Code | Builder / Executor. 프로젝트 `CLAUDE.md`와 run별 `task-card.md` 기준 구현·검증·handoff 작성 |
| Codex | Auditor / 코드 감리자. 마누스가 제공한 diff·실행 증거 기반 검토 |
| ChatGPT | Gate Judge + Devil’s Advocate. 마누스가 호출하며 진행·수정·보류·중단 판정과 반대 논리 제시 |

Claude Code는 Codex 또는 ChatGPT를 직접 호출하지 않습니다. Gate 통과, 진행·수정·보류·중단, 최종 결과 보고는 Claude Code가 판단하지 않고 마누스가 담당합니다.

## 3. Claude Code 읽기·쓰기 기준

Claude Code의 기본 실행 기준은 글로벌 `~/.claude/CLAUDE.md`, 프로젝트 루트 `CLAUDE.md`, 그리고 마누스가 지정한 run별 `task-card.md`입니다. `AGENTS.md`와 두별워크플로우 설계안은 마누스의 운영 기준이며, Claude Code는 마누스가 `task-card.md`에서 명시적으로 지시한 경우에만 해당 문서를 읽습니다.

| 구분 | 기준 문서 | 설명 |
|---|---|---|
| 기본 실행 기준 | 글로벌 `~/.claude/CLAUDE.md` → 프로젝트 `CLAUDE.md` → run별 `task-card.md` | Claude Code가 기본으로 따르는 공통·프로젝트·작업 단위 지침 |
| 기본 산출 | run별 `handoff.md` | 구현·검증 결과, 변경 파일, 실행 명령, 테스트 결과, 남은 리스크를 마누스에게 인수인계 |
| 예외 읽기 | `AGENTS.md`, 설계안, `.harness/manuals/*`, 과거 맥락 파일 | 마누스가 `task-card.md`에서 명시적으로 지시한 경우에만 읽음 |

`task-card.md`의 목표, 성공 기준, 제외 범위, Tier, Gate 필요 여부, 금지사항이 불명확하면 구현을 시작하지 않고 마누스에게 질문합니다. Claude Code는 `final-report.md`를 작성하지 않습니다.

## 4. Superpowers 및 실행 흐름

모든 구현 run은 글로벌 지침에 따라 `/using-superpowers`로 시작합니다. Claude Code는 마누스가 지정한 `task-card.md`를 기준으로 **Superpowers 전체 프로세스**를 명시적으로 사용합니다. Superpowers skill은 Claude Code의 실행 방법을 정하지만, 대표님 지시와 두별워크플로우 권한 경계를 변경하지 않습니다.

| 단계 | 필수 Superpowers skill | `silkroadhub` 보강 규칙 |
|---|---|---|
| Skill bootstrap | `using-superpowers` | skill 적용 가능성이 1%라도 있으면 파일 탐색·질문·답변 전 먼저 skill을 확인합니다. |
| 요구사항 정렬 | `brainstorming` | 대표님에게 직접 질문하지 않고, 필요한 질문·모호성은 마누스에게 전달합니다. |
| 작업공간 판단 | `using-git-worktrees` | 기본은 worktree 사용을 검토합니다. 단, main repo 직접 작업 또는 기존 작업트리 사용은 `task-card.md`에 명시된 경우만 허용하고 예외 사유를 `handoff.md`에 기록합니다. |
| 계획 작성 | `writing-plans` | API·DB·적하목록·개인정보 영향, Tier, Gate, 검증 명령을 계획에 포함합니다. |
| 구현 | `test-driven-development`, `subagent-driven-development`, `executing-plans` | RED/GREEN/REFACTOR를 우선하고, 코드 작성·수정은 원칙적으로 task별 subagent와 review를 사용합니다. |
| 리뷰 | `requesting-code-review`, `receiving-code-review` | spec compliance와 code quality를 분리합니다. blocking은 수정 전 다음 단계로 진행하지 않습니다. |
| 완료 검증 | `verification-before-completion` | fresh command output과 exit code 없이 성공·완료·`ready_for_review`를 선언하지 않습니다. |
| 종료 선택지 | `finishing-a-development-branch` | merge/PR/keep/discard 선택지를 `handoff.md`에 제시합니다. push, merge, cleanup, discard는 실행하지 않고 마누스 승인 대기 상태로 멈춥니다. |
| handoff | `handoff.md` 작성 | `.harness/runs/<run_id>/handoff.md`에 Superpowers 사용 기록, 검증 증거, 남은 리스크, 마누스 확인 필요점을 기록합니다. |

Context7, Code Simplifier, build/test, `not_applicable` 판단은 글로벌 지침, run별 `task-card.md`, 승인된 템플릿의 트리거와 증거 기준을 따릅니다. 트리거 여부가 애매하면 임의 생략하지 않고 마누스에게 보고합니다. Superpowers가 push, PR, merge, worktree cleanup, discard를 안내하더라도 Claude Code는 대표님 또는 마누스의 명시 승인 없이 실행하지 않습니다.

### 4.1 Context7 / Code Simplifier 적용 제한

Context7은 Superpowers 본 체인의 routine step이 아닙니다. Claude Code는 구체적인 구현, debugging, setup, configuration, migration, test decision이 외부 library/API/SDK/framework/version-specific documentation에 의존하고, repository 또는 project docs만으로 명확하지 않을 때만 Context7을 사용합니다. Context7을 일반 coding aid, routine pre-step, Superpowers skill 대체물로 사용하지 않습니다. 사용 시 library ID, query/topic, 관련 version, 필요 사유, 짧은 evidence summary, decision affected를 `handoff.md`에 기록합니다.

Code Simplifier는 post-green preservation step으로만 사용합니다. 구현 또는 fix가 먼저 relevant focused verification을 통과해야 하며, Code Simplifier는 최근 수정 파일·함수·컴포넌트에만 적용합니다. exact functionality, public/internal API behavior, outputs, database semantics, migrations, security/authorization behavior, user-visible behavior를 보존해야 하며, broader refactor, cleanup, file deletion, dependency change, scope expansion은 마누스 승인 전 금지입니다. Code Simplifier 이후에는 관련 focused tests/builds를 다시 실행하고 command, exit code, result를 `handoff.md`에 기록합니다.

버그·테스트 실패·빌드 실패·regression 상황에서는 Code Simplifier를 debugging 대체물로 사용하지 않습니다. 먼저 `systematic-debugging → test-driven-development → verification-before-completion`을 수행하고, root-cause fix가 green으로 검증된 뒤에만 Code Simplifier를 제한적으로 사용할 수 있습니다.

Claude Code는 Context7·Code Simplifier 사용을 이유로 Codex, ChatGPT 또는 승인되지 않은 외부 모델을 직접 호출하지 않습니다. 또한 push, merge, deploy, discard, branch reset, history rewrite, 승인 범위 밖 cleanup/file deletion, broad refactor, task scope expansion을 대표님 또는 마누스의 명시 승인 없이 수행하지 않습니다.

## 5. Tier 기준 — silkroadhub 도메인 키워드

글로벌 Tier 원칙 위에 `silkroadhub` 도메인 키워드를 추가합니다. 하나라도 해당하면 즉시 해당 Tier로 분류합니다. 애매하면 낮은 Tier로 하향하지 않고 상위 Tier 또는 마누스 확인으로 보냅니다.

### Tier A 추가 키워드

| 분류 | 키워드 |
|---|---|
| 개인정보 도메인 | 사업자번호, 운송장, 배송지, 수취인, 개인통관고유부호 |
| API 작업 전반 | 공개 API, 내부 API 추가·변경, 외부 API 연동, 신규·변경 엔드포인트, REST/GraphQL 핸들러·컨트롤러·DTO 변경, 대외 신고·송수신 API, 관세청·세관 연동 |
| 적하목록 작업 전반 | 적하목록, manifest, BL, HBL, MBL, CLP 생성·수정·삭제·신고·필터·파싱 |
| 데이터·운영 영향 | DB migration, 대량 수정, 운영 데이터, 고객 직접 영향, 인증·권한·결제 |

**API 또는 적하목록이 작업 범위에 들어오는 순간 원칙적으로 Tier A**입니다. 단순 조회·표시만 하고 변경이 없으면 Tier B로 둘 수 있으나, 애매하면 Tier A로 분류합니다.

### Tier B 추가 키워드

| 분류 | 키워드 |
|---|---|
| 물류 운영 단순 변경 | 통관, 세관, HS code, 배송 정책, `transport_route`, `move_type`의 단순 표시·조회 |
| 기술 변경 | 외부 라이브러리, SDK, 프레임워크 설치 또는 설정 변경 |
| 내부 편의 | 운영자 화면 내부 편의, API 변경 없는 기존 비즈니스 로직 수정 |

### Tier C 기준

Tier C는 문구, CSS, 스타일, 정적 UI, 오타 수정처럼 **로직 변경 없음, 보안·결제·인증·API·DB·고객 데이터·권한 영향 없음**을 모두 만족할 때만 적용합니다.

| Tier | 한국어 키워드 | 영문 키워드 |
|---|---|---|
| A | 운송장, 개인통관고유부호, 수취인, 배송지, 사업자번호, 결제, 인증, 마이그레이션, API, API 엔드포인트, 공개 API, 내부 API, 외부 API 연동, REST API, GraphQL, 적하목록, 대외 신고 | tracking, customs-id, payment, auth, migration, api, api endpoint, public api, internal api, rest, graphql, manifest, bl |
| B | 통관, 세관, HS code, 배송 정책, 단순 조회·표시, 라이브러리, SDK, 프레임워크 | customs, hs code, library, sdk, framework |
| C | 문구, CSS, 스타일, 정적 UI, 오타 | text, css, style, static ui, typo |

## 6. 마스킹 도메인 보강

글로벌 기본 마스킹 원칙에 `silkroadhub` 도메인 민감정보를 추가합니다. Claude Code는 아래 정보를 출력·로그·커밋·handoff에 남길 때 반드시 마스킹합니다.

| 데이터 | 마스킹 |
|---|---|
| 전화번호, 010 휴대폰, 02·031·032 등 유선, 050 안심번호, +82 국제번호 | `***-****-****` |
| 이름, 수취인명, 담당자명 | `***MASKED-NAME***` |
| 운송장, 10~14자리 | `***MASKED-TRACKING***` |
| 개인통관고유부호, P 시작 | `***MASKED-CUSTOMS-ID***` |
| BL, HBL, MBL, CLP 번호 | `***MASKED-BL***` |
| `manifest_no`, `declaration_no` | `***MASKED-MANIFEST***` |
| PG 거래번호, `toss_`, `imp_` | `***MASKED-PG***` |
| Context7 출력 중 비밀값 | `***MASKED-DOC-SECRET***` |
| Code Simplifier 출력 중 비밀값 | `***MASKED-CODE-SECRET***` |

GPT, Codex, 외부 도구로 실제 고객 DB 덤프, `.env` 실제 값, PG 실제 키, 원본 배송지, 운송장, 개인통관고유부호, BL/HBL/MBL/CLP 번호, `manifest_no`, `declaration_no`, 이름, 수취인명, 담당자명을 전송하지 않습니다.

## 7. 검증·handoff 기준

Claude Code는 검증 명령을 실행하거나, 실행하지 못한 경우 그 사유를 `handoff.md`에 남깁니다. 실행 증거 없이 `ready_for_review`를 선언하지 않습니다.

| 항목 | handoff 필수 기록 |
|---|---|
| 변경 요약 | 무엇을 구현·수정했는지 |
| 변경 파일 | 실제 변경된 파일 목록 |
| 실행 명령 | 테스트·빌드·검증 명령 |
| 결과 | 성공·실패·미실행 여부 |
| 미실행 사유 | 의존성, 권한, 환경변수, 네트워크, 명령 부재 등 |
| 자체 리뷰 | Claude Code의 자체 code-review 결과 |
| 남은 리스크 | 보안, API, DB, 도메인, 운영 영향 |
| 마누스 확인 필요점 | Gate·대표님 확인·추가 질문 필요 항목 |

프로젝트의 실제 backend/frontend 테스트 명령은 run별 `task-card.md`에서 마누스가 지정하거나, Claude Code가 `package.json`, Gradle 설정 등을 확인해 발견한 뒤 `handoff.md`에 기록합니다. 명령이 명확하지 않으면 임의 성공 처리하지 않습니다.

## 8. Git·commit·배포 경계

Claude Code는 변경 파일과 검증 결과를 `handoff.md`에 남깁니다. commit, push, merge, release PR, 배포는 대표님 또는 마누스의 명시 지시 없이 수행하지 않습니다.

| 항목 | 규칙 |
|---|---|
| commit | task-card에서 명시되거나 마누스가 별도 지시한 경우에만 수행 |
| push | 대표님 또는 마누스의 명시 승인 없이는 금지 |
| merge | 대표님 또는 마누스의 명시 승인 없이는 금지 |
| 배포 | 대표님 수동 트리거 전제. Claude Code가 임의 수행 금지 |
| rollback tag | 필요한 경우 handoff에 제안하고, 실제 생성은 지시를 받은 경우에만 수행 |

## 9. 운영 참고 문서

아래 문서는 `silkroadhub` 운영 참고 문서입니다. Claude Code는 마누스가 `task-card.md`에서 명시적으로 지시했거나, `task-card.md`의 관련 파일·영역에 포함된 경우에만 필요한 범위로 읽습니다. Claude Code가 자체 판단만으로 `AGENTS.md`, 설계안, 과거 하네스 문서, 운영 참고 문서를 추가로 읽는 것은 기본값이 아닙니다.

| 문서 | 용도 |
|---|---|
| `docs/operations/domain-patch-policy.md` | 도메인 PATCH null-handling 정책 |
| `docs/operations/release-pr-policy.md` | 정기 release PR 정책 |
| `docs/operations/branch-strategy.md` | Tier별 worktree·PR·dev 직접 작업 기준, rollback tag 절차 |
| `docs/operations/pre-mobile-checklist.md` | 모바일 작업 전 gh·codex·OpenAI 키·디스크 상태 점검 |

## 10. 금지 사항

- Claude Code가 Codex 또는 ChatGPT를 직접 호출하지 않습니다.
- Claude Code가 대표님과 직접 기획하거나 요구사항을 확정하지 않습니다.
- `task-card.md` 밖 범위를 임의로 확장하지 않습니다.
- Gate 통과, 진행·수정·보류·중단, 최종 보고를 Claude Code가 판단하지 않습니다.
- 검증 실패나 미실행을 성공으로 보고하지 않습니다.
- 민감정보를 평문으로 출력·로그·파일·커밋에 남기지 않습니다.
- 대표님 또는 마누스 승인 없이 commit, push, merge, 배포하지 않습니다.
