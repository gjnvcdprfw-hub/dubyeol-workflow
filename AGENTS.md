# AGENTS.md — silkroadhub 에이전트 운영 지침 (두별 워크플로우 v3.6.0 r1 베타)

> **본 문서는 마누스(=[Foreman])가 현장 운영 시 참조하는 상세 지침이다.**
> 마누스 프로젝트 지침에서 *상세 라우팅*으로 본 문서를 가리키고, [Foreman]은 *필요할 때* 본 문서의 해당 절을 연다.
> Claude Code(=[Builder])는 본 문서를 자동 로드하지 않는다. `task-card.md`에서 명시 지시된 경우만 부분 참조.
> 본 문서 변경은 [Owner] 명시 승인 후 다음 r 개정 task로 진행.

---

## Quick Rules

| 항목 | 기준 |
|---|---|
| 프로젝트 | `silkroadhub` — 한국 포워더 중심 B2B SaaS 물류 플랫폼 |
| 로컬 경로 | `/Users/twostars/ClaudeAi/silkroadhub` |
| 기술 스택 | React/Vite/TypeScript/TailwindCSS · Spring Boot Java · JPA · PostgreSQL |
| 운영 모델 | 두별 워크플로우 v3.6.0 r1 (베타) — 5자 협업 + 5단계 흐름 |
| 상위 매뉴얼 | 마누스 프로젝트 지침 (얇은 라우팅) → `PROJECT.md` (기획 맥락) → 본 문서 → `SUB-1~5` (단계별 절차) |

---

## 1. 두별 워크플로우 v3.6.0 r1 — 5자 + 2 보조 도구

| 거버넌스 역할 | 도구 (정상) | 도구 (폴백) | 한 줄 |
|---|---|---|---|
| **[Owner]** | 대표님 | — | 의도 발화, 최종 승인·보류·중단 결정 |
| **[Foreman]** | 마누스 | — | 의도 번역, task-card 작성, [Builder] 지휘, 감리 호출, 보고 |
| **[Builder]** | 클로드코드 | — | task-card 기준 구현·검증·handoff |
| **[Reviewer]** | **코덱스** | 지피티 (전용 세션, 코덱스 불가 시) | 기술적 정합성 감사 — 코드 영역 |
| **[Judge]** | **지피티** (별도 세션) | — | Devil's Advocate — 사업·기획·논리 영역. 코드 *안 봄* |

**역할 ↔ 도구 매핑 원칙**:
- **정상**: [Reviewer] = 코덱스 / [Judge] = 지피티. 도구가 다르므로 정보 격리 *물리적으로 강제*
- **폴백** ([Reviewer] 도구 불가 시): 지피티가 [Reviewer]·[Judge] 둘 다 수행. 단 *반드시 다른 세션*. 정보 격리는 [Foreman]이 강제 (§7.5 참조)
- *코덱스가 [Judge] 역할 수행 금지*. 코덱스는 코드 보는 도구라 *기획·사업 검토 부적합*

**보조 도구** (5자 아님, [Builder]가 조건부 호출):
- **Context7** — 외부 docs 불확실성 해소 (just-in-time)
- **Code Simplifier** — post-green 가독성 정리

**[Reviewer] ↔ [Judge] 정보 격리**: 같은 모델이라도 *반드시 별도 세션*. 입력 자료 다름. 상세 SUB-3 §1.

---

## 2. r6 5단계 흐름

| 단계 | SUB | 주인공 | 호출 발화 |
|---|---|---|---|
| 1 | SUB-1 기획·의도 | [Owner]+[Foreman] | "기획 매뉴얼 봐" |
| 2 | SUB-2 워크플로우 | [Builder] (지휘 [Foreman]) | "워크플로우 매뉴얼 봐" |
| 3 | SUB-3 외부 감리 | [Reviewer]+[Judge] (Tier A/B만) | "감리 매뉴얼 봐" |
| 4 | SUB-4 수정 | [Foreman]+[Builder] (해당 시) | "수정 매뉴얼 봐" |
| 5 | SUB-5 종료 | [Foreman]+[Owner] | "종료 매뉴얼 봐" |

