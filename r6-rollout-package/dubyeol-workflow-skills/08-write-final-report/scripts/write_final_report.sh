#!/bin/zsh
# write_final_report.sh — final-report.md 초안 자동 생성
# 두별 워크플로우 v3.6.0 r1 베타 — Manus Agent Skill
#
# 호출: bash write_final_report.sh <run_id>

set -e

RUN_ID="${1:?usage: write_final_report.sh <run_id>}"
REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"
RUN_DIR="${REPO_ROOT}/.harness/runs/${RUN_ID}"
TASK_CARD="${RUN_DIR}/task-card.md"
HANDOFF="${RUN_DIR}/handoff.md"
GATE_REVIEW="${RUN_DIR}/gate-review.md"
PLAN_REVIEW="${RUN_DIR}/plan-review.md"
VERIFY="${RUN_DIR}/handoff-verification.md"
REPORT="${RUN_DIR}/final-report.md"

cd "${REPO_ROOT}"
NOW=$(date "+%Y-%m-%d %H:%M %Z")

extract_section() {
  local file="$1"
  local section="$2"
  if [ -f "${file}" ]; then
    sed -n "/${section}/,/^## §\|^## [0-9]/p" "${file}" | head -50
  fi
}

cat > "${REPORT}" << REPORT_EOF
# final-report — Run ID ${RUN_ID}

> 작성 시각: ${NOW}
> 상태: 초안 자동 생성. §10~§13은 마누스 수동 작성 필요

## §1. task 요약

### task-card §1 [Owner] 원 발화
$(extract_section "${TASK_CARD}" "§1.\|## §1")

### task-card §3 의도 정렬 증거 블록
$(extract_section "${TASK_CARD}" "§3.\|## §3")

## §2. 진행 결과

### handoff §2 변경 파일 목록
$(extract_section "${HANDOFF}" "§2\|## 2")

### handoff §3 진행 이력
$(extract_section "${HANDOFF}" "§3\|## 3")

## §3. 산출물

### task-card §5에서 정의된 산출물
$(extract_section "${TASK_CARD}" "§5\|## §5")

### handoff §2.2 변경 파일과 매칭
*(마누스 수동 대조)*

## §4. 검증 결과

### handoff §4 자체 검증
$(extract_section "${HANDOFF}" "§4\|## 4")

### handoff §5 fresh evidence
$(extract_section "${HANDOFF}" "§5\|## 5")

## §5. 외부 감리 결과

### gate-review §1 [Reviewer] 결과
$(extract_section "${GATE_REVIEW}" "§1\|## §1")

### gate-review §2 [Judge] 결과
$(extract_section "${GATE_REVIEW}" "§2\|## §2")

## §6. plan-review 결과 (해당 시)

$( [ -f "${PLAN_REVIEW}" ] && cat "${PLAN_REVIEW}" | head -30 || echo "*plan-review 미실시*" )

## §7. 변경 파일 (git 상태)

\`\`\`
$(git status --short 2>&1 | head -30)
\`\`\`

\`\`\`
$(git log --oneline --since="24 hours ago" 2>&1 | head -10)
\`\`\`

## §8. fix-loop 기록 (해당 시)

$(extract_section "${HANDOFF}" "fix-log\|fix 시도" || echo "*fix-loop 발동 없음*")

## §9. 권한 천장 점검

### verify-handoff 결과
$( [ -f "${VERIFY}" ] && tail -10 "${VERIFY}" || echo "*verify-handoff 미실행*" )

## §10. PROJECT.md 갱신 사항 ★ 마누스 수동 작성 ★

### §10.1 §C 모듈 갱신
- 모듈: §C.[N]
- 갱신 내용:

### §10.2 §D 결정 이력 추가 (있으면)

## §11. 후속 task 후보 ★ 마누스 수동 작성 ★

- 발견된 scope 밖 사항 (handoff §8 인용 가능)
- 다음 분기·다음 task로 미룬 사항

## §12. 회고 (베타 어색함 누적) ★ 마누스 수동 작성 ★

- r6 베타 운영 중 어색한 점
- 다음 r 개정에 입력할 사항
- 매뉴얼·양식 개선 제안

## §13. 마누스 짚을 점 ★ 수동 ★

- [Owner]께 추가로 짚어둘 사항
- 결정 필요점
- 보고 누락 우려점

REPORT_EOF

echo "final-report 초안 생성: ${REPORT}"
echo "분량: $(wc -l < "${REPORT}") 줄"
echo ""
echo "마누스 수동 작성 필요:"
echo "  - §3 산출물 매칭 수동 대조"
echo "  - §10 PROJECT.md 갱신 사항"
echo "  - §11 후속 task 후보"
echo "  - §12 회고"
echo "  - §13 짚을 점"
echo ""
echo "작성 완료 후 [Owner]께 제출"
echo "→ update-project-md 스킬 호출 (§10 반영)"
