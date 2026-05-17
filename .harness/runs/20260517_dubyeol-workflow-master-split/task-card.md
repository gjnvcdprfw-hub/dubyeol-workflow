# task-card: 두별 워크플로우 마스터/클라이언트 분리

**run ID**: 20260517_dubyeol-workflow-master-split  
**작성일시**: 2026-05-17 10:10 KST  
**작성자**: [Foreman]  
**상태**: 기획 완료  
**두별 워크트리 카테고리**: 4 (문서·운영)  
**Tier**: A

---

## 1. [Owner] 발화 원문

> [Phase H 진입 — 두별 워크플로우 재구조화: 마스터/클라이언트 분리]
>
> Phase F 종료, Phase G-1 진입 보류. 두별 워크플로우 자체의 구조 재정의 결정에 따라 Phase H를 먼저 진행한다.
>
> 본 Phase H는 회고 13급 결정에 해당하는 큰 재구조화이므로, 마누스가 직접 작업 진입하지 말고 SUB-1 5단계 SOP에 따라 task-card부터 작성해라.
>
> [Owner] 결정 사항: 두별 워크플로우는 두별 사이에 공유되는 운영 프레임워크/도구킷이며, silkroadhub는 첫 번째 사업 클라이언트다. 마스터 원본은 AGENTS.md, PROJECT.md, SUB-1~5 매뉴얼·양식, 9개 스킬, .harness/runs Phase A~F 전체다. 마스터 로컬 경로는 `/Users/twostars/ClaudeAi/dubyeol-workflow`다. 기존 `gjnvcdprfw-hub/dubyeol-workflow-skills`는 `dubyeol-workflow`로 rename한다. Phase A~F는 silkroadhub `.harness/runs`에서 dubyeol-workflow `.harness/runs`로 이전한다. silkroadhub PROJECT.md에서는 §C.1을 제거하고 §D 결정 이력을 추가한다. dubyeol-workflow PROJECT.md를 신설한다. Phase H 완료 후 Phase G-1은 dubyeol-workflow 마스터에서 진행한다.
>
> 추가 지시: PROJECT.md 분리 처리는 silkroadhub/PROJECT.md 정정과 dubyeol-workflow/PROJECT.md 신설을 별개 단계로 박는다. `test_claude_dispatch`는 Builder가 실제 이전 시 dispatch 테스트 성격 확인 후 이전/잔존 결정한다. handoff에는 파일 수 대조, `git log --follow`, GitHub rename 전후 URL 동작 검증, remote URL 기록을 포함한다.

---

## 2. 상위 맥락 연결 (PROJECT.md 진입 시점)

- **연결 모듈**: silkroadhub `PROJECT.md` §C.1 두별 워크플로우 운영 인프라. 본 Phase H 완료 후 해당 모듈은 silkroadhub에서 제거되고, 신설 `dubyeol-workflow/PROJECT.md`의 §C 구조로 이전되어야 한다.
- **진입 시점 마일스톤**: silkroadhub `PROJECT.md` §C.1의 다음 마일스톤은 “마누스 `skill-creator`를 활용해 9개 스킬을 Manus에 직접 등록”이었고, Phase F에서 완료되었다. Phase G-1은 보류되었으며, 본 Phase H에서 마스터/클라이언트 경계를 먼저 재정의한다.
- **이번 task로 *전진시키는 것***: 두별 워크플로우 운영 인프라를 silkroadhub 사업 저장소의 하위 모듈에서 독립 마스터 저장소·로컬 폴더·PROJECT.md로 분리하기 위한 실행 task-card를 확정한다.
- **PROJECT.md 진입 시점 스냅샷**:
  - 모듈 상태: `PROJECT.md` §C.1에는 GitHub import 경로 재해석, Phase D/F 맥락, 9개 스킬 직접 등록 예정 상태가 기록되어 있다.
  - 현재 막힌 점: Phase G-1 동작 검증 설계는 보류되었고, 두별 워크플로우 자체 정체성·저장 위치·repo 경계 재정의가 선행되어야 한다.

---

## 3. 의도 정렬 증거 블록 (SUB-1 §2 SOP 결과 — 불변)

