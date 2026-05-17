# task-card: CLAUDE.md r6 운영 기준 갱신

**run ID**: 20260516_claude-md-r6-update  
**작성일시**: 2026-05-16 20:43  
**작성자**: [Foreman]  
**상태**: 기획 완료  
**두별 워크트리 카테고리**: 4 (문서·운영)  
**Tier**: A

---

## 1. [Owner] 발화 원문

> 응답 정확해. r6 정신 그대로 진입했어.
>
> [지금 베타 가동 first task가 아니라 *베타 가동 직전 준비 task* 진행]
>
> 지금 막 마누스 프로젝트 지침을 r6 풀버전으로 갱신했고, 너의 동작 확인됐어.
> 하지만 베타 가동 전에 두 단계가 더 남았어:
>
> Phase B: CLAUDE.md 갱신 (지금 task)
> Phase D: 스킬 GitHub 등록 (그 다음)
>
> [참고 — 이미 완료된 사항]
> - Phase A (r6 매뉴얼·양식 적용)은 별도 세션에서 완료. r6-rollout 브랜치에 3개 commit + push까지 완료됨 (다른 마누스 세션이 처리).
> - 본 세션에서는 그 결과를 *전제로* 진입하면 돼.
> - AGENTS.md·SUB-1~5·.harness/templates/ 모두 r6 풀버전이 r6-rollout 브랜치에 박혀있음 — 너가 직접 git log·git status로 확인 가능.
>
> [현재 브랜치 확인 먼저]
> 시작 전에:
> 1. git branch --show-current  → r6-rollout이어야 함
> 2. ls .harness/manus-prompts/ → 6개 프롬프트 보여야 함
> 3. cat AGENTS.md | wc -l → 약 500줄이어야 함 (r6 풀버전)
>
> 3개 다 통과하면 본 task 진입. 하나라도 어긋나면 [Owner]께 보고.
>
> [Task 발화]
> .harness/manus-prompts/프롬프트-CLAUDE-md-갱신.md 그대로 읽고 그 프롬프트 task를 진행해.
>
> run_id: 20260516_claude-md-r6-update
> Tier: A (운영 문서 변경 — 모든 향후 [Builder] 행동 기반)
> 카테고리: 4 (문서·운영)
>
> 이 task는 SUB-1 §2 5단계 SOP 진행하되 다음 사실 인지:
> - "한 문장 목표"는 이미 프롬프트에 명시됨 (Step 2 §2.1 참조)
> - "Looks Like / Looks Wrong / 가정"은 프롬프트 §2.1·§2.2에서 추출 가능
> - PROJECT.md §C 연결 모듈은 *없음* (PROJECT.md 자체가 템플릿 상태 + 이건 메타 운영 task)
> - 따라서 task-card §2 "상위 맥락 연결"은 "r6 베타 가동 직전 마지막 준비 task — PROJECT.md 연결 모듈 없음 (메타 운영)"으로 박음
>
> [PROJECT.md 처리]
> 지금은 *템플릿 그대로 둠*. 베타 가동 후 첫 진짜 task부터 §C·§D 채워나감.
> 본 Phase B task의 §10 PROJECT.md 갱신 사항은 *비움*. 본 task는 PROJECT.md에 박힐 영구 자료 없음 (운영 부수물).
>
> [베타 가동 첫 실전 흐름 인지]
> 본 task가 r6 흐름의 *첫 실전 가동*이야. 의도적으로 *작은 운영 task*로 골랐어 — 흐름 검증·어색함 발견용. 어색한 부분은 final-report §12 회고에 솔직히 누적해줘. r7 개정의 직접 자료.
>
> 진입.

---

## 2. 상위 맥락 연결 (PROJECT.md 진입 시점)

- **연결 모듈**: r6 베타 가동 직전 마지막 준비 task — PROJECT.md 연결 모듈 없음 (메타 운영)
- **진입 시점 마일스톤**: 해당 없음 — PROJECT.md §B·§C·§D는 템플릿 상태이며, [Owner] 지시에 따라 본 task에서 그대로 둠
- **이번 task로 *전진시키는 것***: [Builder]가 향후 r6 task-card와 handoff 기준으로 일관되게 움직이도록 글로벌 및 프로젝트 CLAUDE.md를 r6 v3.6.0 r1 베타에 정합화
- **PROJECT.md 진입 시점 스냅샷**:
  - 모듈 상태: 해당 없음 — 메타 운영 task
  - 현재 막힌 점: 없음. 단, PROJECT.md는 아직 템플릿 상태임을 확인함

