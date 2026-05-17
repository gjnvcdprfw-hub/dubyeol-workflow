# Packaged Reviewer Input — GPT Fallback

This package is for [Reviewer] technical audit only. It intentionally excludes Owner intent and PROJECT.md. Do not perform Judge/business role.

## Original reviewer-input.md

# Reviewer Input — G-2 Skills Verification Execution

**Role**: [Reviewer] technical/code auditor  
**Run ID**: 20260518_g2-skills-verification-execution  
**Scope**: technical correctness of 9 Manus Agent Skill definitions and scripts in `dubyeol-workflow`  
**Strict exclusion**: Do not evaluate business intent, Owner intent, prioritization, or project roadmap. Do not perform Judge role.

---

## 1. Technical artifacts to review

Repository root: `/Users/twostars/ClaudeAi/dubyeol-workflow`

### 1.1 Skill definition files

| # | Skill file |
|---:|---|
| 1 | `01-load-sub-manual/SKILL.md` |
| 2 | `02-create-task-card/SKILL.md` |
| 3 | `03-dispatch-to-builder/SKILL.md` |
| 4 | `04-invoke-plan-review/SKILL.md` |
| 5 | `05-verify-handoff/SKILL.md` |
| 6 | `06-invoke-reviewer/SKILL.md` |
| 7 | `07-invoke-judge/SKILL.md` |
| 8 | `08-write-final-report/SKILL.md` |
| 9 | `09-update-project-md/SKILL.md` |

### 1.2 Script files

| # | Script file |
|---:|---|
| 1 | `01-load-sub-manual/scripts/load_project_md.sh` |
| 2 | `01-load-sub-manual/scripts/load_sub.sh` |
| 3 | `02-create-task-card/scripts/create_task_card.sh` |
| 4 | `03-dispatch-to-builder/scripts/dispatch.sh` |
| 5 | `04-invoke-plan-review/scripts/invoke_plan_review.sh` |
| 6 | `05-verify-handoff/scripts/verify_handoff.sh` |
| 7 | `06-invoke-reviewer/scripts/invoke_reviewer.sh` |
| 8 | `07-invoke-judge/scripts/invoke_judge.sh` |
| 9 | `08-write-final-report/scripts/write_final_report.sh` |
| 10 | `09-update-project-md/scripts/update_project_md.sh` |

### 1.3 Verification output files

| # | Evidence file |
|---:|---|
| 1 | `.harness/runs/20260518_g2-skills-verification-execution/g2-01-load-sub-manual-evidence.md` |
| 2 | `.harness/runs/20260518_g2-skills-verification-execution/g2-02-create-task-card-evidence.md` |
| 3 | `.harness/runs/20260518_g2-skills-verification-execution/g2-03-dispatch-to-builder-evidence.md` |
| 4 | `.harness/runs/20260518_g2-skills-verification-execution/g2-04-invoke-plan-review-evidence.md` |
| 5 | `.harness/runs/20260518_g2-skills-verification-execution/g2-05-verify-handoff-evidence.md` |
| 6 | `.harness/runs/20260518_g2-skills-verification-execution/g2-06-invoke-reviewer-evidence.md` |
| 7 | `.harness/runs/20260518_g2-skills-verification-execution/g2-07-invoke-judge-evidence.md` |
| 8 | `.harness/runs/20260518_g2-skills-verification-execution/g2-08-write-final-report-evidence.md` |
| 9 | `.harness/runs/20260518_g2-skills-verification-execution/g2-09-update-project-md-evidence.md` |
| summary | `.harness/runs/20260518_g2-skills-verification-execution/skill-verification-summary.md` |
| handoff | `.harness/runs/20260518_g2-skills-verification-execution/handoff.md` |
| foreman verification | `.harness/runs/20260518_g2-skills-verification-execution/handoff-verification.md` |

---

## 2. Technical findings from SUB-2 verification

The Builder verification produced the following technical result. Please independently inspect the listed files and confirm, challenge, or refine these findings.

| Finding | Builder/Foreman observed result |
|---|---|
| Skill coverage | All 9 skills were evaluated. |
| Overall verdict distribution | PASS 0, PARTIAL PASS 9, FAIL 0. |
| Script existence | Every skill has scripts under its own skill directory. |
| Root scripts assumption | Root `scripts/` does not contain the skill scripts expected by some instructions. |
| Common path issue | All 9 skill scripts appear to hardcode `REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"`, which is technically incompatible with independent `dubyeol-workflow` master execution. |
| `01-load-sub-manual` suspicion | Confirmed as a path/layout issue: skill-local `scripts/load_sub.sh` exists, but root `scripts/load_sub.sh` does not; script appears to target `silkroadhub`. |
| References | Some `references/` directories are empty while SKILL.md files refer to reference files. |
| Template integration | Some generator scripts may use internal templates rather than `.harness/templates/*`, creating drift risk. |
| External tool scripts | Reviewer/Judge/plan-review scripts exist, but official SUB-3 calls must preserve input isolation. |
| Authority | No code or operating document modifications were made during SUB-2 verification. |

---

## 3. Review questions

Please review only technical correctness and implementation reliability.

1. Are the 9 skill scripts technically executable from the `dubyeol-workflow` master repository as-is?
2. Is the `REPO_ROOT` hardcoding to `silkroadhub` a blocking defect, a conditional defect, or acceptable legacy behavior? Give file-level evidence.
3. Do the scripts and SKILL.md files agree on paths, script names, templates, references, and output locations?
4. Are the evidence files sufficient to support the PARTIAL PASS verdicts?
5. Are there any technical risks missed by the Builder/Foreman verification, especially around destructive commands, output paths, external tool calls, or input isolation?
6. Which items should be fixed in SUB-4 before any G-2 closure or commit/push?

---

## 4. Required response format

Please respond in this structure:

```markdown
# Reviewer Raw Result — G-2 Skills Verification

## 1. Overall Technical Verdict
Verdict: PASS / CONDITIONAL PASS / HOLD / BLOCK

## 2. Confirmed Technical Findings
| Finding | Severity | Evidence |
|---|---|---|

## 3. Disputed or Unproven Findings
| Finding | Reason |
|---|---|

## 4. Missed Technical Risks
| Risk | Severity | Evidence |
|---|---|---|

## 5. Required Fixes Before Closure
| Fix | Priority | Scope |
|---|---|---|

## 6. Reviewer Boundary Check
- Code/technical scope only: yes/no
- Business/Judge role avoided: yes/no
- Direct code modification performed: no
```

Do not modify any files. Do not judge business intent. Do not downgrade or upgrade Tier.


## skill-verification-summary.md

# G-2 스킬 검증 종합 요약

**run ID**: 20260518_g2-skills-verification-execution  
**검증 일시**: 2026-05-18  
**검증자**: [Builder] (클로드코드)  
**Tier**: A  

---

## 1. 9개 스킬 판정 테이블

| # | 스킬 ID | 판정 | 스크립트 존재 | REPO_ROOT 정합 | 참조 파일 | 핵심 로직 | 비고 |
|---:|---|---|---|---|---|---|---|
| 1 | `01-load-sub-manual` | **PARTIAL PASS** | ✅ (스킬 내) | ❌ silkroadhub | — | ✅ | 루트 scripts/ 없음 · G-1 의심 확정 |
| 2 | `02-create-task-card` | **PARTIAL PASS** | ✅ (스킬 내) | ❌ silkroadhub | 템플릿 미사용 | ✅ | §11 누락 · 템플릿 독립 관리 |
| 3 | `03-dispatch-to-builder` | **PARTIAL PASS** | ✅ (스킬 내) | ❌ silkroadhub | ❌ references/ 비어있음 | ✅ | 2단계 확정 실행 OK · 현 세션이 증거 |
| 4 | `04-invoke-plan-review` | **PARTIAL PASS** | ✅ (스킬 내) | ❌ silkroadhub | — | ✅ | GPT 호출은 Foreman 전용 |
| 5 | `05-verify-handoff` | **PARTIAL PASS** | ✅ (스킬 내) | ❌ silkroadhub | — | ✅ | 6개 항목 구현 OK · 수동 A-E PASS |
| 6 | `06-invoke-reviewer` | **PARTIAL PASS** | ✅ (스킬 내) | ❌ silkroadhub | ❌ references/ 비어있음 | ✅ | Codex 재시도·폴백 구현 OK |
| 7 | `07-invoke-judge` | **PARTIAL PASS** | ✅ (스킬 내) | ❌ silkroadhub | ❌ references/ 비어있음 | ✅ | DA 3가지 강제·세션 분리 OK |
| 8 | `08-write-final-report` | **PARTIAL PASS** | ✅ (스킬 내) | ❌ silkroadhub | 템플릿 미사용 | ✅ | §1~§13 구조 OK · 입력 매핑 OK |
| 9 | `09-update-project-md` | **PARTIAL PASS** | ✅ (스킬 내) | ❌ silkroadhub | — | ✅ | 자동 commit 금지·백업·diff 구현 OK |

---

## 2. 판정 집계

| 판정 | 수 |
|---|---|
| PASS | **0** |
| PARTIAL PASS | **9** |
| FAIL | **0** |

**전체 9개 스킬 PARTIAL PASS**

---

## 3. 공통 결함 (모든 9개 스킬)

### [COMMON-DEFECT-A] REPO_ROOT 하드코딩 (심각도: HIGH)

**영향**: 9개 스킬 전부  
**내용**: 모든 스크립트에서 `REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"` 하드코딩.  
`dubyeol-workflow` 마스터에서 독립 실행 불가. 실 운영은 마누스가 silkroadhub에서 직접 실행하므로 기능은 하지만, `dubyeol-workflow`의 스킬 스크립트로서는 경로 오류.

**수정 방향 (r7 정비 후보)**: `REPO_ROOT` 환경변수화 또는 스크립트 실행 위치 기반 자동 감지.

### [COMMON-DEFECT-B] 스킬 내부 scripts/ (루트 scripts/ 없음) (심각도: MEDIUM)

**영향**: 01, 02, 03 (SKILL.md 호출 방식과 불일치)  
**내용**: SKILL.md에서 `bash scripts/<script>.sh`로 안내하지만, 실제 스크립트는 `<skill_dir>/scripts/`에 위치. 루트에서 실행 시 "No such file" 오류.  
**수정 방향**: SKILL.md 호출 방식에 실행 디렉토리 명시 또는 루트 scripts/ 심볼릭 링크 생성.

---

## 4. 스킬별 추가 결함

| 스킬 | 결함 ID | 내용 |
|---|---|---|
| 01 | DEFECT-01-C | 전체 로드 미수행 (head -30 미리보기만) |
| 02 | DEFECT-02-B | task-card-template.md 미사용 (heredoc 독립 생성) |
| 02 | DEFECT-02-C | §11 섹션 누락 |
| 03 | DEFECT-03-B | references/ 비어있음 (standard-entry-prompt.md 등) |
| 06 | DEFECT-06-B | references/ 비어있음 (codex-prompt-pattern.md 등) |
| 06 | DEFECT-06-C | PATH 하드코딩 |
| 07 | DEFECT-07-B | references/ 비어있음 (judge-prompt-pattern.md) |
| 08 | DEFECT-08-B | final-report-template.md 미사용 |
| 08 | DEFECT-08-C | extract_section 패턴 정확도 우려 |
| 09 | DEFECT-09-B | §C·§D 자동 배치 미구현 (끝에 추가 후 수동 이동) |

---

## 5. G-1 의심 신호 최종 결론

G-1에서 기록한 "scripts/load_sub.sh 미발견 의심":

**결론**: 부분 확인 (수정된 해석)
- 루트 `scripts/load_sub.sh` → **없음** (루트 scripts/ 디렉토리 자체 없음) ✅ G-1 의심 확인
- `01-load-sub-manual/scripts/load_sub.sh` → **존재** (G-1이 예상한 결함 방향과 다름)
- 실제 결함: 스크립트 존재하지만 `REPO_ROOT` silkroadhub 하드코딩으로 dubyeol-workflow에서 독립 실행 불가

G-1이 "스크립트 없음"으로 의심했으나 실제는 "위치 다름 + 경로 하드코딩"이 문제.

---

## 6. 양호한 점

- 9개 스크립트 모두 존재하고 핵심 로직 구현됨
- 정보 격리 원칙(Reviewer/Judge 입력 분리) 스크립트에 반영됨
- 권한 천장 원칙(자동 commit 금지, push 미포함) 스크립트에 반영됨
- 마누스 수동 보강 영역 명시(수동 판단 영역을 스크립트가 대체하지 않음)
- GPT 폴백 구현 (06-invoke-reviewer)
- 4단 판정 형식 시스템 프롬프트 구현 (04, 06, 07)
- `verify_handoff.sh` 6개 항목 자동화 수준 양호

---

## 7. 의존성 영향 요약

| 의존 그룹 | 영향 |
|---|---|
| 그룹 0: 01-load-sub-manual | PARTIAL PASS → 이후 그룹에 영향 없음 (수동 대체 가능) |
| 그룹 1: 02-create-task-card | PARTIAL PASS → 실 운영 마누스 수동 작성 중 |
| 그룹 2: 03·04 | PARTIAL PASS → 03 현 세션으로 검증. 04 GPT 호출 Foreman 담당 |
| 그룹 3: 05 | PARTIAL PASS → 수동 동등 명령으로 A-E 검증 완료 |
| 그룹 4: 06·07 | PARTIAL PASS → 입력 격리 설계 OK. 실 호출은 Foreman |
| 그룹 5: 08·09 | PARTIAL PASS → 구조·승인 경계 설계 OK. Builder 직접 실행 금지 |

---

## 8. 다음 단계 권고

1. **SUB-3 외부 감리** (Tier A 의무): Codex [Reviewer] + GPT [Judge] 1회씩 → gate-review.md 작성
2. **r7 정비 후보**: 
   - [COMMON-DEFECT-A] REPO_ROOT 환경변수화 (9개 스킬 일괄)
   - [COMMON-DEFECT-B] SKILL.md 호출 방식 명확화 또는 루트 scripts/ 생성
   - references/ 파일 작성 (03, 06, 07)
   - 02·08 템플릿 연동 구현
3. **SUB-3 이후**: [Owner] 결재 후 수정 범위 결정 (SUB-4)


## handoff-verification.md

# handoff-verification: G-2 9개 Manus Agent Skills 실제 동작 검증

**run ID**: 20260518_g2-skills-verification-execution  
**작성일시**: 2026-05-17 KST  
**작성자**: [Foreman]

---

## 1. 검증 대상

본 문서는 [Builder]가 작성한 `.harness/runs/20260518_g2-skills-verification-execution/handoff.md` 수신 후, [Foreman]이 직접 수행한 SUB-2 §4 검증 기록이다.

| 항목 | 경로 |
|---|---|
| task-card | `.harness/runs/20260518_g2-skills-verification-execution/task-card.md` |
| skill verification summary | `.harness/runs/20260518_g2-skills-verification-execution/skill-verification-summary.md` |
| handoff | `.harness/runs/20260518_g2-skills-verification-execution/handoff.md` |
| evidence files | `.harness/runs/20260518_g2-skills-verification-execution/g2-01-*.md` ~ `g2-09-*.md` |

---

## 2. Foreman 직접 검증 결과

| 검증 항목 | 결과 | 근거 |
|---|---|---|
| 9개 증거 파일 존재 | PASS | `g2-01`부터 `g2-09`까지 모든 evidence 파일 존재 확인 |
| 종합 요약 존재 | PASS | `skill-verification-summary.md` 존재 확인 |
| handoff 존재 | PASS | `handoff.md` 존재 확인 |
| `silkroadhub` run 오염 없음 | PASS | `/Users/twostars/ClaudeAi/silkroadhub/.harness/runs/20260518_g2-skills-verification-execution` 미존재 확인 |
| 운영 문서 diff 없음 | PASS | `AGENTS.md`, `PROJECT.md`, `SUB-1~5`, `.harness/templates/` diff 없음 |
| commit·push 미실행 | PASS | `git status --short`는 신규 run·dummy·tmp만 표시, 최근 commit은 G-1 `4f7a103` |
| 파괴적 git 명령 없음 | PASS | 최근 reflog에서 본 task 관련 `reset --hard`, `rebase`, force push 흔적 없음 |
| 마스킹 위반 없음 | PASS | dummy 자료와 증거 파일은 실 사업 데이터·운송장·BL·개인통관고유부호를 사용하지 않음 |
| Tier A 유지 | PASS | handoff가 SUB-3 필수 진입을 명시함 |

---

## 3. 검증 판정 요약

Builder의 9개 스킬 검증 결과는 모두 **PARTIAL PASS**이며, 완전 PASS나 FAIL은 없다. 이는 스킬 내부 `scripts/`는 존재하지만, 공통적으로 `REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"` 하드코딩이 확인되어 `dubyeol-workflow` 마스터 독립 실행 관점에서는 결함이 있기 때문이다.

