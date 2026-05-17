# task-card: 두별 워크플로우 Manus Agent Skills GitHub 등록 및 import 검증

**run ID**: 20260516_skills-github-register  
**작성일시**: 2026-05-16 23:57 KST  
**작성자**: [Foreman]  
**상태**: 기획 완료  
**두별 워크트리 카테고리**: 4 (문서·운영)  
**Tier**: A

---

## 1. [Owner] 발화 원문

> [새 세션 — Phase D 진입 발화]
>
> 직전 Phase B (CLAUDE.md r6 갱신)는 *별도 세션*에서 완료됨. 본 세션은 깨끗한 컨텍스트로 진입.
>
> [환경 점검 먼저]
> 시작 전에:
> 1. git branch --show-current → r6-rollout이어야 함
> 2. git log --oneline -5 → 다음 4개 commit 보여야 함:
>    - 48c0748 docs(workflow): r6 v3.6.0 r1 베타 CLAUDE.md 적용 + 회고
>    - aa46583 chore(gitignore): r6 운영 부수물 제외
>    - bb927a6 docs(harness): r6 베타 검증 회고 자료 보존
>    - dbdbc07 feat(workflow): r6 베타 매뉴얼·양식 적용 (v3.6.0 r1)
> 3. ls .harness/manus-prompts/ → 6개 프롬프트 보여야 함
> 4. ls r6-rollout-package/dubyeol-workflow-skills/ → 33개 파일 (스킬 9개 + README + LICENSE)
> 5. cat AGENTS.md | wc -l → 약 500줄 (r6 풀버전)
>
> 5개 다 통과하면 본 task 진입. 하나라도 어긋나면 [Owner]께 보고.
>
> [직전 Phase B 결과 인지]
> - silkroadhub r6-rollout 브랜치에 4개 commit + push 완료
> - ~/.claude/CLAUDE.md, silkroadhub/CLAUDE.md 모두 r6 풀버전 적용됨
> - final-report §12에 회고 메모 5건 누적 (메모 6은 본 Phase D에서 흡수 예정)
> - Phase B SUB-5 §13 [Owner] 결재 사인 완료
>
> [Phase D 진입]
> .harness/manus-prompts/프롬프트-스킬-깃허브-등록.md 그대로 진행:
>
> run_id: 20260516_skills-github-register
> Tier: A (운영 인프라 구축 — 모든 향후 task의 자동화 기반)
> 카테고리: 4 (문서·운영)
>
> [빈 저장소 생성 완료 + 마누스 접근 등록]
> [Owner]가 GitHub에서 직접 생성하고 마누스에 접근 권한 추가:
> https://github.com/gjnvcdprfw-hub/dubyeol-workflow-skills
> - Public ✅
> - 빈 저장소 (README·gitignore·LICENSE 미추가)
> - 마누스 접근 권한 등록 완료
> - 본 task는 push부터 진행
>
> [작업 분담]
> - [Owner]: 빈 저장소 직접 생성 완료. 추가 GitHub 권한 위임 없음.
> - [Foreman] 마누스: task-card 작성·지휘·verify-handoff·import 검증
> - [Builder] 클로드코드: 33개 파일 push 실행만
>
> [push 대상 파일 — 33개]
> 위치: r6-rollout-package/dubyeol-workflow-skills/
> - README.md, LICENSE
> - 01-load-sub-manual/ ~ 09-update-project-md/ (9개 스킬 폴더, 폴더당 SKILL.md + scripts + references)
>
> [push 방식 권고]
> 클로드코드에 push 실행 시 다음 절차 의무:
> 1. r6-rollout-package/dubyeol-workflow-skills/ 폴더를 별도 임시 디렉터리로 복사 (silkroadhub repo와 완전 분리)
> 2. 그 디렉터리에서 git init -b main
> 3. git remote add origin https://github.com/gjnvcdprfw-hub/dubyeol-workflow-skills.git
> 4. git add . + commit (message: "Initial: 두별 워크플로우 v3.6.0 r1 베타 — Manus Agent Skills 9개")
> 5. git push -u origin main
>
> ★ silkroadhub repo와 완전 분리 — r6-rollout 브랜치를 건드리지 않음. 임시 디렉터리에서 진행.
>
> [안전선]
> - 빈 저장소 사전 확인: gh repo view gjnvcdprfw-hub/dubyeol-workflow-skills --json defaultBranchRef,isEmpty
> - 저장소가 실제로 비어있는지 확인 후 push (충돌 방지)
> - 33개 파일 push 후 클로드코드가 원격 HEAD 확인 (gh repo view 또는 git log origin/main)
> - 33개 파일 모두 원격 반영되었는지 git ls-tree origin/main 또는 GitHub UI 확인
> - 임시 디렉터리는 push 후 보존하지 않음 (필요 시 final-report에 경로만 기록)
>
> [Reviewer·Judge]
> - [Reviewer] 코덱스: 권고 호출 (scripts/ 안 .sh 파일이 코드성 자료 — 너 판단)
> - [Judge] 지피티: 정상 수행 — Tier A 의무. 본 task는 메타 운영 아니라 진짜 운영 인프라 구축. 순환 참조 위험 없음. [Judge] 호출 자료:
>   - task-card §3 의도 정렬
>   - handoff §1·§5 (push 결과)
>   - 공개 저장소 영구 노출 리스크 검토
>   - 마누스 import 동작 예측 (multi-skill 인식 여부 불확실)
>
> [import 검증]
> push 완료 + handoff·gate-review 통과 후 너 ([Foreman])가 직접 진행:
> 1. 마누스 Settings → Skills → + Add → Import from GitHub
> 2. URL 입력: https://github.com/gjnvcdprfw-hub/dubyeol-workflow-skills
> 3. Import 클릭
> 4. 결과 3가지 가능:
>    (가) 9개 모두 인식 → 통과. final-report에 통과 보고
>    (나) 일부만 인식 → 부분 인식 목록 + 구조 정정안 제시
>    (다) Import 실패 → 오류 메시지 그대로 보고 + 정정안 제시
>
> [회고 메모 6 누적]
> 직전 Phase B에서 박지 못한 r7 회고 메모 6 (컨설턴트 클로드 매뉴얼 외부 컨텍스트 누락)을 본 Phase D task의 final-report §12에 누적해줘. 별도 task 만들지 말고 본 task에 흡수.
>
> [추가 회고 메모 7 예약]
> "r7에 명시 권고:
> - GitHub 저장소 생성: [Foreman] 권한 밖. [Owner] 직접 또는 [Owner] 명시 승인 시 [Builder] 위임
> - 저장소 삭제: 절대 금지 (history 회수 불가)
> - 공개·비공개 변경: [Owner] 명시 승인
> 근거: 마누스 글로벌 지침 [권한 경계]는 'Git Push' 명시 승인만 박혀있고 저장소 생성·삭제·공개 설정 변경은 명시 없음. 본 Phase D에서 마누스가 암묵적 안전 행동으로 저장소 생성 거부 → [Owner] 직접 생성으로 우회. r7에 명시 박을 필요."
>
> [추가 회고 메모 8 예약 — 세션 분리 패턴]
> "본 Phase D를 직전 Phase B와 *별도 세션*에서 진행. r6 매뉴얼이 *task 간 세션 분리 기준*을 명시 안 함. r7에 권고:
> - 다른 영역 task는 새 세션 권고 (컨텍스트 오염 방지)
> - 새 세션 시작 시 환경 점검 5개 항목 의무 (git branch·log·ls·wc 등)
> - 직전 task 결과를 *전제로* 인지하는 인계 패턴 명시"
>
> SUB-1 §2 5단계 SOP 진행. task-card 작성 후 결재 요청.
>
> 진입.

