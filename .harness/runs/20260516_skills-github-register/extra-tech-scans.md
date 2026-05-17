# extra-tech-scans

: 2026-05-17 01:08:19 KST

## 1. destructive / privilege / network pattern scan
```text
```

## 2. script executable bits
```text
-rw-r--r--  1 twostars  staff  2390 May 16 19:54 r6-rollout-package/dubyeol-workflow-skills/09-update-project-md/scripts/update_project_md.sh
-rw-r--r--  1 twostars  staff  3204 May 16 19:54 r6-rollout-package/dubyeol-workflow-skills/04-invoke-plan-review/scripts/invoke_plan_review.sh
-rw-r--r--  1 twostars  staff  4598 May 16 19:54 r6-rollout-package/dubyeol-workflow-skills/02-create-task-card/scripts/create_task_card.sh
-rw-r--r--  1 twostars  staff  1323 May 16 19:54 r6-rollout-package/dubyeol-workflow-skills/01-load-sub-manual/scripts/load_sub.sh
-rw-r--r--  1 twostars  staff  878 May 16 19:54 r6-rollout-package/dubyeol-workflow-skills/01-load-sub-manual/scripts/load_project_md.sh
-rw-r--r--  1 twostars  staff  4390 May 16 19:54 r6-rollout-package/dubyeol-workflow-skills/06-invoke-reviewer/scripts/invoke_reviewer.sh
-rw-r--r--  1 twostars  staff  5354 May 16 19:54 r6-rollout-package/dubyeol-workflow-skills/05-verify-handoff/scripts/verify_handoff.sh
-rw-r--r--  1 twostars  staff  2721 May 16 19:54 r6-rollout-package/dubyeol-workflow-skills/03-dispatch-to-builder/scripts/dispatch.sh
-rw-r--r--  1 twostars  staff  3569 May 16 19:54 r6-rollout-package/dubyeol-workflow-skills/08-write-final-report/scripts/write_final_report.sh
-rw-r--r--  1 twostars  staff  3450 May 16 19:54 r6-rollout-package/dubyeol-workflow-skills/07-invoke-judge/scripts/invoke_judge.sh
```

