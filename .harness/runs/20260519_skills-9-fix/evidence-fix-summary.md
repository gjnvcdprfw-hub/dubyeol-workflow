# evidence-fix-summary — Task 3 SUB-2

**run ID**: 20260519_skills-9-fix  
**작성일시**: 2026-05-19  
**작성자**: [Builder] (클로드코드)  
**대응 task-card**: `.harness/runs/20260519_skills-9-fix/task-card.md`

---

## 검증 방법 요약

- `grep -R 'REPO_ROOT="/Users/twostars'` → 하드코딩 잔재 없음 ✅
- `grep -R 'bash scripts/'` → 구 호출 경로 잔재 없음 ✅
- `zsh -n <script>` → 전체 10개 스크립트 신택스 OK ✅
- `grep 'load_openai_key'` → 키 로더 참조 없음 ✅
- `git status --short -- AGENTS.md SUB-1~5 PROJECT.md` → 변경 없음 ✅

---

## 스킬별 수정 내역

### 01-load-sub-manual

**변경 파일**:
- `scripts/load_sub.sh`
- `scripts/load_project_md.sh`
- `SKILL.md`

**변경 요약**:
1. `REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"` 제거 → `SCRIPT_DIR` / `SKILL_DIR` / `REPO_ROOT="${REPO_ROOT:-...}"` 자동감지 패턴으로 교체 (load_sub.sh, load_project_md.sh 모두)
2. `.git` 존재 검증 블록 추가 (REPO_ROOT 오인식 방어)
3. DEFECT-01-C 방어: 전체 로드 미수행 경고 메시지 추가 (`[WARN] 매뉴얼은 *전체 로드* 필수 — 부분만 읽으면 §0 강제력 손실`)
4. SKILL.md `## 동작 순서` step 1: `scripts/load_sub.sh` → `01-load-sub-manual/scripts/load_sub.sh`
5. SKILL.md `## 호출`: `bash scripts/` → `zsh 01-load-sub-manual/scripts/`
6. 스크립트 comment 헤더: `bash load_sub.sh` → `zsh 01-load-sub-manual/scripts/load_sub.sh`

**§11 대응 근거**:
- COMMON-DEFECT-A (REPO_ROOT 하드코딩 제거) ✅
- COMMON-DEFECT-B (SKILL.md 경로 정렬) ✅
- COMMON-DEFECT-C (zsh 통일) ✅ (shebang 이미 `#!/bin/zsh`, 호출 예시 `bash` → `zsh`)
- DEFECT-01-C (전체 로드 미수행 결함 방어) ✅

**§11 표 밖 변경 여부**: 없음

---

### 02-create-task-card

**변경 파일**:
- `scripts/create_task_card.sh`
- `SKILL.md`

**변경 요약**:
1. REPO_ROOT 하드코딩 제거 → 자동감지 패턴
2. `TEMPLATE="${REPO_ROOT}/.harness/templates/task-card-template.md"` 변수 추가
3. 템플릿 존재 여부 확인 블록 추가 (없으면 WARN 출력 후 heredoc으로 진행)
4. §11 "다음 단계 진행 가이드" 섹션을 heredoc에 추가 (§10.3 PROJECT.md 반영 확인 포함)
5. SKILL.md `## 호출`: `bash scripts/` → `zsh 02-create-task-card/scripts/`
6. SKILL.md `## 참조`: `silkroadhub .harness/templates/...` → `REPO_ROOT 기준` 표기

**§11 대응 근거**:
- COMMON-DEFECT-A (REPO_ROOT 제거) ✅
- DEFECT-02-B (템플릿 직접 사용 — 존재 확인 + TEMPLATE 변수) ✅
- DEFECT-02-C (§11 섹션 추가 기준 정렬) ✅

**§11 표 밖 변경 여부**: 없음

---

### 03-dispatch-to-builder

**변경 파일**:
- `scripts/dispatch.sh`
- `SKILL.md`

**변경 요약**:
1. REPO_ROOT 하드코딩 제거 → 자동감지 패턴
2. `INSTRUCTION_FILE` 경로를 `${REPO_ROOT}/tmp/claude-entry-${RUN_ID}.md`로 수정 (REPO_ROOT 기반)
3. 진입 명령 내용에서 `silkroadhub/CLAUDE.md` → `CLAUDE.md` (repo 독립적 표기)
4. SKILL.md `## 호출`: `bash scripts/` → `zsh 03-dispatch-to-builder/scripts/`
5. 스크립트 comment 헤더 업데이트

**§11 대응 근거**:
- COMMON-DEFECT-A (REPO_ROOT 제거) ✅
- COMMON-DEFECT-B (SKILL.md 경로 정렬) ✅
- DEFECT-03-B (references/ 파일 작성 기준 정렬 — 진입 명령의 silkroadhub 하드코딩 제거) ✅

**§11 표 밖 변경 여부**: 없음

---

### 04-invoke-plan-review

**변경 파일**:
- `scripts/invoke_plan_review.sh`
- `SKILL.md`