> 짚어줘서 고마워. 그런데 32개가 *정상값*이야. 33개는 *내(컨설턴트 클로드) 반복 오기*.
>
> [사실]
> - README + LICENSE = 2개
> - 9개 스킬 폴더 합계 30개 (각 폴더 3개 또는 4개)
>   - 01-load-sub-manual: 4개 (scripts/에 load_sub.sh + load_project_md.sh)
>   - 03-dispatch-to-builder: 4개 (references/에 standard-entry-prompt + agents-md-appendix-b)
>   - 06-invoke-reviewer: 4개 (references/에 codex-prompt-pattern + fallback-procedure)
>   - 나머지 6개 스킬: 각 3개
> - 합계 32개 = 진실 원천
>
> [지난 1단계 task에서 이미 정정됨]
> 회고 메모 누적: "1단계 프롬프트 §2.1·§5·§8 스킬 저장소 파일 수 기대값을 33 → 32로 정정. 컨설턴트 클로드의 오기였음."
>
> 내가 본 Phase D 발화에서 또 33개 박은 건 *반복 오기*. 베타 가동의 결정적 자료야.
>
> [결재]
> A 진행 (32개로 확인 + 계속). 단 "리스크 기록" 표현은 정정:
> - 리스크 아님 — *컨설턴트 클로드 발화 오기*
> - 정상값 32개 확인됨 → task-card §3 의도 정렬에 "스킬 저장소 32개 파일" 박음
>
> [추가 회고 메모 9 예약 — 본 task final-report §12에 누적]
> "컨설턴트 클로드의 반복 오기 패턴: 지난 1단계 task에서 이미 *32개 정상값*으로 정정됐음에도 본 Phase D 발화에서 또 *33개*로 잘못 박음. 자기 회고를 참조하지 못함. r7에 명시 권고:
> - 컨설턴트 클로드는 task 발화 작성 전에 직전 task 회고 메모를 반드시 참조
> - 또는 r6 운영 사실 데이터(스킬 파일 수, 매뉴얼 줄 수 등)를 별도 진실 원천 문서로 유지하고 매 발화 시 참조 의무
> - 본 패턴은 회고 메모 6(컨설턴트 클로드 매뉴얼 외부 컨텍스트 누락)의 연장. 같은 뿌리의 어색함."
>
> [PROJECT.md 처리]
> 직전 Phase B에서 결정한 대로 — 템플릿 그대로 둠. 본 Phase D도 메타 운영 영향 가깝지만, 운영 인프라 구축이라 *PROJECT.md §C에 *모듈 등록* 가능한지* 너가 판단해줘:
> - 옵션 가) 메타 운영으로 보고 PROJECT.md 미수정 (Phase B와 동일)
> - 옵션 나) "두별 워크플로우 운영 인프라" 모듈로 §C에 *최초 등록* — 베타 첫 진짜 인프라 자산
>
> 너의 판단 짚어주고 task-card §10에 박아줘.
>
> 진입.

