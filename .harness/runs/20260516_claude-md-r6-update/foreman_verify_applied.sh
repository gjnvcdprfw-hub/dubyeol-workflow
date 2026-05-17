#!/usr/bin/env bash
set -euo pipefail
cd /Users/twostars/ClaudeAi/silkroadhub
RUN=.harness/runs/20260516_claude-md-r6-update
OUT=$RUN/foreman-applied-verification.md
{
  echo '# Foreman applied verification'
  echo
  echo '## Grep checks on actual files'
  echo -n 'global_gate_judge_plus_residual='; grep -cF "Gate Judge + Devil's Advocate" "$HOME/.claude/CLAUDE.md" || true
  echo -n 'global_judge_phrase='; grep -cF '[Judge] — Devil' "$HOME/.claude/CLAUDE.md" || true
  echo -n 'global_reviewer_fallback_phrase='; grep -cF '[Reviewer] 폴백' "$HOME/.claude/CLAUDE.md" || true
  echo -n 'project_gate_judge_residual='; grep -cE "Gate Judge \+ Devil's Advocate|Gate Judge" /Users/twostars/ClaudeAi/silkroadhub/CLAUDE.md || true
  echo -n 'project_legacy_residual='; grep -cE 'v3\.5\.0|두별워크플로우' /Users/twostars/ClaudeAi/silkroadhub/CLAUDE.md || true
  echo -n 'project_new_masking='; grep -cE 'OpenAI|주민등록번호|카드 번호' /Users/twostars/ClaudeAi/silkroadhub/CLAUDE.md || true
  echo -n 'project_domain_masking='; grep -cE '운송장|BL|개인통관고유부호' /Users/twostars/ClaudeAi/silkroadhub/CLAUDE.md || true
  echo -n 'project_reviewer_judge_terms='; grep -cE '\[Reviewer\]|\[Judge\]|코덱스|지피티|ChatGPT' /Users/twostars/ClaudeAi/silkroadhub/CLAUDE.md || true
  echo
  echo '## File match checks'
  if cmp -s "$HOME/.claude/CLAUDE.md" "$RUN/claude-md-global-draft-v2.md"; then echo 'GLOBAL_MATCHES_V2'; else echo 'GLOBAL_NOT_MATCH_V2'; fi
  if cmp -s /Users/twostars/ClaudeAi/silkroadhub/CLAUDE.md "$RUN/claude-md-project-draft-v2.md"; then echo 'PROJECT_MATCHES_V2'; else echo 'PROJECT_NOT_MATCH_V2'; fi
  echo
  echo '## Protected diff names'
  git diff --name-only -- AGENTS.md SUB-1-*.md SUB-2-*.md SUB-3-*.md SUB-4-*.md SUB-5-*.md .harness/templates PROJECT.md || true
  echo
  echo '## Intended project diff names'
  git diff --name-only -- CLAUDE.md || true
  echo
  echo '## Git status short'
  git status --short
  echo
  echo '## Diff line counts'
  wc -l "$RUN/global-claude-apply.diff" "$RUN/project-claude-apply.diff" 2>/dev/null || true
} > "$OUT"
cat "$OUT"
