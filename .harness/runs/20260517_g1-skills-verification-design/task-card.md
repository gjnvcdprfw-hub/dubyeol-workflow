# task-card: G-1 9개 Manus Agent Skills 동작 검증 설계

**run ID**: 20260517_g1-skills-verification-design  
**작성일시**: 2026-05-17 13:48 KST  
**작성자**: [Foreman]  
**상태**: 기획 완료  
**두별 워크트리 카테고리**: 4 (문서·운영)  
**Tier**: B

---

## 1. [Owner] 발화 원문

> [추가 운영 지침 — 클로드코드/코덱스 세션 시작]
>
> 본 G-1 task는 검증 설계 작성 위주이므로 SUB-2 진행 중 클로드코드 [Builder] 호출 필요성 자체가 낮을 수 있다. 다만 다음 경우 클로드코드 [Builder] 세션 시작이 필요하다:
>
> - 검증 설계서 작성 중 dubyeol-workflow 로컬 파일 직접 조작 (예: .harness/runs/ 폴더 신설, 산출물 저장)
> - 설계서 작성 후 commit 단계
>
> 이 경우 다음 절차 적용 (AGENTS.md §12 베타 운영 + 회고 17 학습):
>
> 1. 이전 세션 존재 여부 확인
>    - macOS Terminal에 클로드코드 세션이 이미 실행 중인지 osascript로 확인
>    - 이전 세션이 있어도 본 task용으로 사용하지 않는다
>
> 2. 새 Terminal 창 열기
>    - 마누스가 자기 책임으로 osascript로 새 Terminal 창 생성
>    - 위치: /Users/twostars/ClaudeAi/dubyeol-workflow
>
> 3. 새 클로드코드 세션 시작
>    - 새 창에서 `claude` 명령으로 신규 세션 시작
>    - using-superpowers 스킬 활성화
>
> 4. AGENTS.md §12 베타 운영 Step 2~5 절차 준용
>    - Step 2: 창 ID 조회
>    - Step 3: 입력 파일 저장 + 짧은 명령 전달
>    - Step 4: 2단계 확정 실행
>    - Step 5: 응답·산출물 확인
>
> 코덱스 [Reviewer] 호출 시도 동일 절차 적용. 단 본 G-1은 SUB-3 외부 감리 생략 가능성이 높으므로 코덱스 호출 자체가 발생하지 않을 수 있다.
>
> 원칙:
> - 이전 세션 컨텍스트가 남아 있으면 본 task에 영향 가능. 항상 새 세션으로 시작
> - [Owner]가 매번 Terminal 직접 열어주는 게 아니다. 마누스가 자기 책임으로 시작
> - 도구가 환경에서 호출 불가하면 명시 보고하고 [Owner] 결정 요청
>
> 본 운영 지침은 회고 17 (AGENTS.md §12 일반화)의 사전 적용이다. r7 정비 시 §12 본문 정정 예정이지만 본 task부터 학습 반영해 운영한다.
>
> 진행해.

### 1.1 SUB-1 정렬 검수 및 결재 발화

