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
- **현재 상태**: Phase H 완료. 마스터/클라이언트 분리 실행. 9개 스킬은 dubyeol-workflow 마스터에서 Phase G-1 동작 검증 설계 대기 중.
- **최근 마일스톤** (시간 역순, 최신이 위):
  - 2026-05-17: Phase H — 두별 워크플로우 마스터/클라이언트 분리 완료. dubyeol-workflow 독립 마스터 repo 구성, Phase A~F runs 이전, silkroadhub PROJECT.md §C.1 제거·§D 추가, GitHub rename 검증.
  - 2026-05-17: Phase F — 마누스 `skill-creator` 기반 9개 스킬 직접 등록 완료 (run: `20260517_skills-direct-register`).
  - 2026-05-16: Phase D — Manus Agent Skills 9개 공개 GitHub 저장소 push 및 import 검증 수행. GitHub import 경로 무효 확인, 백업·버전 추적용 유지. (run: `20260516_skills-github-register`)
  - 2026-05-16: Phase C — Claude Code dispatch 방식 A/B 비교 검증 완료. 파일 경유 짧은 명령 방식(B)을 r6 표준 절차로 채택. (run: `test_claude_dispatch`)
  - 2026-05-16: Phase B — CLAUDE.md r6 갱신 (글로벌·프로젝트 양쪽) 완료. (run: `20260516_claude-md-r6-update`)
  - 2026-05-16: Phase A — r6 매뉴얼·양식 최초 적용. `dbdbc07` commit으로 r6-rollout 브랜치에 반영 (별도 harness run 없음).
- **다음 마일스톤**:
  - [ ] Phase G-1: 9개 스킬 동작 검증 설계 (dubyeol-workflow 마스터에서 별도 task).
  - [ ] r7 정비: Phase A~H 회고 메모 1~14 반영, 매뉴얼 개정.
- **현재 막힌 점**: Phase G-1 동작 검증 설계는 Phase H 완료 확인 후 진입.
- **관련 design doc·문서**: `.harness/runs/20260516_skills-github-register/`, `.harness/runs/20260517_skills-direct-register/`, `https://github.com/gjnvcdprfw-hub/dubyeol-workflow`

*(모듈 추가 시 §C.N 번호로 확장)*

---

## D. 매번 갱신 — 결정 이력 + 회고 1~14

큰 결정 발생 시 *날짜 / 결정 / 한 줄 사유 / 영향받은 모듈* 한 줄 추가. 시간 역순(최신이 위).

| 날짜 | 결정 | 사유 | 영향 모듈 |
|---|---|---|---|
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
- **마지막 갱신 task run ID**: 20260517_dubyeol-workflow-master-split (Phase H SUB-5)

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