---

## 2. 상위 맥락 연결 (PROJECT.md 진입 시점)

- **연결 모듈**: §C.1 두별 워크플로우 운영 인프라 (본 task SUB-5에서 최초 등록 예정)
- **진입 시점 마일스톤**: §C가 템플릿 상태라 기존 마일스톤 없음. 본 task는 “두별 워크플로우 스킬 9개 공개 저장소 push 및 import 검증”을 최초 마일스톤으로 등록한다.
- **이번 task로 *전진시키는 것***: r6 베타의 재사용 가능한 Manus Agent Skills 9개를 공개 GitHub 저장소에 등록하고, Manus import 가능성을 검증해 향후 task 자동화 기반을 만든다.
- **PROJECT.md 진입 시점 스냅샷**:
  - 모듈 상태: PROJECT.md §B·§C·§D는 템플릿 상태. 운영 인프라 모듈은 아직 미등록.
  - 현재 막힌 점: multi-skill 단일 저장소 import 동작은 공식 UI 검증 전까지 [미확인]. 다만 push 대상 파일 수는 32개가 정상값으로 [Owner]가 확정.

**PROJECT.md 처리 판단**: 옵션 나를 채택한다. Phase B의 CLAUDE.md 갱신은 메타 운영 문서 자체 정비에 가까워 PROJECT.md 미수정이 타당했지만, 본 Phase D는 공개 GitHub 저장소와 Manus Skills import라는 **향후 모든 task의 재사용 인프라**를 구축한다. 따라서 §C에 “두별 워크플로우 운영 인프라” 모듈을 최초 등록하는 것이 진행 추적성과 회고 가능성 측면에서 더 엄밀하다. 단 §A·§B는 기획 task가 아니므로 변경하지 않는다.