## 3. SKILL frontmatter names
```text
--- r6-rollout-package/dubyeol-workflow-skills/01-load-sub-manual/SKILL.md
---
name: 01-load-sub-manual
description: 마누스가 [Owner] 발화에서 SUB 매뉴얼 호출 신호를 인지하고 해당 SUB-N 매뉴얼을 자동 로드하는 스킬. "기획 매뉴얼 봐"/"워크플로우 매뉴얼 봐"/"감리 매뉴얼 봐"/"수정 매뉴얼 봐"/"종료 매뉴얼 봐"와 같은 자연 발화를 SUB-1~5로 라우팅. 마누스가 발화 컨버터로 동작. silkroadhub 두별 워크플로우 v3.6.0 r1 베타에서 마누스 프로젝트 지침 §7 발화 컨버터의 스킬화.
---

# 01-load-sub-manual

[Owner] 자연 발화를 SUB-N 매뉴얼 로드로 자동 라우팅.

## 언제 호출하는가

[Owner]가 다음 발화 또는 유사 발화 시:
--- r6-rollout-package/dubyeol-workflow-skills/02-create-task-card/SKILL.md
---
name: 02-create-task-card
description: 마누스가 SUB-1 의도 정렬 5단계 SOP 완료 후 task-card.md를 자동 작성하는 스킬. [Owner] 발화·의도 정렬 증거 블록·Tier 판정·카테고리 결정을 task-card 양식에 맞춰 채움. 초안 생성 후 마누스가 §3.5 가정·§5 산출물·§6 진행 트리 등 판단 영역을 직접 보강. silkroadhub 두별 워크플로우 v3.6.0 r1 베타 SUB-1 §3·SUB-2 §1 표준 절차.
---

# 02-create-task-card

마누스가 의도 정렬 5단계 SOP 완료 후 task-card.md 자동 작성.

## 언제 호출하는가

- SUB-1 §2 의도 정렬 SOP 완료 (3중 재구성·모호어 스캔·가정 명시·정렬 확인·증거 고정 모두 통과)
--- r6-rollout-package/dubyeol-workflow-skills/03-dispatch-to-builder/SKILL.md
---
name: 03-dispatch-to-builder
description: 마누스가 클로드코드(Builder) 세션에 진입 명령을 전달하는 표준 스킬. SUB-2 진입 시점에 사용. 파일 경유 + 짧은 명령 + 2단계 확정 실행 방식으로 한글·특수문자 깨짐 없이 안전 전달. activate 사용 금지·단일 do script 금지·Builder 친절 제안 무시 등 r6 검증으로 확인된 안전선이 박혀있음. silkroadhub의 두별 워크플로우 v3.6.0 r1 베타에서 SUB-2 §2 표준 진입 절차.
---

# 03-dispatch-to-builder

마누스가 클로드코드 세션에 *SUB-2 진입 명령*을 전달하는 표준 스킬.

## 언제 호출하는가

- `task-card.md` 작성 완료 (SUB-1 종료) 후
--- r6-rollout-package/dubyeol-workflow-skills/04-invoke-plan-review/SKILL.md
---
name: 04-invoke-plan-review
description: 마누스가 지피티에 plan-review를 요청하는 스킬. SUB-2 §2.5 진입 시점 사용 (writing-plans 직후, 구현 진입 전). Tier A 또는 큰 task에 권고. 클로드코드 writing-plans 산출물을 지피티 Devil's Advocate가 검토해서 구현 진입 전 plan 약점 발견. 입력은 의도·plan·연결 모듈 맥락. 코드 디테일 없음. 통과·수정 권고·보류·중단 4단 판정. silkroadhub 두별 워크플로우 v3.6.0 r1 베타 SUB-2 §2.5 표준 절차.
---

# 04-invoke-plan-review

마누스가 [Judge](지피티)에 *구현 진입 전 plan 검토*를 요청. r6 베타에서 신설된 안전선.

## 언제 호출하는가

- 클로드코드가 `writing-plans` skill 완료 후 plan 산출
--- r6-rollout-package/dubyeol-workflow-skills/05-verify-handoff/SKILL.md
---
name: 05-verify-handoff
description: 마누스가 [Builder] handoff 수신 후 권한 천장 위반·scope 위반·마스킹 위반·증거 부족을 자동 점검하는 스킬. SUB-2 §4 진입 시점 사용. git 명령 6개 자동 실행해서 push 시도·파괴적 git·운영 문서 변경 등 위반 신호 검출. 위반 발견 시 즉시 멈춤 + [Owner] 보고. silkroadhub 두별 워크플로우 v3.6.0 r1 베타 SUB-2 §4 표준 절차.
---

# 05-verify-handoff

handoff 수신 후 *마누스 직접 검증* 자동화. handoff만 믿지 않고 *실제 git·로그* 확인.

## 언제 호출하는가

- [Builder]가 handoff.md 작성 완료
--- r6-rollout-package/dubyeol-workflow-skills/06-invoke-reviewer/SKILL.md
---
name: 06-invoke-reviewer
description: 마누스가 코덱스를 호출해 코드 감리(Reviewer)를 수행하는 표준 스킬. 코덱스 불가 시 지피티(별도 세션)로 자동 폴백. SUB-3 §3 진입 시점 사용. 입력은 코드·기술 명세에 한정, 의도·사업 맥락은 절대 전달 금지 (정보 격리 원칙). 코드 변경 task의 Tier A는 필수. silkroadhub 두별 워크플로우 v3.6.0 r1 베타에서 SUB-3 §3 표준 절차.
---

# 06-invoke-reviewer

마누스가 [Reviewer] 역할을 *코덱스에 위임*해 코드 감리를 수행. 코덱스 불가 시 지피티 폴백.

## 언제 호출하는가

- `handoff.md` 작성 완료 (SUB-2 종료) 후
--- r6-rollout-package/dubyeol-workflow-skills/07-invoke-judge/SKILL.md
---
name: 07-invoke-judge
description: 마누스가 지피티(별도 세션)를 호출해 종합 판정·Devil's Advocate 검토를 수행하는 표준 스킬. SUB-3 §4 진입 시점 사용. 입력은 의도·기획·사업 맥락에 한정, 코드 디테일은 절대 전달 금지 (정보 격리). 모든 Tier A/B는 필수. Reviewer 세션과 반드시 다른 세션. silkroadhub 두별 워크플로우 v3.6.0 r1 베타 SUB-3 §4 표준 절차.
---

# 07-invoke-judge

마누스가 [Judge] 역할을 *지피티에 위임*해 종합 판정 + Devil's Advocate 검토 수행.

## 언제 호출하는가

- [Reviewer] 호출·결과 정리 완료 (SUB-3 §3 종료) 후
--- r6-rollout-package/dubyeol-workflow-skills/08-write-final-report/SKILL.md
---
name: 08-write-final-report
description: 마누스가 SUB-5 §2 진입 시 final-report.md 초안을 자동 작성하는 스킬. task-card·handoff·gate-review·plan-review를 읽어 final-report §1~§9를 자동 채움. §10 PROJECT.md 갱신 사항·§11 후속 task 후보·§12 회고는 마누스가 직접 작성. silkroadhub 두별 워크플로우 v3.6.0 r1 베타 SUB-5 §2 표준 절차.
---

# 08-write-final-report

마누스가 task 종료 시 [Owner]께 final-report 작성. 자동 인용 + 수동 판단 결합.

## 언제 호출하는가

- SUB-5 §2 진입 시 (handoff·gate-review 모두 완료된 후)
--- r6-rollout-package/dubyeol-workflow-skills/09-update-project-md/SKILL.md
---
name: 09-update-project-md
description: 마누스가 SUB-5 §3 진입 시 PROJECT.md를 자동 갱신하는 스킬. task-card §10 PROJECT.md 갱신 사항을 읽어 PROJECT.md §C 모듈 진행과 §D 결정 이력에 반영. 변경 diff는 자동 commit 안 하고 마누스 검토·[Owner] 승인 후 commit. silkroadhub 두별 워크플로우 v3.6.0 r1 베타 SUB-5 §3 표준 절차.
---

# 09-update-project-md

마누스가 task 종료 시 PROJECT.md *살아있는 트래커* 자동 갱신.

## 언제 호출하는가

- SUB-5 §3 진입 시 (final-report 작성 완료 후)
```

