# task-card: r7 정비 — 매뉴얼·운영 문서 회고 반영

**run ID**: 20260519_r7-maintenance  
**작성일시**: 2026-05-17 KST  
**작성자**: [Foreman]  
**상태**: SUB-1 정렬 확인 완료, handoff 전 [Owner] 최종 확인 대기  
**두별 워크트리 카테고리**: 4 (문서·운영)  
**Tier**: A

---

## 1. [Owner] 발화 원문

> [다음 task 진입 — r7 정비 (Task 3와 동시 진행)]
>
> 본 task는 Task 3 (20260519_skills-9-fix)와 동시 진행. 직접 수정 대상 분리되므로 충돌 영역 없음.
>
> run_id: 20260519_r7-maintenance  
> Tier: A (운영 인프라 매뉴얼 정정. 외부 감리 필요)  
> 카테고리: 4 (문서·운영)  
> 작업 대상: dubyeol-workflow 마스터  
> 작업 위치: /Users/twostars/ClaudeAi/dubyeol-workflow/  
> silkroadhub 손대지 않음 (사업 자산 보존)
>
> 입력 자료:
> - 회고 1~36 (PROJECT.md §C 또는 별도 회고 파일)
> - AGENTS.md (현재 r6, 499줄)
> - SUB-1, SUB-2, SUB-3, SUB-4, SUB-5 매뉴얼
> - PROJECT.md
> - 본 세션 7개 task의 final-report
>
> [Owner] 결정 사항 (영구화됨)
>
> 1. 결함 기반 정정 원칙: 잘 돌아가는 영역은 손대지 않음
> 2. 회고 1~36 중 정정 필요 영역만 정비
> 3. Task 3 (9개 스킬 수정)와 동시 진행. 충돌 영역 없음 (Task 3 = 스킬 본문, r7 = 매뉴얼·운영 문서)
> 4. r7 = "r6의 다음 세대 매뉴얼". 회고 누적을 일괄 반영하는 정비
> 5. silkroadhub 사업 자산 손대지 않음
>
> 본 task 작업 — 매뉴얼·운영 문서 정정
>
> 대상 (회고 반영 필요 영역만):
>
> AGENTS.md:
> - §6 권한 천장: 회고 27 (commit·push 후 final-report 사후 갱신 절차)
> - §7 도구 분기: 회고 17 (외부 도구 새 세션 표준 절차), 회고 29·30 (Codex/GPT 폴백)
> - §7.5 Reviewer 폴백: 회고 29·30 명문화, 회고 33 (본 채널 SUB-3 대체 예외 절차)
> - §10 두별 워크트리 카테고리: 회고 18 (Phase C 명칭 보정)
> - §12 베타 운영: 회고 17 일반화 (Local CLI 도구 호출 표준), 회고 36 (Foreman 직접 정정 범위)
>
> SUB-1 매뉴얼:
> - 회고 23 (첨부 정합성) 박기
> - 잘 돌아가는 영역은 손대지 않음 (회고 23만 정정)
>
> SUB-2 매뉴얼:
> - 회고 24 (Builder 친절 제안 ≠ 실행 명령) 박기
>
> SUB-3 매뉴얼:
> - 회고 29·30 (Codex/GPT 폴백 절차) 명문화
> - 회고 33 (본 채널 검수 대체 예외 절차) 박기
>
> SUB-4 매뉴얼:
> - 회고 36 (Foreman 직접 정정 범위 명시화) 박기
>
> SUB-5 매뉴얼:
> - 회고 22 (한글 commit 메시지 영문 키워드 우선) 박기
> - 회고 23 (첨부 정합성) 재확인
> - 회고 27 (commit·push 후 final-report 사후 갱신) 박기
>
> PROJECT.md:
> - §A·B (잘 돌아가는 영역) 손대지 않음
> - §C 회고 영역 정리 (회고 1~36 본문 영구화)
> - §D 본 세션 결정 이력 정리
> - 마스터·클라이언트 sync 정책 본문 (회고 28, 31) 박기
>
> 회고별 정정 필요 여부:
> 회고 1~14 (r6 이전): 본 r7 정비 시점 검토. 정정 필요한 항목만 박기. 잘 돌아가는 건 그대로.
> 회고 15~36: 발화 원문의 지정 위치에 따라 AGENTS.md, SUB-1~5, PROJECT.md 중 필요한 곳에 반영.
>
> 진행 트리
>
> SUB-1 의도 정렬 → SUB-2 매뉴얼 정정 작업 → SUB-3 외부 감리 (Tier A) → SUB-5 종료
>
> SUB-3 외부 감리:
> - Reviewer (Codex 우선, GPT 폴백): 매뉴얼 정정 내용의 일관성, 회고 반영 정합성
> - Judge (GPT): r7이 r6보다 운영 향상시켰는지, 잘 돌아가는 영역 손대지 않았는지 ([Owner] 의도 준수)
> - 회고 29·30·33 학습 적용
>
> [Builder] 영역 / Foreman 영역 구분
>
> Foreman 직접 가능:
> - 매뉴얼 텍스트 정정 (코드 본문 아님)
> - 회고 문구 박기·정리
> - PROJECT.md 갱신
> - 보고서 작성
>
> Builder (클로드코드) 영역:
> - 매뉴얼 안의 코드 예시·스크립트 수정
> - AGENTS.md의 큰 구조 변경 (있는 경우만)
> - 큰 분량의 텍스트 재작성
>
> 대부분의 r7 정비 작업은 Foreman 직접 가능 영역. 다만 큰 구조 변경 시 Builder 호출.
>
> 산출물
>
> 위치: /Users/twostars/ClaudeAi/dubyeol-workflow/.harness/runs/20260519_r7-maintenance/
>
> 핵심 산출물:
> - task-card.md (SUB-1)
> - handoff.md
> - handoff-verification.md
> - r7-changes-summary.md (변경 항목 일괄 표)
> - reviewer-input.md / reviewer-raw.md
> - judge-input.md / judge-raw.md
> - gate-review.md (또는 본 채널 SUB-3 대체 기록)
> - final-report.md
>
> 직접 수정 대상 (마스터 본문):
> - AGENTS.md (§6, §7, §7.5, §10, §12 부분 정정)
> - SUB-1, SUB-2, SUB-3, SUB-4, SUB-5 매뉴얼 (해당 회고 박힘)
> - PROJECT.md (§C, §D 정리)
>
> Task 3와의 동시 진행
>
> 본 task와 Task 3 (20260519_skills-9-fix)는 직접 수정 대상 분리:
> - Task 3: r6-rollout-package/dubyeol-workflow-skills/ (스킬 본문 + scripts)
> - r7: AGENTS.md, SUB-*.md, PROJECT.md (매뉴얼)
>
> 마누스 [Foreman]이 두 task를 분리 관리. handoff·검증·보고도 각자 따로.
>
> 다만 SUB-3 외부 감리는 두 task 각자 별도 진행 (gate-review.md 2개). 또는 API 키 문제 시 본 채널 검수 대체.
>
> 주의
>
> - 결함 기반 정정 원칙: 잘 돌아가는 매뉴얼 영역은 손대지 않음
> - silkroadhub 사업 자산 손대지 않음
> - 권한 천장: push, merge, history rewrite 금지
> - commit·push 사전 승인 없음 (SUB-5 후 별도 결재)
> - 외부 도구 호출 시 새 Terminal + 새 세션 (회고 17)
> - 한글 commit 메시지 영문 키워드 우선 (회고 22)
> - 첨부 정합성 (회고 23)
> - 본 task가 회고 1~36 일괄 영구화하는 중요 정비. r7 = r6의 다음 세대 매뉴얼
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
> [r7 정비 — 20260519_r7-maintenance]
> - 직접 수정 범위는 AGENTS.md, SUB-1~5, PROJECT.md로 한정.
> - 회고 1~36 중 반영 필요 회고만 정정. 반영 근거를 task-card에 명시.
> - 회고는 역사 기록이다. 본문 덮어쓰기 금지, 정정은 addendum 방식으로만.
> - Foreman 직접 수행 우선. 단 다음 경우 즉시 중단 후 Builder 호출: 코드 예시·스크립트 수정이 필요해진 경우, 큰 구조 변경이 필요해진 경우.
> - SUB-3 감리는 별도 gate-review로 진행.
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
- **진입 시점 마일스톤**: Task 2 완료 후 r7 정비가 Task 3와 동시 진입하며, 회고 1~36 중 반영 필요 영역을 운영 문서에 영구화한다.
- **이번 task로 전진시키는 것**: r6 베타 운영에서 누적된 회고를 addendum 원칙으로 정리해 r7 운영 매뉴얼의 권한 경계, 도구 분기, 폴백, 첨부 정합성, 보고·종료 절차를 강화한다.
- **PROJECT.md 진입 시점 스냅샷**:
  - 모듈 상태: Task 2 sync 스크립트 구현이 완료되었고 r7 정비는 회고 1~36 일괄 반영 task로 대기 중이다.
  - 현재 막힌 점: 회고별 반영 필요 여부를 과잉 재작성 없이 판별해야 하며, Task 3의 스킬 본문·scripts 수정 범위와 혼합하지 않아야 한다.

