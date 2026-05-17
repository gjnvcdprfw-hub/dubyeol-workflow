# Phase H secret suspect spot-check

- checked_at: 2026-05-17 12:04:12 KST
- policy: 값은 출력하지 않고 파일별 발견 여부와 false-positive 성격만 기록한다.

| # | Path | Exists | Actual Secret Pattern | Classification |
|---:|---|---:|---:|---|
| 1 | `./.harness/manus-prompts/프롬프트-AGENTS-부록-검증.md` | yes | no | false positive: keyword mention/script variable/documentation only |
| 2 | `./.harness/manus-prompts/프롬프트-scripts-작성.md` | yes | no | false positive: keyword mention/script variable/documentation only |
| 3 | `./.harness/runs/20260516_claude-md-r6-update/claude-md-project-draft.md` | yes | no | false positive: keyword mention/script variable/documentation only |
| 4 | `./.harness/runs/20260516_claude-md-r6-update/claude-md-project-draft-v2.md` | yes | no | false positive: keyword mention/script variable/documentation only |
| 5 | `./.harness/runs/20260516_claude-md-r6-update/CLAUDE-project-before-apply.md` | yes | no | false positive: keyword mention/script variable/documentation only |
| 6 | `./.harness/runs/20260516_claude-md-r6-update/project-claude-apply.diff` | yes | no | false positive: keyword mention/script variable/documentation only |
| 7 | `./.harness/runs/20260517_skills-direct-register/task-card-reissue-diff-summary.md` | yes | yes | STOP_REQUIRED: actual secret-like assignment/token pattern detected |
| 8 | `./.harness/runs/20260516_skills-github-register/handoff.md` | yes | no | false positive: keyword mention/script variable/documentation only |
| 9 | `./AGENTS.md` | yes | no | false positive: keyword mention/script variable/documentation only |
| 10 | `./r6-rollout-package/dubyeol-workflow-skills/04-invoke-plan-review/scripts/invoke_plan_review.sh` | yes | no | false positive: keyword mention/script variable/documentation only |
| 11 | `./r6-rollout-package/dubyeol-workflow-skills/06-invoke-reviewer/scripts/invoke_reviewer.sh` | yes | no | false positive: keyword mention/script variable/documentation only |
| 12 | `./r6-rollout-package/dubyeol-workflow-skills/07-invoke-judge/scripts/invoke_judge.sh` | yes | no | false positive: keyword mention/script variable/documentation only |
| 13 | `./r6-rollout-package/manus-task-prompts/프롬프트-AGENTS-부록-검증.md` | yes | no | false positive: keyword mention/script variable/documentation only |
| 14 | `./r6-rollout-package/manus-task-prompts/프롬프트-scripts-작성.md` | yes | no | false positive: keyword mention/script variable/documentation only |
| 15 | `./r6-rollout-package/silkroadhub-files/AGENTS.md` | yes | no | false positive: keyword mention/script variable/documentation only |

## Summary

- checked_files: 15
- actual_secret_pattern_files: 1
- decision: STOP — commit must not proceed until reviewed.
