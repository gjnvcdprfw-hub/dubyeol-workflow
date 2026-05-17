# task-card: 마누스 skill-creator 기반 두별 워크플로우 9개 스킬 직접 등록

**run ID**: 20260517_skills-direct-register  
**작성일시**: 2026-05-17 08:55 KST  
**작성자**: [Foreman]  
**상태**: 기획 완료  
**두별 워크트리 카테고리**: 4 (문서·운영)  
**Tier**: A

---

## 1. [Owner] 발화 원문

> [정정된 사실]
> GitHub import 경로는 *애초에 틀린 경로*. 마누스 스킬 등록은 *별도 메커니즘*:
> - 마누스에 *자체 스킬 생성 스킬*이 있음 ([Owner] 확인)
> - 그 스킬로 *마누스 자체에* 9개 스킬 직접 박음
> - GitHub 저장소는 *백업·공개 자료*로만 가치
>
> [Phase D 결과 재평가]
> - GitHub 저장소 push (32개 파일) → *백업·공개 자료*로 유효
> - Manus Import from GitHub 미인식 → *경로 자체가 틀린 것*. *동작 실패 아님*
> - 회고 메모 13 정정: "r6 매뉴얼·마누스 프로젝트 지침의 'GitHub import로 스킬 등록' 가정이 *애초에 틀린 경로*. 마누스 *자체 스킬 생성 스킬*로 직접 등록이 정답. r7에서:
>   - manus-import-verification §5 정정안 4개(A·B·C·D) *모두 무효*
>   - 마누스 *스킬 생성 스킬* 활용 절차로 *전면 재설계*
>   - GitHub 저장소는 *백업·공개·버전 추적*용으로만 유지"
>
> [PROJECT.md §C.1 상태 정정]
> "검증중" → "검증 결과: GitHub import 경로 무효 확인. 마누스 *스킬 생성 스킬* 활용으로 후속 재진입 예정"
>
> [후속 task — Phase F (정정)]
> - 한 문장 목표: 마누스 *스킬 생성 스킬* 활용해 r6-rollout-package/dubyeol-workflow-skills/ 9개 스킬을 마누스에 직접 등록
> - run_id: 20260517_skills-direct-register
> - Tier: A (운영 인프라 — Phase D 후속)
> - 카테고리: 4 (문서·운영)
>
> [Owner 짚어줌 받음]
> 대표님이 "마누스 스킬 중에 스킬 생성 스킬이 있다"고 확인. 그 스킬 이름·사용법은 너 ([Foreman])가 *자기 환경에서 *확인 가능**. 마누스 Settings 또는 Skills 메뉴에서 *스킬 생성 스킬* 찾아 활용 방식 짚어줘.
>
> [지금 할 것]
> 1. 너의 마누스 환경에서 *스킬 생성 스킬* 정확한 이름·사용법 확인
> 2. 9개 스킬 (r6-rollout-package/dubyeol-workflow-skills/) 자료를 *어떻게 마누스에 박을 수 있는지* 절차 보고
> 3. 진입 가능한 절차면 → Phase F task-card 작성
> 4. 절차 불명확하면 → [Owner] 추가 결정 요청
>
> [Phase D 결재 — 조건부 승인]
> - Phase D 자체는 *부분 성공* (GitHub 백업 완료, 마누스 등록 별도)
> - final-report §13 결재는 *회고 13 정정 박힌 후* 확정
> - silkroadhub repo commit·push는 회고 13 정정 반영 후 진행
>
> 진행해.

---

## 2. 상위 맥락 연결 (PROJECT.md 진입 시점)

