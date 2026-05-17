# [Reviewer] 폴백 (지피티) — Codex 불가로 대체

# Reviewer Raw Result — G-2 Skills Verification

## 1. Overall Technical Verdict
Verdict: HOLD

## 2. Confirmed Technical Findings
| Finding | Severity | Evidence |
|---|---|---|
| The 9 skill workflows are not independently executable from `/Users/twostars/ClaudeAi/dubyeol-workflow` as-is because every reviewed script hardcodes `REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"`. | Critical | Confirmed in all scripts: `01-load-sub-manual/scripts/load_project_md.sh`, `01-load-sub-manual/scripts/load_sub.sh`, `02-create-task-card/scripts/create_task_card.sh`, `03-dispatch-to-builder/scripts/dispatch.sh`, `04-invoke-plan-review/scripts/invoke_plan_review.sh`, `05-verify-handoff/scripts/verify_handoff.sh`, `06-invoke-reviewer/scripts/invoke_reviewer.sh`, `07-invoke-judge/scripts/invoke_judge.sh`, `08-write-final-report/scripts/write_final_report.sh`, `09-update-project-md/scripts/update_project_md.sh`. This redirects reads/writes to `silkroadhub`, not `dubyeol-workflow`. |
| The hardcoded `silkroadhub` path is a blocking technical defect for master-repo execution, not acceptable legacy behavior, because scripts write outputs and may modify files in the wrong repository. | Critical | `02-create-task-card` writes `${REPO_ROOT}/.harness/runs/${RUN_ID}/task-card.md`; `03-dispatch-to-builder` writes `${REPO_ROOT}/tmp/claude-entry-${RUN_ID}.md`; `04/06/07/08` write run outputs under `${REPO_ROOT}/.harness/runs`; `09-update-project-md` appends to `${REPO_ROOT}/PROJECT.md`. With current `REPO_ROOT`, all target `silkroadhub`. |
| SKILL.md invocation examples do not reliably match packaged locations from repository root. | High | SKILL files call `bash scripts/<script>.sh ...`, but packaged scripts are under each skill directory, e.g. `01-load-sub-manual/scripts/load_sub.sh`, `02-create-task-card/scripts/create_task_card.sh`, etc. Evidence summary reports root `scripts/` absent. From repo root, `bash scripts/load_sub.sh 1` fails unless caller first changes into the skill directory or root wrappers exist. |
| Interpreter instructions are inconsistent: scripts declare `#!/bin/zsh`, while SKILL.md examples invoke them with `bash`. | High | All shown scripts use `#!/bin/zsh`; SKILL.md examples use `bash scripts/...`. `01-load-sub-manual/scripts/load_sub.sh` and `02-create-task-card/scripts/create_task_card.sh` also use associative arrays via `declare -A`; if invoked with macOS default Bash 3.2, this fails. |
| `01-load-sub-manual` does not itself perform full SUB manual loading despite SKILL.md emphasizing full-file load. | Medium | `01-load-sub-manual/scripts/load_sub.sh` prints metadata and `head -30 "${FULL_PATH}"`, then instructs the operator to run `cat "${FULL_PATH}"`. SKILL.md step says the manual must be fully read; the script only previews and delegates full load to a manual follow-up. |
| `02-create-task-card` claims template-based generation but does not read `.harness/templates/task-card-template.md`. | Medium | `02-create-task-card/SKILL.md` references `silkroadhub .harness/templates/task-card-template.md`; script uses an inline heredoc `cat > "${TASK_CARD}" << TC_EOF` and never reads the template path. |
| `04-invoke-plan-review`, `06-invoke-reviewer`, and `07-invoke-judge` SKILL.md files describe saving/creating isolated input files, but scripts only consume pre-existing input files. | High | `04` checks `if [ ! -f "${INPUT_FILE}" ]`; `06` checks `reviewer-input.md`; `07` checks `judge-input.md`. None of these scripts generate the input from task-card/handoff/gate-review. Therefore input isolation depends on manual preparation outside the script. |
| External-call scripts were not technically executed end-to-end in the evidence, so runtime API/tool correctness is not proven. | Medium | Evidence for `04`, `06`, and `07` explicitly states GPT/Codex calls were not run by Builder; checks are static plus dummy input isolation review. |
| `08-write-final-report` claims template-based generation but does not read `.harness/templates/final-report-template.md`. | Medium | `08-write-final-report/SKILL.md` references `final-report-template.md`; script generates the report with an inline heredoc `cat > "${REPORT}" << REPORT_EOF`. |
| `09-update-project-md` does not implement SKILL.md’s stated automatic §C/§D/§E placement; it appends a block to the end of `PROJECT.md` and requires manual movement. | High | `09-update-project-md/SKILL.md` says update PROJECT.md §C module progress, §D decision history, and §E operating info. Script comments say automatic location search is risky, then `cat >> "${PROJECT_MD}"` appends a `[SUB-5 자동 추가]` block and prints manual relocation instructions. |
| `09-update-project-md` §10 extraction is technically fragile and likely extracts only the §10 header from generated task-cards. | High | Script uses `sed -n '/§10\. PROJECT/,/^---\|^$/p' "${TASK_CARD}"`. The generated `02-create-task-card` task-card has a blank line immediately after `## §10. PROJECT.md 갱신 사항...`, so the extraction range can stop before §10.1/§10.2 content while still being non-empty. |
| Evidence supports PARTIAL PASS only for script existence and static logic review, not for full executable correctness. | Medium | Evidence files consistently show script existence and static grep/cat analysis, while avoiding execution where hardcoded paths or external tools would be unsafe/unavailable. |