> SUB-1 정렬 검수 완료.
>
> 평가:
> - What·Looks Like·Looks Wrong·모호어 해소·가정 모두 정합
> - 특히 Looks Wrong #3 (silkroadhub 잘못 저장 방지)은 본 세션 학습 (분리 task 산출물 위치) 반영 우수
> - 가정 2의 신중함 (task-card 결재 전 본문 확정 안 함) 적정
> - run_id: 20260517_g1-skills-verification-design (g1- 접두사 추가 안 채택)
>
> Tier B 확정
>
> 마누스 권고 수용. 이유:
> - 본 task는 G-1 단독 (설계서 작성만). 실제 검증·동작 변경은 G-2 영역
> - 설계서 단계에 SUB-3 외부 감리 발동하면 G-2에서 또 발동해야 함. 비효율
> - SUB-3 외부 감리는 G-2에 집중하는 게 정합
> - AGENTS.md §3.5 Tier B 기준 ("내부 거버넌스 자산 영향만, 실 운영 데이터 영향 없음") 부합
>
> load_sub.sh 부재 사실 — 회고 누적
>
> scripts/load_sub.sh를 마스터 저장소에서 찾지 못해 수동 로드한 사실은 9개 스킬 중 01-load-sub-manual의 동작 의심 신호다. 본 G-1 task 진행에는 영향 없으나 다음 처리:
>
> 1. 본 G-1 검증 설계서의 9개 스킬별 의도 정리 §1에서 01-load-sub-manual 항목에 본 부재 사실을 명시 기록
> 2. G-2 검증 시점에 01-load-sub-manual을 우선 검증 대상으로 분류
> 3. 본 task의 회고 후보로 누적
>
> 마누스 자체 판단으로 위 3건 반영해 진행.
>
> 진행
>
> SUB-1 결재. SUB-2 검증 설계서 작성 진입.
>
> 추가 운영 지침 (회고 17 사전 적용):
> - SUB-2에서 dubyeol-workflow 로컬 파일 조작 필요 시 새 Terminal 창 + 새 클로드코드 세션 시작
> - 이전 세션 컨텍스트 무시
> - 마누스가 자기 책임으로 osascript 활용해 새 세션 시작
> - AGENTS.md §12 베타 운영 절차 준용
>
> 진행해.

---

## 2. 상위 맥락 연결 (PROJECT.md 진입 시점)

- **연결 모듈**: §C.1 두별 워크플로우 운영 인프라
- **진입 시점 마일스톤**: §C.1 다음 마일스톤 중 `Phase G-1: 9개 스킬 동작 검증 설계 (dubyeol-workflow 마스터에서 별도 task)`
- **이번 task로 *전진시키는 것***: 9개 Manus Agent Skills의 실제 검증(G-2) 전에 검증 목적, 절차, 증거 기준, 실패 신호, 우선순위를 문서화한다.
- **PROJECT.md 진입 시점 스냅샷**:
  - 모듈 상태: Phase H 완료. 마스터/클라이언트 분리 실행. 9개 스킬은 `dubyeol-workflow` 마스터에서 Phase G-1 동작 검증 설계 대기 중.
  - 현재 막힌 점: Phase G-1 동작 검증 설계는 Phase H 완료 확인 후 진입.

---

## 3. 의도 정렬 증거 블록 (SUB-1 §2 SOP 결과 — 불변)

> 본 블록은 task 진행 중 **수정 금지**. 의도 변경 발생 시 §9에 *추가* 블록으로 기록.

### 3.1 한 문장 목표 (What)

`dubyeol-workflow` 마스터에서 9개 Manus Agent Skills의 동작 검증 설계서를 작성하고, 향후 실제 검증·회고·r7 정비로 이어질 기준을 세운다.

### 3.2 성공 시 보이는 모습 (Looks Like)

- `.harness/runs/20260517_g1-skills-verification-design/` 아래에 G-1 검증 설계 산출물이 저장된다.
- 9개 스킬 각각에 대해 검증 목적, 입력 조건, 기대 동작, 실패 신호, 증거 파일 기준이 정리된다.
- Builder·Reviewer 호출 필요 여부가 명확히 분기되어, 불필요한 세션 호출을 하지 않는다.
- commit 단계는 [Owner] 별도 승인 없이는 진행하지 않는 것으로 명시된다.
- Phase G-1 이후 실제 검증 task 또는 r7 정비 task로 이어질 후속 기준이 남는다.

### 3.3 실패 시 보이는 모습 (Looks Wrong)

- 검증 설계가 9개 스킬 중 일부만 다루고 누락 스킬이 발생한다.
- 설계서가 실제 실행 증거 기준 없이 선언적 설명만 포함한다.
- `dubyeol-workflow` 마스터가 아니라 `silkroadhub` 클라이언트 저장소 기준으로 산출물이 작성된다.
- [Owner] 승인 없이 commit, push, 운영 문서 반영이 수행된다.
- Builder·Reviewer·Judge 역할 분리가 흐려져 코드 검토와 기획 검토 입력이 섞인다.

### 3.4 모호어 해소 기록

- "진행해" → "SUB-1부터 순서대로 진행하라"
- "검증 설계 작성 위주" → "실제 검증 실행이 아니라 검증 계획·기준·증거 설계가 중심"