---

## 3. 의도 정렬 증거 블록 (SUB-1 §2 SOP 결과 — 불변)

> 본 블록은 task 진행 중 **수정 금지**. 의도 변경 발생 시 §9에 *추가* 블록으로 기록.

### 3.1 한 문장 목표 (What)

회고 1~36 중 반영 필요 회고만 `AGENTS.md`, `SUB-1~5`, `PROJECT.md`에 addendum 방식으로 정정하여 r7 운영 매뉴얼을 만들되, 잘 돌아가는 영역과 silkroadhub 사업 자산은 건드리지 않는다.

### 3.2 성공 시 보이는 모습 (Looks Like)

- `AGENTS.md`의 §6, §7, §7.5, §10, §12에 권한 천장, 로컬 CLI 도구 호출, Codex/GPT 폴백, Phase C 명칭 보정, Foreman 직접 정정 범위 관련 회고가 근거와 함께 반영된다.
- `SUB-1~5`에는 첨부 정합성, Builder 친절 제안과 실행 명령 구분, Codex/GPT 폴백, 본 채널 SUB-3 대체 예외, Foreman 직접 정정 범위, 한글 commit 메시지, final-report 사후 갱신 절차가 필요한 절에만 추가된다.
- `PROJECT.md`는 §A·§B를 건드리지 않고, §C 회고 영역과 §D 결정 이력에 회고 1~36 및 마스터·클라이언트 sync 정책 관련 결정이 정리된다.
- 회고는 역사 기록으로 보존되며, 기존 회고 본문을 덮어쓰지 않고 addendum 방식으로 정정·보강한다.
- `.harness/runs/20260519_r7-maintenance/` 아래에 `task-card.md`, `handoff.md`, `handoff-verification.md`, `r7-changes-summary.md`, `reviewer-input.md`, `reviewer-raw.md`, `judge-input.md`, `judge-raw.md`, `gate-review.md`, `final-report.md`가 생성된다.