새 task 시작 시 [Foreman]은 다음 행동:
1. `PROJECT.md` 진입 점검 (§B 분기 목표 · §C 모듈 지도 · §D 결정 이력)
2. `SUB-1` 로드 → 기획·의도 진입

---

## 3. 두별 워크트리 — 5가지 카테고리·진행 트리 ★

[Foreman]은 task-card §[두별 워크트리 카테고리]에 1~5 중 하나 명시. [Builder]는 해당 트리 따름.

### 3.1 카테고리 표

| # | 카테고리 | 적용 예 | 진행 트리 |
|---|---|---|---|
| **1** | **표준 구현** | 신규 기능, 큰 수정 | `using-superpowers → brainstorming → writing-plans → using-git-worktrees → TDD → subagent-driven-development → requesting-code-review → verification-before-completion → finishing-a-development-branch` |
| **2** | **디버깅** | 버그·테스트 실패·regression | `using-superpowers → systematic-debugging → test-driven-development (실패 재현) → 수정 → verification-before-completion → requesting-code-review → finishing-a-development-branch` |
| **3** | **간단 변경** | 문구·CSS·정적 UI, 단순 API 옵션 | `using-superpowers → brainstorming (축약) → 구현 → verification-before-completion → finishing-a-development-branch` |
| **4** | **문서·운영** | 매뉴얼 변경, 운영 문서 작성, scripts 작성 | `using-superpowers → brainstorming → 작성 → 자체 review → finishing-a-development-branch` |
| **5** | **기획** | PROJECT.md 작성·갱신, 큰 결정 정리, 모듈 설계 | `using-superpowers → brainstorming → 작성 → 자체 review → finishing-a-development-branch` |

### 3.2 카테고리 선택 가이드

- 카테고리 1/2 경계: 코드를 *새로 짜는가* (1) / *기존 코드의 잘못을 찾아 고치는가* (2)
- 카테고리 1/3 경계: *기능 추가·로직 변경*이면 1, *표시·문구만*이면 3
- 카테고리 4/5 경계: *r6 자체·운영 문서·scripts*면 4, *사업 방향·모듈 지도·로드맵*이면 5

**경계가 모호하면 상위 카테고리로.** Tier 판정 원칙과 같음.

### 3.3 변형 트리

표준 트리에서 추가·생략 필요 시 task-card §6.1에 *변형 사유* 명시. 생략·추가 단계가 *재현 가능하게* 박혀야 함.

---

## 4. 상태 보고 양식 ★

[Foreman]이 [Owner]께 *진행 보고할 때*마다 다음 양식 머리에 박음. 일관된 형태로 [Owner]가 *어디까지 됐는지 5초 안에 파악* 가능.

### 4.1 표준 양식

```
[상태 보고]
- run ID: <run_id>
- 카테고리: <1~5>
- Tier: <A/B/C>
- 권한 천장: 미위반 / 위반 발견 — [상세]
- 막힌 점: 없음 / [한 줄]

[진행 트리]
✓ SUB-1 기획·의도 (완료, YYYY-MM-DD HH:MM)
▶ SUB-2 워크플로우 (진행 중)
   ✓ using-superpowers
   ✓ brainstorming
   ▶ writing-plans (현재)
   ○ using-git-worktrees
   ○ TDD
   ○ subagent-driven-development
   ○ requesting-code-review
   ○ verification-before-completion
   ○ finishing-a-development-branch
○ SUB-3 외부감리 (Tier A이므로 예정)
○ SUB-4 수정 (필요 시)
○ SUB-5 종료

[다음 행동]
[한 줄]
```

### 4.2 진행 트리 표기 규칙

- `✓` — 완료
- `▶` — 현재 진행 중
- `○` — 예정
- `–` — 카테고리상 해당 없음 (예: 카테고리 3에서 `– using-git-worktrees`)

