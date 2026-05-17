#!/usr/bin/env bash
set -euo pipefail
cd /Users/twostars/ClaudeAi/silkroadhub

git add CLAUDE.md .harness/runs/20260516_claude-md-r6-update

git commit \
  -m "docs(workflow): r6 v3.6.0 r1 베타 CLAUDE.md 적용 + 회고" \
  -m "run: 20260516_claude-md-r6-update" \
  -m "SUB-3 [Judge] 외부 감리 예외 적용: 메타 운영 task 순환 참조 위험으로 본 run 1회 한정." \
  -m "베타 가동 후 첫 실전 task부터 Tier A/B는 정상 SUB-3를 수행한다." \
  -m "마누스 글로벌 지침의 상시 경량 Devil's Advocate는 r6 [Judge] 중량 외부 감리와 보완 관계이며 대체가 아니다."
