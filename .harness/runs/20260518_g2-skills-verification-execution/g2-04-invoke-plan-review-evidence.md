# G-2 증거 파일 — 04-invoke-plan-review

**스킬 ID**: `04-invoke-plan-review`  
**스킬 경로**: `/Users/twostars/ClaudeAi/dubyeol-workflow/04-invoke-plan-review/`  
**검증 일시**: 2026-05-18  
**판정**: **PARTIAL PASS**

---

## 1. 테스트 목표

`scripts/invoke_plan_review.sh` 존재 여부, plan-review 입력 격리 설계 정합성, GPT 호출 조건(OPENAI_API_KEY) 확인. Builder에서 실 GPT 호출은 금지이므로 dummy 입력으로 정적 검증 수행.

---

## 2. 전제조건 점검

| 전제조건 | 확인 결과 |
|---|---|
| `invoke_plan_review.sh` 존재 | ✅ `04-invoke-plan-review/scripts/invoke_plan_review.sh` |
| `plan-review-input.md` (dummy) | ✅ `.harness/runs/g2-dummy-runs/04-invoke-plan-review/plan-review-input.md` 생성 |
| ChatGPT / GPT API 접근 (OPENAI_API_KEY) | ❌ Builder 환경에서 미설정 — 실행 불가 |
| SUB-3 [Judge] 세션과 분리 의무 확인 | ✅ 스크립트 주석에서 "다른 세션 권고" 언급 |

---

## 3. 테스트 입력

dummy 자료: `.harness/runs/g2-dummy-runs/04-invoke-plan-review/plan-review-input.md`
- §1 [Owner] 발화 (dummy), §3 의도 정렬 블록 (dummy), plan 본문 (dummy), PROJECT.md 연결 모듈 (dummy)
- 코드 디테일·handoff 내용 미포함 (정보 격리 원칙 준수 확인)

---

## 4. 실제 수행 명령·행동

```bash
# 스크립트 존재 확인
ls /Users/twostars/ClaudeAi/dubyeol-workflow/04-invoke-plan-review/scripts/
# → invoke_plan_review.sh

# dummy 입력 파일 생성 (검증 목적)
# → .harness/runs/g2-dummy-runs/04-invoke-plan-review/plan-review-input.md

# 스크립트 내용 정적 분석
cat /Users/twostars/ClaudeAi/dubyeol-workflow/04-invoke-plan-review/scripts/invoke_plan_review.sh

# 실 GPT 호출 미실행 (Builder 권한 밖 + OPENAI_API_KEY 미설정)
```

---

## 5. G-1 설계 / SKILL.md 기대 동작

1. `scripts/invoke_plan_review.sh` 실행
2. 입력 자료를 `plan-review-input.md`에 저장 (코드 없이 plan만)
3. GPT 새 세션 호출 (SUB-3 [Judge] 세션과 분리)
4. 응답을 `plan-review.md`에 저장
5. 마누스가 통과/수정/보류/중단 판정 확인

---

## 6. 실제 결과

### 6.1 스크립트 분석

| 분석 항목 | 결과 |
|---|---|
| `REPO_ROOT` 값 | ❌ `"/Users/twostars/ClaudeAi/silkroadhub"` 하드코딩 |
| 입력 파일 경로 | `${RUN_DIR}/plan-review-input.md` → silkroadhub 경로 |
| `OPENAI_API_KEY` 확인 | ✅ `if [ -z "${OPENAI_API_KEY}" ]` 로 환경변수 체크 |
| GPT 모델 | `gpt-5.5` (watchout.md 안정 모델과 일치 ✅) |
| max_tokens | 3000 (적정) |
| 응답 저장 | `plan-review.md`에 저장 ✅ |
| 코드 디테일 금지 시스템 프롬프트 | ✅ "코드 디테일 검토 시도 금지" 명시 |
| 4단 판정 형식 | ✅ 의도 정렬·Looks Wrong·가정·종합 4단 |

### 6.2 입력 격리 설계 검증

dummy `plan-review-input.md` 내용 점검:
- ✅ [Owner] 발화 포함
- ✅ 의도 정렬 증거 블록 포함
- ✅ plan 본문 포함
- ✅ PROJECT.md 연결 모듈 포함
- ✅ 코드 diff 미포함 (정보 격리 준수)
- ✅ handoff 내용 미포함

### 6.3 GPT 호출 불가 (도구 격차 기록)

Builder 환경에서는 `OPENAI_API_KEY` 미설정으로 실 GPT 호출 불가. 이는 의도된 설계:
- plan-review 호출은 [Foreman](마누스)이 직접 수행하는 절차
- Builder는 입력 파일 격리 여부만 검증하고 실 호출은 Foreman 경로

---

## 7. 판정: PARTIAL PASS

| 점검 항목 | 결과 |
|---|---|
| 스크립트 파일 존재 | ✅ |
| `REPO_ROOT` 경로 정합성 | ❌ **FAIL** (silkroadhub 하드코딩) |
| 입력 격리 설계 | ✅ |
| `OPENAI_API_KEY` 환경변수 체크 | ✅ |
| GPT 모델 (`gpt-5.5`) | ✅ |
| 4단 판정 형식 시스템 프롬프트 | ✅ |
| 실 GPT 호출 가능 여부 (Builder 환경) | ❌ **불가** (도구 격차) |
| dummy 입력 격리 검증 | ✅ |

---

## 8. 결함 상세 및 의존성 영향

### 결함 목록

1. **[DEFECT-04-A] REPO_ROOT 하드코딩**: 입력/출력 경로가 silkroadhub 고정.
2. **[DEFECT-04-B] 도구 격차**: Builder에서 직접 GPT 호출 불가. 스크립트는 Foreman이 실행해야 함. SKILL.md에 "Foreman이 실행" 명시 필요.

### 의존성 영향

- `plan-review`는 실제로 [Foreman] 세션에서 수동 호출 중이므로 운영 차단 없음
- 스크립트는 자동화를 위한 도구로서 경로 수정 후 사용 가능

---

## 9. 증거 스니펫

```bash
# REPO_ROOT 하드코딩 확인
$ grep "REPO_ROOT" 04-invoke-plan-review/scripts/invoke_plan_review.sh
REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"

# GPT 모델 확인
$ grep "model" 04-invoke-plan-review/scripts/invoke_plan_review.sh
    "model": "gpt-5.5",

# 시스템 프롬프트 코드 금지 확인
$ grep -A2 "금지" 04-invoke-plan-review/scripts/invoke_plan_review.sh
- 코드 디테일 검토 시도 금지
- 추상적 "괜찮아 보임" 응답 금지

# dummy 입력 파일 생성 위치
.harness/runs/g2-dummy-runs/04-invoke-plan-review/plan-review-input.md
```
