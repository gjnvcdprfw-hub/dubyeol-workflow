# G-2 증거 파일 — 06-invoke-reviewer

**스킬 ID**: `06-invoke-reviewer`  
**스킬 경로**: `/Users/twostars/ClaudeAi/dubyeol-workflow/06-invoke-reviewer/`  
**검증 일시**: 2026-05-18  
**판정**: **PARTIAL PASS**

---

## 1. 테스트 목표

`scripts/invoke_reviewer.sh` 존재 여부, 정보 격리 설계(코드 영역 한정) 정합성, 참조 파일 존재 여부, reviewer-input 격리 가능 여부 확인. 실 Codex 호출은 Foreman이 수행하므로 Builder에서는 입력 격리 검증만 수행.

---

## 2. 전제조건 점검

| 전제조건 | 확인 결과 |
|---|---|
| `invoke_reviewer.sh` 존재 | ✅ `06-invoke-reviewer/scripts/invoke_reviewer.sh` |
| Codex CLI 설치 | ✅ (watchout.md 기준 v0.128.0 + gpt-5.5 안정) |
| `reviewer-input.md` (dummy) | ✅ `.harness/runs/g2-dummy-runs/06-invoke-reviewer/reviewer-input.md` 생성 |
| `references/codex-prompt-pattern.md` | ❌ `06-invoke-reviewer/references/` 비어있음 |
| `references/fallback-procedure.md` | ❌ 비어있음 |
| `handoff.md` 수신 완료 | ⚠️ 본 세션 handoff는 작성 예정 |

---

## 3. 테스트 입력

dummy reviewer-input: `.harness/runs/g2-dummy-runs/06-invoke-reviewer/reviewer-input.md`
- handoff §2.2 변경 파일 목록 (dummy)
- handoff §3 진행 이력 (dummy)
- diff 발췌 (마스킹 적용, dummy)
- task-card §5 산출물 목록 (dummy)
- [Owner] 발화·의도 정렬·PROJECT.md 미포함 (정보 격리 확인)

---

## 4. 실제 수행 명령·행동

```bash
# 스크립트 존재 확인
ls /Users/twostars/ClaudeAi/dubyeol-workflow/06-invoke-reviewer/scripts/
# → invoke_reviewer.sh

# 참조 파일 확인
ls /Users/twostars/ClaudeAi/dubyeol-workflow/06-invoke-reviewer/references/
# → (비어있음)

# dummy 입력 격리 파일 생성
# → .harness/runs/g2-dummy-runs/06-invoke-reviewer/reviewer-input.md

# 스크립트 내용 정적 분석
cat /Users/twostars/ClaudeAi/dubyeol-workflow/06-invoke-reviewer/scripts/invoke_reviewer.sh

# 실 Codex 호출 미실행 (Builder 역할 범위 밖 + Foreman 전용)
```

---

## 5. G-1 설계 / SKILL.md 기대 동작

1. `scripts/invoke_reviewer.sh` 실행
2. `reviewer-input.md` 생성 (코드 diff·기술 명세만, 기획 제외)
3. Codex exec heredoc stdin 호출 (2~3회 재시도)
4. `reviewer-raw.md` 수신 및 저장
5. Codex 실패 시 GPT 폴백 (별도 세션)

---

## 6. 실제 결과

### 6.1 스크립트 분석

| 분석 항목 | 결과 |
|---|---|
| `REPO_ROOT` 값 | ❌ `"/Users/twostars/ClaudeAi/silkroadhub"` 하드코딩 |
| Codex 재시도 구현 | ✅ `CODEX_MAX_RETRY=2` + for 루프 |
| `--sandbox read-only` 옵션 | ✅ (적절한 안전 설정) |
| GPT 폴백 구현 | ✅ `OPENAI_API_KEY` 체크 후 폴백 |
| 폴백 시 `gate-review.md §1.1` 명시 의무 | ✅ 스크립트에서 명시적 안내 |
| `activate` 없이 stdin 방식 | ✅ `codex exec ... < "${INPUT_FILE}"` |
| 정보 격리 시스템 프롬프트 | ✅ "코드·기술 정합성만 감사" |

### 6.2 dummy 입력 격리 검증

reviewer-input.md 내용 점검:
- ✅ 변경 파일 목록 포함
- ✅ 진행 이력 포함
- ✅ diff 발췌 (마스킹) 포함
- ✅ 산출물 목록 포함
- ✅ [Owner] 발화 미포함 (격리 준수)
- ✅ 의도 정렬 블록 미포함 (격리 준수)
- ✅ PROJECT.md 미포함 (격리 준수)
- ✅ 사업 맥락 미포함 (격리 준수)

### 6.3 Codex 호출 불가 (역할 격리)

- 실 Codex 호출: **Foreman(마누스) 전용**. Builder는 입력 격리 검증만 수행.
- 본 G-2 task는 스킬 검증이므로 입력 파일 skeleton 준비로 충분.

---

## 7. 판정: PARTIAL PASS

| 점검 항목 | 결과 |
|---|---|
| `invoke_reviewer.sh` 존재 | ✅ |
| Codex 재시도 구현 | ✅ |
| GPT 폴백 구현 | ✅ |
| `REPO_ROOT` 경로 정합성 | ❌ **FAIL** (silkroadhub 하드코딩) |
| 참조 파일 존재 | ❌ **FAIL** (`references/` 비어있음) |
| reviewer-input 격리 설계 | ✅ |
| 실 Codex 호출 | 미실행 (Foreman 역할) |

---

## 8. 결함 상세 및 의존성 영향

### 결함 목록

1. **[DEFECT-06-A] REPO_ROOT 하드코딩**: 입력/출력 경로가 silkroadhub 고정.
2. **[DEFECT-06-B] 참조 파일 부재**: `references/codex-prompt-pattern.md`, `references/fallback-procedure.md` 미작성.
3. **[DEFECT-06-C] PATH 설정 방식**: `export PATH="/Users/twostars/.local/node/bin:$PATH"` 하드코딩 — 이식성 우려.

### 의존성 영향

- `07-invoke-judge`도 동일 패턴이므로 같은 결함 예상
- 실 운영은 마누스가 직접 Codex CLI 실행 중이므로 차단 없음

---

## 9. 증거 스니펫

```bash
# REPO_ROOT 확인
$ grep "REPO_ROOT" 06-invoke-reviewer/scripts/invoke_reviewer.sh
REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"

# references/ 비어있음
$ ls 06-invoke-reviewer/references/
(비어있음)

# Codex 재시도 구현 확인
CODEX_MAX_RETRY=2
for attempt in $(seq 1 ${CODEX_MAX_RETRY}); do
  ...
  codex exec --sandbox read-only --output-last-message - < "${INPUT_FILE}" > ...
  ...
done

# dummy reviewer-input 위치
.harness/runs/g2-dummy-runs/06-invoke-reviewer/reviewer-input.md

# 정보 격리 확인: 전달 금지 항목 없음
- [Owner] 발화 → 미포함 ✅
- 의도 정렬 블록 → 미포함 ✅
- PROJECT.md → 미포함 ✅
- 사업 맥락 → 미포함 ✅
```