### 3.3 실패 시 보이는 모습 (Looks Wrong)

- `AGENTS.md`, `SUB-1~5`, `PROJECT.md`의 잘 돌아가는 영역을 근거 없이 재작성하거나 큰 구조 변경을 Foreman이 독단 수행한다.
- 회고 1~36의 역사 기록을 삭제·덮어쓰기하거나, 정정 필요 근거 없이 과잉 반영한다.
- `r6-rollout-package/dubyeol-workflow-skills/` 하위 스킬 본문 또는 scripts를 r7 task에서 수정한다.
- 코드 예시·스크립트 수정 또는 큰 구조 변경 필요가 발견됐는데도 중단하지 않고 Builder 호출 없이 진행한다.
- `silkroadhub` 사업 자산을 건드리거나, commit·push·merge·history rewrite 등 권한 천장 위반이 발생한다.

### 3.4 모호어 해소 기록

- “정정 필요 영역만” → “발화 원문에 지정된 회고·문서 절을 우선 대상으로 삼고, 추가 반영은 근거가 있을 때 task-card와 summary에 명시한다.”
- “잘 돌아가는 영역은 손대지 않음” → “AGENTS.md §A·B 같은 비대상 영역, SUB 매뉴얼의 정상 흐름, PROJECT.md §A·B는 필요한 근거 없이 재작성하지 않는다.”
- “회고는 역사 기록” → “기존 회고 본문을 삭제·덮어쓰기하지 않고 addendum 또는 별도 정정 문구로 보강한다.”
- “큰 구조 변경” → “절 순서 재편, 대량 재작성, 코드 예시·스크립트 수정, 기존 운영 흐름의 의미 변경이 필요해지는 경우 즉시 중단 후 [Builder] 호출 여부를 [Owner]에게 확인한다.”