> 본 블록은 task 진행 중 **수정 금지**. 의도 변경 발생 시 §9에 *추가* 블록으로 기록.

### 3.1 한 문장 목표 (What)

두별 워크플로우를 silkroadhub 내부 운영물이 아니라 두별 간 공유되는 독립 마스터 운영 프레임워크/도구킷으로 분리하기 위한 Phase H 실행 계획과 권한 경계를 task-card로 확정한다.

### 3.2 성공 시 보이는 모습 (Looks Like)

- `dubyeol-workflow` 마스터와 silkroadhub 클라이언트의 **정체성·자료 경계·참조 관계**가 task-card에 명확히 기록된다.
- Scope에는 두별 워크플로우 자료 식별, 마스터 폴더 구성, Phase A~F runs 이전, `silkroadhub/PROJECT.md` 정정, `dubyeol-workflow/PROJECT.md` 신설, GitHub repo rename 검증, silkroadhub cleanup이 구체적으로 포함된다.
- `silkroadhub/PROJECT.md` 정정과 `dubyeol-workflow/PROJECT.md` 신설은 **별개 작업 단계**로 분리되어 기록된다.
- GitHub repo rename은 [Owner] 권한 작업으로 분리되고, [Builder]/[Foreman]은 rename 전후 URL·clone/fetch/push redirect·remote URL 기록 검증만 수행하도록 명시된다.
- Phase H 완료 후 Phase G-1은 silkroadhub가 아니라 `dubyeol-workflow` 마스터에서 진행한다는 순서가 task-card에 박힌다.

### 3.3 실패 시 보이는 모습 (Looks Wrong)

- task-card 결재 전에 `/Users/twostars/ClaudeAi/dubyeol-workflow` 실구성, 파일 이전, 삭제, GitHub rename, remote 변경 같은 실행 작업이 진행된다.
- 두별 워크플로우 자료와 silkroadhub 사업 자료의 경계가 모호해져, 사업 코드·도메인 runs까지 마스터로 이동하거나 반대로 운영 매뉴얼·스킬 자료가 silkroadhub에 잔존한다.
- Phase A~F runs 이전 범위가 추상적으로 남고, 이전 전후 파일 수 대조 및 `git log --follow` 무결성 검증 의무가 빠진다.
- GitHub rename 후 기존 URL redirect와 새 URL 동작을 검증하지 않고 repo rename 성공으로 보고한다.
- `silkroadhub/PROJECT.md`와 `dubyeol-workflow/PROJECT.md` 처리가 한 덩어리로 뭉개져 한쪽만 반영되거나 회고 1~14 이전이 누락된다.

### 3.4 모호어 해소 기록

- “Phase A~F 일체” → “현재 확인된 r6 관련 후보 runs를 출발점으로 하되, [Builder]가 실제 이전 전 task-card 제목·Phase 표기·파일 수를 대조해 Phase A~F 이전 범위를 확정한다.”
- “현재 존재하지 않는 폴더” → “확인 결과 `/Users/twostars/ClaudeAi/dubyeol-workflow` 경로는 이미 존재하지만 비어 있다. 본 task에서는 이를 ‘비어 있는 신설 목적 폴더’로 취급하고, 실제 구성은 task-card 결재 후 SUB-2에서 수행한다.”
- “참조 방식” → “symlink, git submodule, 단순 복사 중 즉시 확정하지 않고, Phase H에서는 설계 옵션과 권고안을 task-card에 박은 뒤 [Builder]가 handoff에서 선택 근거와 적용 결과를 보고한다.”
- “silkroadhub/.harness/runs/는 비워둠” → “두별 워크플로우 Phase A~F에 해당하는 run 산출물만 이전 대상으로 삼고, silkroadhub 사업 task run은 임의 삭제하지 않는다. 이전 후 silkroadhub runs 구조 정리는 파일 수 대조와 Owner 승인 경계 안에서 수행한다.”

### 3.5 마누스가 가정한 것 3가지

