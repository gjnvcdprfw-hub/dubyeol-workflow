#!/usr/bin/env bash
set -euo pipefail
cd /Users/twostars/ClaudeAi/silkroadhub
RUN=.harness/runs/20260516_claude-md-r6-update
OUT=$RUN/foreman-v2-verification.md
{
  echo '# Foreman v2 verification'
  echo
  echo '## Outputs'
  for f in "$RUN/claude-md-global-draft-v2.md" "$RUN/claude-md-project-draft-v2.md" "$RUN/v2-correction-summary.md"; do
    if [ -f "$f" ]; then
      echo "PRESENT $f $(wc -l < "$f") lines"
    else
      echo "MISSING $f"
    fi
  done
  echo
  echo '## Grep checks'
  if [ -f "$RUN/claude-md-global-draft-v2.md" ]; then
    echo -n 'global_gate_judge_plus_residual='; grep -cF "Gate Judge + Devil's Advocate" "$RUN/claude-md-global-draft-v2.md" || true
    echo -n 'global_judge_phrase='; grep -cF '[Judge] — Devil' "$RUN/claude-md-global-draft-v2.md" || true
    echo -n 'global_reviewer_fallback_phrase='; grep -cF '[Reviewer] 폴백' "$RUN/claude-md-global-draft-v2.md" || true
  fi
  if [ -f "$RUN/claude-md-project-draft-v2.md" ]; then
    echo -n 'project_gate_judge_residual='; grep -cE "Gate Judge \+ Devil's Advocate|Gate Judge" "$RUN/claude-md-project-draft-v2.md" || true
    echo -n 'project_legacy_residual='; grep -cE 'v3\.5\.0|두별워크플로우' "$RUN/claude-md-project-draft-v2.md" || true
    echo -n 'project_new_masking='; grep -cE 'OpenAI|주민등록번호|카드 번호' "$RUN/claude-md-project-draft-v2.md" || true
    echo -n 'project_domain_masking='; grep -cE '운송장|BL|개인통관고유부호' "$RUN/claude-md-project-draft-v2.md" || true
    echo -n 'project_reviewer_judge_terms='; grep -cE '\[Reviewer\]|\[Judge\]|코덱스|지피티|ChatGPT' "$RUN/claude-md-project-draft-v2.md" || true
  fi
  echo
  echo '## Actual file comparison'
  if [ -f "$RUN/claude-md-global-draft-v2.md" ]; then
    if cmp -s "$HOME/.claude/CLAUDE.md" "$RUN/claude-md-global-draft-v2.md"; then echo 'GLOBAL_EQUALS_V2'; else echo 'GLOBAL_DIFFERS_FROM_V2'; fi
  fi
  if [ -f "$RUN/claude-md-project-draft-v2.md" ]; then
    if cmp -s /Users/twostars/ClaudeAi/silkroadhub/CLAUDE.md "$RUN/claude-md-project-draft-v2.md"; then echo 'PROJECT_EQUALS_V2'; else echo 'PROJECT_DIFFERS_FROM_V2'; fi
  fi
  echo
  echo '## Git status short'
  git status --short
} > "$OUT"
cat "$OUT"
