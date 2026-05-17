#!/usr/bin/env bash
set -euo pipefail
cd /Users/twostars/ClaudeAi/silkroadhub
OUT=.harness/runs/20260516_claude-md-r6-update/claude-md-current-state.md
{
  echo '# CLAUDE.md current state'
  echo
  echo '## 글로벌 위치'
  ls -la "$HOME/.claude/CLAUDE.md"
  wc -l "$HOME/.claude/CLAUDE.md"
  echo
  echo '## 프로젝트 위치'
  ls -la /Users/twostars/ClaudeAi/silkroadhub/CLAUDE.md
  wc -l /Users/twostars/ClaudeAi/silkroadhub/CLAUDE.md
  echo
  echo '## 글로벌 버전 표시 grep'
  grep -nE 'v3\.5\.0|v3\.6\.0|두별워크플로우|두별 워크플로우' "$HOME/.claude/CLAUDE.md" || true
  echo
  echo '## 프로젝트 버전 표시 grep'
  grep -nE 'v3\.5\.0|v3\.6\.0|두별워크플로우|두별 워크플로우' /Users/twostars/ClaudeAi/silkroadhub/CLAUDE.md || true
} > "$OUT"
cat "$OUT"