## 3. Disputed or Unproven Findings
| Finding | Reason |
|---|---|
| “References directories are empty” for 03, 06, and 07. | The evidence files report empty `references/` directories, but the packaged input also lists expected reference filenames for each skill. Actual file contents were not supplied. This finding is plausible but not fully proven from the packaged material alone. |
| `02-create-task-card` definitely misses a required §11. | The provided `02-create-task-card/SKILL.md` describes generation through §10 only. The evidence says SKILL.md expects §1~§11, but that is not supported by the included SKILL.md text. It may be a template mismatch, but template content was not provided. |
| Current Builder session proves `03-dispatch-to-builder/scripts/dispatch.sh` works as-is. | The evidence says the current session was started by the dispatch procedure “or equivalent manual procedure.” Because the script itself hardcodes `silkroadhub` and sends `Read tmp/...` as a relative path, this does not prove the packaged script works from `dubyeol-workflow`. |
| `gpt-5.5` model compatibility is confirmed. | Evidence asserts it matches local guidance, but no actual API call was executed. Runtime model availability and endpoint compatibility remain unproven. |
| Handoff verification conclusively proves no push/destructive-git activity. | The evidence shows useful checks, but `git reflog | grep push` is not a reliable push detector, and reflog grep is not comprehensive for all destructive or remote operations. It is evidence of limited local checks, not conclusive proof. |

