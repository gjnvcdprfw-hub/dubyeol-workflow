# [Reviewer] 폴백 절차 — 코덱스 불가 시 지피티 대체

본 문서는 AGENTS.md §7.5의 폴백 절차를 *스킬 내부 참조용*으로 정리.

## 폴백 진입 조건

다음 *모두* 충족해야 폴백:

1. 코덱스 호출 *2~3회 자동 재시도* 후 실패
2. 실패 사유가 *코드 자체 문제가 아니라 도구·환경 문제*임이 명확
   - CLI 오류 (`codex: command not found`, PATH 문제)
   - 환경 오류 (API 키 미로딩, 네트워크 단절)
   - rate limit (429)
3. [Foreman]이 [Owner]께 폴백 진입 사실 *사전 보고* + 명시 승인

**폴백 진입 금지 사례**:
- 코덱스 응답이 *"통과 안 됨"*이라는 이유 (그건 결과이지 도구 문제 아님)
- 코덱스 응답이 *느림* (그건 정상)
- 처음부터 폴백 사용 (코덱스 시도 없이)

## 폴백 절차 — Step by Step

### Step 1 — [Owner] 보고 + 승인

```
[폴백 진입 보고]
run_id: <run_id>
코덱스 시도 횟수: <N회>
실패 사유: <CLI 오류 / 환경 오류 / rate limit>
폴백 도구: 지피티 (Reviewer_Fallback 전용 세션)

승인 시 폴백 진행, 거부 시 코덱스 환경 점검 후 재시도.
```

### Step 2 — 지피티 [Reviewer] 전용 새 세션 열기

**핵심**: SUB-3 §4 [Judge] 세션과 *반드시 다른 세션*.

세션 라벨링 (마누스 작업 메모에 박음):
```
지피티 세션 A: Reviewer_Fallback_<run_id>  ← 본 폴백
지피티 세션 B: Judge_<run_id>              ← SUB-3 §4 (별개)
```

두 세션은 *입력 자료가 다름*. 절대 혼동 금지.

### Step 3 — 입력 자료 별도 파일로 저장

```bash
# Reviewer_Fallback 입력 자료
cat > .harness/runs/<run_id>/reviewer-input.md << EOF
[정보 격리 — 코드·기술 명세만]

=== handoff §2.2 변경 파일 목록 ===
<인용>

=== handoff §3 진행 이력 ===
<인용>

=== diff 발췌 (마스킹 적용) ===
<인용>

=== task-card §5 산출물 목록 ===
<인용>

전달 금지:
- task-card §1 [Owner] 발화
- task-card §3 의도 정렬 증거 블록
- PROJECT.md
- 사업 맥락
EOF

# 분리 검증
ls -la .harness/runs/<run_id>/reviewer-input.md
ls -la .harness/runs/<run_id>/judge-input.md   # 별도 파일이어야 함
```

### Step 4 — 지피티 호출 (Reviewer_Fallback 세션)

프롬프트 양식 (`references/codex-prompt-pattern.md`의 *코덱스용을 지피티에 맞게 조정*):

```
당신은 silkroadhub 프로젝트의 [Reviewer] — 기술 감리자입니다.
코덱스 도구 불가로 폴백 호출됨. 지피티가 [Reviewer] 역할을 수행.

다음 코드 변경에 대해 기술적 정합성을 감사하세요.
중요: 사업 맥락·기획 의도를 묻거나 추측하지 마세요. 코드 영역만.

=== 입력 자료 ===
<reviewer-input.md 내용>

=== 검토 기준 ===
1. 코드가 기술 명세와 정렬되는가?
2. 명시되지 않은 사이드이펙트 가능성?
3. 보안·성능·유지보수 우려?
4. 테스트가 변경을 진짜로 검증하는가?

=== 응답 형식 ===
Status: 통과 / 조건부 통과 / 보류 / 차단
각 기준에 대한 평가 (1~3 문장).
구체 파일·라인 근거 필수.
```

### Step 5 — 응답 저장 + 폴백 사실 명시

```bash
# 응답 저장
cat > .harness/runs/<run_id>/reviewer-raw.md << 'EOF'
[폴백 응답 — 지피티가 [Reviewer] 역할 수행 (Reviewer_Fallback_<run_id> 세션)]
[원인: 코덱스 <실패 사유>]
[Owner 폴백 승인: <YYYY-MM-DD HH:MM>]

<지피티 응답 원문>
EOF
```

### Step 6 — gate-review.md §1 작성 시 폴백 명시

`gate-review.md §1.1` 호출 정보 양식:

```
§1.1 호출 정보
- 호출 도구: 지피티 (Reviewer_Fallback) — 폴백 호출
- 폴백 사유: <CLI 오류 / 환경 / rate limit>
- [Owner] 폴백 승인: <YYYY-MM-DD HH:MM>
- 세션 라벨: Reviewer_Fallback_<run_id>
- 정상 호출 시 도구: 코덱스 (다음 task부터 복귀)
```

## 폴백 사후 처리

### 즉시 (해당 task 내)
- gate-review.md §1.1에 폴백 명시 ✅
- 다음 task부터 *코덱스 우선*으로 복귀

### 누적 (회고 자료)
- SUB-5 §12 회고에 폴백 발생 기록
- 폴백 사유 누적해서 *코덱스 환경 안정성 추적*

### 반복 발생 시
- 1주 내 폴백 2회 이상 발생 → [Owner]께 *코덱스 환경 점검 권고*
- 일관된 사유 → 환경 수정 (PATH·키·CLI 버전)

## 정보 격리 자가 점검 (폴백 직후 의무)

- [ ] Reviewer_Fallback 세션과 Judge 세션이 *다른 세션*인가?
- [ ] `reviewer-input.md`와 `judge-input.md`가 *다른 파일*인가?
- [ ] reviewer-input에 *의도·기획·사업 맥락이 포함되지 않았는가*?
- [ ] judge-input에 *코드 디테일이 포함되지 않았는가*? (다음 SUB-3 §4 호출 시 점검)
- [ ] 두 세션을 *동시에 열어두지 않았는가*? (혼동 위험)

5개 모두 통과 후에만 폴백 결과 사용.
