#!/bin/zsh
set -u
cd /Users/twostars/ClaudeAi/dubyeol-workflow
RUN_DIR=.harness/runs/20260517_g1-skills-verification-design
DESIGN="$RUN_DIR/g1-skills-verification-design.md"
HANDOFF="$RUN_DIR/handoff.md"

echo '--- HEAD ---'
git rev-parse --abbrev-ref HEAD
git rev-parse --short HEAD

echo '--- status ---'
git status --short

echo '--- recent commits ---'
git log --oneline -5

echo '--- recent merges ---'
git log --merges --oneline -5

echo '--- reflog suspicious ---'
git reflog -20 | egrep -i 'reset|rebase|force|merge|push|checkout' || true

echo '--- operating docs diff ---'
git diff --stat -- AGENTS.md PROJECT.md SUB-1-*.md SUB-2-*.md SUB-3-*.md SUB-4-*.md SUB-5-*.md .harness/templates/ || true

echo '--- run files ---'
ls -la "$RUN_DIR"

echo '--- silkroadhub pollution check ---'
if test ! -d /Users/twostars/ClaudeAi/silkroadhub/.harness/runs/20260517_g1-skills-verification-design; then
  echo OK_no_silkroadhub_run
else
  echo FAIL_silkroadhub_run_exists
fi

echo '--- skill coverage ---'
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
  if grep -q "$skill" "$DESIGN"; then
    echo "OK $skill"
  else
    echo "MISSING $skill"
  fi
done

echo '--- suspect signal ---'
grep -n 'scripts/load_sub.sh\|G-2 우선' "$DESIGN" | head -20 || true

echo '--- prohibited suggestion scan ---'
grep -n 'git push\|git commit\|commit the G-1\|commit (신규' "$HANDOFF" || true
