# commit-message-draft — Task 3

**run ID**: `20260519_skills-9-fix`  
**작성일시**: 2026-05-17 KST  
**작성자**: [Foreman]  
**상태**: 초안 작성만 수행. 실제 commit은 [Owner] 별도 결재 전 금지.

---

## 1. 권장 commit 제목

```text
fix(skills): repair 9 workflow skills for r6 rollout
```

한글 보조 요약: `r6 rollout 9개 스킬 결함 정정 및 등록 검증`

---

## 2. 권장 commit 본문

```text
run_id: 20260519_skills-9-fix

- Fix 9 Manus Agent Skills under r6-rollout-package/dubyeol-workflow-skills
  according to skills-fix-guidelines.md §11.
- Update each target SKILL.md and scripts/*.sh only; keep Task 3 scope limited
  to the approved skill body/script range.
- Verify Builder handoff and Foreman handoff-verification evidence.
- Register the corrected 9 skills into Manus environment and verify installed
  files match the local master source by SHA-256 hash.
- Skip SUB-3 external review by Owner decision; replace with Manus registration
  and real-use validation path.
- Move references/README residue to r7 maintenance instead of expanding Task 3
  scope.
- Freeze r7 SUB-2 after Owner decision to abandon parallel-task operation.
- Remove non-standard dashboard.md workflow and record r37 retrospective
  candidate for dashboard introduction/removal and parallel-task governance.

Notes:
- No commit/push was performed by Foreman before Owner approval.
- No external Codex/GPT review was invoked for Task 3 SUB-3.
- No silkroadhub business assets or key files were modified.
```

---

## 3. 변경 파일 목록 초안

아래 목록은 commit 메시지 본문에 포함할 수 있는 변경 범위 요약이다. 실제 `git add`와 commit 대상 확정은 [Owner] 별도 결재 후 수행해야 한다.

### 3.1 Task 3 직접 수정 대상

| 구분 | 파일 |
|---|---|
| Skill 01 | `r6-rollout-package/dubyeol-workflow-skills/01-load-sub-manual/SKILL.md` |
| Skill 01 | `r6-rollout-package/dubyeol-workflow-skills/01-load-sub-manual/scripts/load_project_md.sh` |
| Skill 01 | `r6-rollout-package/dubyeol-workflow-skills/01-load-sub-manual/scripts/load_sub.sh` |
| Skill 02 | `r6-rollout-package/dubyeol-workflow-skills/02-create-task-card/SKILL.md` |
| Skill 02 | `r6-rollout-package/dubyeol-workflow-skills/02-create-task-card/scripts/create_task_card.sh` |
| Skill 03 | `r6-rollout-package/dubyeol-workflow-skills/03-dispatch-to-builder/SKILL.md` |
| Skill 03 | `r6-rollout-package/dubyeol-workflow-skills/03-dispatch-to-builder/scripts/dispatch.sh` |
| Skill 04 | `r6-rollout-package/dubyeol-workflow-skills/04-invoke-plan-review/SKILL.md` |
| Skill 04 | `r6-rollout-package/dubyeol-workflow-skills/04-invoke-plan-review/scripts/invoke_plan_review.sh` |
| Skill 05 | `r6-rollout-package/dubyeol-workflow-skills/05-verify-handoff/SKILL.md` |
| Skill 05 | `r6-rollout-package/dubyeol-workflow-skills/05-verify-handoff/scripts/verify_handoff.sh` |
| Skill 06 | `r6-rollout-package/dubyeol-workflow-skills/06-invoke-reviewer/SKILL.md` |
| Skill 06 | `r6-rollout-package/dubyeol-workflow-skills/06-invoke-reviewer/scripts/invoke_reviewer.sh` |
| Skill 07 | `r6-rollout-package/dubyeol-workflow-skills/07-invoke-judge/SKILL.md` |
| Skill 07 | `r6-rollout-package/dubyeol-workflow-skills/07-invoke-judge/scripts/invoke_judge.sh` |
| Skill 08 | `r6-rollout-package/dubyeol-workflow-skills/08-write-final-report/SKILL.md` |
| Skill 08 | `r6-rollout-package/dubyeol-workflow-skills/08-write-final-report/scripts/write_final_report.sh` |
| Skill 09 | `r6-rollout-package/dubyeol-workflow-skills/09-update-project-md/SKILL.md` |
| Skill 09 | `r6-rollout-package/dubyeol-workflow-skills/09-update-project-md/scripts/update_project_md.sh` |

### 3.2 Task 3 run 산출물

| 파일 |
|---|
| `.harness/runs/20260519_skills-9-fix/task-card.md` |
| `.harness/runs/20260519_skills-9-fix/builder-dispatch.md` |
| `.harness/runs/20260519_skills-9-fix/handoff.md` |
| `.harness/runs/20260519_skills-9-fix/evidence-fix-summary.md` |
| `.harness/runs/20260519_skills-9-fix/handoff-verification.md` |
| `.harness/runs/20260519_skills-9-fix/foreman-verification-raw.txt` |
| `.harness/runs/20260519_skills-9-fix/skill-registration-precheck.md` |
| `.harness/runs/20260519_skills-9-fix/local-skill-registration-procedure.md` |
| `.harness/runs/20260519_skills-9-fix/skill-registration-verification.md` |
| `.harness/runs/20260519_skills-9-fix/retrospective-candidates.md` |
| `.harness/runs/20260519_skills-9-fix/final-report.md` |
| `.harness/runs/20260519_skills-9-fix/PROJECT-before.md` |
| `.harness/runs/20260519_skills-9-fix/project-md-diff.patch` |
| `.harness/runs/20260519_skills-9-fix/commit-message-draft.md` |

### 3.3 r7 동결 시점 산출물 및 운영 문서

| 범위 | 내용 |
|---|---|
| r7 run | `.harness/runs/20260519_r7-maintenance/` 하위 task-card 및 동결 시점 산출물 |
| 운영 문서 | `AGENTS.md`, `SUB-1~5`, `PROJECT.md` addendum 변경분 |
| dashboard | `dashboard.md` 삭제분. untracked 상태에서 삭제되었으면 commit 대상에는 나타나지 않을 수 있음 |

---

## 4. commit 전 확인 권고

```bash
git status --short
git diff --stat
git diff --check
```

위 명령은 실제 commit 전에 변경 범위와 whitespace 오류를 확인하기 위한 초안이다. 실행 여부는 [Owner]의 commit 결재 후 별도 진행한다.

---

**commit-message-draft 끝.**