---

## 3. 의도 정렬 증거 블록 (SUB-1 §2 SOP 결과 — 불변)

> 본 블록은 task 진행 중 **수정 금지**. 의도 변경 발생 시 §9에 *추가* 블록으로 기록.

### 3.1 한 문장 목표 (What)

두별 워크플로우 v3.6.0 r1 베타의 Manus Agent Skills 9개, 정상값 **32개 파일**, README, LICENSE를 `gjnvcdprfw-hub/dubyeol-workflow-skills` 공개 GitHub 저장소에 push하고, Manus import 결과를 검증한다.

### 3.2 성공 시 보이는 모습 (Looks Like)

- `git branch --show-current`, 최근 commit 4개, `.harness/manus-prompts/` 6개, `AGENTS.md` 약 500줄, 스킬 저장소 **32개 파일**이라는 진입 환경 점검 결과가 task 자료에 기록된다.
- `r6-rollout-package/dubyeol-workflow-skills/`의 정상값 32개 파일이 silkroadhub repo와 분리된 임시 디렉터리에서 `main` 브랜치로 `https://github.com/gjnvcdprfw-hub/dubyeol-workflow-skills`에 push된다.
- 원격 저장소에서 `README.md`, `LICENSE`, 9개 스킬 폴더, 각 `SKILL.md`, `scripts/`, `references/` 파일이 누락 없이 확인된다.
- [Foreman]이 push 이후 Manus GitHub import를 직접 시도하고, 결과가 “9개 모두 인식”, “일부 인식”, “import 실패” 중 하나로 증거와 함께 기록된다.
- Tier A 의무에 따라 [Reviewer] 권고 호출과 [Judge] 필수 호출 결과가 `gate-review.md`에 분리 기록되고, final-report §12에 회고 메모 6·7·8·9가 누적된다.

### 3.3 실패 시 보이는 모습 (Looks Wrong)

- push 전 빈 저장소 확인을 하지 않아 기존 원격 내용과 충돌하거나 잘못된 저장소에 push된다.
- silkroadhub `r6-rollout` 브랜치 자체에서 원격을 바꾸거나 commit/push하여 본 task의 공개 스킬 저장소와 제품 저장소가 섞인다.
- 32개 정상값을 33개 누락 리스크로 잘못 기록해, 컨설턴트 클로드 발화 오기를 사실처럼 고정한다.
- 공개 저장소에 민감 정보, API 키, 운영 데이터, silkroadhub 도메인 개인정보성 데이터가 포함된다.
- Manus import 검증 없이 “성공”으로 보고하거나, 일부 인식·실패 결과를 구조 정정안 없이 종료한다.

### 3.4 모호어 해소 기록

- “33개 파일” → “[Owner] 정정에 따라 정상값은 32개 파일이며, 33개는 컨설턴트 클로드의 반복 오기이다.”
- “리스크 기록” → “[Owner] 정정에 따라 리스크가 아니라 컨설턴트 클로드 발화 오기로 기록한다.”
- “PROJECT.md §C에 모듈 등록 가능한지 너가 판단” → “[Foreman] 판단으로 옵션 나를 채택해 ‘두별 워크플로우 운영 인프라’ 모듈 최초 등록을 task-card §10에 예정한다.”

### 3.5 마누스가 가정한 것 3가지