### 3.5 마누스가 가정한 것 3가지

**가정 1**: r7 직접 수정 범위는 `AGENTS.md`, `SUB-1~5`, `PROJECT.md`로 한정하며, 9개 스킬 본문과 scripts는 Task 3이 담당한다.  
→ 근거: [Owner]가 공통 정렬과 r7 직접 수정 범위를 명시했다.  
→ 검증: `git status --short`에서 r7 변경 대상과 Task 3 변경 대상이 분리되어 있는지 확인한다.

**가정 2**: r7은 Foreman 직접 수행 우선 task이지만, 코드 예시·스크립트 수정 또는 큰 구조 변경이 필요해지는 순간 즉시 중단하고 [Owner] 확인 후 Builder 호출로 전환한다.  
→ 근거: [Owner]가 Foreman 직접 수행 우선과 중단 조건 2가지를 명시했다.  
→ 검증: `r7-changes-summary.md`에 각 변경의 반영 근거와 수행 주체를 기록하고, 중단 조건이 발생하지 않았는지 확인한다.

**가정 3**: 본 세션 산출 회고 번호는 r37부터 시작하며, 회고 1~36은 역사 기록으로 보존한다.  
→ 근거: [Owner]가 “회고 누적 36건. 본 세션 산출 회고는 r37부터”와 “회고는 역사 기록”을 명시했다.  
→ 검증: final-report §12 회고 작성 시 신규 회고 번호가 r37 이상인지 확인하고, PROJECT.md 회고 본문 덮어쓰기가 없는지 확인한다.

### 3.6 정렬 확인

- **정렬 일시**: 2026-05-17 KST
- **[Owner] 명시 응답**: “정렬 확인, task-card 작성 진행. 단, 다음 정렬 사항을 반영해 두 task-card를 작성한다: … 두 task-card 작성 후 handoff 전 [Owner] 최종 확인 한 번 받는다.”

---

## 4. Tier 판정

- **Tier**: A
- **판정 근거**: [Owner]가 Tier A를 확정했다. 본 task는 AGENTS.md, SUB-1~5, PROJECT.md 등 운영 인프라 매뉴얼을 정정하며 향후 모든 task의 권한 경계, 외부 감리, 보고, 회고, 종료 절차에 영향을 준다.
- **Blast Radius**: 정비가 잘못되면 이후 task에서 권한 천장 위반, 외부 도구 세션 혼합, 회고 번호 오염, 잘못된 Builder 호출 경계, PROJECT.md 갱신 오류가 반복될 수 있다.
- **Gate 의무**: Tier A이므로 SUB-3에서 별도 `gate-review.md`를 작성한다. Reviewer는 매뉴얼 정정 내용의 일관성·회고 반영 정합성을 검토하고, Judge는 r7이 r6보다 운영을 개선했는지와 [Owner] 의도 준수 여부를 검토한다.

---

## 5. 작업 범위 (Scope)

### 5.1 포함

- `AGENTS.md` §6, §7, §7.5, §10, §12의 지정 회고 반영.
- `SUB-1-기획의도.md`에 회고 23 첨부 정합성 반영.
- `SUB-2-워크플로우.md`에 회고 24 Builder 친절 제안과 실행 명령 구분 반영.
- `SUB-3-외부감리.md`에 회고 29·30 Codex/GPT 폴백 절차와 회고 33 본 채널 검수 대체 예외 절차 반영.
- `SUB-4-수정.md`에 회고 36 Foreman 직접 정정 범위 명시화 반영.
- `SUB-5-종료.md`에 회고 22, 23, 27 반영.
- `PROJECT.md` §C 회고 영역 정리, §D 본 세션 결정 이력 정리, 마스터·클라이언트 sync 정책 본문 반영.
- `r7-changes-summary.md`에 반영 회고 번호, 대상 파일·절, 반영 방식, 근거, addendum 여부를 표로 기록.
- SUB-3 별도 Reviewer/Judge 감리 및 `gate-review.md` 작성.