---

## 3. 의도 정렬 증거 블록 (SUB-1 §2 SOP 결과 — 불변)

> 본 블록은 task 진행 중 **수정 금지**. 의도 변경 발생 시 §9에 *추가* 블록으로 기록.

### 3.1 한 문장 목표 (What)

글로벌 `~/.claude/CLAUDE.md`와 프로젝트 `silkroadhub/CLAUDE.md`를 두별 워크플로우 v3.6.0 r1 베타에 정합하게 갱신한다.

### 3.2 성공 시 보이는 모습 (Looks Like)

- 글로벌 CLAUDE.md에서 `두별워크플로우 v3.5.0` 표현이 `두별 워크플로우 v3.6.0 r1 베타` 기준으로 갱신되고, 띄어쓰기 또한 `두별 워크플로우`로 통일된다.
- 글로벌 CLAUDE.md에 `두별 워크트리 — 5가지 카테고리`, `[Builder] 자가 보고 트리거`, `fix-loop 한계`, `handoff-template.md` 참조, `[Builder] 자동 제안 자제 의무`가 추가된다.
- 프로젝트 CLAUDE.md에 PROJECT.md 참조 기준, 카테고리 매핑, OpenAI·외부 API 키 및 주민등록번호·카드번호 마스킹 기준이 추가된다.
- `~/.claude/CLAUDE.md`의 Safety Rules, Git·보안 경계, 기존 코드 작성 원칙·테스트 명령·언어 규칙이 약화 없이 보존된다.
- `silkroadhub/CLAUDE.md`의 Tier 키워드, 도메인 마스킹, Git·commit·배포 경계, 금지 사항이 약화 없이 보존되며, `.harness/runs/20260516_claude-md-r6-update/handoff.md`에 변경 요약과 검증 결과가 남는다.

### 3.3 실패 시 보이는 모습 (Looks Wrong)

- `grep -c "v3.6.0\|두별 워크트리\|자가 보고 트리거\|fix-loop\|handoff-template" ~/.claude/CLAUDE.md` 결과가 0이거나 핵심 항목 일부가 누락된다.
- `grep -c "v3.6.0\|PROJECT.md\|카테고리 매핑\|OpenAI" /Users/twostars/ClaudeAi/silkroadhub/CLAUDE.md` 결과가 0이거나 핵심 항목 일부가 누락된다.
- 글로벌 CLAUDE.md에서 `rm -rf`, `git push --force`, `.env` 등 안전·보안 핵심 항목의 grep 카운트가 기존보다 감소한다.
- 프로젝트 CLAUDE.md에서 `운송장`, `BL`, `개인통관고유부호` 등 silkroadhub 도메인 마스킹 항목의 grep 카운트가 기존보다 감소한다.
- AGENTS.md, SUB-1~5, `.harness/templates/`, 코드 파일 등 명시적 제외 범위 파일이 변경된다.

### 3.4 모호어 해소 기록

- "약 500줄" → "`cat AGENTS.md | wc -l` 결과가 499줄이면 통과로 본다. 실제 사전 검증에서 499줄 확인됨."
- "6개 프롬프트" → "`.harness/manus-prompts/` 목록에 6개 파일이 보이면 통과로 본다. 실제 사전 검증에서 6개 파일 확인됨."
- "PROJECT.md §C 연결 모듈은 없음" → "task-card §2 연결 모듈은 `r6 베타 가동 직전 마지막 준비 task — PROJECT.md 연결 모듈 없음 (메타 운영)`으로 기록하고, PROJECT.md는 수정하지 않는다."

### 3.5 마누스가 가정한 것 3가지

**가정 1**: 본 task에서 `~/.claude/CLAUDE.md`와 `silkroadhub/CLAUDE.md`의 실제 내용 변경은 [Owner]가 이 task 발화로 승인한 범위 안에 있다.  
→ 근거: [Owner]가 `프롬프트-CLAUDE-md-갱신.md` 그대로 진행하라고 지시했고, 해당 프롬프트의 범위가 두 파일 갱신으로 한정되어 있다.  
→ 검증: task-card 결재 후 SUB-2에서 진행하며, commit·push·merge는 별도 [Owner] 명시 승인 전 실행하지 않는다.