### 3.5 마누스가 가정한 것 3가지

**가정 1**: 작업 대상은 `silkroadhub`가 아니라 `/Users/twostars/ClaudeAi/dubyeol-workflow` 마스터 저장소다.  
→ 근거: [Owner] 추가 운영 지침과 PROJECT.md §A.3·§C.1이 G-1을 `dubyeol-workflow` 마스터 task로 지정한다.  
→ 검증: PROJECT.md 진입 점검 및 run 디렉터리 경로를 `/Users/twostars/ClaudeAi/dubyeol-workflow/.harness/runs/20260517_g1-skills-verification-design/`로 생성해 확인한다.

**가정 2**: 이번 SUB-1 이후 산출물 작성은 로컬 파일 직접 조작이므로, 필요 시 새 클로드코드 Builder 세션을 열되, task-card 결재 전에는 설계서 본문을 확정하지 않는다.  
→ 근거: [Owner] 추가 운영 지침은 로컬 파일 직접 조작 또는 commit 단계에서 새 Builder 세션 시작을 요구한다.  
→ 검증: SUB-1 결재 후에만 SUB-2 진입 명령을 만들고, 이전 세션을 본 task용으로 재사용하지 않는다.

**가정 3**: 이번 작업은 운영 인프라 검증 설계이므로 고객·결제·통관 운영 데이터에는 직접 영향이 없지만, 내부 거버넌스 자산과 미래 운영에 영향을 주어 Tier B다.  
→ 근거: SUB-1 §4.2는 내부 거버넌스 자산 영향과 향후 운영 난이도 증가 가능성을 Tier B 기준으로 둔다.  
→ 검증: [Owner]가 `Tier B 확정`을 명시했고, 본 task가 설계서 작성만 수행하며 실제 검증·동작 변경은 G-2 영역이라고 확인했다.

### 3.6 정렬 확인

- **정렬 일시**: 2026-05-17 13:48 KST
- **[Owner] 명시 응답**: "SUB-1 정렬 검수 완료. ... Tier B 확정 ... 진행. SUB-1 결재. SUB-2 검증 설계서 작성 진입."

---

## 4. Tier 판정

- **Tier**: B
- **판정 근거**: 내부 거버넌스 자산과 미래 운영에 영향을 줄 수 있으나 고객·운영 데이터, 결제, 통관, 인증, 외부 프로덕션 시스템을 직접 변경하지 않는다.
- **Blast Radius**: 최악의 경우 9개 스킬 검증의 기준이 잘못 설계되어 G-2 실제 검증과 r7 정비 방향이 왜곡될 수 있다. 다만 본 task 자체는 설계서 작성으로 제한되며 실 운영 데이터나 외부 시스템에는 직접 영향이 없다.
- **Gate 의무**:
  - Tier B 원칙상 [Judge] 필수, gate-review.md 필수다.
  - 단, [Owner]는 본 G-1이 설계서 작성만 수행하고 실제 검증·동작 변경은 G-2 영역이므로 SUB-3 외부 감리는 G-2에 집중하라고 명시했다.
  - 따라서 본 task에서는 SUB-3 생략 사유와 [Owner] 명시 지시를 final-report와 회고 후보에 기록하고, G-2에서 외부 감리 집중 검토를 계획한다.

---

## 5. 작업 범위 (Scope)

### 5.1 포함

- `.harness/runs/20260517_g1-skills-verification-design/` run 디렉터리 구성.
- G-1 검증 설계서 작성. 설계서는 9개 스킬 각각의 의도, 검증 목적, 입력 조건, 기대 동작, 실패 신호, 증거 파일 기준, G-2 우선순위를 포함한다.
- `01-load-sub-manual` 항목에 `scripts/load_sub.sh` 부재 사실을 의심 신호로 명시하고, G-2 우선 검증 대상으로 분류한다.
- Builder 세션이 필요한 경우 [Owner] 추가 운영 지침에 따라 새 Terminal 창과 새 Claude Code 세션을 사용한다.
- task 완료 시 handoff, final-report, 회고 후보를 같은 run 디렉터리에 남긴다.