## 4. Missed Technical Risks
| Risk | Severity | Evidence |
|---|---|---|
| Wrong-repository contamination risk if scripts are executed while `silkroadhub` exists. | Critical | Because `REPO_ROOT` is hardcoded, write-capable scripts create or modify files under `/Users/twostars/ClaudeAi/silkroadhub`. A successful run may silently place evidence, reports, task-cards, or PROJECT.md changes in the wrong repo. |
| `RUN_ID` is not validated or normalized before path construction. | High | Scripts concatenate `${RUN_ID}` into `.harness/runs/${RUN_ID}` and `tmp/claude-entry-${RUN_ID}.md`. A malformed run ID containing `../`, path separators, or shell-hostile characters could escape intended output locations or create confusing paths. Variables are mostly quoted, but path traversal is still possible. |
| External-call Python heredocs are vulnerable to malformed input breaking the generated Python source. | High | `04`, `06`, and `07` embed `${SYSTEM_PROMPT}` and `${PROMPT_CONTENT}` directly into Python triple-quoted strings inside a shell-expanded heredoc. Input containing `"""`, certain backslashes, or crafted content can cause syntax errors or alter the generated Python program. |
| `03-dispatch-to-builder` sends a relative instruction path to Terminal. | Medium | Script creates `${REPO_ROOT}/tmp/claude-entry-${RUN_ID}.md` but sends `Read tmp/claude-entry-${RUN_ID}.md...` to a target window without ensuring that window’s working directory is `${REPO_ROOT}`. The Builder may read the wrong file or fail to find it. |
| `verify_handoff.sh` masking check misses uncommitted files and run artifacts. | High | Script checks `git log --since="6 hours ago" -p` only if recent commits exist. Current evidence shows uncommitted files under `.harness/runs/...` and `tmp/`; those are not scanned for sensitive patterns by the script. |
| `verify_handoff.sh` push detection is technically weak. | Medium | `git reflog` generally records local ref movements, not remote push events. Grepping reflog for “push” can miss actual pushes and can produce false confidence. |
| `verify_handoff.sh` destructive-git detection is incomplete. | Medium | Grepping reflog for strings such as `reset --hard`, `rebase -i`, `force`, `filter-branch`, `--amend` misses destructive file operations outside reflog and may not capture all dangerous git sequences. |
| `08-write-final-report` section extraction is broad and may copy wrong ranges. | Medium | `extract_section()` uses `sed -n "/${section}/,/^## §\|^## [0-9]/p" | head -50`. Broad regexes such as `§1\|## §1` can match unintended text, and hard `head -50` truncates long sections without warning. |
| `09-update-project-md` modifies `PROJECT.md` before approval review. | High | Although it avoids commit, the script appends to `PROJECT.md` immediately and only then prints diff/approval instructions. If run against the wrong repo due to hardcoded root, this becomes both a wrong-repo and operating-document mutation risk. |
| SKILL.md/script references to root-relative `scripts/load_openai_key.sh` are unresolved. | Medium | `04`, `06`, and `07` error messages say `source scripts/load_openai_key.sh` first, but no root `scripts/` directory is included in the reviewed artifact list. |

## 5. Required Fixes Before Closure
| Fix | Priority | Scope |
|---|---|---|
| Remove or replace all hardcoded `/Users/twostars/ClaudeAi/silkroadhub` `REPO_ROOT` values so scripts operate on the intended `dubyeol-workflow` repository or an explicitly supplied safe root. | P0 | All 10 scripts |
| Align script invocation paths with actual packaging: either make SKILL.md execution context explicit or provide a consistent root-level dispatch mechanism. | P0 | All 9 SKILL.md files and script layout |
| Resolve interpreter mismatch by making invocation examples and script syntax use the same supported shell/runtime. | P0 | All SKILL.md call examples and scripts; especially `01` and `02` associative-array usage |
| Prevent wrong-repo writes and path traversal by validating `run_id` and constraining outputs to approved run directories. | P0 | Scripts writing under `.harness/runs` or `tmp`: `02`, `03`, `04`, `05`, `06`, `07`, `08`, `09` |
| Make input isolation enforceable in scripts or explicitly mark input-file creation as a separate manual prerequisite. | P1 | `04-invoke-plan-review`, `06-invoke-reviewer`, `07-invoke-judge` |
| Replace unsafe Python heredoc prompt embedding with a robust file/JSON input mechanism. | P1 | `04-invoke-plan-review`, `06-invoke-reviewer`, `07-invoke-judge` |
| Reconcile template claims with implementation: either actually consume `.harness/templates/*` or remove the template-dependence claim and add drift checks. | P1 | `02-create-task-card`, `08-write-final-report` |
| Fix `09-update-project-md` extraction and placement behavior so it does not silently append incomplete §10 content or misrepresent §C/§D/§E automation. | P0 | `09-update-project-md/scripts/update_project_md.sh` and matching SKILL.md contract |
| Strengthen handoff verification checks for push evidence, destructive actions, uncommitted sensitive data, and scope changes. | P1 | `05-verify-handoff/scripts/verify_handoff.sh` |
| Resolve reference-file discrepancies and ensure every SKILL.md referenced file exists with auditable content. | P2 | `references/` under all skill directories, especially `03`, `06`, `07` |
| Add end-to-end execution evidence after path/interpreter fixes, including safe dummy runs proving output locations under `dubyeol-workflow/.harness/runs/<run_id>`. | P0 | All 9 skills before G-2 closure |

## 6. Reviewer Boundary Check
- Code/technical scope only: yes
- Business/Judge role avoided: yes
- Direct code modification performed: no
