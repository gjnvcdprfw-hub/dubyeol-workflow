# PROJECT.md — 두별 워크플로우 마스터 기획 맥락 및 진행 트래커

> **두별 워크플로우 v3.6.0 r1 (베타) 산출물**
> 본 문서는 두별 워크플로우 **마스터** 저장소의 *기획 맥락 + 살아있는 진행 트래커*다.
> 두별 워크플로우는 두별 사이에 공유되는 독립 운영 프레임워크·도구킷이며, silkroadhub는 첫 번째 사업 클라이언트다.
> task 시작 전 [Foreman]은 본 문서를 먼저 읽어 *상위 맥락*을 확인하고, task 종료 후 §C·§D를 갱신한다.

---

## A. 변하지 않는 부분 — 기획 맥락

### A.1 프레임워크 비전

두별 워크플로우는 두별이 운영하는 모든 사업 프로젝트에 공통으로 적용되는 **운영 프레임워크·도구킷**이다. [Owner]·[Foreman]·[Builder]·[Reviewer]·[Judge] 5자 거버넌스와 표준 5단계 흐름(SUB-1~5)을 통해 기획 의도-구현-외부 감리-수정-종료 사이클을 재현 가능하게 만든다.

### A.2 핵심 원칙

- **의도 정렬 우선**: task-card §3 의도 정렬 증거 블록이 모든 실행의 기준이다.
- **권한 천장 엄수**: push·merge·deploy·history rewrite는 [Owner] 명시 승인 전 절대 금지.
- **실행 증거 의무**: 검증 없는 완료 선언 금지. handoff에 증거 기록.
- **클라이언트 독립**: silkroadhub 등 클라이언트는 마스터 원본을 참조·복사하되, 마스터 직접 수정은 별도 마스터 task로 진행.

### A.3 저장소 구조

| 구분 | 경로 / URL | 역할 |
|---|---|---|
| 마스터 로컬 | `/Users/twostars/ClaudeAi/dubyeol-workflow` | 두별 워크플로우 원본·매뉴얼·스킬·run 이력 |
| 마스터 GitHub | `https://github.com/gjnvcdprfw-hub/dubyeol-workflow` | 마스터 공개 백업·버전 추적 |
| 클라이언트 (silkroadhub) | `/Users/twostars/ClaudeAi/silkroadhub` | 두별 워크플로우 적용 사업 프로젝트 |

### A.4 의도적 out-of-scope

- 두별 워크플로우 r7 매뉴얼 개정 자체는 Phase H 직접 산출물 아님 (별도 task).
- 클라이언트(silkroadhub) 사업 기능 코드 변경은 마스터 scope 밖.

---

## B. 분기·반기마다 갱신 — 중기 목표

### B.1 현재 분기·단계

- **기간**: 2026-05 ~
- **단계 이름**: r6 베타 운영 + 마스터/클라이언트 분리 완료 후 Phase G (스킬 동작 검증) 준비

### B.2 이번 기간 핵심 목표

1. Phase H 완료 — 마스터/클라이언트 분리, 독립 마스터 repo 구성
2. Phase G-1 진입 준비 — 9개 스킬 동작 검증 설계 (dubyeol-workflow 마스터에서 진행)
3. r7 정비 — Phase A~H 회고 메모 1~14 반영, 매뉴얼 개정

---

## C. 자주 갱신 — 모듈별 진행 상황 ★

### §C.1 두별 워크플로우 운영 인프라