#### 5.1 Addendum — Task 3 residue 4건 r7 이관 (2026-05-17 KST)

[Owner]의 C안 변형 결재에 따라, Task 3 SUB-2 검증에서 확인된 `references/`·`README.md` residue 4건을 r7 정비 scope에 추가한다. 이 addendum은 기존 §5.1 본문을 덮어쓰지 않고, 회고 28·31에 따른 **마스터·클라이언트 sync 정책 영구화**의 일부로 참조 문서·패키지 안내 문서를 정렬하기 위한 추가 범위다. 직접 실행 코드가 아니라 참조 문서와 README의 운영 안내를 일반화하는 작업이므로 r7의 매뉴얼·운영 문서 정비 성격과 부합한다.

| 이관 파일 | r7 정정 내용 | 정정 방식 | 근거 |
|---|---|---|---|
| `r6-rollout-package/dubyeol-workflow-skills/README.md` | silkroadhub 경로 및 `scripts/load_openai_key.sh` 참조 정정 | silkroadhub 하드코딩은 `REPO_ROOT` 변수 또는 일반화된 예시로 교체하고, 키 로더 참조는 시스템 환경변수 `$OPENAI_API_KEY` 사용 안내로 교체 | 회고 28·31 |
| `r6-rollout-package/dubyeol-workflow-skills/03-dispatch-to-builder/references/agents-md-appendix-b.md` | silkroadhub 하드코딩 경로 및 tmp/handoff 예시 정정 | 특정 client 경로 대신 `REPO_ROOT` 또는 일반화된 예시 사용 | 회고 28·31 |
| `r6-rollout-package/dubyeol-workflow-skills/03-dispatch-to-builder/references/standard-entry-prompt.md` | `silkroadhub/CLAUDE.md` 참조 정정 | client 특정 문구를 저장소 일반 안내로 교체 | 회고 28·31 |
| `r6-rollout-package/dubyeol-workflow-skills/05-verify-handoff/references/verification-checklist.md` | silkroadhub 경로 정정 | 특정 client 경로 대신 `REPO_ROOT` 또는 일반화된 예시 사용 | 회고 28·31 |

본 addendum은 Task 3 scope를 확대하지 않는다. 해당 파일 자체의 정정은 본 결재에서 수행하지 않고, r7 SUB-2 별도 결재 후 처리한다.

### 5.2 명시적 제외 (out of scope)

- `r6-rollout-package/dubyeol-workflow-skills/` 하위 9개 스킬 본문 및 scripts 수정. 이 범위는 Task 3이 담당한다.
- `silkroadhub` 사업 자산 읽기·수정·복사·sync 실제 적용.
- 회고 1~36 역사 기록 삭제·덮어쓰기.
- AGENTS.md 또는 SUB 매뉴얼의 큰 구조 변경을 Foreman이 독단 수행.
- 코드 예시·스크립트 수정이 필요한 변경을 Foreman이 계속 수행.
- commit·push·merge·deploy·force push·history rewrite·reset hard.

### 5.3 산출물 (Deliverables)

| 산출물 | 경로 |
|---|---|
| task-card | `.harness/runs/20260519_r7-maintenance/task-card.md` |
| handoff | `.harness/runs/20260519_r7-maintenance/handoff.md` |
| handoff 검증 | `.harness/runs/20260519_r7-maintenance/handoff-verification.md` |
| r7 변경 요약 | `.harness/runs/20260519_r7-maintenance/r7-changes-summary.md` |
| Reviewer 입력·원문 | `.harness/runs/20260519_r7-maintenance/reviewer-input.md`, `.harness/runs/20260519_r7-maintenance/reviewer-raw.md` |
| Judge 입력·원문 | `.harness/runs/20260519_r7-maintenance/judge-input.md`, `.harness/runs/20260519_r7-maintenance/judge-raw.md` |
| Gate review | `.harness/runs/20260519_r7-maintenance/gate-review.md` |
| 최종 보고 | `.harness/runs/20260519_r7-maintenance/final-report.md` |
| 진행 병기 대시보드 | `dashboard.md` |

---

## 6. 진행 트리 (두별 워크트리)

본 task의 카테고리는 4 (문서·운영)이다. 대부분은 Foreman 직접 수행 가능 범위이나, [Owner]가 지정한 중단 조건이 발생하면 즉시 중단 후 Builder 호출 여부를 확인한다.