**가정 1**: GitHub 저장소 `gjnvcdprfw-hub/dubyeol-workflow-skills`는 [Owner]가 이미 public 빈 저장소로 생성했고, 마누스/Builder가 push 가능한 권한을 가진다.  
→ 근거: [Owner] 발화에 “Public”, “빈 저장소”, “마누스 접근 권한 등록 완료”, “본 task는 push부터 진행”이 명시됨.  
→ 검증: SUB-2에서 `gh repo view gjnvcdprfw-hub/dubyeol-workflow-skills --json defaultBranchRef,isEmpty`로 확인한다.

**가정 2**: push 대상은 `r6-rollout-package/dubyeol-workflow-skills/` 아래의 현재 32개 파일 전체이며, 파일 구조 **임의 변경**은 본 task 범위가 아니다. 단 사전 점검에서 명백한 결함(빈 파일, 민감 정보 포함, import 부적합 구조 등)이 발견되면 즉시 [Owner]께 보고한 뒤 SUB-4로 분기하거나 별도 task로 분리한다.  
→ 근거: [Owner]가 32개를 “진실 원천”으로 확정했고, “A 진행 (32개로 확인 + 계속)”을 결재했으나, 공개 저장소 최초 push 전 안전 점검은 Tier A 운영 인프라 task의 필수 조건임.  
→ 검증: SUB-2에서 `find ... -type f | wc -l`, `find ... -type f | sort`, `SKILL.md`·scripts·references 구조 및 민감 정보 포함 여부를 점검하고, 원격 `git ls-tree -r origin/main --name-only | wc -l`로 로컬·원격 파일 수와 목록을 대조한다.

**가정 3**: PROJECT.md §C 신규 모듈 등록은 본 task의 종료 단계에서 task-card §10을 경유해 제한적으로 반영 가능하며, §A·§B는 변경하지 않는다.  
→ 근거: AGENTS.md·PROJECT.md는 모든 task 종료 시 §C 갱신 경로를 허용하고, [Owner]가 본 task에서 §C 모듈 등록 여부 판단을 [Foreman]에게 위임함.  
→ 검증: SUB-5에서 final-report 작성 전 task-card §10에 신규 모듈 내용을 확정하고, PROJECT.md §C.1 및 §E만 반영한다.

### 3.6 정렬 확인

- **정렬 일시**: 2026-05-16 23:57 KST
- **[Owner] 명시 응답**: “A 진행 (32개로 확인 + 계속). 단 ‘리스크 기록’ 표현은 정정: 리스크 아님 — 컨설턴트 클로드 발화 오기. 정상값 32개 확인됨 → task-card §3 의도 정렬에 ‘스킬 저장소 32개 파일’ 박음.”

---

## 4. Tier 판정

- **Tier**: A
- **판정 근거**: 공개 GitHub 저장소에 운영 인프라 자산을 최초 등록하고, 향후 모든 task의 자동화 기반인 Manus Agent Skills import를 검증한다. 공개 저장소 영구 노출, 권한·보안, 향후 운영 영향이 있으므로 Tier A로 유지한다.
- **Blast Radius**: 최악의 경우 잘못된 파일, 민감 정보, 잘못된 운영 절차가 공개 저장소에 영구 노출되거나 향후 task 자동화 경로에 편입될 수 있다. 또한 multi-skill import 동작을 잘못 해석하면 다음 task들에서 잘못된 운영 전제가 반복될 수 있다.
- **Gate 의무**:
  - Tier A: [Reviewer] + [Judge] 둘 다, gate-review.md 필수

---

## 5. 작업 범위 (Scope)

### 5.1 포함