- **한 줄 정의**: 두별 워크플로우 r6 베타 운영을 자동화·표준화하기 위한 Manus Agent Skills, run 산출물, 외부 감리, PROJECT.md 갱신 체계.
- **현재 상태**: Task 2 sync 스크립트 구현 완료. `scripts/sync-to-client.sh`, `.harness/sync-exclude.txt`, `.env.template`, `.gitignore` 보강이 완료되었고, 단위 테스트 7/7 PASS, dummy dry-run·실제 sync 2/2 PASS, 대표 체크섬 3/3 MATCH로 확인되었다. SUB-3 외부 감리는 API 키 문제로 [Owner] 지시에 따라 미수행했고, 본 채널 검수가 대체 수행했다. SUB-4에서 `.env.template`의 키 유사 placeholder를 `<SET_IN_SHELL_PROFILE>`로 정정하고 `.harness/sync-reports/` ignore 적용을 확인했다. 후속은 Task 3(9개 스킬 수정)과 r7 정비 동시 진입이다.
- **최근 마일스톤** (시간 역순, 최신이 위):
  - 2026-05-17: Task 2 sync 스크립트 구현 완료. `sync-to-client.sh` 구현, exclude/template/gitignore 보강, dummy client dry-run·실제 sync 검증 완료. SUB-3은 API 키 문제로 미수행하고 본 채널 검수로 대체. 회고 20 추가 사례·33 재적용·36 후보 기록. (run: `20260518_sync-script-implementation`)
  - 2026-05-17: 정책+sync 설계 완료. `policy.md` 175줄, `sync-design.md` 393줄, `skills-fix-guidelines.md` 417줄 작성. SUB-3 외부 API 감리는 자기 참조 부정합 회피를 위해 중단하고 [Owner] 본 채널 검수로 대체. 회고 33~34 후보 기록. (run: `20260518_skills-policy-and-sync-design`)
  - 2026-05-17: Phase G-2 — 9개 Manus Agent Skills 실제 동작 검증 및 Tier A 외부 감리 완료. 9개 전부 PARTIAL PASS, Reviewer HOLD, Judge 수정 판정. 회고 13급 잔재(`silkroadhub` hardcoded root)와 master/client 키 자료 의존 부정합을 확인하고, 마스터 측 키 복사본 삭제 및 `.gitignore` 보강 완료. (run: `20260518_g2-skills-verification-execution`)
  - 2026-05-17: Phase G-1 — 9개 Manus Agent Skills 동작 검증 설계 완료. `01-load-sub-manual`의 `scripts/load_sub.sh` 부재 의심 신호를 G-2 최우선 검증 대상으로 기록. (run: `20260517_g1-skills-verification-design`)
  - 2026-05-17: Phase H — 두별 워크플로우 마스터/클라이언트 분리 완료. dubyeol-workflow 독립 마스터 repo 구성, Phase A~F runs 이전, silkroadhub PROJECT.md §C.1 제거·§D 추가, GitHub rename 검증.
  - 2026-05-17: Phase F — 마누스 `skill-creator` 기반 9개 스킬 직접 등록 완료 (run: `20260517_skills-direct-register`).
  - 2026-05-16: Phase D — Manus Agent Skills 9개 공개 GitHub 저장소 push 및 import 검증 수행. GitHub import 경로 무효 확인, 백업·버전 추적용 유지. (run: `20260516_skills-github-register`)
  - 2026-05-16: Phase C — Claude Code dispatch 방식 A/B 비교 검증 완료. 파일 경유 짧은 명령 방식(B)을 r6 표준 절차로 채택. (run: `test_claude_dispatch`)
  - 2026-05-16: Phase B — CLAUDE.md r6 갱신 (글로벌·프로젝트 양쪽) 완료. (run: `20260516_claude-md-r6-update`)
  - 2026-05-16: Phase A — r6 매뉴얼·양식 최초 적용. `dbdbc07` commit으로 r6-rollout 브랜치에 반영 (별도 harness run 없음).