- **연결 모듈**: §C.1 두별 워크플로우 운영 인프라
- **진입 시점 마일스톤**: “마누스 `skill-creator`를 활용해 `r6-rollout-package/dubyeol-workflow-skills/`의 9개 스킬을 Manus에 직접 등록.”
- **이번 task로 *전진시키는 것***: Phase D에서 백업·공개 자료로 push된 9개 스킬을 GitHub import가 아니라 마누스 자체 `skill-creator` 전달 메커니즘으로 직접 등록한다.
- **PROJECT.md 진입 시점 스냅샷**:
  - 모듈 상태: 검증 결과: GitHub import 경로 무효 확인. 마누스 자체 스킬 생성 스킬 활용으로 후속 재진입 예정
  - 현재 막힌 점: 9개 스킬이 아직 Manus 내 호출 가능 상태가 아니며, 직접 등록 절차의 실제 UI/카드 동작은 [미확인]

---

## 3. 의도 정렬 증거 블록 (SUB-1 §2 SOP 결과 — 불변)

> 본 블록은 task 진행 중 **수정 금지**. 의도 변경 발생 시 §9에 *추가* 블록으로 기록.

### 3.1 한 문장 목표 (What)

로컬 `r6-rollout-package/dubyeol-workflow-skills/`의 기존 9개 스킬 자료를 `/home/ubuntu/skills/<skill-name>/` 표준 위치에 1개씩 준비·검증하고, `skill-creator`의 validation·delivery 절차(Step 3 skip → Step 4·5)로 9개 스킬을 Manus에 등록한다. 등록 후 Skills 목록 또는 slash command에서 9개 노출을 검증한다.

### 3.2 성공 시 보이는 모습 (Looks Like)

- `skill-creator`의 정확한 이름과 사용법이 근거 문서로 기록되어 있다.
- `r6-rollout-package/dubyeol-workflow-skills/01-*`~`09-*`가 `/home/ubuntu/skills/` 아래 9개 스킬 디렉터리로 준비된다.
- 9개 스킬 각각에 대해 `quick_validate.py <skill-name>` 결과가 기록된다.
- 9개 `SKILL.md`가 사용자에게 전달되어 프론트엔드에서 `Add to My Skills` 또는 동등한 직접 등록 경로가 확인된다.
- 등록 후 `/01-load-sub-manual` 등 9개 slash command 또는 Skills 목록 검색에서 9개 스킬이 확인된다.

### 3.3 실패 시 보이는 모습 (Looks Wrong)

- GitHub import 경로를 다시 시도하며 Phase D에서 정정된 “경로 가정 오류”를 반복한다.
- `/home/ubuntu/skills/`에 복사한 9개 스킬이 원본 32개 파일 구조와 달라진다.
- validation 실패를 무시하고 등록 완료로 보고한다.
- `Add to My Skills` 같은 계정 설정성 조작이 필요한데 [Owner] 확인 없이 대신 진행한다.
- 9개 스킬 중 일부만 등록됐는데 “9개 등록 완료”로 과장한다.

### 3.4 모호어 해소 기록

- “마누스 스킬 생성 스킬” → “현재 마누스 환경에서 확인된 정확한 스킬명은 `skill-creator`.”
- “마누스에 직접 박음” → “`/home/ubuntu/skills/<skill-name>/SKILL.md`를 첨부하면 시스템이 스킬 디렉터리를 `.skill` 카드로 패키징하고, 프론트엔드에서 `Add to My Skills`를 제공하는 전달 메커니즘을 사용.”
- “GitHub import 경로 무효” → “GitHub 저장소는 백업·공개·버전 추적용으로 유지하고, 실제 등록 경로로 사용하지 않음.”

### 3.5 마누스가 가정한 것 3가지

**가정 1**: `skill-creator`는 `/home/ubuntu/skills/<skill-name>/`에 1개 스킬이 준비된 상태에서, 해당 스킬의 `SKILL.md`를 message tool로 첨부 전달하면 시스템이 자동으로 `.skill` 파일로 패키징하고 프론트엔드에 “Add to My Skills” 카드를 노출한다. 9개 스킬은 1회씩 9번 이 절차를 반복하는 것이 기본 가정이다.  
→ 근거: `/home/ubuntu/skills/skill-creator/SKILL.md` Step 5는 “The system will automatically: 1. Detect the path pattern `/home/ubuntu/skills/*/SKILL.md` 2. Package the skill directory into a `.skill` file 3. Send to frontend as a special card with options: Add to My Skills / Download / Preview”라고 명시한다. 또한 `skill-creator-input-mode-check.md` §4는 9개 일괄 처리 방식이 미명시이므로 “1개씩 호출이 기본 가정”이라고 정리했다.  
→ 검증: SUB-2에서 9개 스킬 각각 `quick_validate.py` 통과 후 `SKILL.md`를 1개씩 첨부 전달하고, 카드 9개 노출을 확인한다.