### 6.1 변형 사유 (해당 시)

카테고리 4 표준 트리인 `using-superpowers → brainstorming → 작성 → 자체 review → finishing-a-development-branch`를 따르되, r7은 Foreman 직접 수행 우선 task로 시작한다. 단 코드 예시·스크립트 수정 또는 큰 구조 변경이 필요해지면 Foreman 직접 수행을 중단하고 [Builder] 클로드코드 외부 세션으로 전환한다. Tier A이므로 SUB-3 외부 감리는 별도 `gate-review.md`로 진행한다.

| 단계 | 상태 | 책임 |
|---|---|---|
| SUB-1 의도 정렬 | 완료 | [Owner]+[Foreman] |
| SUB-2 매뉴얼 정정 | handoff 전 최종 확인 후 진입 | [Foreman] 우선, 조건부 [Builder] |
| SUB-3 외부 감리 | 예정 | [Reviewer]+[Judge], 조정 [Foreman] |
| SUB-4 수정 | 필요 시 | [Foreman] 우선, 조건부 [Builder] |
| SUB-5 종료 | 예정 | [Foreman]+[Owner] |

---

## 7. 검증 명령

아래 명령은 r7 정비 후 Foreman 자체 검증 및 handoff 검증 시 기준으로 사용한다. 본 task는 문서·운영 정비이므로 내용 검증은 `r7-changes-summary.md`와 diff 중심으로 수행한다.

```bash
cd /Users/twostars/ClaudeAi/dubyeol-workflow
RUN=.harness/runs/20260519_r7-maintenance

# 산출물 존재 확인
test -f "$RUN/task-card.md"
test -f "$RUN/r7-changes-summary.md"

# r7 직접 수정 대상 확인
git status --short -- AGENTS.md SUB-1-기획의도.md SUB-2-워크플로우.md SUB-3-외부감리.md SUB-4-수정.md SUB-5-종료.md PROJECT.md

# Task 3 직접 수정 대상이 r7에서 변경되지 않았는지 확인
git status --short -- r6-rollout-package/dubyeol-workflow-skills

# 회고 반영 근거 기록 확인
grep -E "회고 17|회고 22|회고 23|회고 24|회고 27|회고 29|회고 30|회고 33|회고 36" "$RUN/r7-changes-summary.md"

# 본 세션 회고 번호가 r37부터 시작하는지 final-report 작성 시 확인
grep -E "r37|회고 37" "$RUN/final-report.md" || true

# 변경 diff 검토
git diff -- AGENTS.md SUB-1-기획의도.md SUB-2-워크플로우.md SUB-3-외부감리.md SUB-4-수정.md SUB-5-종료.md PROJECT.md
```

---

## 8. 권한 천장·금지 사항 (재확인)

[Owner] 명시 승인 없이 [Foreman] 및 [Builder] 실행 금지:

- [ ] push / merge / deploy
- [ ] commit
- [ ] 파괴적 git 명령 (reset --hard, force push, history rewrite)
- [ ] task scope 확장 (§5.2 제외 범위 침범)
- [ ] 외부 시스템 프로덕션 실호출
- [ ] Tier 강등

본 task 특유의 추가 금지 사항:

- [ ] 회고 1~36 본문 삭제·덮어쓰기 금지. 정정은 addendum 방식으로만 수행
- [ ] 스킬 본문·scripts 수정 금지
- [ ] 코드 예시·스크립트 수정 또는 큰 구조 변경 필요 시 Foreman 직접 진행 금지
- [ ] `PROJECT.md` §A·§B 불필요 변경 금지
- [ ] `silkroadhub` 사업 자산 접근·수정·복사 금지
- [ ] SUB-3 별도 gate-review 생략 금지

---

## 9. 의도 변경 기록 (해당 시만 추가)

없음. 본 task-card는 [Owner]의 SUB-1 정렬 확인 및 추가 조건 발화를 반영하여 작성되었다. 이후 의도 변경은 본 절에 addendum 방식으로만 추가한다.

### 9.1 의도 변경 1차 — Task 3 residue r7 이관 (C안 변형)