- 진입 환경 5개 항목 확인 결과 기록. 단 파일 수 기대값은 [Owner] 정정에 따라 32개 정상값으로 고정한다.
- `r6-rollout-package/dubyeol-workflow-skills/`의 32개 파일 구조, `SKILL.md` frontmatter, scripts 실행 권한, 공개 저장소 노출 위험을 점검한다.
- silkroadhub repo와 완전히 분리된 임시 디렉터리에서 `git init -b main`, remote 추가, commit, push를 수행하도록 [Builder]를 지휘한다.
- push 이후 원격 HEAD, default branch, 원격 파일 목록, 파일 수 32개를 검증한다.
- [Reviewer] 코덱스 권고 호출 및 [Judge] 지피티 필수 호출을 수행하고, 공개 저장소 영구 노출 리스크와 import 동작 예측을 gate-review에 기록한다.
- Manus Settings → Skills → Import from GitHub에서 저장소 URL import를 시도하고 결과를 기록한다.
- final-report §12에 회고 메모 6·7·8·9를 누적한다.
- PROJECT.md §C.1에 “두별 워크플로우 운영 인프라” 모듈 최초 등록을 SUB-5에서 반영한다.

### 5.2 명시적 제외 (out of scope)

- silkroadhub 제품 코드, DB, API, 프론트엔드, 백엔드 변경.
- AGENTS.md, CLAUDE.md, SUB-1~5, `.harness/templates/` 운영 문서의 내용 변경.
- 스킬 구조 자체 변경, 파일 추가·삭제·내용 수정. 필요한 경우 정정안만 제시하고 [Owner] 승인 후 별도 또는 SUB-4로 진행한다.
- GitHub 저장소 삭제, 공개·비공개 설정 변경, force push, history rewrite.
- 9개 개별 저장소 생성 또는 저장소명 변경.
- 실제 프로덕션 외부 시스템 호출, 결제·통관·DB migration.

### 5.3 산출물 (Deliverables)

- `.harness/runs/20260516_skills-github-register/task-card.md`
- `.harness/runs/20260516_skills-github-register/skills-structure-review.md`
- `.harness/runs/20260516_skills-github-register/handoff.md`
- `.harness/runs/20260516_skills-github-register/gate-review.md`
- `.harness/runs/20260516_skills-github-register/manus-import-verification.md`
- `.harness/runs/20260516_skills-github-register/final-report.md`
- GitHub 저장소: `https://github.com/gjnvcdprfw-hub/dubyeol-workflow-skills`
- PROJECT.md §C.1 및 §E 제한 갱신

---

## 6. 진행 트리 (두별 워크트리)

선택한 카테고리에 따른 진행 트리는 **AGENTS.md §[진행 트리] 참조**.

본 task의 카테고리: 머리의 *두별 워크트리 카테고리* 필드 확인.

### 6.1 변형 사유 (해당 시)

카테고리 4 표준 트리(`using-superpowers → brainstorming → 작성 → 자체 review → finishing-a-development-branch`)를 따른다. 단 본 task는 Tier A 운영 인프라 구축이므로 SUB-2 후 SUB-3 외부 감리와 Manus import 검증 단계를 추가한다. **push 시점은 옵션 가로 명시한다.** 즉, push는 handoff 작성 **전** SUB-2 안에서 실행하며, push 결과 자체가 `handoff.md` §1·§5의 핵심 증거로 박힌다. 본 task는 “공개 저장소에 32개 파일을 최초 push하는 것”이 핵심 행동이므로, handoff와 SUB-3는 push 전 승인 장치가 아니라 push 결과의 검증·감리 장치로 운용한다.

---

## 7. 검증 명령

본 task의 성공 여부를 확인할 *구체 명령어*. [Builder]가 verification 단계에서 실행.

```bash
# silkroadhub repo 진입 환경 확인
cd /Users/twostars/ClaudeAi/silkroadhub
git branch --show-current
git log --oneline -5
ls .harness/manus-prompts/ | wc -l
find r6-rollout-package/dubyeol-workflow-skills -type f | wc -l
find r6-rollout-package/dubyeol-workflow-skills -type f | sort
cat AGENTS.md | wc -l

# GitHub 빈 저장소 확인
gh repo view gjnvcdprfw-hub/dubyeol-workflow-skills --json defaultBranchRef,isEmpty

# 별도 임시 디렉터리에서 push 후 원격 검증
# <tmpdir>는 silkroadhub repo 밖이어야 함.
git -C <tmpdir> status --short
git -C <tmpdir> remote -v
git -C <tmpdir> log --oneline -1
git -C <tmpdir> ls-tree -r origin/main --name-only | wc -l
git -C <tmpdir> ls-tree -r origin/main --name-only | sort
gh repo view gjnvcdprfw-hub/dubyeol-workflow-skills --json defaultBranchRef,isEmpty,url
```

