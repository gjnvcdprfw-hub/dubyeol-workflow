# G-2 증거 파일 — 02-create-task-card

**스킬 ID**: `02-create-task-card`  
**스킬 경로**: `/Users/twostars/ClaudeAi/dubyeol-workflow/02-create-task-card/`  
**검증 일시**: 2026-05-18  
**판정**: **PARTIAL PASS**

---

## 1. 테스트 목표

`scripts/create_task_card.sh` 존재 여부, `.harness/templates/task-card-template.md` 존재 여부, 스크립트가 올바른 경로에 §1~§11 포함 task-card 생성하는지 확인.

---

## 2. 전제조건 점검

| 전제조건 | 확인 결과 |
|---|---|
| `task-card-template.md` 존재 | ✅ `.harness/templates/task-card-template.md` 존재 |
| run_id 형식 (`YYYYMMDD_task-slug`) | ✅ 실제 사용 중 (예: `20260518_g2-skills-verification-execution`) |
| `create_task_card.sh` 존재 | ✅ `02-create-task-card/scripts/create_task_card.sh` |

---

## 3. 테스트 입력 (dummy)

```
run_id: g2-dummy-02
owner_utterance_file: (가상) /tmp/owner_utt.md
intent_alignment_file: (가상) /tmp/intent.md
tier: B
category: 4
```

실제 실행은 금지 (silkroadhub 경로 하드코딩으로 dubyeol-workflow에서 실행 시 오류 예상).
스크립트 내용을 정적 분석으로 검증.

---

## 4. 실제 수행 명령·행동

```bash
# 스크립트 존재 확인
ls /Users/twostars/ClaudeAi/dubyeol-workflow/02-create-task-card/scripts/
# → create_task_card.sh

# 템플릿 존재 확인
ls /Users/twostars/ClaudeAi/dubyeol-workflow/.harness/templates/
# → final-report-template.md  gate-review-template.md
#    handoff-template.md  task-card-template.md

# 스크립트 내용 검사 (정적 분석)
cat /Users/twostars/ClaudeAi/dubyeol-workflow/02-create-task-card/scripts/create_task_card.sh
```

---

## 5. G-1 설계 / SKILL.md 기대 동작

1. `scripts/create_task_card.sh` 실행
2. `.harness/runs/<run_id>/task-card.md` 자동 생성
3. 템플릿 §1~§11 전부 포함
4. run_id·작성일시·카테고리·Tier 메타데이터 채워짐
5. §2 상위 맥락·§5 산출물·§6 변형 사유는 마누스 수동 보강 영역

---

## 6. 실제 결과

### 6.1 스크립트 분석

| 분석 항목 | 결과 |
|---|---|
| `REPO_ROOT` 값 | ❌ `"/Users/twostars/ClaudeAi/silkroadhub"` 하드코딩 |
| `RUN_DIR` 계산 | `${REPO_ROOT}/.harness/runs/${RUN_ID}` → silkroadhub 경로로 생성됨 |
| task-card 경로 | `${RUN_DIR}/task-card.md` → silkroadhub에 생성됨 |
| 섹션 포함 여부 | ✅ §1~§10 포함 (SKILL.md 기술은 §1~§11이나 실제 §10까지 구현) |
| 카테고리별 진행 트리 | ✅ `declare -A TREES` 1~5 전부 정의됨 |
| 마누스 수동 보강 영역 표시 | ✅ `★ 마누스 수동 보강 ★` 명시 |

### 6.2 템플릿 파일 사용 여부

**결함**: SKILL.md에서 "`.harness/templates/task-card-template.md` 기반" 생성이라고 설명하지만, 실제 스크립트는 heredoc(`cat > "${TASK_CARD}" << TC_EOF`)으로 직접 내용을 생성. 템플릿 파일을 읽거나 참조하지 않음.

→ 템플릿 파일과 스크립트 생성 내용이 서로 독립적으로 관리될 위험. 템플릿 업데이트가 스크립트에 반영되지 않을 수 있음.

### 6.3 섹션 구성 검증 (스크립트 헤레독 분석)

| 섹션 | 포함 여부 |
|---|---|
| §1 [Owner] 원 발화 | ✅ |
| §2 상위 맥락 연결 (수동 보강) | ✅ |
| §3 의도 정렬 증거 블록 | ✅ |
| §4 Tier·카테고리·플랜 | ✅ |
| §5 산출물 + 완료 기준 (수동 보강) | ✅ (템플릿 플레이스홀더) |
| §6 진행 트리 변형 사유 (수동 보강) | ✅ |
| §7 마스킹 적용 영역 | ✅ |
| §8 권한 천장·금지 사항 | ✅ |
| §9 변경 이력 | ✅ |
| §10 PROJECT.md 갱신 사항 | ✅ |
| §11 다음 단계 진행 가이드 | ❌ **없음** (SKILL.md에는 §1~§11 언급) |

---

## 7. 판정: PARTIAL PASS

| 점검 항목 | 결과 |
|---|---|
| 스크립트 파일 존재 | ✅ |
| 템플릿 파일 존재 | ✅ |
| `REPO_ROOT` 경로 정합성 | ❌ **FAIL** (silkroadhub 하드코딩) |
| 템플릿 파일 실제 사용 | ❌ **FAIL** (heredoc으로 독립 생성) |
| 섹션 §1~§10 포함 | ✅ |
| §11 포함 | ❌ **누락** |
| 마누스 수동 보강 영역 명시 | ✅ |
| 카테고리별 진행 트리 자동 주입 | ✅ |

---

## 8. 결함 상세 및 의존성 영향

### 결함 목록

1. **[DEFECT-02-A] REPO_ROOT 하드코딩**: 생성 경로가 silkroadhub 고정. dubyeol-workflow에서 실행 시 silkroadhub에 task-card 생성됨 (또는 오류). → r7 정비 대상
2. **[DEFECT-02-B] 템플릿 미사용**: `task-card-template.md`가 존재하지만 스크립트가 직접 heredoc으로 생성. 두 소스의 섹션 구성이 향후 분기될 위험.
3. **[DEFECT-02-C] §11 누락**: SKILL.md 기술과 스크립트 실제 생성 섹션 간 불일치.

### 의존성 영향

- 실 운영에서는 마누스가 수동으로 task-card를 작성하고 있어 직접 차단 없음
- 스크립트 실행 시 silkroadhub에 파일이 생성되는 문제 있음

---

## 9. 증거 스니펫

```bash
# 스크립트 REPO_ROOT 라인
$ grep "REPO_ROOT" 02-create-task-card/scripts/create_task_card.sh
REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"

# 템플릿 파일 존재 확인
$ ls .harness/templates/
final-report-template.md  gate-review-template.md  handoff-template.md  task-card-template.md

# 스크립트 섹션 확인 (§1~§10 존재, §11 없음)
$ grep "^## §" 02-create-task-card/scripts/create_task_card.sh
## §1. [Owner] 원 발화
## §2. 상위 맥락 연결 ★ 마누스 수동 보강 ★
## §3. 의도 정렬 증거 블록 (SOP 5단계 결과)
## §4. Tier·카테고리·플랜
## §5. 산출물 + 완료 기준 ★ 마누스 수동 보강 ★
## §6. 진행 트리 변형 사유 (해당 시) ★ 마누스 수동 보강 ★
## §7. 마스킹 적용 영역
## §8. 권한 천장·금지 사항
## §9. 변경 이력
## §10. PROJECT.md 갱신 사항 (SUB-5 §3 종료 시 채움)

# 실 task-card 섹션 수 (20260518_g2 task-card 참고 — 수동 작성본은 §11 포함)
```