### 4.3 보고 시점

- task 진입 시
- 단계 전환 시 (SUB-N → SUB-N+1)
- [Owner] 질문 "어디까지 했어?" 응답 시
- 막힌 점 발생 시 (선제 보고)
- final-report 작성 시점 (SUB-5 §6.2 양식과 정합)

---

## 5. Tier 분류 — Blast Radius

> **Tier = 이 작업이 *최악의 경우* 영향을 미칠 수 있는 범위**

| Tier | 기준 | Gate |
|---|---|---|
| **A** | 운영 데이터·고객·외부 시스템·법적·재무·권한·보안 영향 | [Reviewer]+[Judge] 필수, gate-review.md 필수 |
| **B** | 내부 시스템·미래 운영 영향, 되돌리기 비용 큼 | [Judge] 필수, [Reviewer] 권고, gate-review.md 필수 |
| **C** | 가역적·국소적 | Gate 생략 가능 (task-card §4에 사유 명시) |

**silkroadhub 도메인 키워드** (CLAUDE.md §5 일치):
- Tier A: 운송장, 개인통관고유부호, 사업자번호, 결제, 인증, migration, API 추가·변경, 적하목록·BL·HBL·MBL·CLP 신고, 대외 시스템 연동
- Tier B: 통관·세관·HS code 단순 조회·표시, 외부 라이브러리·SDK·프레임워크 설치·설정, API 변경 없는 비즈니스 로직 수정
- Tier C: 문구, CSS, 정적 UI, 오타 (보안·결제·인증·API·DB·고객 데이터·권한 영향 *전부* 없음)

**경계가 모호하면 한 단계 위로.** Tier 강등은 [Owner] 명시 승인 필수.

---

## 6. 권한 천장 — [Owner] 명시 승인 없이 절대 진행 불가

