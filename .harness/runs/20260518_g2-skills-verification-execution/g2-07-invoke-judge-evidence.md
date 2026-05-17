# G-2 증거 파일 — 07-invoke-judge

**스킬 ID**: `07-invoke-judge`  
**스킬 경로**: `/Users/twostars/ClaudeAi/dubyeol-workflow/07-invoke-judge/`  
**검증 일시**: 2026-05-18  
**판정**: **PARTIAL PASS**

---

## 1. 테스트 목표

`scripts/invoke_judge.sh` 존재 여부, 정보 격리 설계(기획·사업 영역 한정, 코드 제외) 정합성, [Reviewer] 세션과 분리 설계 확인. 실 GPT 호출은 Foreman 전용이므로 입력 격리 검증만 수행.

---

## 2. 전제조건 점검

| 전제조건 | 확인 결과 |
|---|---|
| `invoke_judge.sh` 존재 | ✅ `07-invoke-judge/scripts/invoke_judge.sh` |
| ChatGPT / GPT API 접근 (`OPENAI_API_KEY`) | ❌ Builder 환경에서 미설정 |
| `judge-input.md` (dummy) | ✅ `.harness/runs/g2-dummy-runs/07-invoke-judge/judge-input.md` 생성 |
| [Reviewer] 세션과 다른 세션 의무 확인 | ✅ SKILL.md·스크립트 주석에 명시 |
| `references/judge-prompt-pattern.md` | ❌ `07-invoke-judge/references/` 비어있음 |

---

## 3. 테스트 입력

dummy judge-input: `.harness/runs/g2-dummy-runs/07-invoke-judge/judge-input.md`
- task-card §1 [Owner] 발화 (dummy)
- task-card §3 의도 정렬 블록 (dummy)
- task-card §5 산출물 목록 (dummy)
- PROJECT.md §C.N 연결 모듈 (dummy)
- handoff §1 의도 정렬 대조 (dummy)
- gate-review §1 [Reviewer] 결과 요약 (dummy)
- diff 본문·코드 시그니처 미포함 (격리 확인)

---

## 4. 실제 수행 명령·행동

```bash
# 스크립트 존재 확인
ls /Users/twostars/ClaudeAi/dubyeol-workflow/07-invoke-judge/scripts/
# → invoke_judge.sh

# 참조 파일 확인
ls /Users/twostars/ClaudeAi/dubyeol-workflow/07-invoke-judge/references/
# → (비어있음)

# dummy 입력 격리 파일 생성
# → .harness/runs/g2-dummy-runs/07-invoke-judge/judge-input.md

# 스크립트 내용 정적 분석
cat /Users/twostars/ClaudeAi/dubyeol-workflow/07-invoke-judge/scripts/invoke_judge.sh

# 실 GPT 호출 미실행 (Builder 역할 범위 밖 + Foreman 전용)
```

---

## 5. G-1 설계 / SKILL.md 기대 동작

1. `scripts/invoke_judge.sh` 실행
2. `judge-input.md` 생성 (기획·사업 영역만, 코드 미포함)
3. GPT 별도 세션 호출 (model: gpt-5.5)
4. `judge-raw.md` 수신 및 저장
5. 마누스가 `gate-review.md §2` 작성

---

## 6. 실제 결과

### 6.1 스크립트 분석

| 분석 항목 | 결과 |
|---|---|
| `REPO_ROOT` 값 | ❌ `"/Users/twostars/ClaudeAi/silkroadhub"` 하드코딩 |
| GPT 모델 | `gpt-5.5` ✅ |
| max_tokens | 4000 (적정) |
| 시스템 프롬프트 | ✅ "코드 디테일을 보지 않음. 의도·기획·사업·논리 영역만 판정" |
| 4단 판정 형식 | ✅ 의도 정렬·사업 영향·Devil's Advocate·종합 판정 |
| Devil's Advocate 최소 3가지 강제 | ✅ 시스템 프롬프트에 명시 |
| `OPENAI_API_KEY` 확인 | ✅ |
| 세션 분리 주석 | ✅ "주의: [Reviewer] 세션과 *반드시 다른* 지피티 세션 사용" |

### 6.2 dummy 입력 격리 검증

judge-input.md 내용 점검:
- ✅ [Owner] 발화 포함
- ✅ 의도 정렬 증거 블록 포함
- ✅ 산출물 목록 포함
- ✅ PROJECT.md 연결 모듈 포함
- ✅ handoff §1 정렬 대조 포함
- ✅ [Reviewer] 결과 요약 포함
- ✅ diff 본문 미포함 (격리 준수)
- ✅ 코드 함수 시그니처 미포함 (격리 준수)
- ✅ 마스킹되지 않은 운영 데이터 미포함

### 6.3 [Reviewer]와 세션 분리 설계

- Codex([Reviewer])와 GPT([Judge])는 도구 자체가 다름 → 물리적 격리 자동 강제
- 폴백 시 GPT [Reviewer] 사용 → "Reviewer_Fallback" 라벨링 + 다른 세션 수동 강제 (SKILL.md 명시)
- invoke_judge.sh는 Codex를 호출하지 않음 → [Reviewer] 역할 침범 없음

---

## 7. 판정: PARTIAL PASS

| 점검 항목 | 결과 |
|---|---|
| `invoke_judge.sh` 존재 | ✅ |
| GPT 단독 모델 (`gpt-5.5`) | ✅ |
| 4단 판정 + DA 3가지 강제 | ✅ |
| `REPO_ROOT` 경로 정합성 | ❌ **FAIL** (silkroadhub 하드코딩) |
| 참조 파일 존재 | ❌ **FAIL** (`references/` 비어있음) |
| judge-input 격리 설계 | ✅ |
| [Reviewer] 세션 분리 설계 | ✅ |
| 실 GPT 호출 | 미실행 (Foreman 역할) |

---

## 8. 결함 상세 및 의존성 영향

### 결함 목록

1. **[DEFECT-07-A] REPO_ROOT 하드코딩**: 동일 패턴.
2. **[DEFECT-07-B] 참조 파일 부재**: `references/judge-prompt-pattern.md` 미작성.
3. **[DEFECT-07-C] Codex가 Judge 역할 수행 가능성**: 스크립트 설계상 GPT만 호출 → Codex Judge 역할 수행 방지됨 ✅

### 의존성 영향

- `06-invoke-reviewer`와 동일한 REPO_ROOT 패턴
- 실 운영은 마누스가 직접 GPT 호출 중이므로 차단 없음

---

## 9. 증거 스니펫

```bash
# REPO_ROOT 확인
$ grep "REPO_ROOT" 07-invoke-judge/scripts/invoke_judge.sh
REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"

# 세션 분리 주석 확인
echo "주의: [Reviewer] 세션과 *반드시 다른* 지피티 세션 사용"

# 시스템 프롬프트 코드 금지 확인
- 코드 디테일을 보지 않음
- 반대 논리·놓친 리스크 최소 3가지

# dummy judge-input 위치
.harness/runs/g2-dummy-runs/07-invoke-judge/judge-input.md

# 정보 격리 확인
- diff 본문 → 미포함 ✅
- 코드 시그니처 → 미포함 ✅
- 운영 데이터 → 미포함 ✅
```
