# local-skill-registration-procedure — 로컬 원본 기준 9개 스킬 등록 UI 준비 절차

**run ID**: `20260519_skills-9-fix`  
**작성일시**: 2026-05-17 KST  
**작성자**: [Foreman]  
**상태**: 절차 재정렬 완료, 실제 등록 UI 준비 실행 전 [Owner] 확인 대기  
**핵심 정정**: 등록 원본은 sandbox staging이 아니라 **로컬 마스터 워킹 디렉토리의 Task 3 정정본**이다.

---

## 1. 원칙 재정의

대표님 지시에 따라 9개 스킬 등록 절차의 기준점을 다시 정렬한다. 기존 sandbox staging은 원본이 아니라 보조 검증 흔적이며, 실제 등록 UI 준비는 로컬 마스터 워킹 디렉토리의 정정본을 기준으로 수행한다. [Foreman]은 등록 화면을 준비하고 내용을 표시할 수 있으나, 마지막 `Save`, `Add to My Skills`, `등록 확정`에 해당하는 클릭은 [Owner]가 수행한다.

| 구분 | 기준 |
|---|---|
| 등록 원본 | `/Users/twostars/ClaudeAi/dubyeol-workflow/r6-rollout-package/dubyeol-workflow-skills/` |
| 대상 스킬 | `01-load-sub-manual`부터 `09-update-project-md`까지 9개 |
| 포함 파일 | 각 스킬의 `SKILL.md`, `scripts/*.sh`, 기존 bundled resources |
| 보조 staging | `/home/ubuntu/skill-registration-20260519-skills-9-fix/` — 원본 아님, 검증 참고만 |
| 확정 권한 | [Owner] 최종 클릭 전까지 등록 확정 금지 |
| 금지 사항 | commit·push, 외부 감리, r7 수정, silkroadhub 키 파일 참조, 자동 Save |

---

## 2. 실행 전 체크리스트

실제 등록 UI 준비에 들어가기 전, [Foreman]은 로컬 원본만 확인한다. 확인은 읽기·표시·비교 범위로 제한하며, 스킬 파일 자체를 수정하지 않는다.

| 체크 | 방법 | 통과 기준 |
|---|---|---|
| 9개 스킬 존재 | 로컬 원본 경로에서 9개 디렉터리 확인 | 9개 모두 존재 |
| `SKILL.md` 존재 | 각 디렉터리의 `SKILL.md` 확인 | 9개 모두 존재 |
| scripts 존재 | 각 스킬의 `scripts/*.sh` 확인 | Task 3 정정본 기준 10개 존재 |
| 등록 내용 표시 | 각 스킬별 이름·설명·본문·scripts 목록을 UI 또는 등록 준비 화면에 표시 | [Owner]가 내용을 육안 확인 가능 |
| Save 경계 | Save 직전 정지 | [Owner]가 직접 클릭 |

---

## 3. 9개 스킬별 UI 준비 순서

아래 순서를 유지한다. 한 스킬의 등록 화면을 준비할 때마다 이름, 설명, `SKILL.md` 본문, scripts 목록을 표시하고 Save 직전 정지한다. [Owner]가 Save를 클릭한 뒤 다음 스킬로 넘어간다.

| 순서 | 스킬 | 로컬 원본 경로 |
|---:|---|---|
| 1 | `01-load-sub-manual` | `/Users/twostars/ClaudeAi/dubyeol-workflow/r6-rollout-package/dubyeol-workflow-skills/01-load-sub-manual/` |
| 2 | `02-create-task-card` | `/Users/twostars/ClaudeAi/dubyeol-workflow/r6-rollout-package/dubyeol-workflow-skills/02-create-task-card/` |
| 3 | `03-dispatch-to-builder` | `/Users/twostars/ClaudeAi/dubyeol-workflow/r6-rollout-package/dubyeol-workflow-skills/03-dispatch-to-builder/` |
| 4 | `04-invoke-plan-review` | `/Users/twostars/ClaudeAi/dubyeol-workflow/r6-rollout-package/dubyeol-workflow-skills/04-invoke-plan-review/` |
| 5 | `05-verify-handoff` | `/Users/twostars/ClaudeAi/dubyeol-workflow/r6-rollout-package/dubyeol-workflow-skills/05-verify-handoff/` |
| 6 | `06-invoke-reviewer` | `/Users/twostars/ClaudeAi/dubyeol-workflow/r6-rollout-package/dubyeol-workflow-skills/06-invoke-reviewer/` |
| 7 | `07-invoke-judge` | `/Users/twostars/ClaudeAi/dubyeol-workflow/r6-rollout-package/dubyeol-workflow-skills/07-invoke-judge/` |
| 8 | `08-write-final-report` | `/Users/twostars/ClaudeAi/dubyeol-workflow/r6-rollout-package/dubyeol-workflow-skills/08-write-final-report/` |
| 9 | `09-update-project-md` | `/Users/twostars/ClaudeAi/dubyeol-workflow/r6-rollout-package/dubyeol-workflow-skills/09-update-project-md/` |

---

## 4. UI 준비 절차

1개 스킬마다 다음 절차를 반복한다. 이 절차는 등록 화면을 준비하기 위한 정렬이며, 확정 클릭은 포함하지 않는다.

| 단계 | [Foreman] 행동 | [Owner] 행동 |
|---:|---|---|
| 1 | 로컬 원본 경로의 `SKILL.md`와 bundled resources를 확인한다. | 없음 |
| 2 | skill-creator 등록 UI에 해당 스킬의 이름, 설명, 본문, scripts를 표시한다. | 화면 내용 확인 |
| 3 | Save/Add 직전 상태에서 멈춘다. | Save/Add 클릭 여부 결정 |
| 4 | [Owner]가 직접 Save/Add를 클릭하면 다음 스킬로 이동한다. | 최종 확정 클릭 |
| 5 | 등록 후 목록에서 해당 스킬 표시 여부를 확인한다. | 필요 시 육안 확인 |

---

## 5. 등록 후 검증 절차

9개 모두 [Owner] Save/Add가 끝난 뒤에만 등록 후 검증으로 넘어간다. 검증은 등록 목록에서 9개 스킬이 표시되는지 확인하고, 가능한 경우 등록된 `SKILL.md`와 scripts가 로컬 원본과 일치하는지 비교한다.

| 검증 항목 | 기준 |
|---|---|
| 9개 스킬 목록 표시 | 9개 이름 모두 확인 |
| 이름·description | 로컬 원본 `SKILL.md` frontmatter와 일치 |
| 본문 | 로컬 원본 `SKILL.md`와 일치 |
| scripts | 로컬 원본 `scripts/*.sh`와 일치 |
| dashboard | 등록 완료 및 검증 결과 기록 |

---

## 6. 현재 상태와 다음 요청

현재 단계에서는 로컬 원본 기준 등록 절차를 재정렬했으며, 실제 skill-creator UI 등록 준비는 아직 실행하지 않았다. 대표님이 다음 발화로 등록 UI 준비 실행을 승인하면, [Foreman]은 1번 스킬부터 순서대로 화면을 준비하고 Save 직전마다 멈춘다.

> 권장 다음 발화: “로컬 원본 기준으로 1번 스킬부터 등록 UI 준비 진행.”

---

**local-skill-registration-procedure 끝.**