**가정 2**: 9개 기존 스킬은 신규 초기화 없이 `/home/ubuntu/skills/`로 복사해 validation을 수행하는 것이 적절하다.  
→ 근거: 이미 각 폴더에 `SKILL.md`, `scripts/`, `references/`가 존재하며 Phase D에서 32개 정상값으로 검증되었다.  
→ 검증: 복사 전후 파일 수·목록 대조 및 `quick_validate.py` 9회 실행.

**가정 3**: `.skill` 카드 프론트엔드 노출까지가 [Builder]가 수행하는 자동 단계이며, “Add to My Skills” 클릭은 [Owner] 계정에 실제 스킬을 등록하는 행위이므로 [Owner] 권한이다. [Builder]는 9개 카드를 노출한 뒤 [Owner]에게 클릭 요청을 보고하고 대기한다.  
→ 근거: `skill-creator` Step 5의 카드 옵션(“Add to My Skills / Download / Preview”)은 시스템이 사용자에게 선택지를 제공하는 형식이므로, 자동 등록이 아니라 [Owner]의 클릭이 필요한 단계임이 명시되어 있다.  
→ 검증: SUB-2에서 카드 9개 노출 후 [Owner] 클릭 요청 시점·응답을 handoff에 기록한다.

### 3.6 정렬 확인

- **정렬 일시**: 2026-05-17 08:55 KST
- **[Owner] 명시 응답**: “진입 가능한 절차면 → Phase F task-card 작성… 진행해.”

---

## 4. Tier 판정

- **Tier**: A
- **판정 근거**: 향후 모든 r6 task 자동화 기반이 되는 Manus Skills 9개를 실제 계정 환경에 직접 등록하는 운영 인프라 task다. 잘못 등록되면 향후 SUB 자동 로드·Builder 지휘·감리 호출·final-report 작성 절차 전체에 영향을 줄 수 있다.
- **Blast Radius**: 최악의 경우 잘못된 스킬이 Manus 계정에 등록되어 향후 task에서 잘못된 운영 절차를 반복하거나, 공개/백업 스킬과 실제 등록 스킬 사이 drift가 생길 수 있다.
- **Gate 의무**:
  - Tier A: [Reviewer] + [Judge] 둘 다, gate-review.md 필수

---

## 5. 작업 범위 (Scope)

### 5.1 포함

- `skill-creator` 사용법 근거 확인 및 절차 문서화.
- 로컬 `r6-rollout-package/dubyeol-workflow-skills/01-*` ~ `09-*` 9개 스킬 디렉터리를 `/home/ubuntu/skills/<skill-name>/` 표준 위치에 1개씩 복사한다. GitHub URL을 `skill-creator` 입력으로 사용하는 경로는 미명시이므로 사용하지 않는다. 마누스 환경에 GitHub 자료가 없는 경우 git clone 또는 동등 명령으로 로컬에 가져온 뒤 표준 위치로 복사한다.
- 원본 32개 파일 중 스킬 폴더 내부 30개 파일 복사 대조. README/LICENSE는 등록용 스킬 디렉터리에 포함하지 않고 백업/공개 자료로 유지.
- 9개 스킬 각각 validation 수행.
- 9개 `SKILL.md`를 첨부 전달해 직접 등록 카드 생성 여부 확인.
- 등록 후 Skills 목록 또는 slash command에서 9개 스킬 확인.

### 5.2 명시적 제외 (out of scope)