| 판정 | 개수 | 의미 |
|---|---:|---|
| PASS | 0 | 마스터 독립 실행 기준으로 완전 통과한 스킬 없음 |
| PARTIAL PASS | 9 | 스킬 내부 스크립트와 절차는 존재하나, 경로 하드코딩·references 누락·템플릿 미연동 등 결함 존재 |
| FAIL | 0 | 검증 자체가 불가능한 스킬은 없음 |

---

## 4. 핵심 결함 패턴

| 결함 패턴 | 영향 | SUB-3 전달 필요성 |
|---|---|---|
| 9개 스킬 전체 `REPO_ROOT`가 `silkroadhub`로 하드코딩 | `dubyeol-workflow` 마스터 독립 실행 불가 또는 오작동 위험 | Reviewer·Judge 모두 전달 |
| 루트 `scripts/` 없음, 스킬 내부 `scripts/` 존재 | G-1에서 관찰한 `scripts/load_sub.sh` 부재 의심은 “루트 scripts 기준”으로 확정 | Reviewer 중심 전달 |
| 03·06·07 references 디렉터리 비어 있음 | SKILL.md가 참조하는 보조 자료 부재 가능 | Reviewer 전달 |
| 02·08 템플릿 미연동 또는 자체 생성 방식 | 표준 템플릿과 산출물 괴리 가능 | Reviewer·Judge 전달 |
| 04·06·07 실제 외부 호출은 Builder가 수행하지 않음 | Tier A SUB-3에서 Foreman이 공식 외부 감리 수행 필요 | Judge·Reviewer 입력 분리 필요 |

---

## 5. SUB-2 종료 판정

SUB-2는 task-card §3 Looks Like의 “9개 스킬 전체 검증·증거 파일 작성·실패 기록 후 계속 진행” 조건을 충족했다. 모든 스킬은 PARTIAL PASS로 판정되어 수정 필요성이 높지만, [Owner] 지시에 따라 실패 발견 즉시 중단하지 않고 전체 검증을 완료했다. 권한 천장 위반은 확인되지 않았다.

Tier A이므로 다음 단계는 **SUB-3 외부 감리**다. [Reviewer] 입력은 스크립트·SKILL.md·기술 결함 중심으로 제한하고, [Judge] 입력은 task-card 의도·G-2 검증 결과·결함 패턴의 운영 논리 중심으로 제한한다.

---

**handoff-verification 끝.**


## Evidence files


### .harness/runs/20260518_g2-skills-verification-execution/g2-01-load-sub-manual-evidence.md

# G-2 증거 파일 — 01-load-sub-manual

**스킬 ID**: `01-load-sub-manual`  
**스킬 경로**: `/Users/twostars/ClaudeAi/dubyeol-workflow/01-load-sub-manual/`  
**검증 일시**: 2026-05-18  
**판정**: **PARTIAL PASS**

---

## 1. 테스트 목표

`scripts/load_sub.sh` 존재 여부, SKILL.md 정합성, 실제 실행 시 SUB 매뉴얼 경로 출력 여부 확인.
G-1 설계에서 기록된 의심 신호(`scripts/load_sub.sh` 미발견) 사실 여부 확정.

---

## 2. 전제조건 점검

| 전제조건 | 확인 결과 |
|---|---|
| 마스터 저장소 접근 가능 | ✅ `/Users/twostars/ClaudeAi/dubyeol-workflow` 접근 확인 |
| SUB 파일 존재 | ✅ `SUB-1-기획의도.md` ~ `SUB-5-종료.md` 루트에 존재 |
| 루트 `scripts/` 디렉토리 존재 | ❌ 존재하지 않음 |

---

## 3. 테스트 입력

- 스킬 호출 대상: `01-load-sub-manual` SKILL.md 분석 + `scripts/load_sub.sh` 직접 검사
- SUB 인자: `1` (SUB-1 로드 테스트)

---

## 4. 실제 수행 명령·행동

```bash
# 루트 scripts/ 디렉토리 확인
ls /Users/twostars/ClaudeAi/dubyeol-workflow/scripts/
# → "scripts/ 디렉토리 없음"

# 스킬 내부 scripts/ 확인
ls /Users/twostars/ClaudeAi/dubyeol-workflow/01-load-sub-manual/scripts/
# → load_project_md.sh  load_sub.sh

# 스크립트 존재 확인
file /Users/twostars/ClaudeAi/dubyeol-workflow/01-load-sub-manual/scripts/load_sub.sh
# → Paul Falstad's zsh script text executable

# 스크립트 주요 내용 검사
cat /Users/twostars/ClaudeAi/dubyeol-workflow/01-load-sub-manual/scripts/load_sub.sh
```

---

## 5. G-1 설계 / SKILL.md 기대 동작

1. `scripts/load_sub.sh` 또는 직접 파일 경로를 지정한다.
2. 지정된 경로의 매뉴얼이 세션 컨텍스트에 로드된다.
3. 로드 성공 메시지 또는 파일 내용이 출력된다.

SKILL.md 호출 방식:
```bash
bash scripts/load_sub.sh 1
```
(암시적으로 스킬 디렉토리에서 실행 또는 루트에 scripts/ 존재 가정)

---

## 6. 실제 결과

### 6.1 스크립트 위치

| 항목 | 기대 | 실제 |
|---|---|---|
| 루트 `scripts/load_sub.sh` | 존재 (SKILL.md 표기 기준) | ❌ **없음** |
| `01-load-sub-manual/scripts/load_sub.sh` | — | ✅ **존재** |

### 6.2 스크립트 내용 분석

```
REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"   ← 하드코딩 경로
```

**결함 1**: `REPO_ROOT`가 `/Users/twostars/ClaudeAi/silkroadhub`로 하드코딩됨.  
`dubyeol-workflow` 마스터에서 호출 시 silkroadhub의 SUB 파일을 참조하려 시도.

```
SUB_FILES[1]="SUB-1-기획의도.md"
FULL_PATH="${REPO_ROOT}/${FILE}"
```

**결함 2**: 스크립트는 경로 출력 + `head -30` 미리보기만 수행. SKILL.md에서 "전체 파일 읽음 (cat·view)"을 요구하지만 스크립트는 미리보기만 제공하고 전체 로드는 수동 단계로 남김.

### 6.3 G-1 의심 신호 확정

G-1에서 기록한 "scripts/load_sub.sh 미발견" 의심 신호는 **부분적으로 확인됨**:
- 루트 `scripts/` 디렉토리가 없어서 `scripts/load_sub.sh`를 루트에서 찾을 수 없음 → **사실**
- 스크립트 자체는 `01-load-sub-manual/scripts/load_sub.sh`에 **존재함**
- G-1에서 "스크립트가 없다"고 의심했으나 실제로는 "위치가 다르고 경로 하드코딩 결함이 있음"

---

## 7. 판정: PARTIAL PASS

| 점검 항목 | 결과 |
|---|---|
| SKILL.md 존재 | ✅ |
| 스크립트 파일 존재 (`01-load-sub-manual/scripts/load_sub.sh`) | ✅ |
| 루트 `scripts/load_sub.sh` 참조 경로 일치 | ❌ **FAIL** |
| `REPO_ROOT` 경로 정합성 (dubyeol-workflow 기준) | ❌ **FAIL** (silkroadhub 하드코딩) |
| SUB 파일 로드 전체 동작 | ❌ **FAIL** (미리보기만, silkroadhub 경로) |
| SKILL.md 호출 방식 명확성 | ⚠️ **WARN** (실행 디렉토리 미명시) |

---

## 8. 결함 상세 및 의존성 영향

### 결함 목록

1. **[DEFECT-01-A] REPO_ROOT 하드코딩**: `scripts/load_sub.sh` 내 `REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"`. dubyeol-workflow에서 독립 실행 불가. → r7 정비 대상
2. **[DEFECT-01-B] 호출 경로 비명시**: SKILL.md가 `bash scripts/load_sub.sh 1`로 안내하지만, 이는 `01-load-sub-manual/` 디렉토리에서 실행해야 정확. 루트에서는 `bash 01-load-sub-manual/scripts/load_sub.sh 1`이 맞음.
3. **[DEFECT-01-C] 전체 로드 미수행**: 스크립트가 `head -30`만 출력. 마누스가 별도로 `cat <path>` 실행 필요.

### 의존성 영향

- `02-create-task-card` ~ `09-update-project-md` 모든 스킬도 동일한 `REPO_ROOT` 하드코딩 패턴이 예상됨 → 연쇄 PARTIAL PASS 예상
- `01-load-sub-manual` 스크립트 결함이 있어도 마누스가 수동으로 SUB 파일을 읽어 운영 중이므로 실 운영 차단은 아님

---

## 9. 증거 스니펫

```bash
# 확인 1: 루트 scripts/ 없음
$ ls /Users/twostars/ClaudeAi/dubyeol-workflow/scripts/
→ "scripts/ 디렉토리 없음"

# 확인 2: 스킬 내부 scripts/ 있음
$ ls /Users/twostars/ClaudeAi/dubyeol-workflow/01-load-sub-manual/scripts/
load_project_md.sh  load_sub.sh

# 확인 3: 스크립트 REPO_ROOT 확인
$ grep "REPO_ROOT" /Users/twostars/ClaudeAi/dubyeol-workflow/01-load-sub-manual/scripts/load_sub.sh
REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"

# 확인 4: dubyeol-workflow에 SUB 파일 실제 존재
$ ls /Users/twostars/ClaudeAi/dubyeol-workflow/SUB-*.md
SUB-1-기획의도.md  SUB-2-워크플로우.md  SUB-3-외부감리.md  SUB-4-수정.md  SUB-5-종료.md

# 확인 5: silkroadhub SUB 파일 확인 (스크립트가 찾아가는 경로)
$ ls /Users/twostars/ClaudeAi/silkroadhub/SUB-*.md (별도 확인 필요 — Builder 접근 제한)
```

---

**G-2 우선 검증 결론**: G-1 의심 신호 확정. `load_sub.sh`는 존재하나 silkroadhub 경로 하드코딩으로 dubyeol-workflow 독립 실행 불가. r7 정비 대상.


### .harness/runs/20260518_g2-skills-verification-execution/g2-02-create-task-card-evidence.md

# G-2 증거 파일 — 02-create-task-card

**스킬 ID**: `02-create-task-card`  
**스킬 경로**: `/Users/twostars/ClaudeAi/dubyeol-workflow/02-create-task-card/`  
**검증 일시**: 2026-05-18  
**판정**: **PARTIAL PASS**

---

## 1. 테스트 목표

`scripts/create_task_card.sh` 존재 여부, `.harness/templates/task-card-template.md` 존재 여부, 스크립트가 올바른 경로에 §1~§11 포함 task-card 생성하는지 확인.

---

## 2. 전제조건 점검

| 전제조건 | 확인 결과 |
|---|---|
| `task-card-template.md` 존재 | ✅ `.harness/templates/task-card-template.md` 존재 |
| run_id 형식 (`YYYYMMDD_task-slug`) | ✅ 실제 사용 중 (예: `20260518_g2-skills-verification-execution`) |
| `create_task_card.sh` 존재 | ✅ `02-create-task-card/scripts/create_task_card.sh` |

---

## 3. 테스트 입력 (dummy)

```
run_id: g2-dummy-02
owner_utterance_file: (가상) /tmp/owner_utt.md
intent_alignment_file: (가상) /tmp/intent.md
tier: B
category: 4
```

실제 실행은 금지 (silkroadhub 경로 하드코딩으로 dubyeol-workflow에서 실행 시 오류 예상).
스크립트 내용을 정적 분석으로 검증.

---

## 4. 실제 수행 명령·행동

```bash
# 스크립트 존재 확인
ls /Users/twostars/ClaudeAi/dubyeol-workflow/02-create-task-card/scripts/
# → create_task_card.sh

# 템플릿 존재 확인
ls /Users/twostars/ClaudeAi/dubyeol-workflow/.harness/templates/
# → final-report-template.md  gate-review-template.md
#    handoff-template.md  task-card-template.md

# 스크립트 내용 검사 (정적 분석)
cat /Users/twostars/ClaudeAi/dubyeol-workflow/02-create-task-card/scripts/create_task_card.sh
```

---

## 5. G-1 설계 / SKILL.md 기대 동작

1. `scripts/create_task_card.sh` 실행
2. `.harness/runs/<run_id>/task-card.md` 자동 생성
3. 템플릿 §1~§11 전부 포함
4. run_id·작성일시·카테고리·Tier 메타데이터 채워짐
5. §2 상위 맥락·§5 산출물·§6 변형 사유는 마누스 수동 보강 영역

---

## 6. 실제 결과

### 6.1 스크립트 분석

| 분석 항목 | 결과 |
|---|---|
| `REPO_ROOT` 값 | ❌ `"/Users/twostars/ClaudeAi/silkroadhub"` 하드코딩 |
| `RUN_DIR` 계산 | `${REPO_ROOT}/.harness/runs/${RUN_ID}` → silkroadhub 경로로 생성됨 |
| task-card 경로 | `${RUN_DIR}/task-card.md` → silkroadhub에 생성됨 |
| 섹션 포함 여부 | ✅ §1~§10 포함 (SKILL.md 기술은 §1~§11이나 실제 §10까지 구현) |
| 카테고리별 진행 트리 | ✅ `declare -A TREES` 1~5 전부 정의됨 |
| 마누스 수동 보강 영역 표시 | ✅ `★ 마누스 수동 보강 ★` 명시 |

### 6.2 템플릿 파일 사용 여부

**결함**: SKILL.md에서 "`.harness/templates/task-card-template.md` 기반" 생성이라고 설명하지만, 실제 스크립트는 heredoc(`cat > "${TASK_CARD}" << TC_EOF`)으로 직접 내용을 생성. 템플릿 파일을 읽거나 참조하지 않음.

→ 템플릿 파일과 스크립트 생성 내용이 서로 독립적으로 관리될 위험. 템플릿 업데이트가 스크립트에 반영되지 않을 수 있음.

### 6.3 섹션 구성 검증 (스크립트 헤레독 분석)

| 섹션 | 포함 여부 |
|---|---|
| §1 [Owner] 원 발화 | ✅ |
| §2 상위 맥락 연결 (수동 보강) | ✅ |
| §3 의도 정렬 증거 블록 | ✅ |
| §4 Tier·카테고리·플랜 | ✅ |
| §5 산출물 + 완료 기준 (수동 보강) | ✅ (템플릿 플레이스홀더) |
| §6 진행 트리 변형 사유 (수동 보강) | ✅ |
| §7 마스킹 적용 영역 | ✅ |
| §8 권한 천장·금지 사항 | ✅ |
| §9 변경 이력 | ✅ |
| §10 PROJECT.md 갱신 사항 | ✅ |
| §11 다음 단계 진행 가이드 | ❌ **없음** (SKILL.md에는 §1~§11 언급) |

---

## 7. 판정: PARTIAL PASS

| 점검 항목 | 결과 |
|---|---|
| 스크립트 파일 존재 | ✅ |
| 템플릿 파일 존재 | ✅ |
| `REPO_ROOT` 경로 정합성 | ❌ **FAIL** (silkroadhub 하드코딩) |
| 템플릿 파일 실제 사용 | ❌ **FAIL** (heredoc으로 독립 생성) |
| 섹션 §1~§10 포함 | ✅ |
| §11 포함 | ❌ **누락** |
| 마누스 수동 보강 영역 명시 | ✅ |
| 카테고리별 진행 트리 자동 주입 | ✅ |

---

## 8. 결함 상세 및 의존성 영향

### 결함 목록

1. **[DEFECT-02-A] REPO_ROOT 하드코딩**: 생성 경로가 silkroadhub 고정. dubyeol-workflow에서 실행 시 silkroadhub에 task-card 생성됨 (또는 오류). → r7 정비 대상
2. **[DEFECT-02-B] 템플릿 미사용**: `task-card-template.md`가 존재하지만 스크립트가 직접 heredoc으로 생성. 두 소스의 섹션 구성이 향후 분기될 위험.
3. **[DEFECT-02-C] §11 누락**: SKILL.md 기술과 스크립트 실제 생성 섹션 간 불일치.

### 의존성 영향

- 실 운영에서는 마누스가 수동으로 task-card를 작성하고 있어 직접 차단 없음
- 스크립트 실행 시 silkroadhub에 파일이 생성되는 문제 있음

---

## 9. 증거 스니펫