**가정 2**: 글로벌 CLAUDE.md의 현재 `v3.5.0` 문구는 r6 전환 전 잔여 문구이며, `v3.6.0 r1 베타`로 갱신해야 하는 대상이다.  
→ 근거: 프롬프트 Step 2·3이 버전 표시 갱신을 명시했고, 현재 상태 확인에서 두 CLAUDE.md 모두 `v3.5.0` 표현을 포함함을 확인했다.  
→ 검증: 갱신 후 grep 검증에서 `v3.6.0` 및 r6 핵심 키워드가 0이 아닌지 확인한다.

**가정 3**: 본 task는 PROJECT.md의 영구 기획·모듈 이력을 남기지 않는 메타 운영 task이므로 PROJECT.md는 수정하지 않는다.  
→ 근거: [Owner]가 `PROJECT.md는 템플릿 그대로 둠`, `본 Phase B task의 §10 PROJECT.md 갱신 사항은 비움`이라고 명시했다.  
→ 검증: 최종 diff에서 PROJECT.md가 변경되지 않았는지 확인한다.

### 3.6 정렬 확인

- **정렬 일시**: 2026-05-16 20:43
- **[Owner] 명시 응답**: "진입."

---

## 4. Tier 판정

- **Tier**: A
- **판정 근거**: 운영 문서 변경이며, 향후 모든 [Builder] 행동 기준에 영향을 준다. [Owner]가 Tier A로 명시했고, SUB-1 §4.2의 권한·운영 영향 및 AGENTS.md 권한 천장 기준상 높은 영향 범위로 본다.
- **Blast Radius**: CLAUDE.md 지침이 잘못 갱신되면 향후 Claude Code가 권한 천장, handoff, 마스킹, 자가 보고 트리거를 잘못 해석할 수 있다. 최악의 경우 모든 후속 Builder run의 실행 경계와 보고 품질에 영향을 준다.
- **Gate 의무**:
  - Tier A: [Reviewer] + [Judge] 둘 다, gate-review.md 필수

---

## 5. 작업 범위 (Scope)

### 5.1 포함

- 글로벌 `~/.claude/CLAUDE.md` 현재 상태 확인 및 r6 v3.6.0 r1 베타 기준 갱신
- 프로젝트 `/Users/twostars/ClaudeAi/silkroadhub/CLAUDE.md` 현재 상태 확인 및 r6 v3.6.0 r1 베타 기준 갱신
- `.harness/runs/20260516_claude-md-r6-update/claude-md-current-state.md` 작성
- `.harness/runs/20260516_claude-md-r6-update/claude-md-global-draft.md` 초안 작성
- `.harness/runs/20260516_claude-md-r6-update/claude-md-project-draft.md` 초안 작성
- 실제 CLAUDE.md 덮어쓰기 전, 마누스가 verify-handoff + grep 검증 + 초안 본문을 [Owner]에게 공유하고 명시 검수·승인을 받는 절차 수행
- [Owner] 승인 후에만 `~/.claude/CLAUDE.md` 및 `/Users/twostars/ClaudeAi/silkroadhub/CLAUDE.md` 실제 덮어쓰기
- 실제 덮어쓰기 후 diff를 한 번 더 [Owner]에게 공유
- `.harness/runs/20260516_claude-md-r6-update/handoff.md` 작성
- 갱신 전 초안 기준 grep 검증, 승인 후 실제 파일 기준 grep 검증 및 보존 사항 확인
- Tier A 감리 산출물인 `.harness/runs/20260516_claude-md-r6-update/gate-review.md` 작성
- SUB-5 종료 시 `.harness/runs/20260516_claude-md-r6-update/final-report.md` 작성 및 회고 기록

### 5.2 명시적 제외 (out of scope)

- AGENTS.md 변경
- SUB-1~5 변경
- `.harness/templates/` 변경
- `.harness/manus-prompts/` 변경
- PROJECT.md 변경
- 애플리케이션 코드 변경
- git commit, push, merge, deploy 실행
- Phase D 스킬 GitHub 등록 작업

### 5.3 산출물 (Deliverables)

- [Owner] 승인 후 갱신된 `~/.claude/CLAUDE.md`
- [Owner] 승인 후 갱신된 `/Users/twostars/ClaudeAi/silkroadhub/CLAUDE.md`
- `.harness/runs/20260516_claude-md-r6-update/claude-md-current-state.md`
- `.harness/runs/20260516_claude-md-r6-update/task-card.md`
- `.harness/runs/20260516_claude-md-r6-update/claude-md-global-draft.md`
- `.harness/runs/20260516_claude-md-r6-update/claude-md-project-draft.md`
- `.harness/runs/20260516_claude-md-r6-update/handoff.md`
- `.harness/runs/20260516_claude-md-r6-update/gate-review.md`
- `.harness/runs/20260516_claude-md-r6-update/final-report.md`

