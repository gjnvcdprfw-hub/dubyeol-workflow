# Foreman v2 verification

## Outputs
PRESENT .harness/runs/20260516_claude-md-r6-update/claude-md-global-draft-v2.md      201 lines
PRESENT .harness/runs/20260516_claude-md-r6-update/claude-md-project-draft-v2.md      171 lines
PRESENT .harness/runs/20260516_claude-md-r6-update/v2-correction-summary.md       99 lines

## Grep checks
global_gate_judge_plus_residual=0
global_judge_phrase=1
global_reviewer_fallback_phrase=1
project_gate_judge_residual=0
project_legacy_residual=0
project_new_masking=3
project_domain_masking=7
project_reviewer_judge_terms=7

## Actual file comparison
GLOBAL_DIFFERS_FROM_V2
PROJECT_DIFFERS_FROM_V2

## Git status short
[31m??[m .harness/runs/20260516_claude-md-r6-update/