## 4. referenced local paths existence hints
```text
r6-rollout-package/dubyeol-workflow-skills/09-update-project-md/SKILL.md:17:1. `scripts/update_project_md.sh <run_id>` 실행
r6-rollout-package/dubyeol-workflow-skills/09-update-project-md/SKILL.md:30:bash scripts/update_project_md.sh <run_id>
r6-rollout-package/dubyeol-workflow-skills/04-invoke-plan-review/SKILL.md:33:1. `scripts/invoke_plan_review.sh` 실행
r6-rollout-package/dubyeol-workflow-skills/04-invoke-plan-review/SKILL.md:42:bash scripts/invoke_plan_review.sh <run_id>
r6-rollout-package/dubyeol-workflow-skills/02-create-task-card/SKILL.md:27:1. `scripts/create_task_card.sh` 실행
r6-rollout-package/dubyeol-workflow-skills/02-create-task-card/SKILL.md:48:bash scripts/create_task_card.sh <run_id> <owner_utterance_file> <intent_alignment_file> <tier> <category>
r6-rollout-package/dubyeol-workflow-skills/01-load-sub-manual/SKILL.md:25:1. `scripts/load_sub.sh <sub_num>` 실행 (또는 PROJECT.md)
r6-rollout-package/dubyeol-workflow-skills/01-load-sub-manual/SKILL.md:35:bash scripts/load_sub.sh 1   # SUB-1
r6-rollout-package/dubyeol-workflow-skills/01-load-sub-manual/SKILL.md:36:bash scripts/load_sub.sh 2   # SUB-2
r6-rollout-package/dubyeol-workflow-skills/01-load-sub-manual/SKILL.md:40:bash scripts/load_project_md.sh
r6-rollout-package/dubyeol-workflow-skills/06-invoke-reviewer/references/fallback-procedure.md:80:프롬프트 양식 (`references/codex-prompt-pattern.md`의 *코덱스용을 지피티에 맞게 조정*):
r6-rollout-package/dubyeol-workflow-skills/06-invoke-reviewer/SKILL.md:33:1. `scripts/invoke_reviewer.sh` 실행
r6-rollout-package/dubyeol-workflow-skills/06-invoke-reviewer/SKILL.md:45:bash scripts/invoke_reviewer.sh <run_id>
r6-rollout-package/dubyeol-workflow-skills/06-invoke-reviewer/SKILL.md:71:- `references/codex-prompt-pattern.md` — 코덱스 호출 프롬프트 패턴
r6-rollout-package/dubyeol-workflow-skills/06-invoke-reviewer/SKILL.md:72:- `references/fallback-procedure.md` — 폴백 절차 상세
r6-rollout-package/dubyeol-workflow-skills/05-verify-handoff/SKILL.md:17:1. `scripts/verify_handoff.sh <run_id>` 실행
r6-rollout-package/dubyeol-workflow-skills/05-verify-handoff/SKILL.md:31:bash scripts/verify_handoff.sh <run_id>
r6-rollout-package/dubyeol-workflow-skills/03-dispatch-to-builder/references/standard-entry-prompt.md:3:본 양식이 `scripts/dispatch.sh`가 자동 생성하는 `tmp/claude-entry-<run_id>.md`의 기반.
r6-rollout-package/dubyeol-workflow-skills/03-dispatch-to-builder/references/agents-md-appendix-b.md:39:(나머지 표준 진입 명령 양식 — references/standard-entry-prompt.md 참조)
r6-rollout-package/dubyeol-workflow-skills/03-dispatch-to-builder/SKILL.md:27:1. `scripts/dispatch.sh` 실행
r6-rollout-package/dubyeol-workflow-skills/03-dispatch-to-builder/SKILL.md:40:bash scripts/dispatch.sh <run_id> <window_id> <tier> <category>
r6-rollout-package/dubyeol-workflow-skills/03-dispatch-to-builder/SKILL.md:65:- `references/standard-entry-prompt.md` — 표준 진입 명령 양식 (영문 ASCII)
r6-rollout-package/dubyeol-workflow-skills/03-dispatch-to-builder/SKILL.md:66:- `references/agents-md-appendix-b.md` — AGENTS.md Appendix B 절차 사본 (참고)
r6-rollout-package/dubyeol-workflow-skills/README.md:44:- OpenAI 키 (`scripts/load_openai_key.sh`로 환경변수 로드)
r6-rollout-package/dubyeol-workflow-skills/08-write-final-report/SKILL.md:16:1. `scripts/write_final_report.sh <run_id>` 실행
r6-rollout-package/dubyeol-workflow-skills/08-write-final-report/SKILL.md:37:bash scripts/write_final_report.sh <run_id>
r6-rollout-package/dubyeol-workflow-skills/07-invoke-judge/SKILL.md:34:1. `scripts/invoke_judge.sh` 실행
r6-rollout-package/dubyeol-workflow-skills/07-invoke-judge/SKILL.md:43:bash scripts/invoke_judge.sh <run_id>
r6-rollout-package/dubyeol-workflow-skills/07-invoke-judge/SKILL.md:69:- `references/judge-prompt-pattern.md` — 지피티 호출 프롬프트 패턴
```

## 5. secret-like pattern scan
```text
```

## 6. optional tools availability
```text
shellcheck: not installed
gitleaks: not installed
trufflehog: not installed
detect-secrets: not installed
```