- **다음 마일스톤**:
  - [x] Phase G-1: 9개 스킬 동작 검증 설계 (dubyeol-workflow 마스터에서 별도 task).
  - [x] Phase G-2: 9개 스킬 실제 동작 검증 수행 및 외부 감리. 결과는 수정 필요 상태로 종료.
  - [x] 정책+sync 설계 task: 마스터·클라이언트 자료 경계, `REPO_ROOT` 환경 변수화, sync 스크립트 설계, 키 자료 sync 제외, 시스템 환경변수(`~/.zshrc`) 단일 키 출처 정책 확정.
  - [x] Task 2 — sync 스크립트 구현 task: `sync-design.md` 기준으로 `sync-to-client.sh`를 구현하되, dry-run 중심으로 정책 검증 수단을 먼저 확보.
  - [ ] Task 3 — 9개 스킬 수정 task: 정책 위에서 스킬 본문 정정, scripts 경로·shell runtime·input isolation·PROJECT.md diff-first 전환. `skills-fix-guidelines.md`와 Task 2 sync 인프라를 직접 입력으로 사용.
  - [ ] r7 정비: Task 3과 동시 진입 가능. AGENTS.md, SUB-1~5, PROJECT.md 등 운영 문서에 회고 1~36과 대체 감리 절차, 후속 순서 결정권 원칙, Foreman 직접 정정 범위 원칙 반영.
  - [ ] Task 4 — silkroadhub 첫 클라이언트 적용 task: sync 구현과 9개 스킬 수정 결과 준비 후 실행과 동작 확인. `silkroadhub` 사업 자산은 손대지 않음.
  - [ ] Task 5 — G-2 v2 또는 부분 재검증: 수정된 스킬의 master 독립 실행과 client 적용 경로를 재검증.
- **현재 막힌 점**: sync 구현은 완료되었으나 9개 스킬 수정과 r7 운영 문서 정비는 아직 미진입 상태다. 다음 task-card는 Task 3(9개 스킬 수정)과 r7 정비를 분리하되 동시 진행 가능한 구조로 관리해야 한다.
- **관련 design doc·문서**: `.harness/runs/20260518_sync-script-implementation/`, `.harness/runs/20260518_skills-policy-and-sync-design/`, `.harness/runs/20260518_g2-skills-verification-execution/`, `.harness/runs/20260517_g1-skills-verification-design/`, `.harness/runs/20260516_skills-github-register/`, `.harness/runs/20260517_skills-direct-register/`, `https://github.com/gjnvcdprfw-hub/dubyeol-workflow`

*(모듈 추가 시 §C.N 번호로 확장)*

---

## D. 매번 갱신 — 결정 이력 + 회고 1~14

큰 결정 발생 시 *날짜 / 결정 / 한 줄 사유 / 영향받은 모듈* 한 줄 추가. 시간 역순(최신이 위).