**변경 요약**:
1. REPO_ROOT 하드코딩 제거 → 자동감지 패턴 (스크립트 전체 재작성)
2. 입력 격리 강제: `INPUT_FILE` 미존재 시 오류 메시지에 "Prerequisite: 사전 작성 필요" 명시
3. Python heredoc → 파일 기반: `python3 - "${INPUT_FILE}" "${OUTPUT_FILE}" <<'PYEOF'`로 전환 (단일 따옴표 PYEOF = shell expansion 없음)
4. sys.argv로 input_file/output_file 전달 → 특수문자 injection 불가
5. system_prompt를 Python 변수로 이동 (shell expansion 없음)
6. `load_openai_key.sh` 참조 제거 → `OPENAI_API_KEY 환경변수 설정` 안내로 교체
7. SKILL.md `## 호출`: `bash scripts/` → `zsh 04-invoke-plan-review/scripts/`

**§11 대응 근거**:
- COMMON-DEFECT-A (REPO_ROOT 제거) ✅
- Reviewer finding 7 (입력 격리 강제) ✅
- missing risk (Python heredoc 안전성 — 파일 기반 전환) ✅

**§11 표 밖 변경 여부**: 없음

---

### 05-verify-handoff

**변경 파일**:
- `scripts/verify_handoff.sh`
- `SKILL.md`

**변경 요약**:
1. REPO_ROOT 하드코딩 제거 → 자동감지 패턴
2. G. uncommitted secret 스캔: `git diff HEAD` + `grep -iE` 민감 패턴 → WARN 출력
3. H. push 금지 확인: `git status`에서 "ahead of remote" 확인
4. I. .env staged 여부: `git diff --cached --name-only` + 민감 파일 패턴 → FAIL (즉시 중단)
5. J. 파괴적 git 명령 감지: bash `history`에서 `reset --hard`, `push --force` 등 패턴 확인 → WARN
6. 종합 메시지: "6개 항목" → "10개 항목"
7. SKILL.md `## 동작 순서`: 10개 항목으로 갱신, `## 호출`/`## 결과 처리` 업데이트

**§11 대응 근거**:
- COMMON-DEFECT-A (REPO_ROOT 제거) ✅
- Reviewer finding P1 (uncommitted secret 스캔, push 확인, .env staged 여부) ✅

**§11 표 밖 변경 여부**: 없음

---

### 06-invoke-reviewer

**변경 파일**:
- `scripts/invoke_reviewer.sh`
- `SKILL.md`

**변경 요약**:
1. REPO_ROOT 하드코딩 제거 → 자동감지 패턴 (스크립트 전체 재작성)
2. `export PATH="/Users/twostars/.local/node/bin:$PATH"` PATH 하드코딩 제거
3. 입력 격리 강제: `INPUT_FILE` 미존재 시 "Prerequisite: 사전 작성 필요" 오류
4. GPT 폴백 Python heredoc → 파일 기반: `python3 - "${INPUT_FILE}" "${OUTPUT_FILE}" <<'PYEOF'`
5. sys.argv로 파일 경로 전달
6. system_prompt를 Python 변수로 이동 (silkroadhub 제거)
7. `load_openai_key.sh` 참조 제거 → 환경변수 안내
8. SKILL.md `## 호출`: `bash scripts/` → `zsh 06-invoke-reviewer/scripts/`

**§11 대응 근거**:
- COMMON-DEFECT-A (REPO_ROOT 제거) ✅
- DEFECT-06-B (PATH 하드코딩 제거) ✅
- DEFECT-06-C (references/ 작성 기준 — silkroadhub 계정 참조 제거) ✅
- missing risk (Python heredoc 안전성) ✅

**§11 표 밖 변경 여부**: 없음

---

### 07-invoke-judge

**변경 파일**:
- `scripts/invoke_judge.sh`
- `SKILL.md`

**변경 요약**:
1. REPO_ROOT 하드코딩 제거 → 자동감지 패턴 (스크립트 전체 재작성)
2. 입력 격리 강제: `INPUT_FILE` 미존재 시 "Prerequisite: 사전 작성 필요" + "diff·코드 디테일은 포함 금지" 오류
3. Python heredoc → 파일 기반: `python3 - "${INPUT_FILE}" "${OUTPUT_FILE}" <<'PYEOF'`
4. sys.argv로 파일 경로 전달
5. system_prompt에서 silkroadhub 제거 (역할 설명만 유지)
6. `load_openai_key.sh` 참조 제거 → 환경변수 안내
7. SKILL.md `## 호출`: `bash scripts/` → `zsh 07-invoke-judge/scripts/`

**§11 대응 근거**:
- COMMON-DEFECT-A (REPO_ROOT 제거) ✅
- DEFECT-07-B (references/ 작성 기준 — silkroadhub 제거) ✅
- missing risk (Python heredoc 안전성) ✅

**§11 표 밖 변경 여부**: 없음

---

### 08-write-final-report

**변경 파일**:
- `scripts/write_final_report.sh`
- `SKILL.md`