### 5.2 명시적 제외 (out of scope)

- 9개 스킬의 실제 실행 검증 또는 수정은 G-2 영역으로 남긴다.
- 스킬 파일, AGENTS.md, PROJECT.md, SUB-1~5, `.harness/templates/*` 같은 운영 문서의 실제 반영 변경은 [Owner] 별도 승인 없이 수행하지 않는다.
- commit, push, merge, deploy는 [Owner] 별도 승인 없이는 수행하지 않는다.
- `silkroadhub` 클라이언트 저장소 파일을 본 task 산출물 대상으로 사용하지 않는다.
- 코덱스 [Reviewer] 또는 지피티 [Judge] 호출은 본 G-1에서 [Owner]가 G-2 집중을 지시했으므로 수행하지 않는다. 단, 이 생략은 회고 후보와 G-2 계획에 명시한다.

### 5.3 산출물 (Deliverables)

- `.harness/runs/20260517_g1-skills-verification-design/task-card.md`
- `.harness/runs/20260517_g1-skills-verification-design/g1-skills-verification-design.md`
- `.harness/runs/20260517_g1-skills-verification-design/handoff.md`
- `.harness/runs/20260517_g1-skills-verification-design/final-report.md`
- 필요 시 `.harness/runs/20260517_g1-skills-verification-design/claude-entry-instruction.md` 및 Builder 응답 로그

---

## 6. 진행 트리 (두별 워크트리)

선택한 카테고리에 따른 진행 트리는 **AGENTS.md §3 진행 트리**를 따른다.

본 task의 카테고리: 4 (문서·운영).

### 6.1 변형 사유 (해당 시)

카테고리 4 표준 트리는 `using-superpowers → brainstorming → 작성 → 자체 review → finishing-a-development-branch`다. 본 task는 로컬 파일 산출물 저장이 필요하므로 SUB-2에서 Builder 호출 가능성이 있으며, [Owner] 추가 운영 지침에 따라 기존 세션을 재사용하지 않고 새 Terminal 창과 새 Claude Code 세션을 사용한다. 다만 본문 설계 작업은 G-1 범위로 제한하고, 실제 검증 실행·수정·외부 감리는 G-2로 넘긴다.

---

## 7. 검증 명령

본 task는 문서·운영 설계 산출물이므로 코드 테스트 대신 파일 존재, 필수 섹션, 9개 스킬 누락 여부, 금지 경로 오염 여부를 확인한다.

```bash
cd /Users/twostars/ClaudeAi/dubyeol-workflow

# 산출물 존재 확인
test -f .harness/runs/20260517_g1-skills-verification-design/task-card.md
test -f .harness/runs/20260517_g1-skills-verification-design/g1-skills-verification-design.md
test -f .harness/runs/20260517_g1-skills-verification-design/handoff.md

# 9개 스킬명이 설계서에 모두 포함되는지 확인
for skill in \
  01-load-sub-manual \
  02-create-task-card \
  03-dispatch-to-builder \
  04-invoke-plan-review \
  05-verify-handoff \
  06-invoke-reviewer \
  07-invoke-judge \
  08-write-final-report \
  09-update-project-md; do
  grep -q "$skill" .harness/runs/20260517_g1-skills-verification-design/g1-skills-verification-design.md
done

# G-2 우선 검증 의심 신호가 명시됐는지 확인
grep -q "scripts/load_sub.sh" .harness/runs/20260517_g1-skills-verification-design/g1-skills-verification-design.md
grep -q "G-2 우선" .harness/runs/20260517_g1-skills-verification-design/g1-skills-verification-design.md

# silkroadhub 클라이언트 경로에 본 run 산출물이 생기지 않았는지 확인
test ! -d /Users/twostars/ClaudeAi/silkroadhub/.harness/runs/20260517_g1-skills-verification-design

# 권한 천장 위반 의심 로그 확인: push/merge/deploy 명령 흔적은 없어야 함
git status --short
```

명령 실행 결과는 handoff 또는 final-report에 증거로 기록한다.

---

## 8. 권한 천장·금지 사항 (재확인)