---

## 6. 진행 트리 (두별 워크트리)

선택한 카테고리에 따른 진행 트리는 **AGENTS.md §3 진행 트리**를 따른다.

본 task의 카테고리: 4 (문서·운영)

### 6.1 변형 사유 (해당 시)

카테고리 4 표준 트리 `using-superpowers → brainstorming → 작성 → 자체 review → finishing-a-development-branch`를 따른다. 단, 본 task는 Tier A 운영 문서 변경이므로 SUB-3 외부 감리를 필수로 수행한다.

---

## 7. 검증 명령

본 task의 성공 여부를 확인할 구체 명령어다. [Builder]는 verification 단계에서 실행하고 결과를 handoff에 기록한다.

```bash
# 글로벌 r6 핵심 항목 확인
grep -c "v3.6.0\|두별 워크트리\|자가 보고 트리거\|fix-loop\|handoff-template" ~/.claude/CLAUDE.md

# 프로젝트 r6 핵심 항목 확인
grep -c "v3.6.0\|PROJECT.md\|카테고리 매핑\|OpenAI" /Users/twostars/ClaudeAi/silkroadhub/CLAUDE.md

# 글로벌 핵심 안전 항목 보존 확인
grep -c "rm -rf\|git push --force\|.env" ~/.claude/CLAUDE.md

# 프로젝트 도메인 마스킹 보존 확인
grep -c "운송장\|BL\|개인통관고유부호" /Users/twostars/ClaudeAi/silkroadhub/CLAUDE.md

# 초안 파일 기준 핵심 항목 확인 — 실제 덮어쓰기 전 Owner 검수 단계
cd /Users/twostars/ClaudeAi/silkroadhub
grep -c "v3.6.0\|두별 워크트리\|자가 보고 트리거\|fix-loop\|handoff-template" .harness/runs/20260516_claude-md-r6-update/claude-md-global-draft.md
grep -c "v3.6.0\|PROJECT.md\|카테고리 매핑\|OpenAI" .harness/runs/20260516_claude-md-r6-update/claude-md-project-draft.md

# 제외 범위 변경 여부 확인
git status --short
git diff -- AGENTS.md SUB-1-*.md SUB-2-*.md SUB-3-*.md SUB-4-*.md SUB-5-*.md .harness/templates PROJECT.md
```

실제 CLAUDE.md 파일 덮어쓰기는 위 초안 검증 및 [Owner] 명시 승인 후에만 수행한다. 실제 덮어쓰기 후 동일 grep 검증과 diff 공유를 반복한다.

---

## 8. 권한 천장·금지 사항 (재확인)

[Owner] 명시 승인 없이 [Builder] 실행 금지:

- [ ] push / merge / deploy
- [ ] 운영 문서 변경 반영 (AGENTS.md, CLAUDE.md, templates 등)
- [ ] 파괴적 git 명령 (reset --hard, force push, history rewrite)
- [ ] task scope 확장 (§5.2 제외 범위 침범)
- [ ] 외부 시스템 프로덕션 실호출
- [ ] Tier 강등

본 task 특유의 추가 금지 사항:

- AGENTS.md는 본 task에서 변경하지 않는다.
- PROJECT.md는 본 task에서 변경하지 않는다.
- Phase D 스킬 GitHub 등록은 본 task에서 착수하지 않는다.
- commit·push·merge는 SUB-5 종료 후에도 [Owner]의 별도 명시 승인 없이는 실행하지 않는다.

---

## 9. 의도 변경 기록 (해당 시만 추가)

### 9.1 의도 변경 1차

- **변경 일시**: 2026-05-16 20:43 이후
- **변경 사유**: [Owner]가 task-card 결재와 함께 운영 문서 통째 갱신에 대한 적용 전 검수 절차를 추가 지시함
- **변경 내용**: [Builder]는 실제 CLAUDE.md 파일을 즉시 덮어쓰지 않고, 먼저 `.harness/runs/20260516_claude-md-r6-update/claude-md-global-draft.md` 및 `claude-md-project-draft.md` 초안을 작성한다. 마누스는 verify-handoff, grep 검증, 초안 본문을 [Owner]에게 공유하고, [Owner] 명시 검수·승인 후에만 실제 파일을 덮어쓴다. 실제 덮어쓰기 후 diff를 한 번 더 [Owner]에게 공유한다.
- **회고 누적 예정**: `카테고리 4 task에서 §3.2 Looks Like와 §7 검증 명령이 중복되는 경향. 의도 정렬 양식 정합성 검토 필요.`를 final-report §12 회고에 기록한다.
- **새 정렬 확인**: "진행. 단 두 가지 짚어줄게:" 이하 [Owner] 보완 지시 전체

