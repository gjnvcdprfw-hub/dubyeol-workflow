# Builder Entry Instruction — G-1 Skills Verification Design

You are [Builder] for the dubyeol-workflow master repository.

## 0. Repository and run

- Repository: `/Users/twostars/ClaudeAi/dubyeol-workflow`
- Run ID: `20260517_g1-skills-verification-design`
- Task-card: `.harness/runs/20260517_g1-skills-verification-design/task-card.md`
- Category: 4 (문서·운영)
- Tier: B
- Output design document: `.harness/runs/20260517_g1-skills-verification-design/g1-skills-verification-design.md`
- Output handoff: `.harness/runs/20260517_g1-skills-verification-design/handoff.md`

## 1. Mandatory first actions

1. Confirm you are in `/Users/twostars/ClaudeAi/dubyeol-workflow`.
2. Read `AGENTS.md` sections 1, 2, 3, 5, 6, 8, 9, and 12 as needed.
3. Read the task-card at `.harness/runs/20260517_g1-skills-verification-design/task-card.md`.
4. Enter `using-superpowers` and follow the category 4 tree: `using-superpowers → brainstorming → 작성 → 자체 review → finishing-a-development-branch`.
5. Do not reuse context from any previous task.

## 2. Scope

Write only the G-1 verification design document and the handoff. This task is design-only. Do not perform actual skill execution verification, do not modify skills, and do not modify operating manuals.

The design document must cover all 9 skills exactly once as first-class items:

1. `01-load-sub-manual`
2. `02-create-task-card`
3. `03-dispatch-to-builder`
4. `04-invoke-plan-review`
5. `05-verify-handoff`
6. `06-invoke-reviewer`
7. `07-invoke-judge`
8. `08-write-final-report`
9. `09-update-project-md`

## 3. Required design document structure

Create `.harness/runs/20260517_g1-skills-verification-design/g1-skills-verification-design.md` with these sections:

1. `# G-1 9개 Manus Agent Skills 동작 검증 설계서`
2. `## 1. 9개 스킬별 의도 정리`
   - Include a table with all 9 skills.
   - For `01-load-sub-manual`, explicitly record the observed suspect signal: `scripts/load_sub.sh` was not found in the master repository during SUB-1, so manual loading was used. Mark it as `G-2 우선 검증`.
3. `## 2. G-1과 G-2 경계`
   - G-1 is design only.
   - G-2 is actual execution verification and any external audit focus.
4. `## 3. 공통 검증 원칙`
   - Evidence-first, no silent success, role isolation, masking, no push/merge/deploy, no operating-manual modification without approval.
5. `## 4. 스킬별 검증 설계 매트릭스`
   - For each skill: purpose, preconditions, test input, expected behavior, failure signals, evidence file(s), G-2 priority.
6. `## 5. G-2 실행 순서 제안`
   - Prioritize `01-load-sub-manual` first because of the missing script signal.
   - Group dependent skills logically: SUB-1 creation, SUB-2 dispatch/verification, SUB-3 audit, SUB-5 closure.
7. `## 6. 역할·정보 격리 설계`
   - Builder, Reviewer, Judge separation.
   - Reviewer cannot judge business/intent; Judge cannot inspect code details.
8. `## 7. 권한 천장 및 중단 조건`
9. `## 8. 증거 파일 명명 규칙`
10. `## 9. G-2 회고 입력 후보`
11. `## 10. 자체 검토 결과`

Use professional Korean. Use tables where they clarify multiple items. Avoid emojis.

## 4. Must include these exact G-2 evidence ideas

- `01-load-sub-manual`: evidence should include command/output proving whether `scripts/load_sub.sh` exists or whether the skill instruction points to a non-existent script.
- `02-create-task-card`: evidence should include generated task-card path and template conformance check.
- `03-dispatch-to-builder`: evidence should include `tmp/claude-entry-<run_id>.md`, Terminal window ID, and confirmation of 2-step execution.
- `04-invoke-plan-review`: evidence should include plan-review input isolation and `plan-review.md` result.
- `05-verify-handoff`: evidence should include git checks for push, merge, operating docs, destructive git, scope, external calls.
- `06-invoke-reviewer`: evidence should include reviewer input file and reviewer raw output, with code-only scope.
- `07-invoke-judge`: evidence should include judge input file and judge raw output, with business/intent-only scope.
- `08-write-final-report`: evidence should include final-report sections generated from task-card/handoff/gate/plan-review.
- `09-update-project-md`: evidence should include proposed PROJECT.md diff and Owner approval boundary.

## 5. Prohibited actions

- Do not run `git push`, merge, deploy, rebase, reset --hard, force push, or branch deletion.
- Do not commit unless [Foreman] explicitly returns with Owner approval.
- Do not edit `AGENTS.md`, `PROJECT.md`, `SUB-1~5`, `.harness/templates/*`, or skill source files.
- Do not write anything under `/Users/twostars/ClaudeAi/silkroadhub`.
- Do not call Codex or ChatGPT for external review in this G-1 task.
- Do not proceed to G-2 actual verification.
- Do not propose cleanup or commit after completion. Write `handoff.md` and stop.

## 6. Verification commands to run before handoff

Run these commands and include outputs or summaries in handoff:

```bash
cd /Users/twostars/ClaudeAi/dubyeol-workflow

test -f .harness/runs/20260517_g1-skills-verification-design/task-card.md
test -f .harness/runs/20260517_g1-skills-verification-design/g1-skills-verification-design.md

for skill in \
  01-load-sub-manual \
  02-create-task-card \
  03-dispatch-to-builder \
  04-invoke-plan-review \
  05-verify-handoff \
  06-invoke-reviewer \
  07-invoke-judge \
  08-write-final-report \
  09-update-project-md; do
  grep -q "$skill" .harness/runs/20260517_g1-skills-verification-design/g1-skills-verification-design.md
done

grep -q "scripts/load_sub.sh" .harness/runs/20260517_g1-skills-verification-design/g1-skills-verification-design.md
grep -q "G-2 우선" .harness/runs/20260517_g1-skills-verification-design/g1-skills-verification-design.md

test ! -d /Users/twostars/ClaudeAi/silkroadhub/.harness/runs/20260517_g1-skills-verification-design

git status --short
```

## 7. Handoff requirements

Write `.harness/runs/20260517_g1-skills-verification-design/handoff.md` using `.harness/templates/handoff-template.md` as the structure. If a template field is not applicable to this document-only task, write `해당 없음` with a short reason.

In handoff, explicitly state:

- The design document path.
- All 9 skills are covered.
- `01-load-sub-manual` missing-script signal was recorded and prioritized for G-2.
- No push/merge/deploy/commit was performed.
- No operating documents or skill source files were modified.
- No `silkroadhub` run output was created.
- This task is ready for [Foreman] verification.

After writing `handoff.md`, stop and wait. Do not auto-suggest commit or cleanup.
