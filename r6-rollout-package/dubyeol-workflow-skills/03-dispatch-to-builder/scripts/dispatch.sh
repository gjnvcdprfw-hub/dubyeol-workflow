#!/bin/zsh
# dispatch.sh — 클로드코드(Builder) 세션에 SUB-2 진입 명령 전달
# 두별 워크플로우 v3.6.0 r1 베타 — Manus Agent Skill
# 검증 완료 2026-05-16
#
# 호출: bash dispatch.sh <run_id> <window_id> <tier> <category>
# 예:   bash dispatch.sh 20260516_manifest-fix 187 A 1

set -e

RUN_ID="${1:?usage: dispatch.sh <run_id> <window_id> <tier> <category>}"
WINDOW_ID="${2:?usage: dispatch.sh <run_id> <window_id> <tier> <category>}"
TIER="${3:?usage: dispatch.sh <run_id> <window_id> <tier> <category>}"
CATEGORY="${4:?usage: dispatch.sh <run_id> <window_id> <tier> <category>}"

REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"
INSTRUCTION_FILE="${REPO_ROOT}/tmp/claude-entry-${RUN_ID}.md"
RUN_DIR="${REPO_ROOT}/.harness/runs/${RUN_ID}"

mkdir -p "${REPO_ROOT}/tmp"
mkdir -p "${RUN_DIR}"

# 진입 명령 파일 작성
cat > "${INSTRUCTION_FILE}" << ENTRY_EOF
[Builder 진입 명령 — 두별 워크플로우 v3.6.0 r1]

task-card: .harness/runs/${RUN_ID}/task-card.md
두별 워크트리 카테고리: ${CATEGORY}
Tier: ${TIER}

본 task는 두별 워크플로우 v3.6.0 r1 SUB-2 단계.

[Builder] 행동 원칙:
1. 글로벌 ~/.claude/CLAUDE.md + 프로젝트 silkroadhub/CLAUDE.md 자동 로드 확인
2. task-card를 우선 입력으로 읽음. task-card §3 의도 정렬 증거 블록은 해석 기준
3. /using-superpowers 진입 후 task-card §[두별 워크트리 카테고리] 진행 트리 따름
4. 모든 산출물에 CLAUDE.md §6 마스킹 규칙 적용
5. task-card §8 권한 천장·금지 사항 절대 위반 금지
6. 작업 완료 또는 block 시 .harness/runs/${RUN_ID}/handoff.md 작성 후 정지
7. push/merge/deploy/운영 문서 변경/파괴적 git/scope 확장은 [Foreman] 또는 [Owner] 명시 승인 후
8. task 완료 후 commit·cleanup·추가 확인 등 task-card 범위 밖 행동을 자동 제안하지 않음. handoff.md만 작성하고 정지.

진입.
ENTRY_EOF

echo "진입 명령 파일 생성: ${INSTRUCTION_FILE}"
echo "행 수: $(wc -l < "${INSTRUCTION_FILE}")"
echo ""

# 2단계 확정 실행으로 클로드코드에 전달
# Step 1: 파일 읽으라는 짧은 명령 + Step 2: do script "" 로 Enter 확정
osascript << OSAEOF
tell application "Terminal"
  do script "Read tmp/claude-entry-${RUN_ID}.md and follow the instructions inside." in window id ${WINDOW_ID}
  do script "" in window id ${WINDOW_ID}
end tell
OSAEOF

echo "클로드코드 창 ${WINDOW_ID}에 진입 명령 전달 완료"
echo "다음: 5~10초 후 클로드코드 응답을 점검"
echo "  - task-card 경로 인지"
echo "  - 카테고리 ${CATEGORY}·Tier ${TIER} 인지"
echo "  - /using-superpowers 진입"
echo "  - 진입 명령 파일 정확히 읽음"