[Owner] 명시 승인 없이 [Builder] 실행 금지:

- [ ] push / merge / deploy
- [ ] 운영 문서 변경 반영 (AGENTS.md, CLAUDE.md, PROJECT.md, templates 등)
- [ ] 파괴적 git 명령 (reset --hard, force push, history rewrite)
- [ ] task scope 확장 (§5.2 제외 범위 침범)
- [ ] 외부 시스템 프로덕션 실호출
- [ ] Tier 강등

본 task 특유의 추가 금지 사항:

- 이전 Claude Code 또는 Codex 세션을 본 task용으로 재사용하지 않는다.
- `silkroadhub` 클라이언트 저장소에 G-1 산출물을 저장하지 않는다.
- 실제 스킬 동작 검증이나 스킬 수정은 G-2 전까지 수행하지 않는다.
- [Builder]·[Reviewer]·[Judge] 입력을 혼합하지 않는다.
- commit은 [Owner] 별도 승인 전 수행하지 않는다.

---

## 9. 의도 변경 기록 (해당 시만 추가)

없음.

---

## 10. PROJECT.md 갱신 사항 (task 종료 시 [Foreman] 작성, SUB-5)

> task 진행 중에는 비워둠. SUB-5 종료 단계에서 [Foreman]이 작성 후, 본 내용을 PROJECT.md §C.N에 *그대로 옮긴다*.

### 10.1 §C.1 모듈 갱신

- **현재 상태**: Phase H 완료. 마스터/클라이언트 분리 실행. 9개 스킬은 `dubyeol-workflow` 마스터에서 Phase G-1 동작 검증 설계 대기 중. → Phase G-1 검증 설계서 작성 완료. 9개 스킬별 검증 목적·입력·기대 동작·실패 신호·증거 기준·G-2 우선순위를 문서화했고, `01-load-sub-manual`의 `scripts/load_sub.sh` 부재 의심 신호를 G-2 최우선 검증 대상으로 확정.
- **최근 마일스톤에 추가**: 2026-05-17: Phase G-1 — 9개 Manus Agent Skills 동작 검증 설계 완료. `01-load-sub-manual`의 `scripts/load_sub.sh` 부재 의심 신호를 G-2 최우선 검증 대상으로 기록. (run: `20260517_g1-skills-verification-design`)
- **다음 마일스톤에서 완료 처리(체크)**: Phase G-1: 9개 스킬 동작 검증 설계.
- **다음 마일스톤에 추가**: Phase G-2: 9개 스킬 실제 동작 검증 수행 및 외부 감리 집중. `01-load-sub-manual`을 최우선 검증 대상으로 시작.
- **현재 막힌 점**: Phase G-1 대기 상태는 해소. 다음 막힌 점은 G-2 실제 검증 전 `01-load-sub-manual`의 스크립트 의존성(`scripts/load_sub.sh`) 존재 여부와 스킬 지시문 정합성 확인 필요.

### 10.2 §D 결정 이력 추가 (큰 결정 발생 시)

- **날짜**: 2026-05-17
- **결정**: G-1은 9개 스킬 동작 검증의 설계 task로 제한하고, 실제 검증·외부 감리는 G-2에 집중한다.
- **사유**: 설계 단계와 실제 검증 단계에서 외부 감리를 중복 호출하면 비효율이 발생하므로, blast radius가 커지는 G-2에 감리를 집중한다.
- **영향 모듈**: §C.1

### 10.3 §A·§B 갱신 (카테고리 5 기획 task일 때만)

해당 없음.

### 10.4 PROJECT.md 반영 확인

- **반영 일시**: 2026-05-17 KST
- **PROJECT.md §E.마지막 갱신 task run ID에 박은 값**: 20260517_g1-skills-verification-design

---

## 11. 다음 단계 진행 가이드

- [x] [Owner] task-card 결재 ("진행" 응답)
- [x] 단계 2 (워크플로우) 진입 승인
- [ ] SUB-2 매뉴얼 로드
- [ ] 필요 시 새 Builder 세션 시작
- [ ] G-1 검증 설계서 작성 및 handoff 수신

---

**task-card 끝.**