| 날짜 | 결정 | 사유 | 영향 모듈 |
|---|---|---|---|
| 2026-05-17 | Task 2 sync 스크립트 구현을 완료하고 후속 Task 3 + r7 동시 진입 준비 상태로 전환한다. | sync-to-client.sh가 dummy dry-run·실제 sync 검증을 통과해 후속 스킬 수정과 client 적용의 인프라가 마련되었다. | §C.1 |
| 2026-05-17 | Task 2에서도 본 채널 검수를 SUB-3 대체 수행으로 인정한다. | API 키 문제로 외부 감리를 진행할 수 없어 [Owner] 본 채널 검수가 Reviewer+Judge 대체 역할을 수행했다. | §C.1 |
| 2026-05-17 | Foreman 직접 정정 가능 범위를 문서 placeholder·검증·보고 영역으로 한정해 인정한다. | SUB-4에서 코드 본문이 아닌 `.env.template` placeholder와 검증 기록을 Foreman이 직접 정정했으며, 추적성을 위해 final-report에 명시했다. | §C.1 |
| 2026-05-17 | 정책+sync 설계 task에서 본 채널 검수를 SUB-3 외부 감리 대체로 인정한다. | API 키·시스템 환경변수 정책 자체를 설계하는 task에서 GPT API 호출을 계속하면 자기 참조 부정합이 발생하므로, [Owner] 본 채널 검수가 Reviewer+Judge 대체 역할을 수행했다. | §C.1 |
| 2026-05-17 | 후속 task 순서를 sync 구현 우선으로 정정한다. | sync 구현이 정책 검증 수단이며 dry-run으로 안전하게 검증 가능하므로, Task 2는 sync 스크립트 구현으로 우선 진행하고 이후 Task 3(9개 스킬 수정)과 r7 정비를 동시 진입한다. | §C.1 |
| 2026-05-17 | G-2 결과는 수정 필요 상태로 종료하고, 실제 수정은 별도 task로 분리한다. | Reviewer HOLD와 Judge 수정 판정이 일치하며, 9개 스킬 전부 PARTIAL PASS이므로 종료 직행이 아니라 별도 정책+수정 task가 필요하다. | §C.1 |
| 2026-05-17 | 마스터→클라이언트 sync 패턴을 후속 정책 설계의 기본 방향으로 삼는다. | 마스터에서 정책을 정의하고 각 클라이언트 프로젝트로 비밀값 없는 운영 자산만 sync해야 자료 drift와 내부 경로 부정합을 줄일 수 있다. | §C.1 |
| 2026-05-17 | 외부 도구 키는 시스템 환경변수(`~/.zshrc`) 단일 출처 정책을 우선 검토한다. | 마스터·클라이언트 어느 쪽도 키 자료를 sync하지 않아야 하며, 같은 로컬·같은 사용자 운영 전제에서는 시스템 환경변수 단일 출처가 가장 정합하다. | §C.1 |
| 2026-05-17 | `silkroadhub/scripts/load_openai_key.sh`는 silkroadhub 사업 서비스 운영 자산으로 보존한다. | 본 G-2의 부정합은 마스터가 클라이언트 사업 자산에 의존한 것이며, silkroadhub 서비스에서 사용 중인 키 로드 파일은 손대지 않는 것이 정합하다. | §C.1, silkroadhub |
| 2026-05-17 | G-1은 9개 스킬 동작 검증의 설계 task로 제한하고, 실제 검증·외부 감리는 G-2에 집중한다. | 설계 단계와 실제 검증 단계에서 외부 감리를 중복 호출하면 비효율이 발생하므로, blast radius가 커지는 G-2에 감리를 집중한다. | §C.1 |
| 2026-05-17 | 두별 워크플로우를 silkroadhub 내부 운영물이 아니라 독립 마스터 운영 프레임워크·도구킷으로 분리한다. | silkroadhub는 첫 번째 사업 클라이언트이며, 향후 다른 사업 프로젝트도 같은 운영 프레임워크를 가져와 적용해야 하므로 운영 원본·회고·스킬·매뉴얼을 마스터에서 관리해야 한다. | §C.1 전체 |
| 2026-05-17 | Manus GitHub import 경로를 r6 스킬 등록 목적의 정답 경로가 아닌 것으로 재해석한다. | [Owner]가 마누스 자체 `skill-creator` 존재를 확인했고, 스킬 등록은 자체 스킬 생성·전달 메커니즘으로 직접 수행하는 것이 맞다고 정정함. GitHub 저장소는 백업·공개·버전 추적용으로 유지한다. | §C.1 |
| 2026-05-17 | `dubyeol-workflow-skills` 단일 저장소 URL은 9개 스킬로 인식되지 않은 것으로 기록한다. | import 실행 후 Skills 목록에서 `01-load-sub-manual`과 `dubyeol` 검색 모두 `결과를 찾을 수 없음`으로 확인됨. 경로 가정 오류로 재해석. | §C.1 |
| 2026-05-16 | `dubyeol-workflow-skills` 정상 파일 수를 32개로 확정하고, 33개 표기는 컨설턴트 클로드 반복 오기로 기록한다. | README+LICENSE 2개와 9개 스킬 폴더 30개 합계가 32개이며, [Owner]가 "합계 32개 = 진실 원천"으로 명시함. | §C.1 |
| 2026-05-16 | Phase C dispatch 방식 검증 결과, 파일 경유 짧은 명령 방식(B)을 r6 표준 절차로 채택한다. | 방식 A(직접 입력) 대비 방식 B(파일 경유)가 재현성·이력 보존·명령 작성 부담에서 모두 우월했다. | AGENTS.md Appendix B |

### D.2 r7 회고 메모 1~14 (Phase B·C·D에서 누적)

**Phase B (20260516_claude-md-r6-update) 회고 메모 1~5**