명령이 명확하지 않으면 [Builder]가 발견 후 handoff에 기록.

---

## 8. 권한 천장·금지 사항 (재확인)

[Owner] 명시 승인 없이 [Builder] 실행 금지:

- [x] push / merge / deploy — 본 task의 `gjnvcdprfw-hub/dubyeol-workflow-skills` 최초 push는 [Owner]가 “A 진행 (32개로 확인 + 계속)” 및 “본 task는 push부터 진행”으로 승인. merge/deploy는 여전히 금지.
- [ ] 운영 문서 변경 반영 (AGENTS.md, CLAUDE.md, templates 등)
- [ ] 파괴적 git 명령 (reset --hard, force push, history rewrite)
- [ ] task scope 확장 (§5.2 제외 범위 침범)
- [ ] 외부 시스템 프로덕션 실호출
- [ ] Tier 강등

본 task 특유의 추가 금지 사항 (있으면):

- silkroadhub repo의 remote, branch, history를 변경하지 않는다.
- 공개 저장소 push 전 민감 정보 포함 여부를 점검한다.
- 임시 디렉터리에서만 `git init`, `git remote add`, `git push`를 수행한다.
- 32개 정상값을 33개로 되돌려 기록하지 않는다.
- import 결과를 확인하지 않고 성공으로 보고하지 않는다.

---

## 9. 의도 변경 기록 (해당 시만 추가)

### 9.1 의도 변경 1차

- **변경 일시**: 2026-05-16 23:57 KST
- **변경 사유**: [Owner]가 task-card 결재와 동시에 push 시점, PROJECT.md 다음 마일스톤 표현, 파일 구조 변경 가정의 닫힘 문제를 지적함.
- **변경 내용**: push는 handoff 작성 전 SUB-2 안에서 실행하고 push 결과를 handoff §1·§5에 박는 옵션 가로 명시한다. PROJECT.md §C.1 다음 마일스톤은 r7 회고 자료가 아니라 “Manus import 결과에 따라 9개 개별 저장소 분리 또는 스킬 구조 보강 검토”로 조정한다. 파일 구조 변경은 임의 변경 금지로 유지하되, 명백한 결함 발견 시 [Owner] 보고 후 SUB-4 또는 별도 task로 분기한다고 완화한다.
- **새 정렬 확인**: “위 세 짚을 점 반영해서 task-card 정정 후 SUB-2 진입. §9.1 의도 변경 1차 박을 필요 있음 — task-card 결재 시점에 의도 변경이라 §9에 기록 의무. 진행해.”

### 9.2 의도 변경 2차

- **변경 일시**: 2026-05-17 01:05 KST
- **변경 사유**: 코덱스 Reviewer 호출 실패 보고 후 [Owner]가 실패 원인을 단일 원인으로 묶지 말고, 입력 손상과 백엔드 장애를 분리 진단하라고 지시함. 또한 코덱스와 지피티가 같은 backend 장애 영향을 받을 수 있으므로 지피티 ping 성공 후에만 Reviewer 폴백을 진행하라고 지시함.
- **변경 내용**: 코덱스 실패는 `reviewer-stderr.log`와 `reviewer-stderr-retry.log`를 분리해 진단한다. 지피티 간단 테스트 호출을 먼저 수행하고, 응답이 오면 지피티 Reviewer 폴백 + 별도 Judge 호출로 진행하며, 동일 실패 시 백엔드 복구 대기 옵션으로 분기한다. final-report §12에는 회고 메모 10·11·12도 추가 누적한다.
- **새 정렬 확인**: “지피티 간단 테스트 호출: 응답 받으면 → 옵션 A 진행 (Reviewer 폴백 + Judge 별도 세션), 동일 실패면 → 옵션 C. 진행 결과 보고… 본 task final-report §12에 누적해줘. 진행해.”