**가정 1**: 두별 워크플로우 자료 식별 기준은 `AGENTS.md`, `SUB-1~5`, `.harness/templates`, `.harness/manus-prompts`, `r6-rollout-package`, 9개 Manus Skills, Phase A~F 관련 `.harness/runs`, 그리고 silkroadhub `PROJECT.md` §C.1·§D의 두별 워크플로우 회고·결정 이력이다. silkroadhub 사업 기능 코드(`backend`, `frontend`, 사업 도메인 docs, manifest·BL·통관 등 사업 runs)는 클라이언트 자료로 남긴다.  
→ 근거: [Owner]가 마스터 원본 범위를 “두별 워크플로우 관련 자료 전부”로 확정했고, 현장 확인 결과 silkroadhub 루트와 `r6-rollout-package`에 r6 매뉴얼·양식·스킬 자료가 존재한다.  
→ 검증: [Builder]는 이전 전 `find`/파일 목록으로 두별 후보와 silkroadhub 잔존 후보를 표로 대조하고, 경계가 애매한 파일은 handoff에 “Owner 확인 필요”로 분리한다.

**가정 2**: Phase A~F runs 이전은 git history 추적성을 최우선으로 하므로, 1순위는 `git mv` 또는 동일 효과의 move 기반 이전이다. 불가피하게 `copy + delete`를 쓰는 경우에도 전후 파일 수 대조, `git status`, `git log --follow` 샘플 검증을 handoff 의무로 둔다.  
→ 근거: 본 task는 자료 손실·운영 이력 단절 위험이 큰 Tier A 재구조화이며, [Owner]가 history 보존 여부와 git log 무결성 확인을 명시 요구했다.  
→ 검증: [Builder]는 이전 대상 run별 파일 수, 이전 후 `dubyeol-workflow/.harness/runs` 파일 수, silkroadhub 잔존 파일 수, `git log --follow` 결과를 handoff §10.5 형식으로 보고한다.

**가정 3**: GitHub repo rename은 [Owner]가 직접 수행하며, GitHub 공식 문서 기준으로 기존 web traffic과 `git clone`·`git fetch`·`git push`는 rename 후 새 위치로 redirect되지만, 혼동 방지를 위해 local clone의 remote URL은 새 URL로 갱신하는 것이 권고된다.[1] silkroadhub local remote URL은 별도 silkroadhub repo이므로 변경하지 않고, `dubyeol-workflow` local에서만 GitHub remote 연결 시점과 URL을 기록한다.  
→ 근거: [Owner]가 repo rename을 계정 설정성 조작으로 분류해 직접 수행한다고 확정했고, GitHub 공식 문서는 rename redirect와 `git remote set-url origin NEW_URL` 권고를 명시한다.[1]  
→ 검증: [Foreman]/[Builder]는 Owner rename 완료 후 old URL과 new URL의 `gh repo view`, clone/fetch/push redirect 또는 dry-run 성격 검증, `git remote -v` 기록을 handoff에 남긴다. 실제 push는 Owner 명시 승인 전 금지한다.

### 3.6 정렬 확인

- **정렬 일시**: 2026-05-17 10:05 KST
- **[Owner] 명시 응답**: “정렬 확인, task-card 작성 진행.”

---

## 4. Tier 판정

- **Tier**: A
- **판정 근거**: 본 task는 두별 워크플로우 운영 원본, 매뉴얼, 스킬, run 이력, GitHub repo 이름, PROJECT.md 체계를 재구조화한다. 내부 거버넌스 자산과 다수 파일시스템 변경을 포함하고, [Owner]가 Tier A로 확정했다.
- **Blast Radius**: 최악의 경우 두별 워크플로우 원본·회고·스킬·run 이력이 손실되거나 silkroadhub 사업 자료와 운영 프레임워크 자료가 뒤섞여 향후 모든 사업 프로젝트의 운영 기준이 오염될 수 있다. GitHub rename 검증 누락 시 기존 참조 URL·clone 경로·자동화 경로가 혼란을 일으킬 수 있다.
- **Gate 의무**:
  - Tier A: [Reviewer] + [Judge] 둘 다, gate-review.md 필수.
  - 본 task-card 작성 단계는 SUB-1이며 실제 감리는 SUB-2 완료 후 수행한다.
  - SUB-2 handoff 위에서 Reviewer/Judge 감리를 수행한다.

---

## 5. 작업 범위 (Scope)

### 5.1 포함