| 번호 | 어디 | 무엇 | 다음 r 개정 제안 |
|---:|---|---|---|
| 1 | 카테고리 4 task §3.2 · §7 | Looks Like와 검증 명령이 중복되는 경향이 있었다. | 의도 정렬 양식과 검증 명령의 역할 경계를 재검토한다. |
| 2 | [Foreman] 보고 | Foreman v2 verification 산출물 결과와 모순되는 [Owner] 보고를 했다. | 보고 직전 verification 결과 그대로 인용 의무를 AGENTS.md 또는 마누스 프로젝트 지침에 추가한다. |
| 3 | Builder finishing thinking | 약 6분 2초를 [Foreman]이 정체로 오인했다. 실제로는 작업 완료 후 output stream 종료 신호였다. | `Baked for X` 종료 신호를 반드시 기다린 후 보고하도록 AGENTS.md 또는 SUB-2 §4를 보강한다. |
| 4 | Tier A → SUB-3 의무 | [Foreman]이 SUB-3 의무를 자가 점검 없이 commit 결재로 직진했다. | SUB-2 §4 verify-handoff 마지막에 "Tier A/B면 SUB-3 진입 의무 확인" 체크박스 추가. |
| 5 | [Judge] 관계 문서화 | 마누스 글로벌 지침의 상시 경량 Devil's Advocate와 r6 [Judge]의 관계가 명확히 문서화되어 있지 않았다. | AGENTS.md §1에 [Foreman] 마누스의 상시 경량 Devil's Advocate와 r6 [Judge]의 보완 관계를 명시한다. |

**Phase D (20260516_skills-github-register) 회고 메모 6~14**

| 번호 | 어디 | 무엇 | 다음 r 개정 제안 |
|---:|---|---|---|
| 6 | 컨설턴트 클로드 발화 | 매뉴얼 외부의 직전 회고·결정 정보를 참조하지 못해 반복 오기를 만들었다. | task 발화 작성 전 직전 final-report §12와 운영 사실 데이터 확인을 의무화한다. |
| 7 | 권한 경계 | GitHub 저장소 생성·삭제·공개/비공개 변경 경계가 글로벌 지침에 명시되어 있지 않았다. | 저장소 생성은 [Owner] 직접 또는 명시 승인 시 위임, 삭제 금지, 공개 설정 변경 명시 승인 규칙을 r7에 추가한다. |
| 8 | 세션 분리 패턴 | Phase B와 Phase D를 별도 세션으로 진행했으나 r6에는 task 간 세션 분리 기준이 없다. | 다른 영역 task는 새 세션 권고, 새 세션 환경 점검 5개 항목, 직전 task 인계 패턴을 명시한다. |
| 9 | 컨설턴트 클로드 반복 오기 | 지난 task에서 32개 정상값으로 정정됐는데도 Phase D 발화에 다시 33개가 박혔다. | 컨설턴트 클로드는 task 발화 전 직전 회고를 참조하거나, 스킬 파일 수 같은 운영 사실을 별도 진실 원천 문서로 유지한다. |
| 10 | 외부 도구 일시 장애 처리 | gh TLS timeout, 코덱스 backend 실패, browser 504가 연속 발생했다. | 대체 검증 경로(`git ls-remote`, clone, ping, UI 재검색)를 매뉴얼화한다. |
| 11 | Reviewer·Judge 입력 전달 무결성 | 코덱스 retry 로그에 Reviewer prompt가 아니라 터미널 조회 명령이 섞인 입력 손상이 발생했다. | 외부 도구 호출 직후 stderr/user 입력 블록 spot-check를 의무화한다. |
| 12 | 폴백 backend 공유 리스크 | 코덱스 실패 후 지피티 폴백은 같은 backend 장애 영향을 받을 수 있다. | 폴백 전 짧은 GPT ping 또는 `/v1/models` 테스트를 의무화하고 실패 시 복구 대기로 분기한다. |
| 13 | 스킬 등록 경로 전제 오류 | r6 매뉴얼의 "GitHub import로 스킬 등록" 가정이 틀린 경로였다. 마누스 자체에 `skill-creator`가 있으며 직접 등록이 정답 경로다. | AGENTS.md §7.2 호출 표와 마누스 프로젝트 지침 §11의 스킬 등록 전제를 정정한다. GitHub 저장소는 백업·버전 추적용으로만 유지. |
| 14 | Reviewer 폴백의 검토 깊이 한계 | 지피티 [Reviewer] 폴백은 실제 파일 본문 정밀 검토 없이 제공 요약에 상당 부분 의존했다. | r6 §7.5 폴백 절차에 추가 보강 검증 의무를 명시하거나, 코덱스 복구까지 대기하는 옵션을 우선 권고한다. |


