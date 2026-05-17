# Phase H run location consistency check

- checked_at: 2026-05-17 11:59:14 KST
- silkroadhub_run: /Users/twostars/ClaudeAi/silkroadhub/.harness/runs/20260517_dubyeol-workflow-master-split
- dubyeol_workflow_run: /Users/twostars/ClaudeAi/dubyeol-workflow/.harness/runs/20260517_dubyeol-workflow-master-split

## 1. Directory existence
| Location | Exists | File Count |
|---|---:|---:|
| /Users/twostars/ClaudeAi/silkroadhub/.harness/runs/20260517_dubyeol-workflow-master-split | yes | 34 |
| /Users/twostars/ClaudeAi/dubyeol-workflow/.harness/runs/20260517_dubyeol-workflow-master-split | no | 0 |

## 2. silkroadhub file list
```text
./codex-call-ops-correction.md
./codex-exec-retry2.log
./codex-exec-terminal.log
./codex-exec.log
./dubyeol-PROJECT-before-sub5.md
./dubyeol-project-sub5-diff.patch
./final-report.md
./foreman-verification.md
./gate-review.md
./handoff.md
./judge-exec.log
./judge-input.md
./judge-payload.json
./judge-raw.json
./judge-raw.md
./reviewer-fallback-exec.log
./reviewer-fallback-payload.json
./reviewer-fallback-raw.json
./reviewer-fallback-raw.md
./reviewer-input-short.md
./reviewer-input.md
./reviewer-raw-retry2.md
./reviewer-raw-terminal.md
./reviewer-raw.md
./run-location-check.md
./sub4-dangling-reference-active-docs.txt
./sub4-dubyeol-contamination-check.md
./sub4-dubyeol-secret-suspect-files.txt
./sub4-legacy-and-phasec-plan.md
./sub4-modifications.md
./sub4-remote-head-check.md
./sub4-silkroadhub-reference-check.md
./sub5-pre-report-check.md
./task-card.md
```

## 3. dubyeol-workflow file list before sync
```text
ABSENT
```

## 4. Comparison before sync
```text
dubyeol-workflow run dir absent; sync required
```