### 9.2 의도 변경 2차 — Tier A SUB-3 분기 재점검

- **변경 일시**: 2026-05-16 22:00 이후
- **변경 사유**: [Owner]가 실제 반영 검증 후, 본 task가 Tier A임에도 [Foreman]이 SUB-3 외부 감리 의무를 자가 점검하지 않고 commit 결재 단계로 직진한 문제를 지적함.
- **변경 내용**: [Owner] 결정에 따라 SUB-3 [Judge] 외부 감리 예외를 적용한다. 사유는 메타 운영 task의 순환 참조 위험이다. [Judge]가 r6 매뉴얼 자체를 평가하려면 그 매뉴얼을 알아야 판정 가능한데, 그 매뉴얼이 이제 막 글로벌·프로젝트 CLAUDE.md에 반영되었기 때문이다. 이 예외는 `20260516_claude-md-r6-update` 1회에 한하며, 베타 가동 후 첫 실전 task부터 Tier A/B는 정상 SUB-3를 수행한다. [Owner]가 로컬 commit까지 결재했으므로 commit은 진행 가능하되, push는 별도 결재 전 진행하지 않는다.
- **회고 누적 예정 4**: `베타 가동 첫 실전 흐름 — [Foreman] 마누스가 *Tier A → SUB-3 의무*를 자가 점검 없이 commit 결재로 직진. AGENTS.md §7.1 호출 분기표 적용 의무를 *진행 흐름에서 강제하는 절차* 필요. 옵션: (1) SUB-2 §4 verify-handoff 마지막에 'Tier A/B면 SUB-3 진입 의무 확인' 체크박스 추가. (2) handoff §11 다음 단계 양식에 'Tier별 다음 SUB 자동 표기' 박기. (3) 메타 운영 task의 [Judge] 순환 참조 위험에 대한 예외 절차 매뉴얼화.`를 final-report §12 회고에 기록한다.
- **회고 누적 예정 5**: `마누스 글로벌 지침과 r6 [Judge]의 관계 명확화: 마누스 글로벌 지침의 [소크라테스 문답법] 절은 마누스에게 *상시 경량 Devil's Advocate 역할*을 의무화한다. r6 매뉴얼의 [Judge] (지피티 외부 호출)와 *목적·강도·산출이 다른* 보완 기능. r6 매뉴얼이 *둘의 관계*를 명시 안 함. r7에 박을 권고: (a) AGENTS.md §1 5자 정의에 한 줄 추가: '[Foreman] 마누스는 글로벌 지침에 따라 *상시 경량 Devil's Advocate*를 수행한다. 이는 r6 [Judge]의 *중량 외부 감리*와 보완 관계이며 대체 아니다.' (b) 메타 task의 [Judge] 예외 적용 시, [Foreman]의 상시 Devil's Advocate가 *부분 안전선* 역할 명시. (c) 본 발견의 재사용 패턴: [Foreman]이 자기 권고를 *제한 문구·반박·대안*으로 자가 검증하는 행동은 *글로벌 지침 동작이지 r6 위반 아님*.`를 final-report §12 회고에 기록한다.
- **새 정렬 확인**: "나로 진행. ... SUB-3 예외 적용 + 제한 문구 + 회고 메모 5건 모두 박히면 commit 진행해."

---

## 10. PROJECT.md 갱신 사항 (task 종료 시 [Foreman] 작성, SUB-5)

> [Owner] 지시에 따라 본 Phase B task의 PROJECT.md 갱신 사항은 비워둔다. 본 task는 PROJECT.md에 박힐 영구 자료가 없는 메타 운영 부수물이다.

### 10.1 §C.[N] 모듈 갱신

해당 없음.

### 10.2 §D 결정 이력 추가 (큰 결정 발생 시)

해당 없음.

### 10.3 §A·§B 갱신 (카테고리 5 기획 task일 때만)

해당 없음.

### 10.4 PROJECT.md 반영 확인

- **반영 일시**: 해당 없음
- **PROJECT.md §E.마지막 갱신 task run ID에 박은 값**: 해당 없음

---

## 11. 다음 단계 진행 가이드

- [ ] [Owner] task-card 결재 ("진행" 응답)
- [ ] 단계 2 (워크플로우) 진입 → SUB-2 호출

---

**task-card 끝.**