| 단계 | 작업 | 포함 내용 | 완료 기준 |
|---:|---|---|---|
| 1 | 두별 워크플로우 정체성·경계 고정 | 마스터/클라이언트 정의, 두별 자료와 silkroadhub 사업 자료 식별 기준 확정 | handoff에 “마스터로 이전/복사할 자료”와 “silkroadhub에 남길 자료” 표가 존재 |
| 2 | `dubyeol-workflow` 마스터 로컬 구성 | `/Users/twostars/ClaudeAi/dubyeol-workflow` 비어 있는 폴더를 마스터 작업공간으로 구성. AGENTS.md, SUB-1~5, `.harness/templates`, `.harness/manus-prompts`, r6 패키지, 9개 스킬 자료 배치 | 마스터 폴더 파일 목록과 source→destination 대조표 제출 |
| 3 | Phase A~F `.harness/runs` 이전 | 후보는 `20260516_claude-md-r6-update`, `20260516_skills-github-register`, `20260517_skills-direct-register`, `test_claude_dispatch`이며, `test_claude_dispatch`는 [Builder]가 dispatch 테스트 성격을 확인해 이전/잔존 여부를 결정 | 이전 전후 파일 수 대조, 이전 대상 확정 근거, `git log --follow` 무결성 샘플 검증 기록 |
| 4 | `silkroadhub/PROJECT.md` 정정 | §C.1 두별 워크플로우 운영 인프라 모듈 통째 삭제, §D에 “두별 워크플로우 마스터 분리 완료, dubyeol-workflow repo 참조” 결정 이력 추가 | silkroadhub PROJECT.md가 사업 자료 중심으로 정리되고, 두별 워크플로우 모듈이 잔존하지 않음 |
| 5 | `dubyeol-workflow/PROJECT.md` 신설 | silkroadhub PROJECT.md §C.1 내용을 마스터 PROJECT.md §C 구조로 재배치, 회고 1~14 일체를 §D로 이전, Phase A~F 완료·Phase G 예정·r7 정비 예정 마일스톤 기록 | 마스터 PROJECT.md에 두별 워크플로우 자체의 모듈·결정 이력·마일스톤이 독립적으로 존재 |
| 6 | GitHub repo rename 및 remote 검증 | [Owner]가 사전 완료한 rename을 검증. old/new URL, redirect, clone/fetch 동작, local remote URL 기록 | Owner rename 완료 시점 기록, old/new URL 검증표, `dubyeol-workflow` local remote 연결 URL 기록 |
| 7 | silkroadhub cleanup 및 참조 방식 결정 | silkroadhub에는 사업 클라이언트로 필요한 참조만 남긴다. 참조 방식은 단순 복사 기본값, symlink/submodule 선택 시 근거 기록 | silkroadhub에 두별 원본이 중복 잔존하지 않고, 필요 참조 방식과 미해결 리스크가 handoff에 명시됨 |

#### 참조 방식 설계 옵션

| 옵션 | 장점 | 리스크 | Phase H 기본 권고 |
|---|---|---|---|
| 단순 복사 | 가장 단순하고 macOS/마누스/클로드코드 환경에서 깨질 가능성이 낮음 | 클라이언트별 복사본 drift 발생 가능 | 초기 안정성 중시 시 권고. r7에서 동기화 규칙 보강 필요 |
| symlink | 마스터 원본 단일화가 쉬움 | 도구·Git·원격 마운트에서 링크 해석 실패 가능 | 즉시 기본값으로는 비권고 |
| git submodule | 원본 버전 추적과 클라이언트 참조가 명확함 | 운영 난이도 상승, clone/update 절차 복잡 | 장기 후보. Phase H에서는 옵션으로 기록하고 즉시 적용은 신중 |

### 5.2 명시적 제외 (out of scope)

- Phase G-1 동작 검증 설계 및 9개 스킬 slash command 실호출 검증은 본 Phase H 완료 후 별도 Phase에서 진행한다.
- 두별 워크플로우 r7 매뉴얼 개정 자체는 본 task의 직접 산출물이 아니다.
- silkroadhub 사업 기능 코드(`backend`, `frontend`) 변경, DB migration, 운영 데이터 변경, 외부 프로덕션 시스템 호출은 제외한다.
- Owner 권한인 GitHub repo rename 버튼 클릭 자체를 [Foreman]/[Builder]가 대행하지 않는다.
- git push, merge, deploy, force push, history rewrite, `reset --hard`, 광범위 삭제 cleanup은 Owner 명시 승인 전 금지한다.