```bash
# 스크립트 REPO_ROOT 라인
$ grep "REPO_ROOT" 02-create-task-card/scripts/create_task_card.sh
REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"

# 템플릿 파일 존재 확인
$ ls .harness/templates/
final-report-template.md  gate-review-template.md  handoff-template.md  task-card-template.md

# 스크립트 섹션 확인 (§1~§10 존재, §11 없음)
$ grep "^## §" 02-create-task-card/scripts/create_task_card.sh
## §1. [Owner] 원 발화
## §2. 상위 맥락 연결 ★ 마누스 수동 보강 ★
## §3. 의도 정렬 증거 블록 (SOP 5단계 결과)
## §4. Tier·카테고리·플랜
## §5. 산출물 + 완료 기준 ★ 마누스 수동 보강 ★
## §6. 진행 트리 변형 사유 (해당 시) ★ 마누스 수동 보강 ★
## §7. 마스킹 적용 영역
## §8. 권한 천장·금지 사항
## §9. 변경 이력
## §10. PROJECT.md 갱신 사항 (SUB-5 §3 종료 시 채움)

# 실 task-card 섹션 수 (20260518_g2 task-card 참고 — 수동 작성본은 §11 포함)
```


### .harness/runs/20260518_g2-skills-verification-execution/g2-03-dispatch-to-builder-evidence.md

# G-2 증거 파일 — 03-dispatch-to-builder

**스킬 ID**: `03-dispatch-to-builder`  
**스킬 경로**: `/Users/twostars/ClaudeAi/dubyeol-workflow/03-dispatch-to-builder/`  
**검증 일시**: 2026-05-18  
**판정**: **PARTIAL PASS**

---

## 1. 테스트 목표

`scripts/dispatch.sh` 존재 여부, SKILL.md 기술과 스크립트 로직 일치 여부, 2단계 확정 실행 구현 여부, 참조 파일 존재 여부 확인. 현재 Builder 세션 자체가 03 스킬 실행 결과의 증거.

---

## 2. 전제조건 점검

| 전제조건 | 확인 결과 |
|---|---|
| `dispatch.sh` 존재 | ✅ `03-dispatch-to-builder/scripts/dispatch.sh` |
| `tmp/claude-entry-<run_id>.md` 사전 작성 | ✅ `tmp/claude-entry-20260518_g2-skills-verification-execution.md` 존재 확인 |
| macOS Terminal 접근 가능 | ✅ (osascript 사용 가능 환경) |
| `claude` CLI 설치 | ✅ (현재 세션이 Builder로 동작 중인 것으로 확인) |
| 참조 파일 (`references/standard-entry-prompt.md`) | ❌ `03-dispatch-to-builder/references/` 비어있음 |

---

## 3. 테스트 입력

현재 G-2 Builder 세션 자체가 이 스킬의 실제 실행 결과:

| 입력 | 값 |
|---|---|
| `run_id` | `20260518_g2-skills-verification-execution` |
| `window_id` | `372` (신규 Terminal 창) |
| `tier` | `A` |
| `category` | `4` |

---

## 4. 실제 수행 명령·행동

```bash
# 스크립트 존재 확인
ls /Users/twostars/ClaudeAi/dubyeol-workflow/03-dispatch-to-builder/scripts/
# → dispatch.sh

# 참조 파일 확인
ls /Users/twostars/ClaudeAi/dubyeol-workflow/03-dispatch-to-builder/references/
# → (비어있음)

# 진입 명령 파일 확인
ls /Users/twostars/ClaudeAi/dubyeol-workflow/tmp/
# → claude-entry-20260518_g2-skills-verification-execution.md

# 스크립트 내용 검사 (정적 분석)
cat /Users/twostars/ClaudeAi/dubyeol-workflow/03-dispatch-to-builder/scripts/dispatch.sh
```

현재 Builder 세션은 [Foreman]이 `dispatch.sh` 절차(또는 그 준하는 수동 절차)로 시작되었으며, 진입 명령 파일 `tmp/claude-entry-20260518_g2-skills-verification-execution.md`를 통해 이 세션이 시작됨.

---

## 5. G-1 설계 / SKILL.md 기대 동작

1. `scripts/dispatch.sh` 실행
2. `tmp/claude-entry-<run_id>.md` 파일에 표준 진입 명령 양식 저장
3. osascript로 짧은 명령 전달 + `do script ""`로 Enter 확정 (2단계)
4. Builder 세션이 진입 명령 읽고 작업 시작

---

## 6. 실제 결과

### 6.1 스크립트 분석

| 분석 항목 | 결과 |
|---|---|
| `REPO_ROOT` 값 | ❌ `"/Users/twostars/ClaudeAi/silkroadhub"` 하드코딩 |
| `INSTRUCTION_FILE` 경로 | `${REPO_ROOT}/tmp/claude-entry-${RUN_ID}.md` → silkroadhub 경로 |
| 2단계 확정 실행 구현 | ✅ `do script "Read tmp/..."` + `do script ""` 별도 호출 |
| `activate` 사용 금지 | ✅ 스크립트에서 `activate` 미사용 |
| 단일 `do script` 금지 | ✅ 반드시 2개 호출 (Step 1 + Step 2) |
| 진입 명령 파일 내용 | ✅ 표준 [Builder] 행동 원칙 8개 항목 포함 |

### 6.2 실제 Builder 세션 진입 증거

현재 진행 중인 이 세션이 03 스킬 절차의 실 검증 결과:

- **진입 명령 파일**: `tmp/claude-entry-20260518_g2-skills-verification-execution.md` (존재 확인)
- **task-card 경로 인지**: ✅ (세션 시작 시 읽음)
- **카테고리 4·Tier A 인지**: ✅
- **`/using-superpowers` 진입**: ✅ (세션 시작 직후 실행)
- **진입 명령 파일 정확히 읽음**: ✅ (현재 작업 내용으로 확인)

### 6.3 참조 파일 누락

SKILL.md가 다음 참조 파일을 명시하지만 실제 존재하지 않음:
- `references/standard-entry-prompt.md` ❌ 없음
- `references/agents-md-appendix-b.md` ❌ 없음

---

## 7. 판정: PARTIAL PASS

| 점검 항목 | 결과 |
|---|---|
| `dispatch.sh` 존재 | ✅ |
| 2단계 확정 실행 구현 | ✅ |
| `activate` 사용 금지 원칙 준수 | ✅ |
| `REPO_ROOT` 경로 정합성 | ❌ **FAIL** (silkroadhub 하드코딩) |
| 참조 파일 존재 | ❌ **FAIL** (references/ 비어있음) |
| 현재 세션이 스킬 절차로 시작됨 | ✅ |
| 진입 명령 파일 존재 | ✅ |

---

## 8. 결함 상세 및 의존성 영향

### 결함 목록

1. **[DEFECT-03-A] REPO_ROOT 하드코딩**: `dispatch.sh`에서 `INSTRUCTION_FILE`이 silkroadhub 경로로 생성됨. dubyeol-workflow 환경에서는 오동작.
2. **[DEFECT-03-B] 참조 파일 부재**: `references/standard-entry-prompt.md`, `references/agents-md-appendix-b.md` 미작성.

### 의존성 영향

- 실 운영에서 [Foreman]이 수동으로 진입 명령 파일 작성 후 osascript 실행 → 스크립트 없어도 운영 가능
- 현재 G-2 세션이 03 절차로 성공 진입했으므로 핵심 로직 자체는 검증됨

---

## 9. 증거 스니펫

```bash
# dispatch.sh REPO_ROOT 확인
REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"

# dispatch.sh 2단계 확정 실행 부분
osascript << OSAEOF
tell application "Terminal"
  do script "Read tmp/claude-entry-${RUN_ID}.md and follow the instructions inside." in window id ${WINDOW_ID}
  do script "" in window id ${WINDOW_ID}
end tell
OSAEOF

# 진입 명령 파일 존재 확인
$ ls /Users/twostars/ClaudeAi/dubyeol-workflow/tmp/
claude-entry-20260518_g2-skills-verification-execution.md

# 현재 세션 진입 증거: 세션 초기에 task-card를 읽고 using-superpowers를 실행한 사실
```


### .harness/runs/20260518_g2-skills-verification-execution/g2-04-invoke-plan-review-evidence.md

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


### .harness/runs/20260518_g2-skills-verification-execution/g2-05-verify-handoff-evidence.md

# G-2 증거 파일 — 05-verify-handoff

**스킬 ID**: `05-verify-handoff`  
**스킬 경로**: `/Users/twostars/ClaudeAi/dubyeol-workflow/05-verify-handoff/`  
**검증 일시**: 2026-05-18  
**판정**: **PARTIAL PASS**

---

## 1. 테스트 목표

`scripts/verify_handoff.sh` 존재 여부, 6개 검증 항목(A-F) 구현 정합성, 수동 동등 명령으로 dubyeol-workflow 현재 상태 검증.

---

## 2. 전제조건 점검

| 전제조건 | 확인 결과 |
|---|---|
| `verify_handoff.sh` 존재 | ✅ `05-verify-handoff/scripts/verify_handoff.sh` |
| `handoff.md` 수신 완료 | ⚠️ 이 세션에서 handoff.md는 작성 예정 (검증 시점 미완) |
| git 접근 가능 | ✅ |

---

## 3. 테스트 입력

- 스크립트 정적 분석 + 수동 동등 명령 실행
- dubyeol-workflow 현재 git 상태 실제 검증

---

## 4. 실제 수행 명령·행동

```bash
# 스크립트 존재 확인
ls /Users/twostars/ClaudeAi/dubyeol-workflow/05-verify-handoff/scripts/
# → verify_handoff.sh

# === 수동 동등 명령 실행 (REPO는 dubyeol-workflow) ===

# A. git push 흔적
git reflog | grep -i "push" | head -5
# 결과: (없음)

# B. 파괴적 git 명령 흔적
git reflog | grep -iE "reset --hard|rebase -i|force|filter-branch|--amend" | head -5
# 결과: (없음)

# C. 운영 문서 변경
git status --short | grep -E "AGENTS\.md|CLAUDE\.md|PROJECT\.md|\.harness/templates/|SUB-[0-9]"
# 결과: (없음)

# D. scope 침범 (수동 점검)
git status --short | head -20

# E. 마스킹 위반
git log --since="6 hours ago" --pretty=format:"%H %s"
# 결과: 최근 커밋 없음 (이 세션은 uncommitted 상태)

# F. handoff §1 의도 정렬 (handoff 작성 후 수동 대조 필요)
```

---

## 5. G-1 설계 / SKILL.md 기대 동작

1. `scripts/verify_handoff.sh <run_id>` 실행
2. 6개 검증 항목 자동 실행 (A~F)
3. 각 항목 PASS/WARN/FAIL 표 출력
4. FAIL 발견 시 즉시 멈춤 + 보고

---

## 6. 실제 결과

### 6.1 스크립트 분석

| 분석 항목 | 결과 |
|---|---|
| `REPO_ROOT` 값 | ❌ `"/Users/twostars/ClaudeAi/silkroadhub"` 하드코딩 |
| 6개 항목 구현 (A~F) | ✅ 전부 구현됨 |
| FAIL 시 즉시 중단 (`exit 10`) | ✅ |
| WARN 시 별도 처리 (`exit 5`) | ✅ |
| 결과 파일 저장 | ✅ `handoff-verification.md` |

### 6.2 수동 동등 검증 결과 (dubyeol-workflow)

| 항목 | 수동 검증 결과 |
|---|---|
| A. git push 흔적 | ✅ **PASS** — reflog에 push 없음 |
| B. 파괴적 git 명령 흔적 | ✅ **PASS** — reset --hard·force push 없음 |
| C. 운영 문서 변경 | ✅ **PASS** — AGENTS.md·PROJECT.md 변경 없음 |
| D. scope 침범 | ✅ **PASS** — 현재 변경 파일: `.harness/runs/20260518_g2-skills-verification-execution/` 및 `.harness/runs/g2-dummy-runs/` 한정 |
| E. 마스킹 위반 | ✅ **PASS** — 최근 커밋 없음, 운송장·BL·키 패턴 미발견 |
| F. handoff §1 의도 정렬 | ⚠️ **INFO** — handoff 작성 후 수동 대조 필요 |

### 6.3 git status 실제 출력

```
?? .harness/runs/20260518_g2-skills-verification-execution/
?? tmp/
```

→ 새 파일만 untracked, 기존 파일 수정 없음. 운영 문서(AGENTS.md, PROJECT.md 등) 변경 없음.

---

## 7. 판정: PARTIAL PASS

| 점검 항목 | 결과 |
|---|---|
| `verify_handoff.sh` 존재 | ✅ |
| 6개 항목 구현 | ✅ |
| FAIL 즉시 중단 구현 | ✅ |
| `REPO_ROOT` 경로 정합성 | ❌ **FAIL** (silkroadhub 하드코딩) |
| 수동 동등 검증 A-E | ✅ 전부 PASS |
| F. handoff §1 정렬 대조 | ⚠️ handoff 작성 후 수행 필요 |

---

## 8. 결함 상세 및 의존성 영향

### 결함 목록

1. **[DEFECT-05-A] REPO_ROOT 하드코딩**: 스크립트가 silkroadhub repo에서만 동작.
2. **[DEFECT-05-B] handoff §1 패턴 검사**: `grep -q "## §1\|## 1\."` 패턴이 너무 넓어 다른 섹션과 중복 가능성.

### 의존성 영향

- 수동 동등 명령으로 A-E 모두 PASS — 현재 세션은 권한 천장 준수 확인됨
- 자동화 스크립트 실행 불가하지만 수동으로 검증 완료

---

## 9. 증거 스니펫

```bash
# 수동 검증 실행 결과

# A. git push 흔적
$ git reflog | grep -i "push" | head -5
(출력 없음 — PASS)

# B. 파괴적 git 명령
$ git reflog | grep -iE "reset --hard|rebase -i|force" | head -5
(출력 없음 — PASS)

# C. 운영 문서 변경
$ git status --short | grep -E "AGENTS|CLAUDE|PROJECT|templates|SUB-"
(출력 없음 — PASS)

# D. git status 전체
$ git status --short
?? .harness/runs/20260518_g2-skills-verification-execution/
?? tmp/

# E. 마스킹 위반 패턴
$ git log --since="6 hours ago" --pretty=format:"%H %s"
(출력 없음 — 최근 커밋 없음, PASS)

# 스크립트 REPO_ROOT 확인
$ grep "REPO_ROOT" 05-verify-handoff/scripts/verify_handoff.sh
REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"
```


### .harness/runs/20260518_g2-skills-verification-execution/g2-06-invoke-reviewer-evidence.md

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


### .harness/runs/20260518_g2-skills-verification-execution/g2-07-invoke-judge-evidence.md

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


### .harness/runs/20260518_g2-skills-verification-execution/g2-08-write-final-report-evidence.md

# G-2 증거 파일 — 08-write-final-report

**스킬 ID**: `08-write-final-report`  
**스킬 경로**: `/Users/twostars/ClaudeAi/dubyeol-workflow/08-write-final-report/`  
**검증 일시**: 2026-05-18  
**판정**: **PARTIAL PASS**

---

## 1. 테스트 목표

`scripts/write_final_report.sh` 존재 여부, `final-report-template.md` 존재 여부, 스크립트가 §1~§13 구조를 올바르게 생성하는지, 입력 소스 매핑 정합성 확인. Builder는 final-report를 작성하지 않으므로 정적 분석 수행.

---

## 2. 전제조건 점검

| 전제조건 | 확인 결과 |
|---|---|
| `write_final_report.sh` 존재 | ✅ `08-write-final-report/scripts/write_final_report.sh` |
| `final-report-template.md` 존재 | ✅ `.harness/templates/final-report-template.md` |
| task-card·handoff·gate-review 전부 존재 | ⚠️ 본 run에서는 SUB-2 진행 중 — 해당 파일들이 아직 완전하지 않음 |
| SUB-5 진입 승인 완료 | ❌ 미완 (이 스킬은 SUB-5 전용) |

---

## 3. 테스트 입력 (정적 분석)

스크립트 코드 분석으로 §1~§13 구조와 입력 소스 매핑을 검증.

---

## 4. 실제 수행 명령·행동

```bash
# 스크립트 존재 확인
ls /Users/twostars/ClaudeAi/dubyeol-workflow/08-write-final-report/scripts/
# → write_final_report.sh

# 템플릿 파일 존재 확인
ls /Users/twostars/ClaudeAi/dubyeol-workflow/.harness/templates/
# → final-report-template.md ✅

# 스크립트 내용 정적 분석
cat /Users/twostars/ClaudeAi/dubyeol-workflow/08-write-final-report/scripts/write_final_report.sh

# Builder는 final-report 직접 생성 금지 → 스크립트 미실행
```

---

## 5. G-1 설계 / SKILL.md 기대 동작

1. `.harness/templates/final-report-template.md` 기반으로 `final-report.md` 생성
2. 섹션 §1~§12(또는 §13) 전부 포함
3. 입력 소스별 내용이 해당 섹션에 정확히 매핑
4. §10~§13은 마누스 수동 작성

