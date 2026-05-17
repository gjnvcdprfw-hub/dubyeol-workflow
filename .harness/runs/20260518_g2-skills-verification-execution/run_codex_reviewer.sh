#!/bin/zsh
set -u
export PATH="/Users/twostars/.local/node/bin:$PATH"
source ~/.zshrc 2>/dev/null || true
cd /Users/twostars/ClaudeAi/dubyeol-workflow
RUN_DIR=".harness/runs/20260518_g2-skills-verification-execution"
INPUT_FILE="$RUN_DIR/reviewer-input.md"
OUTPUT_FILE="$RUN_DIR/reviewer-raw.md"
LOG_FILE="$RUN_DIR/codex-exec.log"

echo "=== Codex Reviewer Start: $(date) ===" | tee "$LOG_FILE"
echo "INPUT_FILE=$INPUT_FILE" | tee -a "$LOG_FILE"
echo "OUTPUT_FILE=$OUTPUT_FILE" | tee -a "$LOG_FILE"

codex exec \
  --sandbox read-only \
  --output-last-message \
  - < "$INPUT_FILE" > "$OUTPUT_FILE" 2>> "$LOG_FILE"

EXIT_CODE=$?
echo "=== Codex Reviewer End: $(date), exit=$EXIT_CODE ===" | tee -a "$LOG_FILE"
echo "--- reviewer-raw head ---" | tee -a "$LOG_FILE"
head -20 "$OUTPUT_FILE" 2>&1 | tee -a "$LOG_FILE"
exit $EXIT_CODE
