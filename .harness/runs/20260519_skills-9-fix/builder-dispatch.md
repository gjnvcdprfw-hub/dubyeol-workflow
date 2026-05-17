# Builder Dispatch: Task 3 — 9개 스킬 결함 기반 정정

**run ID**: `20260519_skills-9-fix`  
**작성자**: [Foreman]  
**대상**: [Builder] 클로드코드 외부 세션  
**상태**: SUB-2 진입 승인됨. SUB-3, SUB-4, SUB-5, commit·push는 승인되지 않음.  
**대응 task-card**: `.harness/runs/20260519_skills-9-fix/task-card.md`

---

## 0. 진입 명령

[Builder]는 이 파일과 task-card를 읽고 Task 3 단일 건만 수행한다. 본 task의 목적은 `r6-rollout-package/dubyeol-workflow-skills/` 하위 9개 스킬의 결함을 `skills-fix-guidelines.md §11` 표 기준으로만 정정하는 것이다. 수행 완료 후 [Builder]는 `.harness/runs/20260519_skills-9-fix/handoff.md`를 작성하고 정지한다.

| 항목 | 값 |
|---|---|
| run ID | `20260519_skills-9-fix` |
| Tier | A |
| 카테고리 | 4 (문서·운영, 코드 본문 수정 포함 변형) |
| 직접 수정 범위 | `r6-rollout-package/dubyeol-workflow-skills/` 하위 9개 스킬의 `SKILL.md`, `scripts/*.sh` |
| 정정 근거 | `.harness/runs/20260518_skills-policy-and-sync-design/skills-fix-guidelines.md` §11 |
| Builder 산출물 | `handoff.md`, `evidence-fix-summary.md` |
| Foreman 검증 산출물 | `handoff-verification.md` |

---

## 1. 반드시 읽을 파일

| 순서 | 파일 | 읽는 목적 |
|---:|---|---|
| 1 | `.harness/runs/20260519_skills-9-fix/task-card.md` | 의도 정렬, Scope, 권한 천장, 검증 기준 확인 |
| 2 | `.harness/runs/20260518_skills-policy-and-sync-design/skills-fix-guidelines.md` | §11 표의 9개 스킬별 정정 방향 확인 |
| 3 | `.harness/runs/20260518_skills-policy-and-sync-design/sync-design.md` | REPO_ROOT 정책과 sync 호환성 기준 확인 |
| 4 | `.harness/templates/handoff-template.md` | SUB-2 종료 handoff 양식 확인 |
| 5 | 대상 9개 스킬의 `SKILL.md`, `scripts/*.sh` | 결함 위치 확인 및 정정 |

---

## 2. §11 기준 1:1 정정 매핑

다음 표는 정정 범위의 상한이다. 표 밖 핵심 로직, 권한 천장, 정보 격리 설계, 정상 동작 영역은 수정하지 않는다.

| # | 스킬 | 수정 방향 |
|---:|---|---|
| 1 | `01-load-sub-manual` | `REPO_ROOT` 하드코딩 제거, 스크립트 경로 정렬, 전체 로드 미수행 결함 방어 |
| 2 | `02-create-task-card` | `REPO_ROOT` 제거, 템플릿 직접 사용, §11 섹션 추가 기준 정렬 |
| 3 | `03-dispatch-to-builder` | `REPO_ROOT` 제거, `references/` 파일 작성 기준 정렬 |
| 4 | `04-invoke-plan-review` | `REPO_ROOT` 제거, 입력 격리 강제, Python heredoc을 파일 기반 실행으로 전환 |
| 5 | `05-verify-handoff` | `REPO_ROOT` 제거, uncommitted secret scan, push 확인 강화 |
| 6 | `06-invoke-reviewer` | `REPO_ROOT`와 PATH 하드코딩 제거, `references/` 작성, Python heredoc을 파일 기반 실행으로 전환 |
| 7 | `07-invoke-judge` | `REPO_ROOT` 제거, `references/` 작성, Python heredoc을 파일 기반 실행으로 전환 |
| 8 | `08-write-final-report` | `REPO_ROOT` 제거, 템플릿 직접 사용, `extract_section` 안정성 개선 |
| 9 | `09-update-project-md` | `REPO_ROOT` 제거, diff-first·approval-first 전환, §C·§D·§E 자동 배치 구현 |

---

## 3. 직접 수정 범위와 금지 범위

| 구분 | 허용 여부 | 상세 |
|---|---:|---|
| `r6-rollout-package/dubyeol-workflow-skills/*/SKILL.md` | 허용 | §11 결함 정정에 필요한 부분만 |
| `r6-rollout-package/dubyeol-workflow-skills/*/scripts/*.sh` | 허용 | §11 결함 정정에 필요한 부분만 |
| `AGENTS.md`, `SUB-1~5`, `PROJECT.md` | 금지 | r7 정비 task 영역 |
| `silkroadhub` 사업 자산 | 금지 | 읽기·수정·복사·키 파일 참조 모두 금지 |
| 마스터 키 파일 생성 | 금지 | `$OPENAI_API_KEY` 환경변수 SET/NOT SET 확인만 허용 |
| 외부 감리 호출 | 금지 | SUB-3 별도 결재 필요. [Builder]가 호출하지 않음 |
| commit·push·merge·deploy | 금지 | 본 결재에 포함되지 않음 |

---

## 4. 필수 가드

본 task는 SUB-2 수행 권한만 부여되었다. [Builder]는 commit, push, merge, deploy, force push, history rewrite, reset hard를 수행하지 않는다. SUB-3 Reviewer 호출도 본 결재에 포함되지 않으므로 [Builder]가 Codex나 GPT를 호출하지 않는다. Codex Reviewer 실패 시 GPT Reviewer 자동 폴백도 금지이며, 본 채널 SUB-3 대체와 GPT Reviewer 폴백은 [Foreman]이 [Owner]에게 함께 올린 뒤 [Owner]가 선택한다.

