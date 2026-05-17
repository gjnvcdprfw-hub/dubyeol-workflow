# task-card: Task 3 — 9개 스킬 결함 기반 정정

**run ID**: 20260519_skills-9-fix  
**작성일시**: 2026-05-17 KST  
**작성자**: [Foreman]  
**상태**: SUB-1 정렬 확인 완료, handoff 전 [Owner] 최종 확인 대기  
**두별 워크트리 카테고리**: 4 (문서·운영)  
**Tier**: A

---

## 1. [Owner] 발화 원문

> [다음 task 진입 — Task 3 9개 스킬 결함 수정]
>
> Task 2 sync 스크립트 구현 종결 확인 (commit 7dfa777). Task 3 진입.
>
> run_id: 20260519_skills-9-fix  
> Tier: A  
> 카테고리: 4 (문서·운영, 다만 코드 본문 수정 포함하므로 변형 트리 적용)  
> 작업 대상: dubyeol-workflow 마스터  
> 작업 위치: /Users/twostars/ClaudeAi/dubyeol-workflow/  
> 대응 task: r7 정비 (별도 task로 동시 진입)  
> silkroadhub 손대지 않음 (사업 자산 보존)
>
> 입력 자료:
> - skills-fix-guidelines.md (정책 task §6에 박힌 결함별 가이드라인, commit 8c2394f)
> - G-2 evidence (commit 72f8ab2, 9개 스킬 PARTIAL PASS 결과)
> - sync-design.md (Task 2 commit 7dfa777, REPO_ROOT 정책 적용 기준)
> - AGENTS.md §6 권한 천장, §12 베타 운영 절차
>
> [Owner] 결정 사항 (영구화됨)
>
> 1. 결함 기반 정정 원칙: 잘 돌아가는 영역은 손대지 않음
> 2. 본 task는 skills-fix-guidelines.md 위에서 결함 위치만 정정
> 3. [Builder] = 클로드코드 외부 세션 (회고 17 베타 운영)
> 4. Foreman = 마누스 (조정·검증·보고)
> 5. r7 정비 task와 동시 진행 가능 (직접 수정 대상 분리)
> 6. silkroadhub 사업 자산 손대지 않음
>
> 본 task 작업 — 9개 스킬 결함만 정정
>
> 대상: r6-rollout-package/dubyeol-workflow-skills/ (9개 스킬 본문 + scripts)
>
> 수정 범위 — skills-fix-guidelines.md §11 표 기준:
>
> 공통 결함 (3건, 9개 모두 1회 정정):
> 1. silkroadhub REPO_ROOT 하드코딩 제거 (skills-fix-guidelines.md §4)
> 2. SKILL.md 호출 경로와 실제 script layout 정렬 (§2)
> 3. zsh/bash 런타임 통일 (§3)
>
> 개별 결함:
> - 04·06·07: input isolation 강화 (§6)
> - 04·06·07: Python heredoc 안전성 (§7)
> - 02·08: 템플릿 직접 사용 (§10)
> - 05: secret scan + push 확인 강화 (§9)
> - 09: PROJECT.md diff-first·approval-first 전환 (§8)
>
> 수정 안 함:
> - 9개 스킬 핵심 로직
> - 권한 천장 원칙
> - 정보 격리 설계
> - 기타 잘 돌아가는 영역
>
> 진행 트리
>
> SUB-1 의도 정렬 → SUB-2 9개 스킬 정정 (클로드코드 [Builder] 외부 세션) → SUB-3 외부 감리 (Tier A) → (필요 시 SUB-4) → SUB-5 종료
>
> SUB-3 외부 감리:
> - Reviewer (Codex 우선, GPT 폴백): 정정 결과 기술 정합성, sync 호환성, edge case
> - Judge (GPT): 정책 정렬, [Owner] 의도 (결함 기반 원칙) 준수, 잠재 위험
> - 회고 29·30 학습 적용 (Codex/GPT 폴백 절차)
> - 회고 32 학습 적용 (키 echo 최소화, SET/NOT SET 권고)
>
> API 키 정책 (Task 2와 동일):
> - 시스템 환경변수 $OPENAI_API_KEY 사용 ([Owner] ~/.zshrc 설정)
> - silkroadhub의 키 로드 파일 참조 금지 (회고 31)
> - 마스터 측 키 파일 생성 금지
> - 키 값 출력 금지 (회고 32)
>
> API 키 문제 발생 시:
> - 본 채널 SUB-3 대체 옵션 (회고 33 패턴)
> - [Owner] 결정 필요
>
> [Builder] 클로드코드 세션 활용
>
> 본 task는 코드 본문 수정 포함하므로 [Builder] = 클로드코드 외부 세션 사용:
> - 새 Terminal 창 (osascript)
> - 새 클로드코드 세션
> - 9개 스킬 본문 + scripts 수정
> - 마누스 [Foreman]은 handoff 수발신·검증·보고 담당
>
> 회고 17 베타 운영 절차 준용. 회고 36 (Foreman 직접 정정 범위) 위반 금지 — 코드 본문 수정은 [Builder] 영역.
>
> 산출물
>
> 위치: /Users/twostars/ClaudeAi/dubyeol-workflow/.harness/runs/20260519_skills-9-fix/
>
> 핵심 산출물:
> - task-card.md (SUB-1)
> - handoff.md (Builder)
> - handoff-verification.md (Foreman)
> - evidence-fix-summary.md (9개 스킬별 변경 사항)
> - reviewer-input.md / reviewer-raw.md
> - judge-input.md / judge-raw.md
> - gate-review.md (또는 본 채널 SUB-3 대체 시 alternative 기록)
> - final-report.md
>
> 직접 수정 대상 (마스터 본문):
> - r6-rollout-package/dubyeol-workflow-skills/01-load-sub-manual/
> - r6-rollout-package/dubyeol-workflow-skills/02-create-task-card/
> - ... (9개 스킬 모두)
> - 각 스킬의 SKILL.md + scripts/*.sh
>
> 마누스 환경 재등록:
> - 본 task 종결 후 [Owner] 결정에 따라 마누스가 정정된 자료를 skill-creator로 재리팩토링·재등록 (선택)
>
> 주의
>
> - 결함 기반 정정 원칙 위반 금지: 가이드라인 §11 표 외 영역 손대지 않음
> - silkroadhub 사업 자산 손대지 않음
> - 권한 천장 준수: push, merge, history rewrite, force push, reset --hard 금지
> - 운영 문서 (AGENTS.md, SUB-1~5, PROJECT.md) 임의 수정 금지 (r7 정비에서 처리)
> - commit·push 사전 승인 없음 (SUB-5 후 별도 결재)
> - 외부 도구 호출 시 새 Terminal + 새 세션 (회고 17)
> - 한글 commit 메시지 영문 키워드 우선 (회고 22)
> - 보고서 첨부 정합성 (회고 23)
> - 한글 commit 후 final-report 사후 갱신 절차 (회고 27)
> - 본 task가 회고 13급 결정 (Phase H)의 진짜 완성을 향한 핵심 작업
> - 본 task와 r7 정비 task가 동시 진행 가능. 직접 수정 대상 분리 (Task 3 = 스킬 본문, r7 = 매뉴얼)
>
> SUB-1 의도 정렬 보고 받은 뒤 [Owner] 결재
>
> 본 발화로 task 진입 결재. SUB-1 보고 후 SUB-2 진입 결재 별도.
>
> 진행해.

### 1.1 SUB-1 정렬 확인 및 추가 조건 발화

> 정렬 확인, task-card 작성 진행.
>
> 단, 다음 정렬 사항을 반영해 두 task-card를 작성한다:
>
> [공통]
> - 두 task-card는 동시 진입하되 직접 수정 대상이 분리되어 충돌 없음. Task 3 = 9개 스킬 본문·scripts, r7 = AGENTS.md, SUB-1~5, PROJECT.md
> - 두 task 모두 Tier A · 카테고리 4 확정.
> - 결함 기반 정정 원칙: 잘 돌아가는 영역은 손대지 않는다.
> - silkroadhub 사업 자산은 두 task 모두에서 보존 대상.
> - commit·push·merge·history rewrite는 권한 천장. [Owner] 승인 없이 수행 불가.
>
> [Task 3 — 20260519_skills-9-fix]
> - 직접 수정 범위는 r6-rollout-package/dubyeol-workflow-skills/ 하위 9개 스킬의 SKILL.md와 scripts/*.sh로 한정.
> - 정정 근거는 skills-fix-guidelines.md §11 표 기준. §11 밖 핵심 로직은 건드리지 않는다.
> - [Builder] = 클로드코드 외부 세션. [Foreman] = task-card·handoff 검증·보고.
> - [Reviewer] = Codex 우선, GPT 폴백 (회고 29·30). API 키 또는 도구 문제 발생 시 [Owner]에게 별도 승인 요청 후 대체 절차 전환.
> - [Judge] = GPT.
>
> [보고]
> - 회고 누적 36건. 본 세션 산출 회고는 r37부터.
> - 보고 형식은 기존 [Foreman] 보고 템플릿 유지.
> - dashboard.md에 두 task 진행 상태 병기.
>
> 두 task-card 작성 후 handoff 전 [Owner] 최종 확인 한 번 받는다.

---

## 2. 상위 맥락 연결 (PROJECT.md 진입 시점)

- **연결 모듈**: §C.1 두별 워크플로우 운영 인프라
- **진입 시점 마일스톤**: Task 2 sync 스크립트 구현 완료 후 후속 Task 3(9개 스킬 결함 정정)과 r7 정비가 동시 진입한다.
- **이번 task로 전진시키는 것**: G-2에서 PARTIAL PASS로 확인된 9개 스킬 결함을 `skills-fix-guidelines.md §11` 기준으로만 정정하여, 마스터 스킬 패키지의 실제 운영 가능성을 높인다.
- **PROJECT.md 진입 시점 스냅샷**:
  - 모듈 상태: Task 2 sync 스크립트 구현이 완료되었고 후속은 Task 3과 r7 정비 동시 진입으로 명시되어 있다.
  - 현재 막힌 점: 9개 스킬의 PARTIAL PASS 결함이 남아 있으며, r7 매뉴얼 정비와 직접 수정 대상 분리를 유지해야 한다.

---

## 3. 의도 정렬 증거 블록 (SUB-1 §2 SOP 결과 — 불변)

> 본 블록은 task 진행 중 **수정 금지**. 의도 변경 발생 시 §9에 *추가* 블록으로 기록.

### 3.1 한 문장 목표 (What)

`r6-rollout-package/dubyeol-workflow-skills/` 하위 9개 스킬의 `SKILL.md`와 `scripts/*.sh`에서 `skills-fix-guidelines.md §11`에 명시된 결함 위치만 정정하고, 잘 돌아가는 핵심 로직과 silkroadhub 사업 자산은 건드리지 않는다.

### 3.2 성공 시 보이는 모습 (Looks Like)

- 9개 스킬 전체에서 `silkroadhub` REPO_ROOT 하드코딩 제거, SKILL.md 호출 경로와 실제 script layout 정렬, zsh/bash 런타임 통일이 각 1회 기준으로 정정된다.
- 04·06·07 스킬은 input isolation과 Python heredoc 안전성이 강화되며, Reviewer/Judge/plan-review 입력 격리 원칙이 훼손되지 않는다.
- 02·08 스킬은 템플릿 직접 사용 기준으로 정렬되고, 05 스킬은 secret scan 및 push 확인이 강화되며, 09 스킬은 PROJECT.md diff-first·approval-first 흐름으로 전환된다.
- `.harness/runs/20260519_skills-9-fix/` 아래에 `task-card.md`, `handoff.md`, `handoff-verification.md`, `evidence-fix-summary.md`, `reviewer-input.md`, `reviewer-raw.md`, `judge-input.md`, `judge-raw.md`, `gate-review.md`, `final-report.md`가 생성된다.
- r7 정비와 동시에 진행되더라도 직접 수정 대상이 분리되어 Task 3은 스킬 본문·scripts만, r7은 AGENTS.md·SUB-1~5·PROJECT.md만 다룬다.

### 3.3 실패 시 보이는 모습 (Looks Wrong)

- `skills-fix-guidelines.md §11` 밖의 9개 스킬 핵심 로직, 권한 천장 원칙, 정보 격리 설계 또는 기타 정상 영역이 수정된다.
- `AGENTS.md`, `SUB-1~5`, `PROJECT.md` 등 r7 직접 수정 대상이 Task 3에서 수정된다.
- `silkroadhub` 사업 자산을 읽기·수정·복사하거나, silkroadhub의 키 로드 파일을 참조한다.
- Codex Reviewer와 GPT Judge 입력이 혼합되거나, GPT Reviewer 폴백을 [Owner] 별도 승인 없이 진행한다.
- commit·push·merge·history rewrite·force push·reset hard 등 권한 천장 위반이 발생한다.

### 3.4 모호어 해소 기록

- “결함 기반 정정” → “`skills-fix-guidelines.md §11` 표에 명시된 결함 위치만 정정하고, 표 밖 핵심 로직과 정상 영역은 수정하지 않는다.”
- “Task 3와 r7 정비 동시 진행” → “Task 3은 9개 스킬 본문·scripts만, r7은 AGENTS.md·SUB-1~5·PROJECT.md만 수정하여 직접 수정 대상 충돌을 방지한다.”
- “silkroadhub 손대지 않음” → “silkroadhub 사업 자산, 키 로드 파일, 실제 client 적용, 사업 기능 코드를 Task 3 범위에서 제외한다.”
- “API 키 또는 도구 문제 발생 시” → “자동 폴백 또는 Tier 강등 없이 [Owner]에게 별도 승인 요청 후 대체 절차로 전환한다.”

### 3.5 마누스가 가정한 것 3가지

**가정 1**: 직접 수정 범위는 `r6-rollout-package/dubyeol-workflow-skills/` 하위 9개 스킬의 `SKILL.md`와 `scripts/*.sh`에 한정한다.  
→ 근거: [Owner]가 Task 3 직접 수정 범위를 해당 경로와 파일 유형으로 명시했다.  
→ 검증: handoff 검증 시 `git status --short`와 파일 목록을 확인하여 r7 대상 문서 또는 silkroadhub 자산 변경이 없는지 점검한다.

**가정 2**: 본 task는 코드 본문 수정 성격이 있으므로 [Builder]는 클로드코드 외부 세션을 사용하고, [Foreman]은 task-card 작성, handoff 수발신, handoff 검증, 감리 호출, 보고만 담당한다.  
→ 근거: [Owner]가 `[Builder] = 클로드코드 외부 세션`, `[Foreman] = task-card·handoff 검증·보고`로 명시했다.  
→ 검증: SUB-2 진입 전 [Owner] 최종 확인을 받은 뒤 Builder handoff를 작성하고, Foreman이 독단 코드 수정을 수행하지 않았는지 확인한다.

**가정 3**: Tier A 및 카테고리 4는 확정이며, Codex Reviewer 우선·GPT Reviewer 폴백·GPT Judge 분리 원칙은 유지한다.  
→ 근거: [Owner]가 두 task 모두 Tier A·카테고리 4를 확정했고, Reviewer/Judge 도구 분기와 폴백 승인 조건을 명시했다.  
→ 검증: SUB-3에서 `reviewer-input.md`와 `judge-input.md`를 별도 작성하고, 도구 문제 발생 시 [Owner] 승인 전 대체 절차를 실행하지 않는다.

### 3.6 정렬 확인

- **정렬 일시**: 2026-05-17 KST
- **[Owner] 명시 응답**: “정렬 확인, task-card 작성 진행. 단, 다음 정렬 사항을 반영해 두 task-card를 작성한다: … 두 task-card 작성 후 handoff 전 [Owner] 최종 확인 한 번 받는다.”

---

## 4. Tier 판정

- **Tier**: A
- **판정 근거**: [Owner]가 Tier A를 확정했다. 본 task는 9개 Manus Agent Skills의 본문과 scripts를 정정하므로 향후 두별 워크플로우 운영, 외부 도구 호출, 정보 격리, 권한 천장 준수에 직접 영향을 준다.
- **Blast Radius**: 결함 정정이 잘못되면 이후 모든 SUB 단계 자동화와 외부 감리 호출에서 wrong-root, 입력 격리 실패, 권한 천장 위반, sync 호환성 결함이 반복될 수 있다.
- **Gate 의무**: Tier A이므로 SUB-3에서 [Reviewer]와 [Judge]를 분리 호출하고 `gate-review.md`를 작성한다. [Reviewer]는 Codex 우선이며, Codex 또는 API 키 문제 시 [Owner] 별도 승인 후 GPT Reviewer 폴백 또는 대체 절차로 전환한다.

---

## 5. 작업 범위 (Scope)

### 5.1 포함

- `r6-rollout-package/dubyeol-workflow-skills/01-load-sub-manual/`부터 `09-update-project-md/`까지 9개 스킬의 `SKILL.md`와 `scripts/*.sh` 결함 위치 정정.
- 공통 결함 3건 정정: REPO_ROOT 하드코딩 제거, SKILL.md 호출 경로와 script layout 정렬, zsh/bash 런타임 통일.
- 개별 결함 정정: 04·06·07 input isolation 및 Python heredoc 안전성, 02·08 템플릿 직접 사용, 05 secret scan 및 push 확인, 09 PROJECT.md diff-first·approval-first.
- `evidence-fix-summary.md`에 9개 스킬별 변경 사항과 `skills-fix-guidelines.md §11` 대응 근거 기록.
- SUB-2 Builder handoff, Foreman handoff 검증, SUB-3 외부 감리, 필요 시 SUB-4, SUB-5 final-report 작성.

### 5.2 명시적 제외 (out of scope)

- `skills-fix-guidelines.md §11` 밖의 핵심 로직 수정.
- `AGENTS.md`, `SUB-1~5`, `PROJECT.md` 수정. 이 범위는 r7 정비 task가 담당한다.
- `silkroadhub` 사업 자산 읽기·수정·복사·sync 실제 적용.
- 마스터 측 키 파일 생성, silkroadhub 키 로드 파일 참조, 키 값 출력.
- commit·push·merge·deploy·force push·history rewrite·reset hard.
- 정정 완료 후 마누스 환경 재등록. 이는 task 종결 후 [Owner] 결정에 따른 선택 후속이다.

### 5.3 산출물 (Deliverables)

| 산출물 | 경로 |
|---|---|
| task-card | `.harness/runs/20260519_skills-9-fix/task-card.md` |
| Builder handoff | `.harness/runs/20260519_skills-9-fix/handoff.md` |
| Foreman handoff 검증 | `.harness/runs/20260519_skills-9-fix/handoff-verification.md` |
| 9개 스킬별 변경 요약 | `.harness/runs/20260519_skills-9-fix/evidence-fix-summary.md` |
| Reviewer 입력·원문 | `.harness/runs/20260519_skills-9-fix/reviewer-input.md`, `.harness/runs/20260519_skills-9-fix/reviewer-raw.md` |
| Judge 입력·원문 | `.harness/runs/20260519_skills-9-fix/judge-input.md`, `.harness/runs/20260519_skills-9-fix/judge-raw.md` |
| Gate review | `.harness/runs/20260519_skills-9-fix/gate-review.md` |
| 최종 보고 | `.harness/runs/20260519_skills-9-fix/final-report.md` |
| 진행 병기 대시보드 | `dashboard.md` |

---

## 6. 진행 트리 (두별 워크트리)

본 task의 카테고리는 4 (문서·운영)이다. 다만 9개 스킬의 `SKILL.md`와 `scripts/*.sh` 수정이 포함되므로, SUB-2는 [Builder] 클로드코드 외부 세션에서 변형 트리로 진행한다.

### 6.1 변형 사유 (해당 시)

카테고리 4 표준 트리인 `using-superpowers → brainstorming → 작성 → 자체 review → finishing-a-development-branch`를 따르되, 코드 본문·scripts 수정이 포함되므로 [Builder]가 검증 증거를 남기고 [Foreman]이 handoff 검증을 수행한다. Tier A이므로 SUB-3 외부 감리는 필수이며, 필요 시 SUB-4 수정으로 돌아간다.

| 단계 | 상태 | 책임 |
|---|---|---|
| SUB-1 의도 정렬 | 완료 | [Owner]+[Foreman] |
| SUB-2 9개 스킬 정정 | handoff 전 최종 확인 후 진입 | [Builder], 지휘 [Foreman] |
| SUB-3 외부 감리 | 예정 | [Reviewer]+[Judge], 조정 [Foreman] |
| SUB-4 수정 | 필요 시 | [Foreman]+[Builder] |
| SUB-5 종료 | 예정 | [Foreman]+[Owner] |

---

## 7. 검증 명령

아래 명령은 [Builder] handoff 이후 [Foreman] 검증 및 evidence 작성 시 기준으로 사용한다. 실제 검증 명령은 [Builder]가 변경 내용에 맞게 보강할 수 있으나, 범위 위반 확인은 반드시 포함한다.

```bash
cd /Users/twostars/ClaudeAi/dubyeol-workflow
RUN=.harness/runs/20260519_skills-9-fix

# 산출물 존재 확인
test -f "$RUN/task-card.md"
test -f "$RUN/handoff.md"
test -f "$RUN/evidence-fix-summary.md"

# Task 3 직접 수정 대상 확인
git status --short -- r6-rollout-package/dubyeol-workflow-skills

# r7 직접 수정 대상이 Task 3에서 변경되지 않았는지 확인
git status --short -- AGENTS.md SUB-1-기획의도.md SUB-2-워크플로우.md SUB-3-외부감리.md SUB-4-수정.md SUB-5-종료.md PROJECT.md

# silkroadhub 사업 자산을 건드리지 않았는지 확인: 로컬 git 대상은 dubyeol-workflow 마스터 내부로 제한
pwd
git rev-parse --show-toplevel

# 하드코딩 잔재 점검 예시
grep -R "silkroadhub" r6-rollout-package/dubyeol-workflow-skills || true

# evidence에 9개 스킬이 모두 기록됐는지 확인
grep -E "01-load-sub-manual|02-create-task-card|03-dispatch-to-builder|04-invoke-plan-review|05-verify-handoff|06-invoke-reviewer|07-invoke-judge|08-write-final-report|09-update-project-md" "$RUN/evidence-fix-summary.md"
```

---

## 8. 권한 천장·금지 사항 (재확인)

[Owner] 명시 승인 없이 [Builder] 및 [Foreman] 실행 금지:

- [ ] push / merge / deploy
- [ ] commit
- [ ] 파괴적 git 명령 (reset --hard, force push, history rewrite)
- [ ] task scope 확장 (§5.2 제외 범위 침범)
- [ ] 외부 시스템 프로덕션 실호출
- [ ] Tier 강등

본 task 특유의 추가 금지 사항:

- [ ] `skills-fix-guidelines.md §11` 밖의 핵심 로직 또는 정상 영역 수정 금지
- [ ] `AGENTS.md`, `SUB-1~5`, `PROJECT.md` 수정 금지
- [ ] `silkroadhub` 사업 자산 접근·수정·복사 금지
- [ ] 마스터 측 키 파일 생성, silkroadhub 키 로드 파일 참조, 키 값 출력 금지
- [ ] Codex/GPT 도구 문제 발생 시 [Owner] 승인 없는 자동 폴백 금지
- [ ] r7 정비 task의 직접 수정 대상과 혼합 금지

---

## 9. 의도 변경 기록 (해당 시만 추가)

없음. 본 task-card는 [Owner]의 SUB-1 정렬 확인 및 추가 조건 발화를 반영하여 작성되었다. 이후 의도 변경은 본 절에 addendum 방식으로만 추가한다.

### 9.1 의도 변경 1차 — SUB-3 외부 감리 생략 및 SUB-5 직접 진입

- **변경 일시**: 2026-05-17 KST
- **변경 사유**: [Owner] 결정에 따라 외부 감리 대신 마누스 환경 등록 및 실사용 검증으로 대체한다. 9개 스킬은 이미 마누스 환경에 등록되어 실사용 가능 상태이며, 직전 결정에서 외부 감리는 실사용 후로 미루는 방향이 합의되었고, 본 결정으로 Task 3의 외부 감리는 사실상 폐기로 확정되었다.
- **변경 내용**: Task 3의 SUB-3 외부 감리를 생략하고 SUB-5로 직접 진입한다. `reviewer-input.md`, `judge-input.md`, 외부 도구 호출, gate-review 작성은 수행하지 않는다.
- **대체 검증**: `handoff-verification.md`, `skill-registration-verification.md`, 등록된 9개 스킬의 파일 일치성 검증을 Task 3 종료 판단의 근거로 사용한다.
- **새 정렬 확인**: “[Owner] 상황 정정. r7 SUB-2 일시 동결, Task 3 SUB-5 먼저 진행.”

---

## 10. PROJECT.md 갱신 사항 (task 종료 시 [Foreman] 작성, SUB-5)

> task 진행 중에는 비워둔다. SUB-5 종료 단계에서 [Foreman]이 작성 후, 본 내용을 PROJECT.md §C.1에 반영한다.

### 10.1 §C.1 모듈 갱신

- **현재 상태**: Task 3 진입 전 PARTIAL PASS 결함 잔존 → Task 3에서 9개 스킬 `SKILL.md`·`scripts/*.sh` 결함 정정 완료, 마누스 환경 등록 및 설치본 일치성 검증 PASS.
- **최근 마일스톤에 추가**: 2026-05-17: `20260519_skills-9-fix` 완료. 9개 스킬 결함 정정, handoff 검증, residue r7 이관, 9개 스킬 마누스 환경 등록 검증 완료.
- **다음 마일스톤에서 완료 처리(체크)**: Task 3 — 9개 스킬 수정 task 완료 처리.
- **다음 마일스톤에 추가**: 등록된 9개 스킬 실사용 검증 및 r7 SUB-2 재개.
- **현재 막힌 점**: Task 3 기준 없음. r7 SUB-2는 병행 운영 폐기 결정에 따라 일시 동결.

### 10.2 §D 결정 이력 추가 (큰 결정 발생 시)

- **날짜**: 2026-05-17
- **결정**: Task 3 SUB-3 외부 감리를 생략하고, 마누스 환경 등록 및 실사용 검증으로 대체한 뒤 SUB-5로 직접 진입한다.
- **사유**: 9개 스킬이 마누스 환경에 등록되어 실사용 가능 상태이며, [Owner]가 외부 감리보다 실사용 검증을 우선하기로 결정했다.
- **영향 모듈**: §C.1

- **날짜**: 2026-05-17
- **결정**: `references/README` residue 4건은 Task 3 scope를 확대하지 않고 r7 정비로 이관한다.
- **사유**: 해당 residue는 실행 코드가 아니라 참조 문서·README 안내 문서의 sync 정책 정렬 문제이며, Task 3의 직접 수정 범위는 9개 스킬 `SKILL.md`·`scripts/*.sh`로 유지해야 한다.
- **영향 모듈**: §C.1

- **날짜**: 2026-05-17
- **결정**: 매뉴얼 정의 없는 `dashboard.md`는 폐기하고, 병행 task 운영을 중단한다.
- **사유**: 비표준 산출물 도입이 매뉴얼 정합성을 깨는 것으로 [Owner]가 판단했다.
- **영향 모듈**: §C.1, §D

### 10.3 §A·§B 갱신 (카테고리 5 기획 task일 때만)

해당 없음.

### 10.4 PROJECT.md 반영 확인

- **반영 일시**: 2026-05-17 KST
- **PROJECT.md §E.마지막 갱신 task run ID에 박은 값**: `20260519_skills-9-fix`

---

## 11. 다음 단계 진행 가이드

- [ ] [Owner] task-card 최종 확인 및 handoff 전 결재
- [ ] 단계 2 (워크플로우) 진입 → SUB-2 호출
- [ ] [Builder] 클로드코드 외부 세션에 Task 3 handoff 전달

---

**task-card 끝.**
