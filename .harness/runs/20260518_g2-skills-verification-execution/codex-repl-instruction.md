# Codex REPL Instruction — Reviewer for G-2 Skills Verification

You are acting as [Reviewer], the technical/code auditor only.

Repository: `/Users/twostars/ClaudeAi/dubyeol-workflow`  
Run ID: `20260518_g2-skills-verification-execution`

Please read the reviewer input file:

`.harness/runs/20260518_g2-skills-verification-execution/reviewer-input.md`

Then inspect only the technical artifacts listed there: `SKILL.md` files, skill-local `scripts/`, and G-2 evidence files. Do not evaluate business intent, Owner intent, roadmap, prioritization, or Tier. Do not perform Judge role.

Write your final response to:

`.harness/runs/20260518_g2-skills-verification-execution/reviewer-raw.md`

Use exactly the response structure requested in `reviewer-input.md`:

1. Overall Technical Verdict
2. Confirmed Technical Findings
3. Disputed or Unproven Findings
4. Missed Technical Risks
5. Required Fixes Before Closure
6. Reviewer Boundary Check

Do not modify any project files except the single output file `reviewer-raw.md`. If you cannot write the file, print the full final response in the terminal and clearly mark it with `REVIEWER_RAW_BEGIN` and `REVIEWER_RAW_END`.