---

## 10. PROJECT.md 갱신 사항 (task 종료 시 [Foreman] 작성, SUB-5)

> task 진행 중에는 비워둠. SUB-5 종료 단계에서 [Foreman]이 작성 후, 본 내용을 PROJECT.md §C.N에 *그대로 옮긴다*.

### 10.1 §C.1 모듈 갱신

- **신규 모듈명**: 두별 워크플로우 운영 인프라
- **한 줄 정의**: 두별 워크플로우 r6 베타 운영을 자동화·표준화하기 위한 Manus Agent Skills, run 산출물, 외부 감리, PROJECT.md 갱신 체계.
- **현재 상태**: 미등록 → 검증중
- **최근 마일스톤에 추가**: 2026-05-16: Manus Agent Skills 9개 공개 GitHub 저장소 push 및 import 검증 수행.
- **다음 마일스톤에서 완료 처리(체크)**: 해당 없음 (신규 모듈 최초 등록)
- **다음 마일스톤에 추가**: Manus import 결과에 따라 9개 개별 저장소 분리 또는 스킬 구조 보강 검토.
- **현재 막힌 점**: 단일 GitHub 저장소 URL import 후 `01-load-sub-manual`·`dubyeol` 검색 결과가 없어 9개 스킬 인식이 확인되지 않음. multi-skill 단일 저장소 자동 탐색 여부는 현재 검증상 부정적이며, 하위 폴더 개별 import·루트 SKILL.md 추가·9개 개별 저장소 분리 중 정정안 검토 필요.

### 10.2 §D 결정 이력 추가 (큰 결정 발생 시)

- **날짜**: 2026-05-16
- **결정**: `dubyeol-workflow-skills` 정상 파일 수를 32개로 확정하고, 33개 표기는 컨설턴트 클로드 반복 오기로 기록한다.
- **사유**: README+LICENSE 2개와 9개 스킬 폴더 30개 합계가 32개이며, [Owner]가 “합계 32개 = 진실 원천”으로 명시함.
- **영향 모듈**: §C.1 두별 워크플로우 운영 인프라

- **날짜**: 2026-05-16
- **결정**: PROJECT.md §C.1에 “두별 워크플로우 운영 인프라” 모듈을 최초 등록한다.
- **사유**: 본 task는 메타 운영 문서 정비를 넘어 공개 GitHub 저장소와 Manus Skills import라는 향후 task 자동화 기반을 구축하므로 추적 가능한 운영 인프라 모듈로 관리하는 편이 타당함.
- **영향 모듈**: §C.1 두별 워크플로우 운영 인프라

- **날짜**: 2026-05-17
- **결정**: Manus GitHub import 검증 결과, `dubyeol-workflow-skills` 단일 저장소 URL은 9개 스킬로 인식되지 않은 것으로 기록한다.
- **사유**: import 실행 후 Skills 목록에서 `01-load-sub-manual`과 `dubyeol` 검색 모두 `결과를 찾을 수 없음`으로 확인됨. 명시적 오류 toast는 캡처하지 못했으므로 “import 실패 또는 인식 결과 없음”으로 표현한다.
- **영향 모듈**: §C.1 두별 워크플로우 운영 인프라

### 10.3 §A·§B 갱신 (카테고리 5 기획 task일 때만)

- §A 변경 사항: 해당 없음
- §B 변경 사항: 해당 없음

### 10.4 PROJECT.md 반영 확인

- **반영 일시**: 2026-05-17 01:18 KST
- **PROJECT.md §E.마지막 갱신 task run ID에 박은 값**: 20260516_skills-github-register

---

## 11. 다음 단계 진행 가이드

- [ ] [Owner] task-card 결재 ("진행" 응답)
- [ ] 단계 2 (워크플로우) 진입 → SUB-2 호출

---

**task-card 끝.**