**Phase H SUB-5 회고 메모 15~19**

| 번호 | 어디 | 무엇 | 다음 r 개정 제안 |
|---:|---|---|---|
| 15 | Codex 호출 운영 | Codex 호출 자체 운영 절차 정정이 발생했고 `codex-call-ops-correction.md`가 산출되었다. | Codex는 `codex exec` 직접 실행뿐 아니라 `codex` REPL 선진입 방식까지 로컬 CLI 절차에 포함한다. |
| 16 | Context7·Code Simplifier | 두 보조 도구가 Claude Code/Builder 영역에 통합되는 방식이 아직 명확하지 않다. | r7에서 보조 도구의 호출 주체, 입력 격리, 결정권 부재를 명시한다. |
| 17 | AGENTS.md §12 | 베타 운영 절차가 Claude Code 중심으로만 표현되어 Codex·GPT 로컬 호출에 혼선이 있었다. | §12를 “로컬 CLI 도구 호출 표준 절차”로 일반화하고 Claude Code·Codex·GPT 호출을 모두 포괄한다. |
| 18 | Phase C 명칭 | `test_claude_dispatch`는 공식 Phase C task-card가 아니라 dispatch 검증 run인데 PROJECT.md에는 Phase C처럼 보일 수 있다. | “Phase C 후보/dispatch 검증 run”으로 명칭을 보정하고 r7 정비 때 phase provenance 표기를 정리한다. |
| 19 | legacy residue | silkroadhub `.harness/proposals` 등 구형 운영 제안 파일이 client-local legacy residue로 남아 있다. | r7 cleanup task에서 master 이전·archive·삭제 기준을 정한다. |
| 20 | secret scanner | `sk-` 패턴이 `skills-direct-register`, `skill-creator`, `task-card` 같은 일반 단어 일부를 secret-like pattern으로 오탐했다. | r7에서 토큰 길이·boundary 명시 정규식을 사용하거나 gitleaks·trufflehog 같은 전용 secret scanning 도구 도입을 검토한다. |
| 21 | 긴 명령 전달 | `dubyeol-workflow` import commit이 긴 Terminal 명령 전달 중 일부 실행되어 3개 commit으로 분할되었다. | r7에서 commit 단계도 파일 경유 짧은 명령 + 2단계 확정 실행 SOP를 적용하도록 표준화한다. |
| 22 | 한글 commit 메시지 | `silkroadhub` cleanup commit 메시지에서 한글 일부가 Terminal 인용 처리 중 축약되었다. | r7에서 commit 메시지는 영문 키워드 + 한글 보조 설명 또는 파일 경유 commit message 방식으로 표준화한다. |

---

## E. 운영 정보

- **마지막 갱신**: 2026-05-17 KST
- **마지막 갱신 task run ID**: 20260518_sync-script-implementation (Task 2 sync 스크립트 구현 SUB-5)

### E.1 갱신 메커니즘

PROJECT.md는 **task-card를 통해서만** 갱신된다. [Foreman] 단독으로 본 문서를 임의 수정하지 않는다.

| 절 | 갱신 시점 | 갱신 경로 |
|---|---|---|
| §A 기획 맥락 | [Owner] 발화로 *카테고리 5 (기획) task* 발생 시 | 해당 task-card → 본 문서 §A |
| §B 중기 목표 | 분기 종료 또는 [Owner] 발화로 *카테고리 5 task* 발생 시 | 해당 task-card → 본 문서 §B |
| §C 모듈 진행 | **모든 task의 SUB-5 종료 시** | 해당 task-card §10 → 본 문서 §C.N |
| §D 결정 이력 | task 진행 중 큰 결정 발생 시 | 해당 task-card에 박은 후 본 문서 §D |

---

**본 문서 끝.**

베타 운영 중 발견된 어색함은 SUB-5 회고에 기록 → 다음 r 개정에 반영.