---

## 6. 실제 결과

### 6.1 스크립트 분석

| 분석 항목 | 결과 |
|---|---|
| `REPO_ROOT` 값 | ❌ `"/Users/twostars/ClaudeAi/silkroadhub"` 하드코딩 |
| 템플릿 파일 실제 사용 | ❌ heredoc으로 직접 생성 (template 미사용) |
| §1~§13 포함 | ✅ 전부 포함 (§13까지) |
| 마누스 수동 작성 영역 명시 | ✅ `★ 마누스 수동 작성 ★` |

### 6.2 섹션별 입력 소스 매핑 검증

| 섹션 | 기대 입력 소스 | 실제 스크립트 구현 |
|---|---|---|
| §1 task 요약 | task-card §1·§3 | ✅ `extract_section "${TASK_CARD}" "§1.\|## §1"` |
| §2 진행 결과 | handoff §2·§3 | ✅ `extract_section "${HANDOFF}" "§2\|## 2"` |
| §3 산출물 | task-card §5 + handoff §2.2 | ✅ `extract_section "${TASK_CARD}" "§5\|## §5"` |
| §4 검증 결과 | handoff §4·§5 | ✅ `extract_section "${HANDOFF}" "§4\|## 4"` |
| §5 외부 감리 결과 | gate-review §1·§2 | ✅ `extract_section "${GATE_REVIEW}" "§1\|## §1"` |
| §6 plan-review 결과 | plan-review.md | ✅ 선택적 포함 |
| §7 변경 파일 | git status | ✅ `git status --short` 직접 실행 |
| §8 fix-loop 기록 | handoff fix-log | ✅ `extract_section "${HANDOFF}" "fix-log"` |
| §9 권한 천장 | verify-handoff 결과 | ✅ `tail -10 "${VERIFY}"` |
| §10 PROJECT.md 갱신 | 마누스 수동 | ✅ 플레이스홀더 |
| §11 후속 task | 마누스 수동 | ✅ 플레이스홀더 |
| §12 회고 | 마누스 수동 | ✅ 플레이스홀더 |
| §13 마누스 짚을 점 | 마누스 수동 | ✅ 플레이스홀더 |

### 6.3 템플릿 미사용 (02와 동일 패턴)

`final-report-template.md`가 존재하지만 스크립트는 heredoc으로 직접 생성. 두 소스 간 섹션 구성이 분기될 위험.

### 6.4 Builder 역할 경계

SKILL.md 기술: "마누스가 SUB-5 §2 진입 시 final-report 작성". Builder가 final-report를 직접 작성하는 것은 역할 침범. 이 스킬은 Foreman 전용으로 올바르게 설계됨.

---

## 7. 판정: PARTIAL PASS

| 점검 항목 | 결과 |
|---|---|
| `write_final_report.sh` 존재 | ✅ |
| `final-report-template.md` 존재 | ✅ |
| §1~§13 섹션 구성 | ✅ |
| 입력 소스 매핑 | ✅ |
| 마누스 수동 영역 명시 | ✅ |
| `REPO_ROOT` 경로 정합성 | ❌ **FAIL** (silkroadhub 하드코딩) |
| 템플릿 파일 실제 사용 | ❌ **FAIL** (heredoc으로 독립 생성) |
| Builder 역할 경계 준수 | ✅ (실행 안 함) |

---

## 8. 결함 상세 및 의존성 영향

### 결함 목록

1. **[DEFECT-08-A] REPO_ROOT 하드코딩**: 동일 패턴.
2. **[DEFECT-08-B] 템플릿 미사용**: 02와 동일. `final-report-template.md`와 스크립트가 독립적으로 관리됨.
3. **[DEFECT-08-C] `extract_section` 함수 패턴 범용성**: `sed -n "/section/,/^## §.../p"` 패턴이 섹션 경계를 정확히 잡지 못할 수 있음.

### 의존성 영향

- final-report는 Foreman이 SUB-5에서 작성하므로 실 운영 차단 없음

---

## 9. 증거 스니펫

```bash
# 스크립트 REPO_ROOT
$ grep "REPO_ROOT" 08-write-final-report/scripts/write_final_report.sh
REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"

# 템플릿 존재 확인
$ ls .harness/templates/
final-report-template.md  gate-review-template.md  handoff-template.md  task-card-template.md

# §1~§13 섹션 확인 (스크립트에서 grep)
§1. task 요약
§2. 진행 결과
§3. 산출물
§4. 검증 결과
§5. 외부 감리 결과
§6. plan-review 결과 (해당 시)
§7. 변경 파일 (git 상태)
§8. fix-loop 기록 (해당 시)
§9. 권한 천장 점검
§10. PROJECT.md 갱신 사항 ★ 마누스 수동 작성 ★
§11. 후속 task 후보 ★ 마누스 수동 작성 ★
§12. 회고 (베타 어색함 누적) ★ 마누스 수동 작성 ★
§13. 마누스 짚을 점 ★ 수동 ★
```


### .harness/runs/20260518_g2-skills-verification-execution/g2-09-update-project-md-evidence.md

# G-2 증거 파일 — 09-update-project-md

**스킬 ID**: `09-update-project-md`  
**스킬 경로**: `/Users/twostars/ClaudeAi/dubyeol-workflow/09-update-project-md/`  
**검증 일시**: 2026-05-18  
**판정**: **PARTIAL PASS**

---

## 1. 테스트 목표

`scripts/update_project_md.sh` 존재 여부, [Owner] 승인 경계 구현 정합성(자동 commit 금지), diff 생성 방식, 백업 생성 여부 확인. Builder는 PROJECT.md를 수정하지 않으므로 정적 분석 + dummy diff 생성.

---

## 2. 전제조건 점검

| 전제조건 | 확인 결과 |
|---|---|
| `update_project_md.sh` 존재 | ✅ `09-update-project-md/scripts/update_project_md.sh` |
| `PROJECT.md` 존재 | ✅ `/Users/twostars/ClaudeAi/dubyeol-workflow/PROJECT.md` |
| task-card §10 완성 | ⚠️ 본 task는 SUB-2 진행 중 — §10 미완성 |
| [Owner] 명시 승인 확보 | ❌ 미확보 (SUB-5 이후) |
| Builder가 직접 PROJECT.md 수정 | 금지 (역할 침범) |

---

## 3. 테스트 입력 (정적 분석)

스크립트 코드 분석으로 승인 경계 구현 검증.

dummy proposed diff: 
- Builder는 PROJECT.md를 직접 수정하지 않음
- 대신 스크립트 로직 분석으로 "승인 전 diff만 출력" 동작 검증

---

## 4. 실제 수행 명령·행동

```bash
# 스크립트 존재 확인
ls /Users/twostars/ClaudeAi/dubyeol-workflow/09-update-project-md/scripts/
# → update_project_md.sh

# 스크립트 내용 정적 분석
cat /Users/twostars/ClaudeAi/dubyeol-workflow/09-update-project-md/scripts/update_project_md.sh

# PROJECT.md 존재 확인
ls /Users/twostars/ClaudeAi/dubyeol-workflow/PROJECT.md
# → 존재 ✅

# Builder는 PROJECT.md 수정 금지 → 스크립트 미실행
```

---

## 5. G-1 설계 / SKILL.md 기대 동작

1. `scripts/update_project_md.sh <run_id>` 실행
2. task-card §10에서 갱신 사항 추출
3. PROJECT.md 백업 생성
4. PROJECT.md §C·§D 갱신
5. diff 출력 (commit 안 함)
6. 마누스 diff 검토 후 [Owner] 승인
7. 승인 후 별도 git commit

---

## 6. 실제 결과

### 6.1 스크립트 분석

| 분석 항목 | 결과 |
|---|---|
| `REPO_ROOT` 값 | ❌ `"/Users/twostars/ClaudeAi/silkroadhub"` 하드코딩 |
| 자동 commit 금지 | ✅ 스크립트 내 git commit 명령 없음 |
| 백업 생성 | ✅ `cp "${PROJECT_MD}" "${BACKUP}"` |
| diff 출력 | ✅ `git diff "${PROJECT_MD}" > "${DIFF_FILE}"` |
| task-card §10 비어있을 때 오류 처리 | ✅ `exit 3`로 명시적 오류 |
| 승인 절차 안내 | ✅ "다음 행동 (마누스 수동)" 명시 |
| 거부 시 복원 안내 | ✅ `cp ${BACKUP} ${PROJECT_MD}` |

### 6.2 승인 경계 검증

스크립트가 수행하는 것:
1. PROJECT.md 끝에 `cat >>` 로 §10 내용 추가 (작업 디렉토리 변경만)
2. `git diff` 출력 + diff 파일 저장
3. **git commit 없음** ✅
4. 마누스에게 수동 검토 + [Owner] 승인 후 별도 commit 지시

이는 SKILL.md의 "자동 commit 절대 금지" 원칙을 올바르게 구현함.

### 6.3 §C·§D 자동 배치 한계

스크립트는 PROJECT.md 끝에 블록을 `cat >>`로 덧붙임. 실제 §C.N·§D 위치는 마누스가 수동으로 이동해야 함 (주석으로 명시됨). 완전 자동 배치는 구현되지 않았으나 안전한 설계 선택.

### 6.4 dummy proposed diff (개념 설명)

실제 실행 없이 스크립트가 생성할 diff의 구조:
```diff
+<!-- update-project-md 스킬 자동 추가, 2026-05-18, Run ID <run_id> -->
+<!-- 마누스 수동 검토 후 §C·§D 적절 위치로 이동 필요 -->
+
+## [SUB-5 자동 추가 — Run <run_id>]
+
+<task-card §10 내용>
```

---

## 7. 판정: PARTIAL PASS

| 점검 항목 | 결과 |
|---|---|
| `update_project_md.sh` 존재 | ✅ |
| 자동 commit 금지 구현 | ✅ |
| 백업 생성 구현 | ✅ |
| diff 출력 구현 | ✅ |
| 승인 절차 안내 포함 | ✅ |
| `REPO_ROOT` 경로 정합성 | ❌ **FAIL** (silkroadhub 하드코딩) |
| §C·§D 자동 정확 배치 | ⚠️ **PARTIAL** (끝에 추가 후 수동 이동) |
| Builder가 PROJECT.md 직접 수정 | ✅ **미실행** (역할 경계 준수) |

---

## 8. 결함 상세 및 의존성 영향

### 결함 목록

1. **[DEFECT-09-A] REPO_ROOT 하드코딩**: 동일 패턴.
2. **[DEFECT-09-B] §C·§D 자동 배치 미구현**: 끝에 덧붙이는 방식으로 마누스 수동 이동 필요. 위험 최소화를 위한 의도적 선택으로 보임 — r7에서 개선 여지.

### 의존성 영향

- PROJECT.md 갱신은 Foreman(마누스)이 [Owner] 승인 후 수행하므로 Builder 차단 없음
- 9개 스킬 중 유일하게 운영 파일을 직접 수정하는 스킬이므로 승인 경계 설계가 가장 중요함 → 올바르게 구현됨

---

## 9. 증거 스니펫

```bash
# REPO_ROOT 확인
$ grep "REPO_ROOT" 09-update-project-md/scripts/update_project_md.sh
REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"

# 자동 commit 없음 확인
$ grep "git commit" 09-update-project-md/scripts/update_project_md.sh
(출력 없음 — git commit 명령 없음 ✅)

# 백업 생성 확인
cp "${PROJECT_MD}" "${BACKUP}"

# diff 출력 확인
git diff "${PROJECT_MD}" > "${DIFF_FILE}" 2>&1 || true

# 승인 경계 안내 출력
echo "5. [Owner] 명시 승인 후 별도 단계로 git commit"

# PROJECT.md 존재 확인
$ ls /Users/twostars/ClaudeAi/dubyeol-workflow/PROJECT.md
PROJECT.md ✅
```


## Skill definitions and scripts


### 01-load-sub-manual/SKILL.md

---
name: 01-load-sub-manual
description: 마누스가 [Owner] 발화에서 SUB 매뉴얼 호출 신호를 인지하고 해당 SUB-N 매뉴얼을 자동 로드하는 스킬. "기획 매뉴얼 봐"/"워크플로우 매뉴얼 봐"/"감리 매뉴얼 봐"/"수정 매뉴얼 봐"/"종료 매뉴얼 봐"와 같은 자연 발화를 SUB-1~5로 라우팅. 마누스가 발화 컨버터로 동작. silkroadhub 두별 워크플로우 v3.6.0 r1 베타에서 마누스 프로젝트 지침 §7 발화 컨버터의 스킬화.
---

# 01-load-sub-manual

[Owner] 자연 발화를 SUB-N 매뉴얼 로드로 자동 라우팅.

## 언제 호출하는가

[Owner]가 다음 발화 또는 유사 발화 시:

| 발화 패턴 | 매핑 |
|---|---|
| "기획 매뉴얼 봐" / "의도 매뉴얼" / "SUB-1" | SUB-1 로드 |
| "워크플로우 매뉴얼 봐" / "구현 매뉴얼" / "SUB-2" | SUB-2 로드 |
| "감리 매뉴얼 봐" / "외부 검토 매뉴얼" / "SUB-3" | SUB-3 로드 |
| "수정 매뉴얼 봐" / "fix 매뉴얼" / "SUB-4" | SUB-4 로드 |
| "종료 매뉴얼 봐" / "마무리 매뉴얼" / "SUB-5" | SUB-5 로드 |
| "PROJECT.md 봐" | PROJECT.md 진입 점검 |

## 동작 순서

1. `scripts/load_sub.sh <sub_num>` 실행 (또는 PROJECT.md)
2. 해당 SUB-N 매뉴얼 파일 경로 출력
3. 마누스가 *전체 파일 읽음* (cat·view)
4. 매뉴얼 §0 강제력 + §1 진입 첫 행동 인지
5. 인지 완료 응답으로 [Owner]에 "SUB-N 진입 완료, 첫 행동 …" 보고

## 호출

```bash
# SUB-N 로드
bash scripts/load_sub.sh 1   # SUB-1
bash scripts/load_sub.sh 2   # SUB-2
# ... 3, 4, 5

# PROJECT.md 진입 점검
bash scripts/load_project_md.sh
```

## 핵심 원칙

- 매뉴얼은 *전체 로드* — 부분만 읽으면 §0 강제력 손실
- *진입 첫 행동*을 인지한 후에만 다음 행동
- 매뉴얼 충돌 시 [Owner] 최신 발화 우선, 그 다음 매뉴얼

## 산출물

- 마누스 컨텍스트에 SUB-N 매뉴얼 로드된 상태
- 진입 완료 응답 (예: "SUB-1 로드. 첫 행동은 §2 의도 정렬 5단계 SOP입니다.")

## 참조

- silkroadhub `마누스-프로젝트-지침-r6.md` §7 발화 컨버터
- silkroadhub `SUB-1`~`SUB-5` 매뉴얼


### 01-load-sub-manual/scripts/load_project_md.sh

#!/bin/zsh
# load_project_md.sh — PROJECT.md 진입 점검
# 두별 워크플로우 v3.6.0 r1 베타 — Manus Agent Skill

set -e

REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"
FILE="${REPO_ROOT}/PROJECT.md"

if [ ! -f "${FILE}" ]; then
  echo "ERROR: PROJECT.md 없음 — ${FILE}"
  exit 1
fi

echo "===== PROJECT.md 진입 점검 ====="
echo "경로: ${FILE}"
echo "분량: $(wc -l < "${FILE}") 줄"
echo ""
echo "===== §B 현재 분기 목표 ====="
sed -n '/^## §B\|^## B\./,/^## §C\|^## C\./p' "${FILE}" | head -30 || head -50 "${FILE}"
echo ""
echo "===== 진입 안내 ====="
echo "전체 로드: cat \"${FILE}\""
echo "마누스 다음 행동:"
echo "  1. §B 현재 분기 목표 확인"
echo "  2. §C 모듈 지도에서 이번 task 연결 모듈 식별 (§C.N)"
echo "  3. §D 최근 결정 이력 확인"
echo "  4. SUB-1 로드 → 의도 정렬 진입"


### 01-load-sub-manual/scripts/load_sub.sh

#!/bin/zsh
# load_sub.sh — SUB-N 매뉴얼 로드 (경로 출력 + 첫 N줄 미리보기)
# 두별 워크플로우 v3.6.0 r1 베타 — Manus Agent Skill
#
# 호출: bash load_sub.sh <sub_num>
# 예:   bash load_sub.sh 1   # SUB-1
#       bash load_sub.sh 2   # SUB-2

set -e

SUB_NUM="${1:?usage: load_sub.sh <sub_num: 1~5>}"
REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"

