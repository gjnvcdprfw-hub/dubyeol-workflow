#!/bin/zsh
# create_task_card.sh — task-card.md 초안 자동 생성
# 두별 워크플로우 v3.6.0 r1 베타 — Manus Agent Skill
#
# 호출: bash create_task_card.sh <run_id> <owner_utterance_file> <intent_alignment_file> <tier> <category>

set -e

RUN_ID="${1:?usage: create_task_card.sh <run_id> <owner_utt> <intent> <tier> <category>}"
OWNER_UTT="${2:?need owner utterance file}"
INTENT_FILE="${3:?need intent alignment file}"
TIER="${4:?need tier A/B/C}"
CATEGORY="${5:?need category 1-5}"

REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"
RUN_DIR="${REPO_ROOT}/.harness/runs/${RUN_ID}"
TASK_CARD="${RUN_DIR}/task-card.md"

mkdir -p "${RUN_DIR}"

OWNER_TEXT=$(cat "${OWNER_UTT}")
INTENT_TEXT=$(cat "${INTENT_FILE}")
NOW=$(date "+%Y-%m-%d %H:%M %Z")

# 카테고리별 진행 트리
declare -A TREES
TREES[1]="using-superpowers → brainstorming → writing-plans → using-git-worktrees → TDD → subagent-driven-development → requesting-code-review → verification-before-completion → finishing-a-development-branch"
TREES[2]="using-superpowers → systematic-debugging → test-driven-development (실패 재현) → 수정 → verification-before-completion → requesting-code-review → finishing-a-development-branch"
TREES[3]="using-superpowers → brainstorming (축약) → 구현 → verification-before-completion → finishing-a-development-branch"
TREES[4]="using-superpowers → brainstorming → 작성 → 자체 review → finishing-a-development-branch"
TREES[5]="using-superpowers → brainstorming → 작성 → 자체 review → finishing-a-development-branch"

PROGRESS_TREE="${TREES[$CATEGORY]}"

cat > "${TASK_CARD}" << TC_EOF
# task-card — Run ID ${RUN_ID}

> **상태**: 초안 자동 생성. 마누스 수동 보강 필요 (§2 상위 맥락 / §5 산출물·완료 기준 / §6 변형 사유)
> 작성 시각: ${NOW}

## §1. [Owner] 원 발화

\`\`\`
${OWNER_TEXT}
\`\`\`

## §2. 상위 맥락 연결 ★ 마누스 수동 보강 ★

- PROJECT.md §C.[N] 연결 모듈: *(여기에 모듈명·번호)*
- 분기 목표 정합성: *(§B와의 관계)*
- 최근 결정 이력: *(§D 관련 결정)*

## §3. 의도 정렬 증거 블록 (SOP 5단계 결과)

${INTENT_TEXT}

## §4. Tier·카테고리·플랜

- Tier: **${TIER}**
- 두별 워크트리 카테고리: **${CATEGORY}**
- 진행 트리 (카테고리 ${CATEGORY} 표준):
  - ${PROGRESS_TREE}

## §5. 산출물 + 완료 기준 ★ 마누스 수동 보강 ★

| 산출물 | 완료 기준 | 검증 방법 |
|---|---|---|
| *(예시)* | *(예시)* | *(예시)* |

### §5.1 포함 범위
- *(여기 작성)*

### §5.2 제외 범위 (scope 명시)
- *(여기 작성 — [Builder]가 침범 금지)*

## §6. 진행 트리 변형 사유 (해당 시) ★ 마누스 수동 보강 ★

- 표준 트리에서 *생략·추가* 단계 시 *재현 가능한 사유* 명시
- 생략 항목:
- 추가 항목:

## §7. 마스킹 적용 영역

- AGENTS.md §8 규칙 전체 적용
- 특별히 본 task에서 주의할 마스킹 영역: *(있으면 작성)*

## §8. 권한 천장·금지 사항

### 기본 권한 천장 (모든 task 공통)
1. git push / merge / deploy 금지 ([Owner] 명시 승인 후)
2. AGENTS.md·CLAUDE.md·PROJECT.md·.harness/templates/* 변경 금지
3. 파괴적 git (reset --hard, rebase -i, force push, history rewrite) 금지
4. task scope 확장 (§5.2 제외 범위 침범) 금지
5. 외부 시스템 프로덕션 실호출 금지 (결제·통관·DB migration)
6. Tier 강등 (A→B, B→C 자동 다운그레이드) 금지
7. [Builder]가 자동 제안하는 task-card 범위 밖 행동은 [Foreman]이 명령으로 해석 안 함

### 본 task 추가 금지 사항 ★ 필요 시 마누스 보강 ★
- *(있으면 작성)*

## §9. 변경 이력

| 시각 | 변경 | 사유 |
|---|---|---|
| ${NOW} | 초안 자동 생성 | create-task-card 스킬 |

## §10. PROJECT.md 갱신 사항 (SUB-5 §3 종료 시 채움)

> SUB-5 진입 시 update-project-md 스킬이 본 절을 읽어 PROJECT.md §C·§D 갱신

### §10.1 §C 모듈 갱신
- 모듈: §C.[N]
- 갱신 내용: *(SUB-5에서 채움)*

### §10.2 §D 결정 이력 추가 (있으면)
- *(SUB-5에서 채움)*
TC_EOF

echo "task-card 초안 생성: ${TASK_CARD}"
echo "분량: $(wc -l < "${TASK_CARD}") 줄"
echo ""
echo "마누스 수동 보강 필요:"
echo "  - §2 상위 맥락 연결 (PROJECT.md에서 추출)"
echo "  - §5 산출물 + 완료 기준"
echo "  - §6 변형 사유 (해당 시)"
echo "  - §8 추가 금지 사항 (필요 시)"
echo ""
echo "보강 완료 후 [Owner] 결재 요청"