키 관련 출력은 `SET` 또는 `NOT SET` 상태만 허용한다. 실제 키 값, 키 prefix, 키 파일 경로의 민감 내용은 출력하지 않는다. silkroadhub 키 로드 파일은 참조하지 않고, 외부 감리 단계에서는 시스템 환경변수 `$OPENAI_API_KEY`만 사용한다. 이 SUB-2에서는 외부 감리를 호출하지 않는다.

---

## 5. evidence-fix-summary.md 작성 요구

[Builder]는 작업 완료 후 `.harness/runs/20260519_skills-9-fix/evidence-fix-summary.md`를 작성한다. 이 파일에는 9개 스킬이 모두 등장해야 하며, 각 스킬마다 변경 파일, 변경 요약, `skills-fix-guidelines.md §11` 대응 근거, §11 표 밖 변경 여부를 기록한다.

| 필드 | 작성 기준 |
|---|---|
| 스킬명 | 9개 스킬 모두 필수 |
| 변경 파일 | `SKILL.md`, `scripts/*.sh` 중 실제 변경 파일 |
| §11 대응 근거 | §11 표의 수정 방향과 1:1 매핑 |
| 검증 방법 | grep, diff, shellcheck 유사 정적 확인, 실행 가능 여부 등 실제 수행한 확인 |
| §11 표 밖 변경 여부 | 반드시 `없음` 또는 `있음 — 즉시 보고 필요`로 명시 |

§11 표 밖 변경이 필요해 보이면 즉시 작업을 중단하고 [Foreman]에게 보고한다. 판단이 애매하면 수정하지 말고 `handoff.md` §10 의문·미해소 사항에 기록한다.

---

## 6. handoff.md 작성 요구

작업 완료 후 [Builder]는 `.harness/runs/20260519_skills-9-fix/handoff.md`를 작성하고 정지한다. 양식은 `.harness/templates/handoff-template.md`를 따른다. 다음 항목은 반드시 채운다.

| handoff 절 | 필수 내용 |
|---|---|
| §1 | task-card §3 Looks Like, Looks Wrong, 가정 3개와 1:1 대조 |
| §2 | 변경 파일 목록, test 결과, push 미실행 상태 |
| §3 | 카테고리 4 변형 트리 진행 이력 |
| §4 | Context7·Code Simplifier 호출 여부. 호출하지 않았으면 호출 없음 |
| §6 | 권한 천장 점검. push·merge·deploy·운영 문서 변경·파괴적 git·scope 확장·외부 실호출 미위반 여부 |
| §7 | 마스킹 점검. 키 값 출력 없음, silkroadhub 도메인 민감정보 없음 |
| §8 | scope 밖 발견 사항은 제안만 기록하고 실행 금지 |
| §10 | 의문·미해소 사항 |

---

## 7. Builder 자체 검증 기준

아래 검증은 [Builder]가 가능한 범위에서 수행하고, 결과를 `evidence-fix-summary.md`와 `handoff.md`에 기록한다. [Foreman]은 이후 별도 handoff 검증을 수행한다.

```bash
cd /Users/twostars/ClaudeAi/dubyeol-workflow
RUN=.harness/runs/20260519_skills-9-fix

# 산출물 존재 확인
test -f "$RUN/task-card.md"
test -f "$RUN/evidence-fix-summary.md"
test -f "$RUN/handoff.md"

# Task 3 직접 수정 대상 확인
git status --short -- r6-rollout-package/dubyeol-workflow-skills

# r7 직접 수정 대상이 Task 3에서 변경되지 않았는지 확인
git status --short -- AGENTS.md SUB-1-기획의도.md SUB-2-워크플로우.md SUB-3-외부감리.md SUB-4-수정.md SUB-5-종료.md PROJECT.md

# 하드코딩 잔재 점검 예시
grep -R "silkroadhub" r6-rollout-package/dubyeol-workflow-skills || true

# evidence에 9개 스킬이 모두 기록됐는지 확인
grep -E "01-load-sub-manual|02-create-task-card|03-dispatch-to-builder|04-invoke-plan-review|05-verify-handoff|06-invoke-reviewer|07-invoke-judge|08-write-final-report|09-update-project-md" "$RUN/evidence-fix-summary.md"
```

---

## 8. 정지 조건

다음 중 하나라도 발생하면 즉시 작업을 중단하고 [Foreman]에게 보고한다.

| 정지 조건 | 이유 |
|---|---|
| §11 표 밖 변경 필요 | Scope 확장 가능성 |
| `AGENTS.md`, `SUB-1~5`, `PROJECT.md` 수정 필요 | r7 영역 침범 |
| silkroadhub 사업 자산 또는 키 파일 접근 필요 | 사업 자산 보존 원칙 위반 |
| Reviewer/Judge 호출 필요 | SUB-3 별도 결재 필요 |
| commit 또는 push가 필요 | 권한 천장 위반 |
| 권한 천장 위반이 이미 발생 | 즉시 Foreman·Owner 보고 필요 |
| 키 값이 출력될 위험 | 회고 32 위반 |

---

## 9. 완료 후 동작

`handoff.md`와 `evidence-fix-summary.md` 작성 후 정지한다. commit, cleanup, 추가 refactor, 외부 감리 호출, SUB-3 진입 제안의 자동 실행은 하지 않는다. 필요하다고 생각되는 후속은 handoff §8 또는 §10에 제안으로만 기록한다.

---

**Builder Dispatch 끝.**