### 5.3 산출물 (Deliverables)

- `/Users/twostars/ClaudeAi/dubyeol-workflow` 마스터 폴더 구성 결과.
- `dubyeol-workflow/PROJECT.md` 신설본.
- `silkroadhub/PROJECT.md` 정정본.
- Phase A~F `.harness/runs` 이전 결과 및 파일 수 대조표.
- GitHub repo rename 전후 검증 기록.
- silkroadhub cleanup 결과 및 잔존 참조 방식 설명.
- `.harness/runs/20260517_dubyeol-workflow-master-split/handoff.md`.
- Tier A에 따른 `gate-review.md` 및 최종 `final-report.md`.

---

## 6. 진행 트리 (두별 워크트리)

본 task의 카테고리: 4 (문서·운영).

### 6.1 변형 사유 (해당 시)

카테고리 4 표준 트리인 `using-superpowers → brainstorming → 작성 → 자체 review → finishing-a-development-branch`를 기본으로 하되, 본 task는 Tier A 재구조화이므로 다음 변형을 적용한다.

- **Owner rename checkpoint 추가**: GitHub repo rename은 Owner 권한 작업이나, Owner가 SUB-2 진입 직전 이미 완료했으므로 본 task에서는 검증만 수행한다.
- **무결성 검증 checkpoint 추가**: 파일 이전 후 파일 수 대조와 `git log --follow` 검증이 완료되기 전 cleanup 단계로 넘어가지 않는다.
- **SUB-3 필수**: SUB-2 handoff 완료 후 [Reviewer]와 [Judge] 감리를 수행한다.

---

## 7. 검증 명령

```bash
cd /Users/twostars/ClaudeAi/silkroadhub
git branch --show-current
git status --short
find .harness/runs -maxdepth 1 -mindepth 1 -type d | sort > /tmp/silkroadhub-runs-after.txt

cd /Users/twostars/ClaudeAi/dubyeol-workflow
find . -maxdepth 3 -type f | sort > /tmp/dubyeol-workflow-files.txt
find .harness/runs -maxdepth 2 -type f | sort > /tmp/dubyeol-workflow-run-files.txt

wc -l /tmp/silkroadhub-runs-before.txt /tmp/silkroadhub-runs-after.txt /tmp/dubyeol-workflow-run-files.txt

git log --follow --oneline -- .harness/runs/20260516_skills-github-register/task-card.md | head -20

gh repo view gjnvcdprfw-hub/dubyeol-workflow --json nameWithOwner,url,defaultBranchRef,visibility
gh repo view gjnvcdprfw-hub/dubyeol-workflow-skills --json nameWithOwner,url

cd /Users/twostars/ClaudeAi/silkroadhub && git remote -v
cd /Users/twostars/ClaudeAi/dubyeol-workflow && git remote -v
```

`git push` 실검증은 Owner가 명시 승인한 경우에만 수행한다. 승인 전에는 remote URL, fetch, dry-run 성격의 안전 검증으로 제한한다.

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

- `rm -rf`, `git reset --hard`, `git filter-repo`, `git filter-branch`, rebase 기반 history rewrite, force push를 사용하지 않는다.
- 이전 대상 확정 전 silkroadhub `.harness/runs`를 비우거나 사업 task run을 삭제하지 않는다.
- GitHub rename 후 old URL redirect 검증을 생략하고 성공으로 보고하지 않는다.
- `test_claude_dispatch`를 근거 확인 없이 무조건 마스터로 이전하거나 무조건 silkroadhub에 잔존시키지 않는다.
- silkroadhub local remote URL을 변경하지 않는다.

---

## 9. 의도 변경 기록 (해당 시만 추가)

없음. GitHub rename 사전 완료는 작업 순서 변경이며 handoff에 기록한다.

---

## 10. PROJECT.md 갱신 사항 (task 종료 시 [Foreman] 작성, SUB-5)

