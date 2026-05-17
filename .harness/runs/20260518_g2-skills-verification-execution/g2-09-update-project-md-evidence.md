# G-2 증거 파일 — 09-update-project-md

**스킬 ID**: `09-update-project-md`  
**스킬 경로**: `/Users/twostars/ClaudeAi/dubyeol-workflow/09-update-project-md/`  
**검증 일시**: 2026-05-18  
**판정**: **PARTIAL PASS**

---

## 1. 테스트 목표

`scripts/update_project_md.sh` 존재 여부, [Owner] 승인 경계 구현 정합성(자동 commit 금지), diff 생성 방식, 백업 생성 여부 확인. Builder는 PROJECT.md를 수정하지 않으므로 정적 분석 + dummy diff 생성.

---

## 2. 전제조건 점검

| 전제조건 | 확인 결과 |
|---|---|
| `update_project_md.sh` 존재 | ✅ `09-update-project-md/scripts/update_project_md.sh` |
| `PROJECT.md` 존재 | ✅ `/Users/twostars/ClaudeAi/dubyeol-workflow/PROJECT.md` |
| task-card §10 완성 | ⚠️ 본 task는 SUB-2 진행 중 — §10 미완성 |
| [Owner] 명시 승인 확보 | ❌ 미확보 (SUB-5 이후) |
| Builder가 직접 PROJECT.md 수정 | 금지 (역할 침범) |

---

## 3. 테스트 입력 (정적 분석)

스크립트 코드 분석으로 승인 경계 구현 검증.

dummy proposed diff: 
- Builder는 PROJECT.md를 직접 수정하지 않음
- 대신 스크립트 로직 분석으로 "승인 전 diff만 출력" 동작 검증

---

## 4. 실제 수행 명령·행동

```bash
# 스크립트 존재 확인
ls /Users/twostars/ClaudeAi/dubyeol-workflow/09-update-project-md/scripts/
# → update_project_md.sh

# 스크립트 내용 정적 분석
cat /Users/twostars/ClaudeAi/dubyeol-workflow/09-update-project-md/scripts/update_project_md.sh

# PROJECT.md 존재 확인
ls /Users/twostars/ClaudeAi/dubyeol-workflow/PROJECT.md
# → 존재 ✅

# Builder는 PROJECT.md 수정 금지 → 스크립트 미실행
```

---

## 5. G-1 설계 / SKILL.md 기대 동작

1. `scripts/update_project_md.sh <run_id>` 실행
2. task-card §10에서 갱신 사항 추출
3. PROJECT.md 백업 생성
4. PROJECT.md §C·§D 갱신
5. diff 출력 (commit 안 함)
6. 마누스 diff 검토 후 [Owner] 승인
7. 승인 후 별도 git commit

---

## 6. 실제 결과

### 6.1 스크립트 분석

| 분석 항목 | 결과 |
|---|---|
| `REPO_ROOT` 값 | ❌ `"/Users/twostars/ClaudeAi/silkroadhub"` 하드코딩 |
| 자동 commit 금지 | ✅ 스크립트 내 git commit 명령 없음 |
| 백업 생성 | ✅ `cp "${PROJECT_MD}" "${BACKUP}"` |
| diff 출력 | ✅ `git diff "${PROJECT_MD}" > "${DIFF_FILE}"` |
| task-card §10 비어있을 때 오류 처리 | ✅ `exit 3`로 명시적 오류 |
| 승인 절차 안내 | ✅ "다음 행동 (마누스 수동)" 명시 |
| 거부 시 복원 안내 | ✅ `cp ${BACKUP} ${PROJECT_MD}` |

### 6.2 승인 경계 검증

스크립트가 수행하는 것:
1. PROJECT.md 끝에 `cat >>` 로 §10 내용 추가 (작업 디렉토리 변경만)
2. `git diff` 출력 + diff 파일 저장
3. **git commit 없음** ✅
4. 마누스에게 수동 검토 + [Owner] 승인 후 별도 commit 지시

이는 SKILL.md의 "자동 commit 절대 금지" 원칙을 올바르게 구현함.

### 6.3 §C·§D 자동 배치 한계

스크립트는 PROJECT.md 끝에 블록을 `cat >>`로 덧붙임. 실제 §C.N·§D 위치는 마누스가 수동으로 이동해야 함 (주석으로 명시됨). 완전 자동 배치는 구현되지 않았으나 안전한 설계 선택.

### 6.4 dummy proposed diff (개념 설명)

실제 실행 없이 스크립트가 생성할 diff의 구조:
```diff
+<!-- update-project-md 스킬 자동 추가, 2026-05-18, Run ID <run_id> -->
+<!-- 마누스 수동 검토 후 §C·§D 적절 위치로 이동 필요 -->
+
+## [SUB-5 자동 추가 — Run <run_id>]
+
+<task-card §10 내용>
```

---

## 7. 판정: PARTIAL PASS

| 점검 항목 | 결과 |
|---|---|
| `update_project_md.sh` 존재 | ✅ |
| 자동 commit 금지 구현 | ✅ |
| 백업 생성 구현 | ✅ |
| diff 출력 구현 | ✅ |
| 승인 절차 안내 포함 | ✅ |
| `REPO_ROOT` 경로 정합성 | ❌ **FAIL** (silkroadhub 하드코딩) |
| §C·§D 자동 정확 배치 | ⚠️ **PARTIAL** (끝에 추가 후 수동 이동) |
| Builder가 PROJECT.md 직접 수정 | ✅ **미실행** (역할 경계 준수) |

---

## 8. 결함 상세 및 의존성 영향

### 결함 목록

1. **[DEFECT-09-A] REPO_ROOT 하드코딩**: 동일 패턴.
2. **[DEFECT-09-B] §C·§D 자동 배치 미구현**: 끝에 덧붙이는 방식으로 마누스 수동 이동 필요. 위험 최소화를 위한 의도적 선택으로 보임 — r7에서 개선 여지.

### 의존성 영향

- PROJECT.md 갱신은 Foreman(마누스)이 [Owner] 승인 후 수행하므로 Builder 차단 없음
- 9개 스킬 중 유일하게 운영 파일을 직접 수정하는 스킬이므로 승인 경계 설계가 가장 중요함 → 올바르게 구현됨

---

## 9. 증거 스니펫

```bash
# REPO_ROOT 확인
$ grep "REPO_ROOT" 09-update-project-md/scripts/update_project_md.sh
REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"

# 자동 commit 없음 확인
$ grep "git commit" 09-update-project-md/scripts/update_project_md.sh
(출력 없음 — git commit 명령 없음 ✅)

# 백업 생성 확인
cp "${PROJECT_MD}" "${BACKUP}"

# diff 출력 확인
git diff "${PROJECT_MD}" > "${DIFF_FILE}" 2>&1 || true

# 승인 경계 안내 출력
echo "5. [Owner] 명시 승인 후 별도 단계로 git commit"

# PROJECT.md 존재 확인
$ ls /Users/twostars/ClaudeAi/dubyeol-workflow/PROJECT.md
PROJECT.md ✅
```