- **변경 일시**: 2026-05-17 KST
- **변경 사유**: Task 3 SUB-2 Foreman 검증에서 `references/`·`README.md` residue 4건이 확인되었다. 해당 residue는 Task 3 scope인 `skills-fix-guidelines.md §11` 표 및 9개 스킬 `SKILL.md`·`scripts/*.sh` 직접 수정 범위 밖이므로, 결함 기반 정정 원칙에 따라 Task 3 scope 확대 대신 r7으로 이관하기로 [Owner]가 C안 변형을 결재했다.
- **변경 내용**: r7 task-card §5.1에 `r6-rollout-package/dubyeol-workflow-skills/README.md`, `03-dispatch-to-builder/references/agents-md-appendix-b.md`, `03-dispatch-to-builder/references/standard-entry-prompt.md`, `05-verify-handoff/references/verification-checklist.md`의 residue 정정을 addendum으로 추가했다.
- **추가 근거**: residue는 실행 코드가 아니라 참조 문서·README의 경로 및 운영 안내 문제이므로, 회고 28·31의 마스터·클라이언트 sync 정책 영구화와 r7 매뉴얼·운영 문서 정비 성격에 부합한다.
- **새 정렬 확인**: “[Owner] C안 변형 확정. references/README residue는 r7 이관.”

### 9.2 의도 변경 2차 — r7 SUB-2 일시 동결 및 Task 3 우선 종결

- **변경 일시**: 2026-05-17 KST
- **변경 사유**: [Owner]가 병행 task 운영 폐기를 추가 결정했다. 직접 계기는 `dashboard.md`가 매뉴얼 정의 없는 비표준 산출물로 도입된 사실이 확인되어, 병행 운영 자체가 매뉴얼 정합성을 깨고 있다는 판단이다.
- **변경 내용**: r7 SUB-2를 일시 동결한다. 현재까지의 r7 SUB-2 산출물인 `AGENTS.md`, `SUB-1~5`, `PROJECT.md` addendum은 보존하고, `references/README` 4건 정정은 동결한다. Task 3을 먼저 완전 종결한 뒤 r7을 재개한다.
- **보류 사항**: `references/README` 4건 처리 방식(A/C 등)은 r7 재개 시점에 다시 결정한다.
- **새 정렬 확인**: “[Owner] 상황 정정. r7 SUB-2 일시 동결, Task 3 SUB-5 먼저 진행.”

---

## 10. PROJECT.md 갱신 사항 (task 종료 시 [Foreman] 작성, SUB-5)

> task 진행 중에는 비워둔다. SUB-5 종료 단계에서 [Foreman]이 작성 후, 본 내용을 PROJECT.md §C.1 및 §D에 반영한다.

### 10.1 §C.1 모듈 갱신

- **현재 상태**: r7 정비 진입 전 회고 1~36 반영 대기 → [SUB-5에서 작성]
- **최근 마일스톤에 추가**: [SUB-5에서 작성]
- **다음 마일스톤에서 완료 처리(체크)**: [SUB-5에서 작성]
- **다음 마일스톤에 추가**: [SUB-5에서 작성]
- **현재 막힌 점**: [SUB-5에서 작성]

### 10.2 §D 결정 이력 추가 (큰 결정 발생 시)

- **날짜**: 2026-05-17
- **결정**: r7 정비는 회고 1~36 중 반영 필요 회고만 addendum 방식으로 반영하고, 본 세션 신규 회고는 r37부터 시작한다.
- **사유**: 회고는 역사 기록이므로 덮어쓰지 않고, 향후 운영 추적성을 보존하기 위해 신규 회고 번호를 분리한다.
- **영향 모듈**: §C.1, §D

### 10.3 §A·§B 갱신 (카테고리 5 기획 task일 때만)

해당 없음.

### 10.4 PROJECT.md 반영 확인

- **반영 일시**: SUB-5에서 작성
- **PROJECT.md §E.마지막 갱신 task run ID에 박은 값**: SUB-5에서 작성

---

## 11. 다음 단계 진행 가이드

- [ ] [Owner] task-card 최종 확인 및 handoff 전 결재
- [ ] 단계 2 (워크플로우) 진입 → SUB-2 호출
- [ ] Foreman 직접 수행으로 시작하되, 중단 조건 발생 시 [Owner]에게 Builder 호출 확인

---

**task-card 끝.**
