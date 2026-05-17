#!/usr/bin/env bash
set -euo pipefail
cd /Users/twostars/ClaudeAi/silkroadhub
RUN=.harness/runs/20260516_claude-md-r6-update
OUT=$RUN/foreman-verification.md
{
  echo '# Foreman verification after Builder handoff'
  echo
  echo '## Outputs'
  for f in "$RUN/claude-md-global-draft.md" "$RUN/claude-md-project-draft.md" "$RUN/handoff.md"; do
    if [ -f "$f" ]; then
      echo "PRESENT $f $(wc -l < "$f") lines"
    else
      echo "MISSING $f"
    fi
  done
  echo
  echo '## Draft grep counts'
  if [ -f "$RUN/claude-md-global-draft.md" ]; then
    echo -n 'global_r6_core='; grep -cE 'v3\.6\.0|두별 워크트리|자가 보고 트리거|fix-loop|handoff-template' "$RUN/claude-md-global-draft.md" || true
    echo -n 'global_safety='; grep -cE 'rm -rf|git push --force|\.env' "$RUN/claude-md-global-draft.md" || true
  fi
  if [ -f "$RUN/claude-md-project-draft.md" ]; then
    echo -n 'project_r6_core='; grep -cE 'v3\.6\.0|PROJECT\.md|카테고리 매핑|OpenAI' "$RUN/claude-md-project-draft.md" || true
    echo -n 'project_masking='; grep -cE '운송장|BL|개인통관고유부호' "$RUN/claude-md-project-draft.md" || true
  fi
  echo
  echo '## Git status short'
  git status --short
  echo
  echo '## Protected diff names'
  git diff --name-only -- AGENTS.md SUB-1-*.md SUB-2-*.md SUB-3-*.md SUB-4-*.md SUB-5-*.md .harness/templates PROJECT.md CLAUDE.md || true
  echo
  echo '## Actual file comparison'
  if [ -f "$RUN/claude-md-global-draft.md" ]; then
    if cmp -s "$HOME/.claude/CLAUDE.md" "$RUN/claude-md-global-draft.md"; then
      echo 'GLOBAL_EQUALS_DRAFT'
    else
      echo 'GLOBAL_DIFFERS_FROM_DRAFT'
    fi
  fi
  if [ -f "$RUN/claude-md-project-draft.md" ]; then
    if cmp -s /Users/twostars/ClaudeAi/silkroadhub/CLAUDE.md "$RUN/claude-md-project-draft.md"; then
      echo 'PROJECT_EQUALS_DRAFT'
    else
      echo 'PROJECT_DIFFERS_FROM_DRAFT'
    fi
  fi
} > "$OUT"
cat "$OUT"