### 10.1 §C.[N] 모듈 갱신

- **현재 상태**: silkroadhub §C.1에 두별 워크플로우 운영 인프라가 존재 → 두별 워크플로우 마스터 `dubyeol-workflow/PROJECT.md` §C로 이전됨.
- **최근 마일스톤에 추가**: Phase H에서 두별 워크플로우 마스터/클라이언트 분리 완료.
- **다음 마일스톤에서 완료 처리(체크)**: Phase F 9개 스킬 직접 등록 완료 및 Phase H 마스터 분리 완료.
- **다음 마일스톤에 추가**: Phase G-1 동작 검증 설계, Phase G 스킬 동작 검증, r7 정비.
- **현재 막힌 점**: Phase H 완료 전까지 Phase G-1 보류. Phase H 완료 후 해소.

### 10.2 §D 결정 이력 추가 (큰 결정 발생 시)

- **날짜**: 2026-05-17
- **결정**: 두별 워크플로우를 silkroadhub 내부 운영물이 아니라 독립 마스터 운영 프레임워크/도구킷으로 분리한다.
- **사유**: silkroadhub는 첫 번째 사업 클라이언트이며, 향후 다른 사업 프로젝트도 같은 운영 프레임워크를 가져와 적용해야 하므로 운영 원본·회고·스킬·매뉴얼을 마스터에서 관리해야 한다.
- **영향 모듈**: silkroadhub `PROJECT.md` §C.1 제거, `dubyeol-workflow/PROJECT.md` §C·§D 신설.

### 10.3 §A·§B 갱신 (카테고리 5 기획 task일 때만)

해당 없음.

### 10.4 PROJECT.md 반영 확인

- **반영 일시**: SUB-5에서 작성.
- **PROJECT.md §E.마지막 갱신 task run ID에 박은 값**: 20260517_dubyeol-workflow-master-split

### 10.5 handoff.md 작성 의무

| 의무 항목 | 필수 기록 내용 |
|---|---|
| 단계별 결과 | §5.1의 7개 실행 체크포인트별 PASS/FAIL/보류 및 근거 |
| 이전 파일 수 대조 | silkroadhub 이전 전 파일 수, silkroadhub 이전 후 파일 수, `dubyeol-workflow` 이전 후 파일 수 |
| 이전 범위 확정 | Phase A~F로 확정한 run 목록, 제외한 run 목록, `test_claude_dispatch` 이전/잔존 결정 근거 |
| git log 무결성 | `git log --follow` 샘플 검증 대상 파일과 결과 요약 |
| GitHub rename 검증 | rename 전 URL, rename 후 URL, old URL redirect, clone/fetch/push redirect 확인 결과. push는 Owner 승인 전 실제 수행 금지 |
| remote URL 기록 | silkroadhub local remote URL은 변경 없음으로 기록. `dubyeol-workflow` local에서 GitHub remote 연결 시점과 URL 기록 |
| PROJECT.md 분리 | `silkroadhub/PROJECT.md` §C.1 제거·§D 추가 결과와 `dubyeol-workflow/PROJECT.md` §C 재배치·§D 회고 1~14 이전 결과를 별개로 기록 |
| cleanup 검증 | silkroadhub에 두별 원본이 중복 잔존하지 않는지, 사업 자료가 삭제되지 않았는지 확인 결과 |
| 권한 천장 | push/merge/deploy/history rewrite/파괴적 삭제 미수행 여부, Owner rename 수행 시점 |

---

## 11. 다음 단계 진행 가이드

- [x] [Owner] task-card 결재 (“task-card 결재, SUB-2 진입”)
- [ ] 단계 2 (워크플로우) 진입 → SUB-2 호출
- [ ] SUB-2 handoff 완료 후 Tier A 기준 SUB-3 Reviewer + Judge 감리 수행
- [ ] Phase H 종료 후 Phase G-1 동작 검증 설계는 `dubyeol-workflow` 마스터에서 별도 task로 진행

---

## References

[1]: https://docs.github.com/en/repositories/creating-and-managing-repositories/renaming-a-repository "GitHub Docs — Renaming a repository"

**task-card 끝.**