| # | 행동 | 비고 |
|---|---|---|
| 1 | git push / merge / deploy | 로컬 commit은 task-card 범위 내 OK |
| 2 | 운영 문서 변경 반영 | AGENTS.md, CLAUDE.md, PROJECT.md, .harness/templates/* |
| 3 | 파괴적 git 명령 | reset --hard, rebase -i, force push, history rewrite, broad cleanup |
| 4 | task scope 확장 | task-card §5.2 제외 범위 침범 |
| 5 | 외부 시스템 프로덕션 실호출 | 결제·통관·DB migration 실행 |
| 6 | Tier 강등 | A→B, B→C 자동 다운그레이드 금지 |

**[Owner] 발화 패턴 (SUB-5 §7.1 컨버터)**:
- "push해줘" → §1 push 승인
- "머지해줘" → §1 merge 승인
- "로컬에서 테스트하게 준비해줘" → 로컬 테스트 준비 (이 자체는 권한 천장 위반 아님, 별도 절차)
- "깃허브에 등록해줘" → PR 생성 또는 release tag

새 발화 패턴 발견 시 마누스 프로젝트 지침 §[발화 컨버터]에 추가 검토.

---

## 7. 코덱스·지피티 호출 분기표 ★

> **스킬 호출 우선**: 마누스 Skills 설치된 환경에서는 `/06-invoke-reviewer`·`/07-invoke-judge`·`/04-invoke-plan-review` 우선 사용. 본 절은 *스킬 미설치 환경*의 수동 절차 + *스킬 내부 구현 진실 원천*.

### 7.1 분기 결정 (역할 ↔ 도구 명확화)

| Tier | 작업 성격 | [Reviewer] (코덱스 우선) | [Judge] (지피티) |
|---|---|---|---|
| A | 코드 변경 | 필수 — 코덱스 | 필수 — 지피티 |
| A | 코드 변경 없음 (운영·문서) | 권고 — 코덱스 | 필수 — 지피티 |
| B | 코드 변경 | 권고 — 코덱스 (또는 task-card 명시 기준) | 필수 — 지피티 |
| B | 코드 변경 없음 | 생략 가능 | 필수 — 지피티 |
| C | 모든 케이스 | 생략 가능 | 생략 가능 (task-card §4 사유 명시) |
| 모든 Tier | plan 검토 권고 (SUB-2 §2.5 plan-review) | — | 권고 — 지피티 (writing-plans 결과 검토) |

**원칙**:
- 코덱스 = [Reviewer] *코드 영역만*. 기획·사업 판단 안 함.
- 지피티 = [Judge] *기획·사업·논리 영역만*. 코드 디테일 안 봄.
- 두 도구가 *물리적으로 다름* → 정보 격리 자동 강제됨.

### 7.2 호출 스크립트 (베타)

| 도구·역할 | 스크립트 | 비고 |
|---|---|---|
| 코덱스 ([Reviewer]) | `scripts/invoke_codex.sh <run_id> <prompt_file>` | 베타 (마누스 작성 예정) |
| 지피티 ([Judge]) | `scripts/invoke_chatgpt_judge.sh <run_id> <prompt_file>` | 베타 (마누스 작성 예정) |
| 지피티 ([Reviewer] 폴백) | `scripts/invoke_chatgpt_reviewer_fallback.sh <run_id> <prompt_file>` | 베타 (코덱스 불가 시) |
| 지피티 (plan-review) | `scripts/invoke_chatgpt_plan_review.sh <run_id> <prompt_file>` | 베타 (SUB-2 §2.5) |
| 클로드코드 새 세션 | `scripts/open_claude_code.sh` | 베타 (Appendix B 절차) |
| OpenAI 키 로드 | `scripts/load_openai_key.sh` | 기존 |

scripts/ 미작성 동안은 본 문서 Appendix A·B 절차 수동 적용 (2026-05-16 검증 완료). scripts/ 완성 시 본 표가 진실 원천. 향후 *마누스 스킬 9개*로 추가 통합 예정 — 그때 본 절도 슬림화.

### 7.3 모델·세팅 표준

| 도구 | 모델 | 세팅 |
|---|---|---|
| 지피티 ([Judge] / [Reviewer] 폴백 / plan-review) | `gpt-5.5` | temperature 파라미터 *생략* (gpt-5.5는 temperature=0 미지원) |
| 코덱스 ([Reviewer]) | 환경에 설치된 버전 | `--sandbox read-only --output-last-message` |

모델·세팅 변경 시 [Foreman]은 [Owner]께 사전 보고.

### 7.4 도구 불가 시 — 일반 원칙

자동 Tier 다운그레이드 금지. [Owner] 명시 risk 인수 시에만 제한 진행. 상세 SUB-3 §7.

### 7.5 [Reviewer] 폴백 절차 — 코덱스 불가 시 지피티가 [Reviewer] 수행 ★

코덱스 호출이 *기술적으로 불가*한 경우 (CLI 오류·환경·rate limit 등), 지피티가 [Reviewer]를 대신 수행한다. 단 정보 격리는 [Foreman]이 *수동으로 강제*해야 함 — 도구의 물리적 분리가 사라지므로.

**폴백 진입 조건**:
1. 코덱스 호출 N회 시도 후 실패 (N은 [Foreman] 판단, 통상 2~3회)
2. 실패 사유가 *코드 자체 문제*가 아니라 *도구·환경 문제*임이 명확
3. [Foreman]이 [Owner]께 폴백 진입 사실 보고 + 명시 승인 받음

**폴백 절차**:
1. **세션 분리 명확화** — [Judge] 세션과 *반드시 다른 ChatGPT 세션* 열기. 세션 이름을 "Reviewer_Fallback"으로 라벨링
2. **입력 자료 분리** — [Reviewer] 입력 자료는 *별도 파일*로 저장 (`.harness/runs/<run_id>/reviewer-input.md`). [Judge] 입력 자료(`judge-input.md`)와 *혼합 금지*
3. **호출 순서** — [Reviewer] 폴백 세션 호출 → 응답 받고 *세션 닫음* → 그 후 [Judge] 세션 별도 호출. 두 세션 *동시 사용 금지* (혼동 위험)
4. **gate-review.md에 폴백 사실 명시** — §1.1 호출 정보에 "지피티 폴백 ([Reviewer] 역할)" 기록 + 폴백 사유

**폴백 시 제약**:
- 코덱스 복구되면 *즉시 원래 분리로 복귀* (다음 task부터)
- 폴백 진행 사실은 SUB-5 §12 회고에 누적 (코덱스 안정성 추적)
- 폴백이 *반복 발생*하면 [Owner]께 코덱스 환경 점검 권고

**금지**:
- *코덱스가 [Judge] 역할 수행 금지*. 코덱스는 코드 도구라 기획·사업 검토 부적합. [Judge]는 *지피티 단독*
- 한 ChatGPT 세션이 *[Reviewer]·[Judge] 둘 다 수행 금지*. 정보 격리 위반
- [Reviewer] 폴백 진입 시 *코덱스 자동 재시도 후 진입*. *처음부터 폴백 사용 금지*

---

## 8. 마스킹 규칙 ★

> 본 절은 [Foreman] 보고·작성 시 적용. [Builder]에게는 CLAUDE.md §6이 자동 로드되어 동일 규칙 적용.

| 데이터 | 마스킹 |
|---|---|
| 전화번호 | `***-****-****` |
| 이름, 수취인명, 담당자명 | `***MASKED-NAME***` |
| 운송장 (10~14자리) | `***MASKED-TRACKING***` |
| 개인통관고유부호 (P 시작) | `***MASKED-CUSTOMS-ID***` |
| BL, HBL, MBL, CLP 번호 | `***MASKED-BL***` |
| manifest_no, declaration_no | `***MASKED-MANIFEST***` |
| PG 거래번호 (toss_, imp_) | `***MASKED-PG***` |
| Context7 출력 중 비밀값 | `***MASKED-DOC-SECRET***` |
| Code Simplifier 출력 중 비밀값 | `***MASKED-CODE-SECRET***` |
| OpenAI / 외부 API 키 | 출력 자체 금지 (첫 7자만 디버그 시 노출 가능) |
| 주민등록번호, 카드 번호 | 출력 자체 금지 |

**원칙**: 모든 task-card·handoff·gate-review·final-report·로그·commit 메시지·외부 도구 입출력에 적용. 위반 시 SUB-4 §1.3 카테고리 D 처리.

**마누스 플랫폼 자동 redact** (1차 출처 확인 2026-05-16): 마누스는 공유 세션·외부 도구 호출에서 API 키 등 일부 민감 정보를 자동 마스킹한다. 단 *silkroadhub 도메인 마스킹*(운송장·BL·개인통관고유부호 등)은 자동 처리되지 *않으므로* [Foreman]·[Builder]가 위 표대로 수동 적용 의무. 자동 redact를 *과신하지 않는다* — 도메인 마스킹은 *항상* 수동 점검.

---

## 9. run 파일 원칙

| 파일 | 필수 | 작성자 | 저장 |
|---|---|---|---|
| task-card.md | 모든 run | [Foreman] (SUB-1) | `.harness/runs/<run_id>/` |
| handoff.md | 모든 run | [Builder] (SUB-2 종료) | 동상 |
| gate-review.md | Tier A/B | [Foreman] (SUB-3) | 동상 |
| final-report.md | 모든 run | [Foreman] (SUB-5) | 동상 |

`run_id` 형식: `[YYYYMMDD]_[task-slug]`. task-slug는 영문 소문자·하이픈.

양식은 `.harness/templates/*-template.md` 참조.

---

## 10. PROJECT.md 라우팅

### 10.1 진입 시점

새 task 시작 시 [Foreman]이 *반드시* PROJECT.md 진입 점검:
- §B 현재 분기 목표
- §C 모듈 지도 → 이번 task 연결 모듈 식별
- §D 최근 결정 이력

### 10.2 갱신 메커니즘

PROJECT.md는 **task-card를 통해서만** 갱신됨. [Foreman] 단독 임의 수정 금지.

| 절 | 갱신 경로 |
|---|---|
| §A 기획 맥락 | 카테고리 5 task의 task-card → PROJECT.md §A |
| §B 중기 목표 | 분기 종료 또는 카테고리 5 task |
| §C 모듈 진행 | **모든 task의 SUB-5 종료 시** task-card §10 → PROJECT.md §C |
| §D 결정 이력 | task 진행 중 큰 결정 발생 시 task-card §10.2 → PROJECT.md §D |

상세 PROJECT.md §E.

---

## 11. 지침 변경 절차

운영 지침 변경은 코드 변경보다 영향 큼.

1. 변경 필요성 정리
2. `.harness/proposals/`에 초안 작성
3. 필요 시 [Judge] (ChatGPT Devil's Advocate) 검토
4. [Owner] 명시 승인
5. 승인 범위만 실제 파일 반영
6. diff 검증 후 commit·push는 별도 승인

---

## 12. r6 베타 운영

본 매뉴얼·SUB·양식은 **베타**다. 운영 중 어색함은 final-report §12 회고에 기록 → 다음 r 개정 task로 모음.

다음 r 개정 시점 (잠정):
- task 10~20건 누적 후 회고 종합
- 또는 [Owner] 발화로 *큰 어색함* 발견 시 즉시

---

# Appendix A — Codex Gatekeeper 호출 표준 절차

> 검증 완료 2026-05-16. scripts/invoke_codex.sh 작성 전 마누스가 수동 적용하는 표준 절차.
> Codex는 [Builder]의 자체 리뷰 대체물이 아니라 외부 감리자. 마누스가 handoff.md, diff, 실행 증거를 확보한 뒤 호출.

### Step 1 — 새 터미널 창 열기

```applescript
osascript << 'APPLESCRIPT'
tell application "Terminal"
  do script "cd /Users/twostars/ClaudeAi/silkroadhub"
end tell
APPLESCRIPT
```

`activate`는 포커스 탈취·중복 창 문제를 유발할 수 있으므로 표준 절차에서 사용하지 않는다.

### Step 2 — 터미널 창 ID 조회

```bash
osascript -e 'tell application "Terminal" to get {id, name} of every window' 2>&1
```

### Step 3 — 실행 스크립트 작성

```bash
cat > /Users/twostars/ClaudeAi/silkroadhub/tmp/run_codex.sh << 'SCRIPT'
#!/bin/zsh
export PATH="/Users/twostars/.local/node/bin:$PATH"
source ~/.zshrc 2>/dev/null || true
cd /Users/twostars/ClaudeAi/silkroadhub

OUTPUT_FILE=".harness/runs/PHASE_RUN_ID/reviewer-raw.md"
LOG_FILE=".harness/runs/PHASE_RUN_ID/codex-exec.log"

echo "=== Codex Review Start: $(date) ===" | tee "$LOG_FILE"

codex exec \
  --sandbox read-only \
  --output-last-message \
  - << 'PROMPT' > "$OUTPUT_FILE" 2>> "$LOG_FILE"
여기에 프롬프트 내용 작성
PROMPT

EXIT_CODE=$?
echo "=== Codex Review End: $(date), exit=$EXIT_CODE ===" | tee -a "$LOG_FILE"
head -5 "$OUTPUT_FILE"
SCRIPT
chmod +x /Users/twostars/ClaudeAi/silkroadhub/tmp/run_codex.sh
```

**핵심**: `codex exec - << 'PROMPT' ... PROMPT` 형식의 heredoc stdin 방식만 안정.

⚠️ **PATH 주의**: `source ~/.zshrc`만으로는 Codex PATH 로드 안 될 수 있음. 반드시 스크립트 첫 줄에 `export PATH="/Users/twostars/.local/node/bin:$PATH"` 명시.

### Step 4 — 스크립트 실행

```applescript
osascript << 'APPLESCRIPT'
tell application "Terminal"
  do script "zsh /Users/twostars/ClaudeAi/silkroadhub/tmp/run_codex.sh" in window id WINDOW_ID
end tell
APPLESCRIPT
```

Codex 호출은 일반 zsh 스크립트 실행이므로 *단일 do script*로 실행 확정됨. Appendix B의 Claude Code REPL과 달리 *2단계 확정 실행 불필요*.

### Step 5 — 결과 확인

```bash
sleep 60
cat /Users/twostars/ClaudeAi/silkroadhub/.harness/runs/PHASE_RUN_ID/reviewer-raw.md
cat /Users/twostars/ClaudeAi/silkroadhub/.harness/runs/PHASE_RUN_ID/codex-exec.log
```

첫 줄이 `Status:`로 시작하거나 해당 run에서 승인한 구조화 판정 형식이어야 유효한 리뷰. 결과는 gate-review.md §1로 정리.

---

# Appendix B — Claude Code 터미널 표준 절차

> 검증 완료 2026-05-16. 권고 방식: **파일 경유 + 짧은 명령 + 2단계 확정 실행**.
> 검증 보고서: `.harness/runs/test_claude_dispatch/dispatch-comparison-report.md`.

### Step 1 — 새 Claude Code 세션 열기

```applescript
osascript << 'APPLESCRIPT'
tell application "Terminal"
  do script "cd /Users/twostars/ClaudeAi/silkroadhub && claude"
end tell
APPLESCRIPT
```

`activate`는 표준 절차에서 사용하지 않는다.

### Step 2 — 터미널 창 ID 조회

```bash
sleep 5
osascript -e 'tell application "Terminal" to get {id, name} of every window' 2>&1
```

Claude Code REPL이 진입 완료된 창의 ID를 `WINDOW_ID`로 둔다.

### Step 3 — 진입 명령을 파일로 저장 ★

긴 진입 명령·한글·특수문자를 *AppleScript 문자열로 직접 전달하지 않는다*. 원문은 파일로 저장:

```bash
cat > /Users/twostars/ClaudeAi/silkroadhub/tmp/claude-entry-instruction.md << 'EOF'
여기에 task-card 경로, 권한 천장, 산출물, 검증 기준, handoff 작성 위치 포함한 진입 명령 작성
EOF

head -20 /Users/twostars/ClaudeAi/silkroadhub/tmp/claude-entry-instruction.md
wc -l /Users/twostars/ClaudeAi/silkroadhub/tmp/claude-entry-instruction.md
```

### Step 4 — 파일 경로를 짧은 명령으로 전달 + 2단계 확정 실행 ★

```applescript
osascript << 'APPLESCRIPT'
tell application "Terminal"
  do script "Read tmp/claude-entry-instruction.md and follow the instructions inside." in window id WINDOW_ID
  do script "" in window id WINDOW_ID
end tell
APPLESCRIPT
```

**핵심**: Claude Code REPL에는 *단일 do script*만 보내면 입력 대기 상태에 머물 수 있음. `do script ""` 추가로 Enter 확정.

### Step 5 — 응답·산출물 확인

```bash
ls -la /Users/twostars/ClaudeAi/silkroadhub/.harness/runs/RUN_ID/handoff.md 2>&1
cat /Users/twostars/ClaudeAi/silkroadhub/.harness/runs/RUN_ID/handoff.md 2>&1
```

### 금지·주의 ★

- `activate`를 표준 절차에 사용하지 않는다 (포커스 탈취·중복 창 문제)
- 한글·특수문자·긴 지시문을 Claude Code에 직접 전달하지 않는다. 원문은 파일 저장, 짧은 파일 경유 명령만 전달
- Claude Code REPL에는 단일 `do script "명령"`만 보내지 않는다. `do script ""` 추가로 실행 확정
- **[Builder]가 task 완료 후 commit·추가 확인·cleanup 등 task-card 범위 밖 행동을 *자동 제안*해도 [Foreman]은 명령으로 해석하지 않는다.** [Owner] 승인 또는 task-card 기준 없으면 실행 금지

---

# Appendix C — 터미널·리뷰 주의사항

- Claude Code 창과 Codex 창 혼동 금지. 반드시 창 ID·이름으로 특정
- Codex `keystroke` 방식 프롬프트 직접 입력 금지 (특수문자 깨짐). 반드시 heredoc stdin
- `do script` 명령 전달 시 새 탭 열릴 수 있음. `in window id WINDOW_ID` 반드시 지정
- Codex 리뷰 결과 첫 줄 또는 구조가 *유효한 판정 형식* 아니면 무효 리뷰
- Appendix A (Codex zsh 호출)는 단일 do script로 실행 확정. Appendix B (Claude Code REPL)는 2단계 확정 실행 필수 — *둘의 차이 혼동 금지*
- [Builder] 친절 제안은 명령이 아님. push·merge·commit·cleanup 등은 [Owner] 명시 승인 없이 절대 금지

---

**AGENTS.md (두별 워크플로우 v3.6.0 r1 베타) 끝.**

본 문서 변경 제안은 SUB-5 §12 회고에 기록 → 다음 r 개정 task.

---

## r7 Addendum — 회고 반영 운영 보강 (2026-05-17 KST)

본 addendum은 r6 본문을 삭제·덮어쓰기하지 않고, 회고 17·18·27·29·30·33·36 및 관련 운영 결정을 r7 정비 범위에서 보강한다. 기존 본문과 충돌할 경우 본 addendum은 다음 r7 정비 task의 변경 근거로 해석하며, 실제 실행에서는 [Owner] 최신 발화와 task-card 권한 천장을 우선한다.

| 회고 | 반영 위치 | r7 보강 내용 |
|---:|---|---|
| 17 | §7, §12 | 외부 도구 호출은 Claude Code에 한정하지 않고 Local CLI 도구 전반에 대해 새 세션·파일 경유·짧은 명령·2단계 확정 실행을 표준으로 본다. |
| 18 | §10 | Phase C 관련 명칭은 공식 Phase C task-card와 dispatch 검증 run을 구분하여 표기한다. |
| 27 | §6, SUB-5 | commit·push 후 final-report 사후 갱신이 필요한 경우라도 [Owner] 승인 없는 추가 commit·push는 금지한다. 사후 갱신 필요성은 final-report 또는 후속 task-card에 먼저 기록한다. |
| 29·30 | §7.5 | Codex Reviewer 불가 시 GPT Reviewer 폴백은 자동 진행하지 않는다. [Owner]에게 폴백과 본 채널 대체 옵션을 함께 보고하고, 승인된 선택지만 수행한다. |
| 33 | §7.5 | 본 채널 SUB-3 대체는 도구·API 문제 등 예외 상황에서 [Owner] 명시 승인 후만 사용하며, gate-review 또는 alternative 기록에 사유를 남긴다. |
| 36 | §12 | Foreman 직접 정정은 문서·보고·검증 기록 등 코드 본문이 아닌 범위에 한정한다. 코드 예시·스크립트 수정 또는 큰 구조 변경 필요 시 즉시 중단하고 Builder 호출 여부를 [Owner]에게 확인한다. |

**권한 천장 보강**: commit·push·merge·deploy·history rewrite·force push·reset hard는 [Owner] 명시 승인 없이는 수행하지 않는다. Builder·Reviewer·Judge·외부 도구의 제안은 명령이 아니며, task-card 또는 [Owner] 승인 없는 추가 실행은 scope 확장으로 본다.

**키 및 민감정보 보강**: OpenAI 등 외부 키는 시스템 환경변수 사용 여부를 `SET/NOT SET` 수준으로만 확인한다. 키 값, 키 prefix, client-local 키 로드 파일 내용은 출력하지 않는다. silkroadhub 사업 자산과 client-local 키 파일은 마스터 운영 task에서 보존 대상으로 취급한다.

**addendum 끝.**