- GitHub import 재시도.
- 9개 스킬 내용 임의 수정. validation 실패 시 정정안 보고 후 [Owner] 승인 필요.
- GitHub 저장소 구조 변경, 추가 push, force push, 삭제.
- AGENTS.md, SUB-1~5, PROJECT.md 구조 자체 개정.
- [Owner] 확인 없는 계정 설정성 최종 등록 클릭.

### 5.3 산출물 (Deliverables)

- `.harness/runs/20260517_skills-direct-register/task-card.md`
- `.harness/runs/20260517_skills-direct-register/direct-register-procedure.md`
- `.harness/runs/20260517_skills-direct-register/validation-results.md`
- `.harness/runs/20260517_skills-direct-register/handoff.md`
- `.harness/runs/20260517_skills-direct-register/gate-review.md`
- `.harness/runs/20260517_skills-direct-register/final-report.md`

**환경간 산출물 흐름**: 마누스 환경에서 작성된 `.md` 산출물(`direct-register-procedure.md`, `validation-results.md`, `handoff.md`, `gate-review.md`, `final-report.md`)은 마누스가 메시지로 전달하고, [Owner] 또는 silkroadhub 측 [Foreman]이 `.harness/runs/20260517_skills-direct-register/` 경로에 박은 뒤 commit한다. Phase D와 동일 패턴.

---

## 6. 진행 트리 (두별 워크트리)

선택한 카테고리에 따른 진행 트리는 **AGENTS.md §[진행 트리] 참조**.

본 task의 카테고리: 머리의 *두별 워크트리 카테고리* 필드 확인.

### 6.1 변형 사유 (해당 시)

카테고리 4 표준 트리를 따른다. 단 최종 “Add to My Skills” 조작이 계정 설정성 조작으로 판정되면 [Owner] 확인 또는 브라우저 takeover가 필요하다.

---

## 7. 검증 명령

> 본 검증 명령은 마누스 [Builder] 환경(`/home/ubuntu/skills/`) 기준이다. 로컬 silkroadhub에서는 실행 불가하며, 검증 결과는 마누스가 `handoff.md`에 기록한다. 로컬에서는 원본 파일 구조 확인 명령(`find`, `wc`)만 실행 가능하다.

```bash
cd /Users/twostars/ClaudeAi/silkroadhub

# 원본 파일 구조 확인
find r6-rollout-package/dubyeol-workflow-skills -type f | wc -l
find r6-rollout-package/dubyeol-workflow-skills -mindepth 2 -type f | wc -l

# /home/ubuntu/skills 준비 후 각 스킬 검증
python /home/ubuntu/skills/skill-creator/scripts/quick_validate.py 01-load-sub-manual
python /home/ubuntu/skills/skill-creator/scripts/quick_validate.py 02-create-task-card
python /home/ubuntu/skills/skill-creator/scripts/quick_validate.py 03-dispatch-to-builder
python /home/ubuntu/skills/skill-creator/scripts/quick_validate.py 04-invoke-plan-review
python /home/ubuntu/skills/skill-creator/scripts/quick_validate.py 05-verify-handoff
python /home/ubuntu/skills/skill-creator/scripts/quick_validate.py 06-invoke-reviewer
python /home/ubuntu/skills/skill-creator/scripts/quick_validate.py 07-invoke-judge
python /home/ubuntu/skills/skill-creator/scripts/quick_validate.py 08-write-final-report
python /home/ubuntu/skills/skill-creator/scripts/quick_validate.py 09-update-project-md
```

---

## 8. 권한 천장·금지 사항 (재확인)

[Owner] 명시 승인 없이 [Builder]/[Foreman] 실행 금지:

- [ ] push / merge / deploy
- [ ] 운영 문서 변경 반영 (AGENTS.md, CLAUDE.md, templates 등)
- [ ] 파괴적 git 명령 (reset --hard, force push, history rewrite)
- [ ] task scope 확장 (§5.2 제외 범위 침범)
- [ ] 외부 시스템 프로덕션 실호출
- [ ] Tier 강등

본 task 특유의 추가 금지 사항:

- GitHub import 경로를 재시도하지 않는다.
- validation 실패를 숨기지 않는다.
- 계정 내 스킬 등록 클릭이 필요한 경우 [Owner] 확인 없이 진행하지 않는다.
- 9개 스킬 중 일부만 등록된 상태를 전체 성공으로 보고하지 않는다.
- `.skill` 카드 프론트엔드 노출까지가 [Builder] 권한이다. 카드의 “Add to My Skills” 버튼 클릭은 [Owner] 권한이며, [Builder]는 9개 카드를 모두 노출한 뒤 [Owner]에게 일괄 클릭 요청을 보고하고 대기한다. [Builder]가 [Owner] 확인 없이 임의로 클릭을 가정·진행하지 않는다.

---

## 9. 의도 변경 기록 (해당 시만 추가)

없음.

---

## 10. PROJECT.md 갱신 사항 (task 종료 시 [Foreman] 작성, SUB-5)

### 10.1 §C.1 모듈 갱신

- **현재 상태**: GitHub import 경로 무효 확인, 직접 등록 예정 → SUB-5에서 실제 등록 결과에 따라 확정
- **최근 마일스톤에 추가**: 2026-05-17: `skill-creator` 기반 9개 스킬 직접 등록 수행.
- **다음 마일스톤에서 완료 처리(체크)**: 마누스 `skill-creator`를 활용해 `r6-rollout-package/dubyeol-workflow-skills/`의 9개 스킬을 Manus에 직접 등록.
- **다음 마일스톤에 추가**: 등록 후 r7 매뉴얼·프로젝트 지침의 스킬 호출 표를 실제 등록 방식에 맞춰 개정.
- **현재 막힌 점**: SUB-5에서 등록 결과에 따라 확정.

### 10.2 §D 결정 이력 추가 (큰 결정 발생 시)

- **날짜**: 2026-05-17
- **결정**: GitHub import가 아니라 `skill-creator` 직접 등록 경로를 r6 스킬 등록 정답 경로로 채택한다.
- **사유**: [Owner] 확인 및 `skill-creator` 문서 확인 결과, `/home/ubuntu/skills/*/SKILL.md` 첨부가 `.skill` 카드와 Add to My Skills 흐름을 제공함.
- **영향 모듈**: §C.1 두별 워크플로우 운영 인프라

### 10.3 §A·§B 갱신 (카테고리 5 기획 task일 때만)

- §A 변경 사항: 해당 없음
- §B 변경 사항: 해당 없음

### 10.4 PROJECT.md 반영 확인

- **반영 일시**: SUB-5에서 기록 예정
- **PROJECT.md §E.마지막 갱신 task run ID에 박은 값**: 20260517_skills-direct-register

### 10.5 handoff.md 작성 의무 사항

handoff.md 작성 시 다음을 별도 섹션으로 박는다:

- 9개 스킬 복사 결과 (`r6-rollout-package/` → `/home/ubuntu/skills/` 복사 단위·파일 수 대조)
- 9개 스킬 frontmatter 필드 비교 결과 (`name`, `description` 외 `license` 필드 보유 여부, 마누스 공식 `skill-creator`와의 형식 차이)
- 9개 스킬 validation 결과 (`quick_validate.py` 호출 9회 결과, 스킬별 PASS/FAIL 및 실패 사유)
- 1개 이상 validation 실패 시 처리 분기 (전체 중단 / 부분 진행 / [Owner] 결정 요청 중 어느 분기 선택했는지 및 사유)
- 9개 `.skill` 카드 생성 결과 (9개 모두 생성 / 일부 생성 / 생성 실패)
- [Owner] “Add to My Skills” 클릭 요청 시점과 응답 결과 (9개 모두 클릭 완료 / 일부 클릭 / [Owner] 보류)
- 등록 후 Skills 목록 또는 slash command에서 9개 노출 검증 결과

---

## 11. 다음 단계 진행 가이드

- [ ] [Owner] task-card 결재
- [ ] 단계 2 (워크플로우) 진입

---

**task-card 끝.**