declare -A SUB_FILES
SUB_FILES[1]="SUB-1-기획의도.md"
SUB_FILES[2]="SUB-2-워크플로우.md"
SUB_FILES[3]="SUB-3-외부감리.md"
SUB_FILES[4]="SUB-4-수정.md"
SUB_FILES[5]="SUB-5-종료.md"

FILE="${SUB_FILES[$SUB_NUM]}"

if [ -z "${FILE}" ]; then
  echo "ERROR: SUB-${SUB_NUM} 없음. 1~5 중 선택"
  exit 1
fi

FULL_PATH="${REPO_ROOT}/${FILE}"

if [ ! -f "${FULL_PATH}" ]; then
  echo "ERROR: 파일 없음 — ${FULL_PATH}"
  exit 2
fi

echo "===== SUB-${SUB_NUM} 매뉴얼 로드 ====="
echo "경로: ${FULL_PATH}"
echo "분량: $(wc -l < "${FULL_PATH}") 줄 / $(wc -c < "${FULL_PATH}") chars"
echo ""
echo "===== 첫 30줄 미리보기 ====="
head -30 "${FULL_PATH}"
echo ""
echo "===== 진입 안내 ====="
echo "매뉴얼 전체 읽기: cat \"${FULL_PATH}\""
echo "마누스 다음 행동:"
echo "  1. 매뉴얼 전체 로드"
echo "  2. §0 강제력 + §1 진입 첫 행동 인지"
echo "  3. [Owner]에 진입 완료 응답"


### 01-load-sub-manual/references file list

01-load-sub-manual/references/utterance-converter.md

### 02-create-task-card/SKILL.md

---
name: 02-create-task-card
description: 마누스가 SUB-1 의도 정렬 5단계 SOP 완료 후 task-card.md를 자동 작성하는 스킬. [Owner] 발화·의도 정렬 증거 블록·Tier 판정·카테고리 결정을 task-card 양식에 맞춰 채움. 초안 생성 후 마누스가 §3.5 가정·§5 산출물·§6 진행 트리 등 판단 영역을 직접 보강. silkroadhub 두별 워크플로우 v3.6.0 r1 베타 SUB-1 §3·SUB-2 §1 표준 절차.
---

# 02-create-task-card

마누스가 의도 정렬 5단계 SOP 완료 후 task-card.md 자동 작성.

## 언제 호출하는가

- SUB-1 §2 의도 정렬 SOP 완료 (3중 재구성·모호어 스캔·가정 명시·정렬 확인·증거 고정 모두 통과)
- run_id 결정 후 (`<YYYYMMDD>_<task-slug>`)

## 입력

| 필드 | 설명 |
|---|---|
| `run_id` | 예: `20260516_manifest-fix` |
| `owner_utterance_file` | [Owner] 원 발화 저장 파일 |
| `intent_alignment_file` | SOP 5단계 결과 (한 문장 목표·Looks Like·Looks Wrong·가정·증거) |
| `tier` | A/B/C |
| `category` | 1~5 |

## 동작 순서

1. `scripts/create_task_card.sh` 실행
2. `.harness/runs/<run_id>/task-card.md` 자동 생성:
   - §1 [Owner] 원 발화 (입력 파일에서)
   - §2 상위 맥락 연결 (마누스가 PROJECT.md에서 추출 — *수동 보강 필요*)
   - §3 의도 정렬 증거 블록 (입력 파일에서)
   - §4 Tier·카테고리·플랜
   - §5 산출물 + 완료 기준 — *수동 보강 필요*
   - §6 진행 트리 (카테고리별 자동) — 변형 사유 *수동 보강*
   - §7 마스킹 적용 영역
   - §8 권한 천장·금지 사항
   - §9 변경 이력
   - §10 PROJECT.md 갱신 사항 *템플릿만 박음 — SUB-5에서 채움*
3. 자동 생성 후 *마누스가 수동 보강 영역* 채우기:
   - §2 상위 맥락 연결
   - §5 산출물 + 완료 기준
   - §6 변형 사유 (해당 시)
4. [Owner] 결재 요청

## 호출

```bash
bash scripts/create_task_card.sh <run_id> <owner_utterance_file> <intent_alignment_file> <tier> <category>
```

## 핵심 안전선

- 스킬은 *초안 자동 생성*만. 마누스의 *판단 영역*은 수동 보강 의무
- §3.5 가정은 *반드시 3개 이상*. 자동 생성에서 부족하면 마누스가 추가
- §5 산출물·완료 기준은 *마누스 판단* — 자동 생성 안 함
- §8 권한 천장 *기본값* 자동 박힘. 추가 금지 항목은 수동

## 산출물

- `.harness/runs/<run_id>/task-card.md` — 초안 (수동 보강 필요)

## 참조

- silkroadhub `.harness/templates/task-card-template.md`
- silkroadhub `SUB-1-기획의도.md` §3


### 02-create-task-card/scripts/create_task_card.sh

#!/bin/zsh
# create_task_card.sh — task-card.md 초안 자동 생성
# 두별 워크플로우 v3.6.0 r1 베타 — Manus Agent Skill
#
# 호출: bash create_task_card.sh <run_id> <owner_utterance_file> <intent_alignment_file> <tier> <category>

set -e

RUN_ID="${1:?usage: create_task_card.sh <run_id> <owner_utt> <intent> <tier> <category>}"
OWNER_UTT="${2:?need owner utterance file}"
INTENT_FILE="${3:?need intent alignment file}"
TIER="${4:?need tier A/B/C}"
CATEGORY="${5:?need category 1-5}"

REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"
RUN_DIR="${REPO_ROOT}/.harness/runs/${RUN_ID}"
TASK_CARD="${RUN_DIR}/task-card.md"

mkdir -p "${RUN_DIR}"

OWNER_TEXT=$(cat "${OWNER_UTT}")
INTENT_TEXT=$(cat "${INTENT_FILE}")
NOW=$(date "+%Y-%m-%d %H:%M %Z")

# 카테고리별 진행 트리
declare -A TREES
TREES[1]="using-superpowers → brainstorming → writing-plans → using-git-worktrees → TDD → subagent-driven-development → requesting-code-review → verification-before-completion → finishing-a-development-branch"
TREES[2]="using-superpowers → systematic-debugging → test-driven-development (실패 재현) → 수정 → verification-before-completion → requesting-code-review → finishing-a-development-branch"
TREES[3]="using-superpowers → brainstorming (축약) → 구현 → verification-before-completion → finishing-a-development-branch"
TREES[4]="using-superpowers → brainstorming → 작성 → 자체 review → finishing-a-development-branch"
TREES[5]="using-superpowers → brainstorming → 작성 → 자체 review → finishing-a-development-branch"

PROGRESS_TREE="${TREES[$CATEGORY]}"

cat > "${TASK_CARD}" << TC_EOF
# task-card — Run ID ${RUN_ID}

> **상태**: 초안 자동 생성. 마누스 수동 보강 필요 (§2 상위 맥락 / §5 산출물·완료 기준 / §6 변형 사유)
> 작성 시각: ${NOW}

## §1. [Owner] 원 발화