**변경 요약**:
1. REPO_ROOT 하드코딩 제거 → 자동감지 패턴 (스크립트 전체 재작성)
2. `TEMPLATE="${REPO_ROOT}/.harness/templates/final-report-template.md"` 변수 추가
3. 템플릿 존재 여부 확인 블록 추가 (참조 경로 명시)
4. `extract_section` 안정성 개선:
   - 파일 존재 여부 선 검증 (`[[ ! -f "${file}" ]]`)
   - 섹션 미발견 시 안전한 빈 문자열 처리
   - `max_lines` 파라미터 추가로 호출 시 제어 가능
   - `2>/dev/null` 오류 억제
   - `|| true` 패턴으로 `set -e`에서 안전
5. `§ ` prefix와 `## [0-9§]` 종료 패턴 통합으로 섹션 경계 개선
6. SKILL.md `## 호출` / `## 참조` 업데이트

**§11 대응 근거**:
- COMMON-DEFECT-A (REPO_ROOT 제거) ✅
- DEFECT-08-B (템플릿 직접 사용 — TEMPLATE 변수 + 존재 확인) ✅
- DEFECT-08-C (extract_section 안정성 개선) ✅

**§11 표 밖 변경 여부**: 없음

---

### 09-update-project-md

**변경 파일**:
- `scripts/update_project_md.sh`
- `SKILL.md`

**변경 요약**:
1. REPO_ROOT 하드코딩 제거 → 자동감지 패턴 (스크립트 전체 재작성)
2. diff-first 패턴 구현:
   - `DRAFT_FILE="${REPO_ROOT}/tmp/project-md-draft-${RUN_ID}.md"` 임시 파일에 변경안 먼저 생성
   - `diff "${PROJECT_MD}" "${DRAFT_FILE}"` 마누스에게 diff 제시
3. approval-first 구현:
   - `read -r _CONFIRM` 으로 마누스 Enter 확인 후에만 `cp "${DRAFT_FILE}" "${PROJECT_MD}"` 적용
   - `--no-interactive` 플래그 지원: 드래프트만 생성 후 종료
4. §C·§D·§E 자동 배치:
   - task-card §10.1에서 §C 갱신 내용 추출
   - task-card §10.2에서 §D 결정 이력 추출
   - awk로 `§D` 섹션 앞에 §C 내용 삽입, `§E` 앞에 §D 내용 삽입
   - 섹션 미존재 시 파일 끝에 추가 (fallback)
   - §E `마지막 갱신 task run ID` / `마지막 갱신 일시` sed 자동 갱신
5. 기존 `cat >>` 직접 append 방식 제거
6. SKILL.md `## 호출`: `bash scripts/` → `zsh 09-update-project-md/scripts/` + `--no-interactive` 옵션 추가

**§11 대응 근거**:
- COMMON-DEFECT-A (REPO_ROOT 제거) ✅
- DEFECT-09-B (diff-first·approval-first 전환) ✅
- Reviewer finding 10~11 (§C·§D·§E 자동 배치 구현) ✅

**§11 표 밖 변경 여부**: 없음

---

## 종합 검증 결과

| 검증 항목 | 결과 |
|---|---|
| REPO_ROOT 하드코딩 잔재 (`grep 'REPO_ROOT="/Users/twostars'`) | 없음 ✅ |
| `bash scripts/` 잔재 (SKILL.md) | 없음 ✅ |
| 전체 10개 스크립트 zsh 신택스 | 전부 OK ✅ |
| `load_openai_key.sh` 참조 | 없음 ✅ |
| `silkroadhub` 하드코딩 잔재 (scripts) | 없음 ✅ |
| r7 대상 파일 변경 여부 (AGENTS.md, SUB-1~5, PROJECT.md) | 없음 ✅ |
| Python 파일기반 전환 (04, 06, 07) | 3개 파일 `<<'PYEOF'` 확인 ✅ |
| §11 표 밖 변경 | 없음 ✅ |

**[Foreman] 검증 권고 명령**:
```bash
cd /Users/twostars/ClaudeAi/dubyeol-workflow
RUN=.harness/runs/20260519_skills-9-fix

# 산출물 존재 확인
test -f "$RUN/task-card.md" && echo "task-card OK"
test -f "$RUN/evidence-fix-summary.md" && echo "evidence OK"
test -f "$RUN/handoff.md" && echo "handoff OK"

# 수정 대상 확인
git status --short -- r6-rollout-package/dubyeol-workflow-skills

# r7 대상 미변경 확인
git status --short -- AGENTS.md SUB-1-기획의도.md SUB-2-워크플로우.md SUB-3-외부감리.md SUB-4-수정.md SUB-5-종료.md PROJECT.md

# 하드코딩 잔재 없음 확인
grep -R 'REPO_ROOT="/Users/twostars' r6-rollout-package/dubyeol-workflow-skills || true
grep -R 'bash scripts/' r6-rollout-package/dubyeol-workflow-skills/*/SKILL.md || true

# 9개 스킬 등장 확인
grep -E "01-load-sub-manual|02-create-task-card|03-dispatch-to-builder|04-invoke-plan-review|05-verify-handoff|06-invoke-reviewer|07-invoke-judge|08-write-final-report|09-update-project-md" "$RUN/evidence-fix-summary.md"
```

---

**evidence-fix-summary 끝.**