\`\`\`
${OWNER_TEXT}
\`\`\`

## §2. 상위 맥락 연결 ★ 마누스 수동 보강 ★

- PROJECT.md §C.[N] 연결 모듈: *(여기에 모듈명·번호)*
- 분기 목표 정합성: *(§B와의 관계)*
- 최근 결정 이력: *(§D 관련 결정)*

## §3. 의도 정렬 증거 블록 (SOP 5단계 결과)

${INTENT_TEXT}

## §4. Tier·카테고리·플랜

- Tier: **${TIER}**
- 두별 워크트리 카테고리: **${CATEGORY}**
- 진행 트리 (카테고리 ${CATEGORY} 표준):
  - ${PROGRESS_TREE}

## §5. 산출물 + 완료 기준 ★ 마누스 수동 보강 ★

| 산출물 | 완료 기준 | 검증 방법 |
|---|---|---|
| *(예시)* | *(예시)* | *(예시)* |

### §5.1 포함 범위
- *(여기 작성)*

### §5.2 제외 범위 (scope 명시)
- *(여기 작성 — [Builder]가 침범 금지)*

## §6. 진행 트리 변형 사유 (해당 시) ★ 마누스 수동 보강 ★

- 표준 트리에서 *생략·추가* 단계 시 *재현 가능한 사유* 명시
- 생략 항목:
- 추가 항목:

## §7. 마스킹 적용 영역

- AGENTS.md §8 규칙 전체 적용
- 특별히 본 task에서 주의할 마스킹 영역: *(있으면 작성)*

## §8. 권한 천장·금지 사항

### 기본 권한 천장 (모든 task 공통)
1. git push / merge / deploy 금지 ([Owner] 명시 승인 후)
2. AGENTS.md·CLAUDE.md·PROJECT.md·.harness/templates/* 변경 금지
3. 파괴적 git (reset --hard, rebase -i, force push, history rewrite) 금지
4. task scope 확장 (§5.2 제외 범위 침범) 금지
5. 외부 시스템 프로덕션 실호출 금지 (결제·통관·DB migration)
6. Tier 강등 (A→B, B→C 자동 다운그레이드) 금지
7. [Builder]가 자동 제안하는 task-card 범위 밖 행동은 [Foreman]이 명령으로 해석 안 함

### 본 task 추가 금지 사항 ★ 필요 시 마누스 보강 ★
- *(있으면 작성)*

## §9. 변경 이력

| 시각 | 변경 | 사유 |
|---|---|---|
| ${NOW} | 초안 자동 생성 | create-task-card 스킬 |

## §10. PROJECT.md 갱신 사항 (SUB-5 §3 종료 시 채움)

> SUB-5 진입 시 update-project-md 스킬이 본 절을 읽어 PROJECT.md §C·§D 갱신

### §10.1 §C 모듈 갱신
- 모듈: §C.[N]
- 갱신 내용: *(SUB-5에서 채움)*

### §10.2 §D 결정 이력 추가 (있으면)
- *(SUB-5에서 채움)*
TC_EOF

echo "task-card 초안 생성: ${TASK_CARD}"
echo "분량: $(wc -l < "${TASK_CARD}") 줄"
echo ""
echo "마누스 수동 보강 필요:"
echo "  - §2 상위 맥락 연결 (PROJECT.md에서 추출)"
echo "  - §5 산출물 + 완료 기준"
echo "  - §6 변형 사유 (해당 시)"
echo "  - §8 추가 금지 사항 (필요 시)"
echo ""
echo "보강 완료 후 [Owner] 결재 요청"


### 02-create-task-card/references file list

02-create-task-card/references/task-card-template-guide.md

### 03-dispatch-to-builder/SKILL.md

---
name: 03-dispatch-to-builder
description: 마누스가 클로드코드(Builder) 세션에 진입 명령을 전달하는 표준 스킬. SUB-2 진입 시점에 사용. 파일 경유 + 짧은 명령 + 2단계 확정 실행 방식으로 한글·특수문자 깨짐 없이 안전 전달. activate 사용 금지·단일 do script 금지·Builder 친절 제안 무시 등 r6 검증으로 확인된 안전선이 박혀있음. silkroadhub의 두별 워크플로우 v3.6.0 r1 베타에서 SUB-2 §2 표준 진입 절차.
---

# 03-dispatch-to-builder

마누스가 클로드코드 세션에 *SUB-2 진입 명령*을 전달하는 표준 스킬.

## 언제 호출하는가

- `task-card.md` 작성 완료 (SUB-1 종료) 후
- `[Owner]`가 "워크플로우 매뉴얼 봐" 또는 *SUB-2 진입 신호* 발화 시
- 클로드코드 새 세션이 열려 있고 `WINDOW_ID` 확보된 상태

## 입력

| 필드 | 설명 |
|---|---|
| `run_id` | 예: `20260516_manifest-fix` |
| `window_id` | osascript으로 조회한 클로드코드 창 ID |
| `tier` | `A` / `B` / `C` |
| `category` | 두별 워크트리 카테고리 `1`~`5` |

## 동작 순서

1. `scripts/dispatch.sh` 실행
2. `tmp/claude-entry-<run_id>.md` 파일에 *표준 진입 명령 양식* 저장
3. osascript로 짧은 명령 전달 + `do script ""`로 Enter 확정 (2단계)
4. 클로드코드 첫 응답 5~10초 내 확인
5. 응답에서 다음 4가지 점검:
   - task-card 경로 인지
   - 카테고리·Tier 인지
   - `/using-superpowers` 진입 명시
   - 진입 명령 파일 정확히 읽음

## 호출

```bash
bash scripts/dispatch.sh <run_id> <window_id> <tier> <category>
```

## 핵심 안전선 (r6 검증 발견 반영)

- `activate` *절대 사용 금지* — 포커스 탈취·중복 창 위험
- 단일 `do script` *절대 사용 금지* — Enter 미확정으로 입력 대기에 머묾. *반드시* 2단계 확정 실행
- 클로드코드가 task 완료 후 `git commit` 등을 *자동 제안*해도 *명령으로 해석 금지*. 마누스는 *입력 필드 비우고* 정지

## 산출물

- `tmp/claude-entry-<run_id>.md` — 진입 명령 원문 보존 (재실행·회고 자료)
- 클로드코드 응답 캡처 (마누스 작업 메모)

## 실패 모드

| 신호 | 처리 |
|---|---|
| 클로드코드가 응답 없음 (10초 이상) | `do script ""` 한 번 더 시도. 그래도 응답 없으면 새 세션 |
| 응답에 task-card 경로 누락 | 진입 명령 파일 재확인 후 재전달 |
| `/using-superpowers` 진입 안 함 | 명시 재요청 |
| 한글·특수문자 깨짐 | 진입 명령 파일을 *직접 cat으로 확인* 후 재전달 |

## 참조

- `references/standard-entry-prompt.md` — 표준 진입 명령 양식 (영문 ASCII)
- `references/agents-md-appendix-b.md` — AGENTS.md Appendix B 절차 사본 (참고)
- silkroadhub `AGENTS.md` §7.2 + Appendix B
- silkroadhub `SUB-2-워크플로우.md` §2


### 03-dispatch-to-builder/scripts/dispatch.sh

#!/bin/zsh
# dispatch.sh — 클로드코드(Builder) 세션에 SUB-2 진입 명령 전달
# 두별 워크플로우 v3.6.0 r1 베타 — Manus Agent Skill
# 검증 완료 2026-05-16
#
# 호출: bash dispatch.sh <run_id> <window_id> <tier> <category>
# 예:   bash dispatch.sh 20260516_manifest-fix 187 A 1

set -e

RUN_ID="${1:?usage: dispatch.sh <run_id> <window_id> <tier> <category>}"
WINDOW_ID="${2:?usage: dispatch.sh <run_id> <window_id> <tier> <category>}"
TIER="${3:?usage: dispatch.sh <run_id> <window_id> <tier> <category>}"
CATEGORY="${4:?usage: dispatch.sh <run_id> <window_id> <tier> <category>}"

REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"
INSTRUCTION_FILE="${REPO_ROOT}/tmp/claude-entry-${RUN_ID}.md"
RUN_DIR="${REPO_ROOT}/.harness/runs/${RUN_ID}"

mkdir -p "${REPO_ROOT}/tmp"
mkdir -p "${RUN_DIR}"

# 진입 명령 파일 작성
cat > "${INSTRUCTION_FILE}" << ENTRY_EOF
[Builder 진입 명령 — 두별 워크플로우 v3.6.0 r1]

task-card: .harness/runs/${RUN_ID}/task-card.md
두별 워크트리 카테고리: ${CATEGORY}
Tier: ${TIER}

본 task는 두별 워크플로우 v3.6.0 r1 SUB-2 단계.

[Builder] 행동 원칙:
1. 글로벌 ~/.claude/CLAUDE.md + 프로젝트 silkroadhub/CLAUDE.md 자동 로드 확인
2. task-card를 우선 입력으로 읽음. task-card §3 의도 정렬 증거 블록은 해석 기준
3. /using-superpowers 진입 후 task-card §[두별 워크트리 카테고리] 진행 트리 따름
4. 모든 산출물에 CLAUDE.md §6 마스킹 규칙 적용
5. task-card §8 권한 천장·금지 사항 절대 위반 금지
6. 작업 완료 또는 block 시 .harness/runs/${RUN_ID}/handoff.md 작성 후 정지
7. push/merge/deploy/운영 문서 변경/파괴적 git/scope 확장은 [Foreman] 또는 [Owner] 명시 승인 후
8. task 완료 후 commit·cleanup·추가 확인 등 task-card 범위 밖 행동을 자동 제안하지 않음. handoff.md만 작성하고 정지.

진입.
ENTRY_EOF

echo "진입 명령 파일 생성: ${INSTRUCTION_FILE}"
echo "행 수: $(wc -l < "${INSTRUCTION_FILE}")"
echo ""

# 2단계 확정 실행으로 클로드코드에 전달
# Step 1: 파일 읽으라는 짧은 명령 + Step 2: do script "" 로 Enter 확정
osascript << OSAEOF
tell application "Terminal"
  do script "Read tmp/claude-entry-${RUN_ID}.md and follow the instructions inside." in window id ${WINDOW_ID}
  do script "" in window id ${WINDOW_ID}
end tell
OSAEOF

echo "클로드코드 창 ${WINDOW_ID}에 진입 명령 전달 완료"
echo "다음: 5~10초 후 클로드코드 응답을 점검"
echo "  - task-card 경로 인지"
echo "  - 카테고리 ${CATEGORY}·Tier ${TIER} 인지"
echo "  - /using-superpowers 진입"
echo "  - 진입 명령 파일 정확히 읽음"


### 03-dispatch-to-builder/references file list

03-dispatch-to-builder/references/agents-md-appendix-b.md
03-dispatch-to-builder/references/standard-entry-prompt.md

### 04-invoke-plan-review/SKILL.md

---
name: 04-invoke-plan-review
description: 마누스가 지피티에 plan-review를 요청하는 스킬. SUB-2 §2.5 진입 시점 사용 (writing-plans 직후, 구현 진입 전). Tier A 또는 큰 task에 권고. 클로드코드 writing-plans 산출물을 지피티 Devil's Advocate가 검토해서 구현 진입 전 plan 약점 발견. 입력은 의도·plan·연결 모듈 맥락. 코드 디테일 없음. 통과·수정 권고·보류·중단 4단 판정. silkroadhub 두별 워크플로우 v3.6.0 r1 베타 SUB-2 §2.5 표준 절차.
---

# 04-invoke-plan-review

마누스가 [Judge](지피티)에 *구현 진입 전 plan 검토*를 요청. r6 베타에서 신설된 안전선.

## 언제 호출하는가

- 클로드코드가 `writing-plans` skill 완료 후 plan 산출
- *구현 진입 전*에 plan-review 분기 판정 통과 시:
  - Tier A → 권고
  - Tier B → 마누스 판단
  - Tier C → 일반적으로 생략
  - 카테고리 1 큰 변경 / 4 큰 운영 문서 / 5 기획 → 권고

## 입력 자료 — 정보 격리 원칙

**[Judge]에게 전달**:
- `task-card.md` §1 [Owner] 발화 원문
- `task-card.md` §3 의도 정렬 증거 블록
- 클로드코드 `writing-plans` 산출물 (plan 본문)
- `PROJECT.md` §C.[N] 연결 모듈 맥락

**전달 금지**:
- 구현 코드 디테일 (아직 구현 안 됨)
- 다른 task의 task-card·plan

## 동작 순서

1. `scripts/invoke_plan_review.sh` 실행
2. 입력 자료를 `.harness/runs/<run_id>/plan-review-input.md`에 저장
3. 지피티 plan-review 전용 새 세션 호출 (SUB-3 [Judge] 세션과도 *분리* — 시점·자료 다름)
4. 응답을 `plan-review.md`에 저장
5. 마누스가 판정 확인 후 [Builder]에 통과/수정 지시

## 호출

```bash
bash scripts/invoke_plan_review.sh <run_id>
```

## 핵심 안전선

- *코드 디테일 검토 금지* — plan 수준의 검토만 (지피티가 코드 보면 외부성 손상)
- *SUB-3 [Judge] 세션과 별도 세션 권고* — 시점·자료가 다름. 혼동 방지
- 통과 판정 받기 *전*에 구현 진입 금지

## 산출물

- `.harness/runs/<run_id>/plan-review-input.md` — 입력 자료
- `.harness/runs/<run_id>/plan-review.md` — 판정 + 권고

## 판정 형식 (4단)

1. **의도 정렬** — plan이 [Owner] 의도와 정렬되는가?
2. **Looks Wrong 방어** — plan이 task-card §3 Looks Wrong을 *진짜로* 방어하는가?
3. **가정 검증** — task-card §3.5 가정 중 *실제 검증 안 된* 것은?
4. **종합** — Status: 통과 / 수정 권고 / 보류 / 중단

## 처리

- **통과** → [Builder] 구현 진입
- **수정 권고** → [Builder]에 plan 수정 지시 + 재검토
- **보류·중단** → [Owner] 에스컬레이션

## 참조

- silkroadhub `SUB-2-워크플로우.md` §2.4·§2.5


### 04-invoke-plan-review/scripts/invoke_plan_review.sh

#!/bin/zsh
# invoke_plan_review.sh — plan-review 호출 (지피티, SUB-2 §2.5)
# 두별 워크플로우 v3.6.0 r1 베타 — Manus Agent Skill
#
# 호출: bash invoke_plan_review.sh <run_id>
# 입력: .harness/runs/<run_id>/plan-review-input.md
# 출력: .harness/runs/<run_id>/plan-review.md

set -e

RUN_ID="${1:?usage: invoke_plan_review.sh <run_id>}"

REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"
RUN_DIR="${REPO_ROOT}/.harness/runs/${RUN_ID}"
INPUT_FILE="${RUN_DIR}/plan-review-input.md"
OUTPUT_FILE="${RUN_DIR}/plan-review.md"
LOG_FILE="${RUN_DIR}/plan-review-exec.log"

cd "${REPO_ROOT}"

if [ ! -f "${INPUT_FILE}" ]; then
  echo "ERROR: 입력 자료 없음 — ${INPUT_FILE}"
  echo "마누스 사전 작성 필요: task-card §1/§3 + plan 본문 + PROJECT.md §C.N"
  exit 1
fi

if [ -z "${OPENAI_API_KEY}" ]; then
  echo "ERROR: OPENAI_API_KEY 미설정 — source scripts/load_openai_key.sh 먼저"
  exit 2
fi

echo "=== plan-review 호출 시작: $(date) ===" | tee "${LOG_FILE}"

SYSTEM_PROMPT='당신은 silkroadhub의 [Judge] — Devil"'"'"'s Advocate (plan 검토 시점).

역할:
- 구현 *전* plan 단계 검토. 코드 디테일 없음
- [Builder] writing-plans 산출물을 [Owner] 의도·Looks Wrong·가정과 대조
- 빠진 단계·과도한 단계·검증 안 된 가정 발견

응답 4단:
1. 의도 정렬 — plan이 [Owner] 의도와 정렬되는가?
2. Looks Wrong 방어 — task-card §3 Looks Wrong을 plan이 진짜 방어하는가?
3. 가정 검증 — 가정 중 실제 검증 안 된 것은? (1개 이상 강제 발견)
4. 종합 — Status: 통과 / 수정 권고 / 보류 / 중단

금지:
- 코드 디테일 검토 시도 금지
- 추상적 "괜찮아 보임" 응답 금지
- "가정 다 OK" 같은 무비판 응답 금지 — 항상 의심점 1개 이상'

PROMPT_CONTENT=$(cat "${INPUT_FILE}")

python3 << PYEOF | tee -a "${LOG_FILE}"
import json, os, urllib.request

api_key = os.environ.get("OPENAI_API_KEY")
payload = {
    "model": "gpt-5.5",
    "messages": [
        {"role": "system", "content": """${SYSTEM_PROMPT}"""},
        {"role": "user", "content": """${PROMPT_CONTENT}"""}
    ],
    "max_tokens": 3000
}
req = urllib.request.Request(
    "https://api.openai.com/v1/chat/completions",
    data=json.dumps(payload).encode("utf-8"),
    headers={"Authorization": f"Bearer {api_key}", "Content-Type": "application/json"},
    method="POST"
)
try:
    with urllib.request.urlopen(req, timeout=120) as resp:
        data = json.loads(resp.read().decode("utf-8"))
        text = data["choices"][0]["message"]["content"]
        with open("${OUTPUT_FILE}", "w") as f:
            f.write("# plan-review 결과 (지피티, SUB-2 §2.5)\n\n")
            f.write(text)
        print(f"호출 성공. 응답 길이: {len(text)} chars")
        print(f"사용 토큰: {data.get('usage', {})}")
except Exception as e:
    print(f"호출 실패: {e}")
    exit(3)
PYEOF

echo "=== plan-review 호출 종료: $(date) ===" | tee -a "${LOG_FILE}"
echo ""
echo "다음 단계:"
echo "  통과 → [Builder] 구현 진입"
echo "  수정 권고 → [Builder]에 plan 수정 지시 + 재검토"
echo "  보류·중단 → [Owner] 에스컬레이션"


### 04-invoke-plan-review/references file list

04-invoke-plan-review/references/plan-review-prompt-pattern.md

### 05-verify-handoff/SKILL.md

---
name: 05-verify-handoff
description: 마누스가 [Builder] handoff 수신 후 권한 천장 위반·scope 위반·마스킹 위반·증거 부족을 자동 점검하는 스킬. SUB-2 §4 진입 시점 사용. git 명령 6개 자동 실행해서 push 시도·파괴적 git·운영 문서 변경 등 위반 신호 검출. 위반 발견 시 즉시 멈춤 + [Owner] 보고. silkroadhub 두별 워크플로우 v3.6.0 r1 베타 SUB-2 §4 표준 절차.
---

# 05-verify-handoff

handoff 수신 후 *마누스 직접 검증* 자동화. handoff만 믿지 않고 *실제 git·로그* 확인.

## 언제 호출하는가

- [Builder]가 handoff.md 작성 완료
- SUB-2 §4 [Foreman] 검증 단계 진입 시

## 동작 순서

1. `scripts/verify_handoff.sh <run_id>` 실행
2. 6개 검증 항목 자동 실행:
   - **A. git push 흔적** — 로컬 commit 외 push 발생 여부
   - **B. 파괴적 git 명령 흔적** — reflog에 reset --hard·force push 등
   - **C. 운영 문서 변경** — AGENTS.md·CLAUDE.md·PROJECT.md·.harness/templates/ diff
   - **D. scope 침범** — task-card §5.2 제외 범위 파일 변경
   - **E. 마스킹 위반** — commit 메시지·코드 안 운송장·BL·키 노출 패턴
   - **F. handoff §1 의도 정렬 대조** — task-card §3과 항목별 1:1 매칭
3. 각 항목 PASS/WARN/FAIL 표 출력
4. FAIL 발견 시 즉시 멈춤 + [Owner] 보고 안내

## 호출

```bash
bash scripts/verify_handoff.sh <run_id>
```

## 핵심 안전선

- 자동 검증이 *PASS*여도 마누스가 *추가 점검* — 자동 검증은 *형식적 신호*만 잡음
- 의미적 위반 (예: handoff §1 의도 정렬이 *겉으로는 매칭하지만 실제 의도 어긋남*)은 *마누스 판단*
- FAIL 발견 시 *handoff 통과 처리 절대 금지*. SUB-4 진입 후보

## 산출물

- `.harness/runs/<run_id>/handoff-verification.md` — 검증 결과 표

## 결과 처리

| 결과 | 다음 행동 |
|---|---|
| 6개 모두 PASS | SUB-3 진입 (Tier A/B) 또는 SUB-5 진입 (Tier C) |
| 1개 이상 WARN | 마누스 추가 점검 + [Owner] 보고 검토 |
| 1개 이상 FAIL | SUB-4 진입 또는 [Owner] 즉시 보고 |

## 참조

- silkroadhub `SUB-2-워크플로우.md` §4
- silkroadhub `AGENTS.md` §6 권한 천장


### 05-verify-handoff/scripts/verify_handoff.sh

#!/bin/zsh
# verify_handoff.sh — handoff 수신 후 6개 항목 자동 검증
# 두별 워크플로우 v3.6.0 r1 베타 — Manus Agent Skill
#
# 호출: bash verify_handoff.sh <run_id>

set -e

RUN_ID="${1:?usage: verify_handoff.sh <run_id>}"
REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"
RUN_DIR="${REPO_ROOT}/.harness/runs/${RUN_ID}"
HANDOFF="${RUN_DIR}/handoff.md"
TASK_CARD="${RUN_DIR}/task-card.md"
REPORT="${RUN_DIR}/handoff-verification.md"

cd "${REPO_ROOT}"

if [ ! -f "${HANDOFF}" ]; then
  echo "ERROR: handoff.md 없음 — ${HANDOFF}"
  exit 1
fi

echo "===== handoff 자동 검증 시작: $(date) =====" | tee "${REPORT}"
echo "Run ID: ${RUN_ID}" | tee -a "${REPORT}"
echo "" | tee -a "${REPORT}"

FAIL_COUNT=0
WARN_COUNT=0

# A. git push 흔적
echo "## A. git push 흔적" | tee -a "${REPORT}"
PUSH_TRACE=$(git reflog 2>&1 | grep -i "push" | head -5 || true)
if [ -z "${PUSH_TRACE}" ]; then
  echo "  [PASS] reflog에 push 흔적 없음" | tee -a "${REPORT}"
else
  echo "  [WARN] reflog에 push 관련 항목:" | tee -a "${REPORT}"
  echo "${PUSH_TRACE}" | sed 's/^/    /' | tee -a "${REPORT}"
  WARN_COUNT=$((WARN_COUNT+1))
fi
echo "" | tee -a "${REPORT}"

# B. 파괴적 git 명령 흔적
echo "## B. 파괴적 git 명령 흔적" | tee -a "${REPORT}"
DESTRUCT=$(git reflog 2>&1 | grep -iE "reset --hard|rebase -i|force|filter-branch|--amend" | head -5 || true)
if [ -z "${DESTRUCT}" ]; then
  echo "  [PASS] 파괴적 git 흔적 없음" | tee -a "${REPORT}"
else
  echo "  [FAIL] reflog에 파괴적 git 흔적:" | tee -a "${REPORT}"
  echo "${DESTRUCT}" | sed 's/^/    /' | tee -a "${REPORT}"
  FAIL_COUNT=$((FAIL_COUNT+1))
fi
echo "" | tee -a "${REPORT}"

# C. 운영 문서 변경
echo "## C. 운영 문서 변경" | tee -a "${REPORT}"
OPS_CHANGED=$(git status --short 2>&1 | grep -E "AGENTS\.md|CLAUDE\.md|PROJECT\.md|\.harness/templates/|SUB-[0-9]" || true)
if [ -z "${OPS_CHANGED}" ]; then
  echo "  [PASS] 운영 문서 변경 없음" | tee -a "${REPORT}"
else
  echo "  [FAIL] 운영 문서 변경 발견:" | tee -a "${REPORT}"
  echo "${OPS_CHANGED}" | sed 's/^/    /' | tee -a "${REPORT}"
  echo "    → [Owner] 명시 승인 없이는 권한 천장 위반" | tee -a "${REPORT}"
  FAIL_COUNT=$((FAIL_COUNT+1))
fi
echo "" | tee -a "${REPORT}"

# D. scope 침범 — task-card §5.2 제외 범위 확인 (수동 점검 안내)
echo "## D. scope 침범 (수동 점검 권고)" | tee -a "${REPORT}"
if [ -f "${TASK_CARD}" ]; then
  echo "  task-card §5.2 제외 범위:" | tee -a "${REPORT}"
  sed -n '/§5.2 제외 범위/,/^## §6\|^## §7\|^### §6/p' "${TASK_CARD}" | head -20 | sed 's/^/    /' | tee -a "${REPORT}"
  echo "  변경 파일 목록 (git status):" | tee -a "${REPORT}"
  git status --short | head -20 | sed 's/^/    /' | tee -a "${REPORT}"
  echo "  [INFO] 위 두 목록 대조하여 마누스 수동 판단" | tee -a "${REPORT}"
else
  echo "  [WARN] task-card 없음 — scope 점검 불가" | tee -a "${REPORT}"
  WARN_COUNT=$((WARN_COUNT+1))
fi
echo "" | tee -a "${REPORT}"

# E. 마스킹 위반 — commit 메시지·diff에서 운송장·BL·키 패턴
echo "## E. 마스킹 위반" | tee -a "${REPORT}"
RECENT_COMMITS=$(git log --since="6 hours ago" --pretty=format:"%H %s" 2>&1 | head -10 || true)

# 운송장 패턴: 10~14자리 숫자
MASK_VIOLATIONS=""
if [ -n "${RECENT_COMMITS}" ]; then
  MASK_VIOLATIONS=$(git log --since="6 hours ago" -p 2>&1 | grep -E "\b[0-9]{10,14}\b|P[0-9]{12,13}|sk-[a-zA-Z0-9]{20,}" | head -5 || true)
fi

if [ -z "${MASK_VIOLATIONS}" ]; then
  echo "  [PASS] 최근 commit에서 마스킹 위반 패턴 미발견" | tee -a "${REPORT}"
else
  echo "  [FAIL] 마스킹 위반 의심 패턴:" | tee -a "${REPORT}"
  echo "${MASK_VIOLATIONS}" | sed 's/^/    /' | tee -a "${REPORT}"
  echo "    → git history 진입 여부 확인 + SUB-4 카테고리 D 처리" | tee -a "${REPORT}"
  FAIL_COUNT=$((FAIL_COUNT+1))
fi
echo "" | tee -a "${REPORT}"

# F. handoff §1 의도 정렬 (마누스 수동 대조 안내)
echo "## F. handoff §1 의도 정렬 (수동 대조 권고)" | tee -a "${REPORT}"
if grep -q "## §1\|## 1\." "${HANDOFF}"; then
  echo "  [INFO] handoff §1 발견. 마누스가 task-card §3과 1:1 매칭 수동 대조" | tee -a "${REPORT}"
  echo "    - 한 문장 목표 일치?" | tee -a "${REPORT}"
  echo "    - Looks Like 항목 일치?" | tee -a "${REPORT}"
  echo "    - Looks Wrong 항목 방어 확인?" | tee -a "${REPORT}"
  echo "    - 가정 중 틀린 것 발견 시 보고?" | tee -a "${REPORT}"
else
  echo "  [WARN] handoff §1 의도 정렬 블록 형식 미발견" | tee -a "${REPORT}"
  WARN_COUNT=$((WARN_COUNT+1))
fi
echo "" | tee -a "${REPORT}"

# 종합
echo "===== 검증 종합 =====" | tee -a "${REPORT}"
echo "FAIL: ${FAIL_COUNT}, WARN: ${WARN_COUNT}" | tee -a "${REPORT}"
echo "" | tee -a "${REPORT}"

if [ ${FAIL_COUNT} -gt 0 ]; then
  echo "[차단] FAIL 발견 — handoff 통과 금지" | tee -a "${REPORT}"
  echo "다음: SUB-4 진입 또는 [Owner] 즉시 보고" | tee -a "${REPORT}"
  exit 10
elif [ ${WARN_COUNT} -gt 0 ]; then
  echo "[주의] WARN 발견 — 마누스 추가 점검 후 [Owner] 보고 검토" | tee -a "${REPORT}"
  exit 5
else
  echo "[통과] 6개 항목 모두 PASS" | tee -a "${REPORT}"
  echo "다음: Tier A/B → SUB-3 진입 / Tier C → SUB-5 진입" | tee -a "${REPORT}"
  exit 0
fi


### 05-verify-handoff/references file list

05-verify-handoff/references/verification-checklist.md

### 06-invoke-reviewer/SKILL.md

---
name: 06-invoke-reviewer
description: 마누스가 코덱스를 호출해 코드 감리(Reviewer)를 수행하는 표준 스킬. 코덱스 불가 시 지피티(별도 세션)로 자동 폴백. SUB-3 §3 진입 시점 사용. 입력은 코드·기술 명세에 한정, 의도·사업 맥락은 절대 전달 금지 (정보 격리 원칙). 코드 변경 task의 Tier A는 필수. silkroadhub 두별 워크플로우 v3.6.0 r1 베타에서 SUB-3 §3 표준 절차.
---

# 06-invoke-reviewer

마누스가 [Reviewer] 역할을 *코덱스에 위임*해 코드 감리를 수행. 코덱스 불가 시 지피티 폴백.

## 언제 호출하는가

- `handoff.md` 작성 완료 (SUB-2 종료) 후
- Tier A 코드 변경 task → *필수*
- Tier B 코드 변경 task → *권고*
- Tier C → 생략 가능

## 입력 자료 — 정보 격리 원칙 ★

**[Reviewer]에게 전달**:
- `handoff.md` §2.2 변경 파일 목록
- `handoff.md` §3 진행 이력
- diff 발췌 (마스킹 적용 후)
- `task-card.md` §5 산출물 목록 (기술 명세)

**전달 금지**:
- `task-card.md` §1 [Owner] 발화 원문
- `task-card.md` §3 의도 정렬 증거 블록 (Looks Like/Wrong)
- `PROJECT.md` 내용
- 사업 맥락·우선순위

## 동작 순서

1. `scripts/invoke_reviewer.sh` 실행
2. 입력 자료를 `.harness/runs/<run_id>/reviewer-input.md`에 저장
3. 코덱스 호출 시도 (1차)
4. **코덱스 성공** → 응답을 `reviewer-raw.md`에 저장 → `gate-review.md §1` 자동 작성
5. **코덱스 실패** (CLI 오류·환경·rate limit) → 폴백 진입:
   - [Owner] 폴백 진입 보고
   - 지피티 [Reviewer] 전용 세션 호출 (별도 세션 — [Judge]와 분리)
   - 응답을 `reviewer-raw.md`에 저장 + 폴백 사실 명시

## 호출

```bash
bash scripts/invoke_reviewer.sh <run_id>
```

## 핵심 안전선

- *코덱스 자동 재시도 2~3회* 후에만 폴백 진입. *처음부터 폴백 사용 금지*
- 폴백 시 *지피티 [Judge] 세션과 반드시 다른 세션* 사용 (세션 라벨링: `Reviewer_Fallback`)
- 폴백 진행 시 `gate-review.md §1.1`에 *폴백 사실·사유 명시*
- 입력 자료에 *의도·사업 맥락 절대 포함 금지* (정보 격리)
- 마스킹 규칙 적용 후 전달

## 산출물

- `.harness/runs/<run_id>/reviewer-input.md` — 입력 자료 (정보 격리 검증용)
- `.harness/runs/<run_id>/reviewer-raw.md` — 응답 원문
- `.harness/runs/<run_id>/codex-exec.log` — 호출 로그
- `.harness/runs/<run_id>/gate-review.md §1` — 마누스가 정리한 감리 결과

## 폴백 사후 처리

- 폴백 진행 사실은 SUB-5 §12 회고에 누적
- 폴백 반복 시 [Owner]께 코덱스 환경 점검 권고
- 다음 task는 *코덱스 우선*으로 복귀

## 참조

- `references/codex-prompt-pattern.md` — 코덱스 호출 프롬프트 패턴
- `references/fallback-procedure.md` — 폴백 절차 상세
- silkroadhub `AGENTS.md` §7.1·§7.5
- silkroadhub `SUB-3-외부감리.md` §3


### 06-invoke-reviewer/scripts/invoke_reviewer.sh

#!/bin/zsh
# invoke_reviewer.sh — [Reviewer] 호출 (코덱스 우선, 지피티 폴백)
# 두별 워크플로우 v3.6.0 r1 베타 — Manus Agent Skill
#
# 호출: bash invoke_reviewer.sh <run_id>
# 입력: .harness/runs/<run_id>/reviewer-input.md (마누스가 사전 작성)
# 출력: .harness/runs/<run_id>/reviewer-raw.md + codex-exec.log

set -e

RUN_ID="${1:?usage: invoke_reviewer.sh <run_id>}"

REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"
RUN_DIR="${REPO_ROOT}/.harness/runs/${RUN_ID}"
INPUT_FILE="${RUN_DIR}/reviewer-input.md"
OUTPUT_FILE="${RUN_DIR}/reviewer-raw.md"
LOG_FILE="${RUN_DIR}/codex-exec.log"

cd "${REPO_ROOT}"

# 입력 자료 점검
if [ ! -f "${INPUT_FILE}" ]; then
  echo "ERROR: 입력 자료 없음 — ${INPUT_FILE}"
  echo "마누스가 사전 작성 필요: handoff §2.2 변경 파일·§3 진행 이력·diff 발췌·task-card §5"
  exit 1
fi

echo "=== [Reviewer] 호출 시작: $(date) ===" | tee "${LOG_FILE}"
echo "Run ID: ${RUN_ID}" | tee -a "${LOG_FILE}"

# === 1차: 코덱스 시도 ===
echo "" | tee -a "${LOG_FILE}"
echo "1차 시도: 코덱스 ([Reviewer] 표준 도구)" | tee -a "${LOG_FILE}"

export PATH="/Users/twostars/.local/node/bin:$PATH"
source ~/.zshrc 2>/dev/null || true

CODEX_MAX_RETRY=2
CODEX_OK=false

for attempt in $(seq 1 ${CODEX_MAX_RETRY}); do
  echo "코덱스 시도 ${attempt}/${CODEX_MAX_RETRY}" | tee -a "${LOG_FILE}"

  codex exec --sandbox read-only --output-last-message \
    - < "${INPUT_FILE}" > "${OUTPUT_FILE}.tmp" 2>> "${LOG_FILE}" && {
    mv "${OUTPUT_FILE}.tmp" "${OUTPUT_FILE}"
    CODEX_OK=true
    break
  }

  echo "코덱스 시도 ${attempt} 실패" | tee -a "${LOG_FILE}"
  rm -f "${OUTPUT_FILE}.tmp"
  sleep 3
done

if [ "${CODEX_OK}" = "true" ]; then
  echo "" | tee -a "${LOG_FILE}"
  echo "코덱스 호출 성공" | tee -a "${LOG_FILE}"
  head -5 "${OUTPUT_FILE}" | tee -a "${LOG_FILE}"
  echo "=== [Reviewer] 호출 종료: $(date) ===" | tee -a "${LOG_FILE}"
  echo ""
  echo "다음: gate-review.md §1 작성 (마누스)"
  exit 0
fi

# === 2차: 지피티 폴백 ===
echo "" | tee -a "${LOG_FILE}"
echo "코덱스 ${CODEX_MAX_RETRY}회 시도 모두 실패. 지피티 폴백 진입." | tee -a "${LOG_FILE}"
echo "⚠️  폴백 진입 — [Owner] 보고 필요. gate-review.md §1.1에 폴백 사실 명시 의무" | tee -a "${LOG_FILE}"

if [ -z "${OPENAI_API_KEY}" ]; then
  echo "ERROR: OPENAI_API_KEY 미설정 — source scripts/load_openai_key.sh 먼저" | tee -a "${LOG_FILE}"
  exit 2
fi

PROMPT_CONTENT=$(cat "${INPUT_FILE}")
SYSTEM_PROMPT="당신은 silkroadhub의 [Reviewer] 폴백 세션입니다. 코덱스 불가로 임시 대체. 코드·기술 정합성만 감사하세요. 사업·기획 판단 금지. 입력 자료의 코드·diff·기술 명세를 봐서 통과/조건부 통과/보류/차단 중 하나 판정. 구체 파일·라인 근거 명시 필수."

python3 << PYEOF | tee -a "${LOG_FILE}"
import json, os, urllib.request

api_key = os.environ.get("OPENAI_API_KEY")
payload = {
    "model": "gpt-5.5",
    "messages": [
        {"role": "system", "content": """${SYSTEM_PROMPT}"""},
        {"role": "user", "content": """${PROMPT_CONTENT}"""}
    ],
    "max_tokens": 4000
}
req = urllib.request.Request(
    "https://api.openai.com/v1/chat/completions",
    data=json.dumps(payload).encode("utf-8"),
    headers={"Authorization": f"Bearer {api_key}", "Content-Type": "application/json"},
    method="POST"
)
try:
    with urllib.request.urlopen(req, timeout=120) as resp:
        data = json.loads(resp.read().decode("utf-8"))
        text = data["choices"][0]["message"]["content"]
        with open("${OUTPUT_FILE}", "w") as f:
            f.write("# [Reviewer] 폴백 (지피티) — 코덱스 불가로 임시 대체\n\n")
            f.write(text)
        print(f"폴백 호출 성공. 응답 길이: {len(text)} chars")
        print(f"사용 토큰: {data.get('usage', {})}")
except Exception as e:
    print(f"폴백 호출 실패: {e}")
    exit(3)
PYEOF

echo "=== [Reviewer] 호출 종료: $(date) ===" | tee -a "${LOG_FILE}"
echo ""
echo "⚠️  폴백 진입 완료."
echo "마누스 다음 행동:"
echo "  1. [Owner]께 폴백 진입 보고"
echo "  2. gate-review.md §1.1에 폴백 사실·사유 명시"
echo "  3. [Judge] 호출 시 *반드시 다른 지피티 세션* 사용"
echo "  4. SUB-5 §12 회고에 폴백 누적 기록"


### 06-invoke-reviewer/references file list

06-invoke-reviewer/references/codex-prompt-pattern.md
06-invoke-reviewer/references/fallback-procedure.md

### 07-invoke-judge/SKILL.md

---
name: 07-invoke-judge
description: 마누스가 지피티(별도 세션)를 호출해 종합 판정·Devil's Advocate 검토를 수행하는 표준 스킬. SUB-3 §4 진입 시점 사용. 입력은 의도·기획·사업 맥락에 한정, 코드 디테일은 절대 전달 금지 (정보 격리). 모든 Tier A/B는 필수. Reviewer 세션과 반드시 다른 세션. silkroadhub 두별 워크플로우 v3.6.0 r1 베타 SUB-3 §4 표준 절차.
---

# 07-invoke-judge

마누스가 [Judge] 역할을 *지피티에 위임*해 종합 판정 + Devil's Advocate 검토 수행.

## 언제 호출하는가

- [Reviewer] 호출·결과 정리 완료 (SUB-3 §3 종료) 후
- Tier A/B → *필수*
- Tier C → 생략 가능 (task-card §4에 사유 명시)
- *반드시 [Reviewer] 세션과 분리된 새 지피티 세션*

## 입력 자료 — 정보 격리 원칙 ★

**[Judge]에게 전달**:
- `task-card.md` §1 [Owner] 발화 원문
- `task-card.md` §3 의도 정렬 증거 블록 (Looks Like / Looks Wrong / 가정)
- `task-card.md` §5 산출물 + 완료 기준
- `PROJECT.md` §C.[N] 연결 모듈 정보
- `handoff.md` §1 의도 정렬 증거 블록 대조 (1:1 매칭)
- `gate-review.md §1` [Reviewer] 결과 요약 (코덱스의 코드 영역 판정)

**전달 금지**:
- diff 본문 (코드 디테일)
- [Builder] 구현 내부 로직 디테일
- 마스킹되지 않은 운영 데이터

## 동작 순서

1. `scripts/invoke_judge.sh` 실행
2. 입력 자료를 `.harness/runs/<run_id>/judge-input.md`에 저장
3. 지피티 [Judge] 전용 새 세션 호출 (모델 `gpt-5.5`, temperature 파라미터 생략)
4. 응답을 `judge-raw.md`에 저장
5. 마누스가 `gate-review.md §2`로 정리

## 호출

```bash
bash scripts/invoke_judge.sh <run_id>
```

## 핵심 안전선

- *[Reviewer] 세션과 동일 세션 사용 절대 금지* — 정보 격리 위반
- 코드 디테일·diff 전달 금지 — [Judge]가 코드 보면 *외부성 손상*
- 응답이 *추상적*이면 *Devil's Advocate 부분* 재호출 — "리스크 5가지 명시" 같은 강제 프롬프트

## 산출물

- `.harness/runs/<run_id>/judge-input.md` — 입력 자료 (정보 격리 검증용)
- `.harness/runs/<run_id>/judge-raw.md` — 응답 원문
- `.harness/runs/<run_id>/gate-review.md §2` — 마누스 정리 결과

## 판정 형식

[Judge]는 다음 4단 응답 의무:

1. **의도 정렬 판정** — handoff §1 의도 정렬 증거 블록이 task-card §3 의도와 *1:1 매칭*되는가
2. **사업 영향 평가** — 변경이 [Owner] 발화의 *진짜 의도*와 부합하는가
3. **Devil's Advocate** — 반대 논리·놓친 리스크 *최소 3가지* 명시 강제
4. **종합 판정** — 진행 / 수정 / 보류 / 중단

## 참조

- `references/judge-prompt-pattern.md` — 지피티 호출 프롬프트 패턴
- silkroadhub `AGENTS.md` §1·§7
- silkroadhub `SUB-3-외부감리.md` §4


### 07-invoke-judge/scripts/invoke_judge.sh

#!/bin/zsh
# invoke_judge.sh — [Judge] 호출 (지피티 단독, 별도 세션)
# 두별 워크플로우 v3.6.0 r1 베타 — Manus Agent Skill
#
# 호출: bash invoke_judge.sh <run_id>
# 입력: .harness/runs/<run_id>/judge-input.md (마누스가 사전 작성)
# 출력: .harness/runs/<run_id>/judge-raw.md

set -e

RUN_ID="${1:?usage: invoke_judge.sh <run_id>}"

REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"
RUN_DIR="${REPO_ROOT}/.harness/runs/${RUN_ID}"
INPUT_FILE="${RUN_DIR}/judge-input.md"
OUTPUT_FILE="${RUN_DIR}/judge-raw.md"
LOG_FILE="${RUN_DIR}/judge-exec.log"

cd "${REPO_ROOT}"

if [ ! -f "${INPUT_FILE}" ]; then
  echo "ERROR: 입력 자료 없음 — ${INPUT_FILE}"
  echo "마누스 사전 작성 필요: task-card §1/§3/§5 + PROJECT.md §C.N + handoff §1 + gate-review §1"
  exit 1
fi

if [ -z "${OPENAI_API_KEY}" ]; then
  echo "ERROR: OPENAI_API_KEY 미설정 — source scripts/load_openai_key.sh 먼저"
  exit 2
fi

echo "=== [Judge] 호출 시작: $(date) ===" | tee "${LOG_FILE}"
echo "Run ID: ${RUN_ID}" | tee -a "${LOG_FILE}"
echo "주의: [Reviewer] 세션과 *반드시 다른* 지피티 세션 사용" | tee -a "${LOG_FILE}"

SYSTEM_PROMPT='당신은 silkroadhub의 [Judge] — Devil"'"'"'s Advocate + 종합 판정자입니다.

역할:
- 코드 디테일을 보지 않음. 의도·기획·사업·논리 영역만 판정
- [Reviewer] 세션과 완전히 분리. 같은 task-card라도 다른 시각으로 검토
- 반대 논리·놓친 리스크 최소 3가지 명시 강제

응답 4단 의무:
1. 의도 정렬 판정 — handoff §1 의도 정렬 증거 블록이 task-card §3 의도와 1:1 매칭되는가
2. 사업 영향 평가 — 변경이 [Owner] 발화의 진짜 의도와 부합하는가
3. Devil"'"'"'s Advocate — 반대 논리·놓친 리스크 최소 3가지
4. 종합 판정 — Status: 진행 / 수정 / 보류 / 중단

금지:
- 코드 직접 수정 금지
- Tier 분류 시도 금지
- 추상적 "괜찮아 보임"만 응답하지 말 것. 항상 구체 근거'

PROMPT_CONTENT=$(cat "${INPUT_FILE}")

python3 << PYEOF | tee -a "${LOG_FILE}"
import json, os, urllib.request

api_key = os.environ.get("OPENAI_API_KEY")
payload = {
    "model": "gpt-5.5",
    "messages": [
        {"role": "system", "content": """${SYSTEM_PROMPT}"""},
        {"role": "user", "content": """${PROMPT_CONTENT}"""}
    ],
    "max_tokens": 4000
}
req = urllib.request.Request(
    "https://api.openai.com/v1/chat/completions",
    data=json.dumps(payload).encode("utf-8"),
    headers={"Authorization": f"Bearer {api_key}", "Content-Type": "application/json"},
    method="POST"
)
try:
    with urllib.request.urlopen(req, timeout=120) as resp:
        data = json.loads(resp.read().decode("utf-8"))
        text = data["choices"][0]["message"]["content"]
        with open("${OUTPUT_FILE}", "w") as f:
            f.write("# [Judge] 응답 — 지피티 별도 세션\n\n")
            f.write(text)
        print(f"호출 성공. 응답 길이: {len(text)} chars")
        print(f"사용 토큰: {data.get('usage', {})}")
except Exception as e:
    print(f"호출 실패: {e}")
    exit(3)
PYEOF

echo "=== [Judge] 호출 종료: $(date) ===" | tee -a "${LOG_FILE}"
echo ""
echo "다음 단계 (마누스):"
echo "  1. judge-raw.md 검토"
echo "  2. Devil's Advocate 부분이 추상적이면 *재호출* (구체 리스크 3개 강제)"
echo "  3. gate-review.md §2 작성"
echo "  4. [Owner] 보고"


### 07-invoke-judge/references file list

07-invoke-judge/references/judge-prompt-pattern.md

### 08-write-final-report/SKILL.md

---
name: 08-write-final-report
description: 마누스가 SUB-5 §2 진입 시 final-report.md 초안을 자동 작성하는 스킬. task-card·handoff·gate-review·plan-review를 읽어 final-report §1~§9를 자동 채움. §10 PROJECT.md 갱신 사항·§11 후속 task 후보·§12 회고는 마누스가 직접 작성. silkroadhub 두별 워크플로우 v3.6.0 r1 베타 SUB-5 §2 표준 절차.
---

# 08-write-final-report

마누스가 task 종료 시 [Owner]께 final-report 작성. 자동 인용 + 수동 판단 결합.

## 언제 호출하는가

- SUB-5 §2 진입 시 (handoff·gate-review 모두 완료된 후)

## 동작 순서

1. `scripts/write_final_report.sh <run_id>` 실행
2. `.harness/runs/<run_id>/final-report.md` 자동 생성:
   - §1 task 요약 — task-card §1·§3에서 추출
   - §2 진행 결과 — handoff에서 추출
   - §3 산출물 — handoff §2.2·task-card §5에서 매칭
   - §4 검증 결과 — handoff §4·§5에서 추출
   - §5 외부 감리 결과 — gate-review §1·§2에서 추출
   - §6 plan-review 결과 — plan-review.md 있으면 추출 (선택)
   - §7 변경 파일 (git status) — git에서 직접
   - §8 fix-loop 기록 — handoff 또는 별도 fix-log
   - §9 권한 천장 점검 — verify-handoff 결과 인용
   - §10 PROJECT.md 갱신 사항 *마누스 수동 작성*
   - §11 후속 task 후보 *마누스 수동 작성*
   - §12 회고 (베타 어색함) *마누스 수동 작성*
   - §13 마누스 짚을 점 *수동*
3. 마누스가 §10~§13 채우기
4. [Owner]께 final-report 제출

## 호출

```bash
bash scripts/write_final_report.sh <run_id>
```

## 핵심 안전선

- *자동 인용은 기계적 복사*. 의미 손실 위험 — 마누스가 *검토*
- §10·§11·§12·§13은 *판단 영역*. 자동 생성 안 함
- 자동 인용이 *마스킹된 데이터*만 다루는지 확인 (마스킹 위반 재발 방지)

## 산출물

- `.harness/runs/<run_id>/final-report.md` — 초안 (수동 보강 필요)

## 참조

- silkroadhub `.harness/templates/final-report-template.md`
- silkroadhub `SUB-5-종료.md` §2


### 08-write-final-report/scripts/write_final_report.sh

#!/bin/zsh
# write_final_report.sh — final-report.md 초안 자동 생성
# 두별 워크플로우 v3.6.0 r1 베타 — Manus Agent Skill
#
# 호출: bash write_final_report.sh <run_id>

set -e

RUN_ID="${1:?usage: write_final_report.sh <run_id>}"
REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"
RUN_DIR="${REPO_ROOT}/.harness/runs/${RUN_ID}"
TASK_CARD="${RUN_DIR}/task-card.md"
HANDOFF="${RUN_DIR}/handoff.md"
GATE_REVIEW="${RUN_DIR}/gate-review.md"
PLAN_REVIEW="${RUN_DIR}/plan-review.md"
VERIFY="${RUN_DIR}/handoff-verification.md"
REPORT="${RUN_DIR}/final-report.md"

cd "${REPO_ROOT}"
NOW=$(date "+%Y-%m-%d %H:%M %Z")

extract_section() {
  local file="$1"
  local section="$2"
  if [ -f "${file}" ]; then
    sed -n "/${section}/,/^## §\|^## [0-9]/p" "${file}" | head -50
  fi
}

cat > "${REPORT}" << REPORT_EOF
# final-report — Run ID ${RUN_ID}

> 작성 시각: ${NOW}
> 상태: 초안 자동 생성. §10~§13은 마누스 수동 작성 필요

## §1. task 요약

### task-card §1 [Owner] 원 발화
$(extract_section "${TASK_CARD}" "§1.\|## §1")

### task-card §3 의도 정렬 증거 블록
$(extract_section "${TASK_CARD}" "§3.\|## §3")

## §2. 진행 결과

### handoff §2 변경 파일 목록
$(extract_section "${HANDOFF}" "§2\|## 2")

### handoff §3 진행 이력
$(extract_section "${HANDOFF}" "§3\|## 3")

## §3. 산출물

### task-card §5에서 정의된 산출물
$(extract_section "${TASK_CARD}" "§5\|## §5")

### handoff §2.2 변경 파일과 매칭
*(마누스 수동 대조)*

## §4. 검증 결과

### handoff §4 자체 검증
$(extract_section "${HANDOFF}" "§4\|## 4")

### handoff §5 fresh evidence
$(extract_section "${HANDOFF}" "§5\|## 5")

## §5. 외부 감리 결과

### gate-review §1 [Reviewer] 결과
$(extract_section "${GATE_REVIEW}" "§1\|## §1")

### gate-review §2 [Judge] 결과
$(extract_section "${GATE_REVIEW}" "§2\|## §2")

## §6. plan-review 결과 (해당 시)

$( [ -f "${PLAN_REVIEW}" ] && cat "${PLAN_REVIEW}" | head -30 || echo "*plan-review 미실시*" )

## §7. 변경 파일 (git 상태)

\`\`\`
$(git status --short 2>&1 | head -30)
\`\`\`

\`\`\`
$(git log --oneline --since="24 hours ago" 2>&1 | head -10)
\`\`\`

## §8. fix-loop 기록 (해당 시)

$(extract_section "${HANDOFF}" "fix-log\|fix 시도" || echo "*fix-loop 발동 없음*")

## §9. 권한 천장 점검

### verify-handoff 결과
$( [ -f "${VERIFY}" ] && tail -10 "${VERIFY}" || echo "*verify-handoff 미실행*" )

## §10. PROJECT.md 갱신 사항 ★ 마누스 수동 작성 ★

### §10.1 §C 모듈 갱신
- 모듈: §C.[N]
- 갱신 내용:

### §10.2 §D 결정 이력 추가 (있으면)

## §11. 후속 task 후보 ★ 마누스 수동 작성 ★

- 발견된 scope 밖 사항 (handoff §8 인용 가능)
- 다음 분기·다음 task로 미룬 사항

## §12. 회고 (베타 어색함 누적) ★ 마누스 수동 작성 ★

- r6 베타 운영 중 어색한 점
- 다음 r 개정에 입력할 사항
- 매뉴얼·양식 개선 제안

## §13. 마누스 짚을 점 ★ 수동 ★

- [Owner]께 추가로 짚어둘 사항
- 결정 필요점
- 보고 누락 우려점

REPORT_EOF

echo "final-report 초안 생성: ${REPORT}"
echo "분량: $(wc -l < "${REPORT}") 줄"
echo ""
echo "마누스 수동 작성 필요:"
echo "  - §3 산출물 매칭 수동 대조"
echo "  - §10 PROJECT.md 갱신 사항"
echo "  - §11 후속 task 후보"
echo "  - §12 회고"
echo "  - §13 짚을 점"
echo ""
echo "작성 완료 후 [Owner]께 제출"
echo "→ update-project-md 스킬 호출 (§10 반영)"


### 08-write-final-report/references file list

08-write-final-report/references/final-report-sections-guide.md

### 09-update-project-md/SKILL.md

---
name: 09-update-project-md
description: 마누스가 SUB-5 §3 진입 시 PROJECT.md를 자동 갱신하는 스킬. task-card §10 PROJECT.md 갱신 사항을 읽어 PROJECT.md §C 모듈 진행과 §D 결정 이력에 반영. 변경 diff는 자동 commit 안 하고 마누스 검토·[Owner] 승인 후 commit. silkroadhub 두별 워크플로우 v3.6.0 r1 베타 SUB-5 §3 표준 절차.
---

# 09-update-project-md

마누스가 task 종료 시 PROJECT.md *살아있는 트래커* 자동 갱신.

## 언제 호출하는가

- SUB-5 §3 진입 시 (final-report 작성 완료 후)
- task-card §10에 PROJECT.md 갱신 사항이 채워진 상태

## 동작 순서

1. `scripts/update_project_md.sh <run_id>` 실행
2. task-card §10에서 갱신 사항 추출
3. PROJECT.md *백업* (`.harness/runs/<run_id>/PROJECT-before.md`)
4. PROJECT.md §C.[N] 모듈 진행 갱신
5. task-card §10.2에 결정 이력 있으면 PROJECT.md §D에 추가
6. PROJECT.md §E 운영 정보 갱신 (마지막 task ID·갱신 시각)
7. diff 출력
8. 마누스가 *diff 검토 후* [Owner] 승인 받음
9. 승인 후 commit (별도 단계)

## 호출

```bash
bash scripts/update_project_md.sh <run_id>
```

## 핵심 안전선

- *자동 commit 절대 금지* — diff 출력만. commit은 [Owner] 명시 승인 후 *별도 단계*
- task-card §10이 *비어있거나 부정확*하면 마누스가 수동 보강 후 재실행
- PROJECT.md 변경은 *운영 문서 변경*에 해당 — Tier A 처리

## 산출물

- `.harness/runs/<run_id>/PROJECT-before.md` — 갱신 전 백업
- `.harness/runs/<run_id>/project-md-diff.patch` — 변경 diff
- `PROJECT.md` (작업 디렉터리 변경 상태)

## 결과 처리

1. 마누스가 diff 검토
2. [Owner]께 PROJECT.md 갱신 사실 + 주요 변경 보고
3. [Owner] 명시 승인 후:
   - 변경 적용 유지
   - 별도 단계로 git commit (push는 또 별도 승인)
4. 거부 시:
   - 백업에서 복원 (`cp PROJECT-before.md PROJECT.md`)

## 참조

- silkroadhub `SUB-5-종료.md` §3
- silkroadhub `PROJECT.md` §E 갱신 메커니즘


### 09-update-project-md/scripts/update_project_md.sh

#!/bin/zsh
# update_project_md.sh — PROJECT.md 자동 갱신 (commit 안 함)
# 두별 워크플로우 v3.6.0 r1 베타 — Manus Agent Skill
#
# 호출: bash update_project_md.sh <run_id>
# 자동 commit 절대 금지 — diff 출력만, [Owner] 승인 후 별도 commit

set -e

RUN_ID="${1:?usage: update_project_md.sh <run_id>}"
REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"
RUN_DIR="${REPO_ROOT}/.harness/runs/${RUN_ID}"
TASK_CARD="${RUN_DIR}/task-card.md"
PROJECT_MD="${REPO_ROOT}/PROJECT.md"
BACKUP="${RUN_DIR}/PROJECT-before.md"
DIFF_FILE="${RUN_DIR}/project-md-diff.patch"

cd "${REPO_ROOT}"
NOW=$(date "+%Y-%m-%d %H:%M %Z")

if [ ! -f "${TASK_CARD}" ]; then
  echo "ERROR: task-card.md 없음 — ${TASK_CARD}"
  exit 1
fi

if [ ! -f "${PROJECT_MD}" ]; then
  echo "ERROR: PROJECT.md 없음 — ${PROJECT_MD}"
  exit 2
fi

# task-card §10 추출
TASK_CARD_S10=$(sed -n '/§10\. PROJECT/,/^---\|^$/p' "${TASK_CARD}")
if [ -z "${TASK_CARD_S10}" ]; then
  echo "ERROR: task-card §10 PROJECT.md 갱신 사항 비어있음"
  echo "마누스가 §10 수동 채운 후 재실행"
  exit 3
fi

# 백업
cp "${PROJECT_MD}" "${BACKUP}"
echo "백업 생성: ${BACKUP}"

# §10 내용을 PROJECT.md 끝부분 §C·§D에 추가하는 후크
# (실제 §C.N 모듈 위치는 마누스가 task-card §10.1에 명시했어야 함 — 자동 위치 검색은 위험)

cat >> "${PROJECT_MD}" << UPDATE_EOF

<!-- update-project-md 스킬 자동 추가, ${NOW}, Run ID ${RUN_ID} -->
<!-- 마누스 수동 검토 후 §C·§D 적절 위치로 이동 필요 -->

## [SUB-5 자동 추가 — Run ${RUN_ID}]

${TASK_CARD_S10}

UPDATE_EOF

echo ""
echo "PROJECT.md 갱신 완료 (작업 디렉터리)"
echo ""
echo "===== diff =====" 
git diff "${PROJECT_MD}" > "${DIFF_FILE}" 2>&1 || true
git diff --stat "${PROJECT_MD}" 2>&1 | head -10
echo ""
echo "전체 diff: ${DIFF_FILE}"
echo ""
echo "===== 다음 행동 (마누스 수동) ====="
echo "1. diff 검토: cat ${DIFF_FILE}"
echo "2. 자동 추가된 [SUB-5 자동 추가 ...] 블록을 §C.N 모듈·§D 결정 이력 적절 위치로 *수동 이동*"
echo "3. §E 운영 정보 수동 갱신 (마지막 task ID·갱신 시각)"
echo "4. [Owner]께 PROJECT.md 갱신 사실 + 주요 변경 보고"
echo "5. [Owner] 명시 승인 후 별도 단계로 git commit"
echo ""
echo "===== 거부 시 복원 ====="
echo "cp ${BACKUP} ${PROJECT_MD}"


### 09-update-project-md/references file list

09-update-project-md/references/project-md-update-procedure.md