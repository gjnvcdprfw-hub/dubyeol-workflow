# task-card: Task 2 sync 스크립트 구현

**run ID**: 20260518_sync-script-implementation  
**작성일시**: 2026-05-17 17:24 KST  
**작성자**: [Foreman]  
**상태**: SUB-1 결재 완료, SUB-2 진입 준비  
**두별 워크트리 카테고리**: 4 (문서·운영)  
**Tier**: A

---

## 1. [Owner] 발화 원문

> [다음 task 진입 — Task 2 sync 스크립트 구현]
>
> 정책+sync 설계 task 종결 확인 (commit 8c2394f). Task 2 진입.
>
> run_id: 20260518_sync-script-implementation  
> Tier: A  
> 카테고리: 4 (문서·운영)  
> 작업 대상: dubyeol-workflow 마스터  
> 작업 위치: /Users/twostars/ClaudeAi/dubyeol-workflow/  
> silkroadhub 손대지 않음 (사업 자산 보존)
>
> 대응 정책 task: 20260518_skills-policy-and-sync-design (commit 8c2394f)
>
> 본 task는 sync-to-client.sh 실제 구현. 9개 스킬 본문 수정·r7 정비·silkroadhub 적용 안 함.
>
> 본 task에서는 dummy 클라이언트 대상으로만 sync 검증. silkroadhub 실제 적용은 Task 4에서.
>
> Tier A SUB-3 외부 감리 정상 진행. Codex 실패 시 GPT Reviewer 폴백 + Judge 별도 세션.
>
> 직접 작성 대상: `scripts/sync-to-client.sh`, `.harness/sync-exclude.txt`, `.env.template`, `.gitignore` 보강.
>
> API 키 사용 정책: 시스템 환경변수 `$OPENAI_API_KEY` 사용. silkroadhub의 `scripts/load_openai_key.sh` 참조 금지. 마스터 측 키 파일 생성 금지. 키 값 출력 금지.
>
> SUB-1 의도 정렬 보고 받은 뒤 [Owner] 결재. 진행해.

### 1.1 SUB-1 정렬 검수 및 결재 발화

> Task 2 SUB-1 정렬 검수 완료.
>
> 평가:
> - What·Looks Like·Looks Wrong·모호어 해소·가정 모두 정합
> - 회고 23·29·30·31·32 반영
> - 가정 1 scripts/ 재생성 근거 정확
> - 가정 2 .env.template 추적 vs .env 자체 제외 분리 정합
> - 가정 3 Tier A 유지 근거 명시
> - 부정합 발견 없음
>
> 진행
>
> SUB-1 결재. SUB-2 sync-to-client.sh 구현 진입.
>
> 추가 운영 짚을 점:
> - 실제 sync = `tmp/dummy-client/` 대상만
> - 실제 sync ≠ silkroadhub 또는 다른 실 클라이언트
> - dummy git repo는 빈 commit 1개로 `.git` 디렉터리 확보
> - 단위 검증 5개 케이스는 실제 명령 + exit code + 출력 모두 evidence-unit-tests.md에 기록
> - dummy dry-run 1회와 실제 sync 1회 결과를 evidence-dummy-client-test.md에 기록
> - SUB-3에서 키 값 출력 금지, SET/NOT SET 형태만
> - 시스템 환경변수 `$OPENAI_API_KEY` 직접 참조, silkroadhub 키 파일 의존 금지
>
> 권한 천장:
> - commit·push 사전 승인 없음
> - 9개 스킬 본문, AGENTS.md, SUB-1~5, PROJECT.md 임의 수정 금지
> - silkroadhub 사업 자산 손대지 않음
> - force push, history rewrite, reset --hard 금지
>
> 진행해.

---

## 2. 상위 맥락 연결 (PROJECT.md 진입 시점)

- **연결 모듈**: §C.1 두별 워크플로우 운영 인프라
- **진입 시점 마일스톤**: §C.1 다음 마일스톤 중 `Task 2 — sync 스크립트 구현 task: sync-design.md 기준으로 sync-to-client.sh를 구현하되, dry-run 중심으로 정책 검증 수단을 먼저 확보.`
- **이번 task로 전진시키는 것**: 정책+sync 설계서의 `sync-to-client.sh` 설계를 실제 실행 가능한 zsh 스크립트와 exclude/template 파일로 구현하고, dummy 클라이언트에서 dry-run·실제 sync를 검증해 후속 Task 3·r7·Task 4의 인프라를 만든다.
- **PROJECT.md 진입 시점 스냅샷**:
  - 모듈 상태: 정책+sync 설계 task 완료. 본 task는 그 다음 마일스톤인 Task 2 sync 구현이다.
  - 현재 막힌 점: sync 구현, 9개 스킬 수정, r7 정비, client 적용은 미진입 상태이며, Task 2에서 sync 검증 수단을 먼저 확보해야 한다.

---

## 3. 의도 정렬 증거 블록 (SUB-1 §2 SOP 결과 — 불변)

> 본 블록은 task 진행 중 **수정 금지**. 의도 변경 발생 시 §9에 *추가* 블록으로 기록.

### 3.1 한 문장 목표 (What)

`dubyeol-workflow` 마스터에서 `sync-design.md` 기준으로 `scripts/sync-to-client.sh`, `.harness/sync-exclude.txt`, `.env.template`, `.gitignore` 보강을 구현하고, dummy 클라이언트에서 dry-run·실제 sync까지 검증한다.

### 3.2 성공 시 보이는 모습 (Looks Like)

- `.harness/runs/20260518_sync-script-implementation/` 아래에 `task-card.md`, `handoff.md`, `handoff-verification.md`, `evidence-unit-tests.md`, `evidence-dummy-client-test.md`, Reviewer/Judge 입력·원문, `gate-review.md`, `final-report.md`가 생성된다.
- 마스터 본문에는 `scripts/sync-to-client.sh`, `.harness/sync-exclude.txt`, `.env.template`, `.gitignore` 보강만 반영된다.
- `sync-to-client.sh --help`와 인자 검증 5개 케이스가 기대 exit code와 메시지로 검증된다.
- `tmp/dummy-client/`에서 dry-run 1회와 실제 sync 1회가 수행되고, 체크섬·파일 수·비밀 파일 미복사 증거가 남는다.
- SUB-3에서 Codex Reviewer와 GPT Judge가 분리 호출되고, Codex 실패 시 GPT Reviewer 폴백과 Judge 별도 세션이 적용된다.

### 3.3 실패 시 보이는 모습 (Looks Wrong)

- 본 task 범위를 넘어 9개 스킬 본문, r7 운영 문서, `silkroadhub` 실제 적용을 수행한다.
- `silkroadhub/scripts/load_openai_key.sh` 등 사업 자산을 읽기·수정·복사 대상으로 삼는다.
- `.env`, API 키, 키 로드 파일이 sync 대상 또는 commit 대상에 포함된다.
- dummy 클라이언트가 아닌 실제 client 경로에 sync를 실행하거나, `tmp/` 검증 자료가 commit 대상에 포함된다.
- SUB-3 입력 격리가 깨지거나, [Owner] 별도 승인 없이 commit·push·force push·history rewrite가 실행된다.

### 3.4 모호어 해소 기록

- “sync-to-client.sh 실제 구현” → “정책서의 설계 내용을 실행 가능한 zsh 스크립트로 구현하되, 9개 스킬 수정과 실제 silkroadhub 적용은 하지 않는다.”
- “dummy 클라이언트 검증” → “`tmp/dummy-client/`에서 git init 후 dry-run과 실제 sync를 안전하게 수행하고, tmp는 commit하지 않는다.”
- “API 키 사용 정책(Task 2부터 적용)” → “SUB-3 GPT 호출 시 시스템 환경변수 `$OPENAI_API_KEY`만 사용하고, 키 값·키 파일은 출력·복사·생성하지 않는다.”

### 3.5 마누스가 가정한 것 3가지

**가정 1**: `scripts/` 디렉터리는 G-2에서 키 파일 정리를 위해 제거됐지만, 이번에는 목적이 전혀 다른 추적 대상 코드(`sync-to-client.sh`)를 담기 위해 재생성하는 것이 정합하다.  
→ 근거: [Owner] 발화 40~43행과 153~157행.  
→ 검증: 생성 파일이 `scripts/sync-to-client.sh`뿐인지, 키 로드 파일이 없는지 확인한다.

**가정 2**: `.env.template`은 키 값을 포함하지 않는 추적 대상이고, 실제 `.env`·`.env.*`·키 로드 파일은 `.gitignore` 및 sync exclude 대상이다.  
→ 근거: [Owner] 발화 62~70행과 161~169행.  
→ 검증: `.env.template`에는 변수명·설명만 있고 키 값이 없으며, `.env`가 commit 대상에 포함되지 않는지 확인한다.

**가정 3**: Tier A는 실제 sync 스크립트 구현, 경로 검증, 비밀 파일 차단, dummy 실제 sync, 외부 감리를 포함하므로 유지하며, 구현 범위가 마스터 내부라도 자동 강등하지 않는다.  
→ 근거: [Owner] 발화 6행, 24~25행, AGENTS.md Tier 강등 금지 원칙.  
→ 검증: SUB-3에서 Reviewer/Judge를 분리 호출하고 `gate-review.md`를 작성한다.

### 3.6 정렬 확인

- **정렬 일시**: 2026-05-17 17:24 KST
- **[Owner] 명시 응답**: “Task 2 SUB-1 정렬 검수 완료. ... SUB-1 결재. SUB-2 sync-to-client.sh 구현 진입. ... 진행해.”

---

## 4. Tier 판정

- **Tier**: A
- **판정 근거**: [Owner]가 Tier A를 명시했다. 본 task는 파일 sync 스크립트, 경로 검증, 비밀 파일 차단, 실제 dummy sync, 외부 감리, 추후 client 적용 인프라에 영향을 준다.
- **Blast Radius**: 스크립트 결함이 있으면 후속 client 적용에서 wrong-path sync, 비밀 파일 복사, client 사업 자산 오염, sync drift를 유발할 수 있다.
- **Gate 의무**: Tier A이므로 SUB-3에서 Reviewer와 Judge를 분리 호출하고 `gate-review.md`를 작성한다. Codex 실패 시 GPT Reviewer 폴백을 사용하되 Judge와 입력·세션을 분리한다.

---

## 5. 작업 범위 (Scope)

### 5.1 포함

- `scripts/` 디렉터리 재생성 및 `scripts/sync-to-client.sh` 구현.
- `.harness/sync-exclude.txt` 작성.
- `.env.template` 작성. 키 값 없음.
- `.gitignore` 보강: 실제 `.env`, dummy client tmp, secret/key 패턴 제외.
- 단위 검증 5개 케이스 실행 및 `evidence-unit-tests.md` 작성.
- `tmp/dummy-client/`에서 dry-run 1회 및 실제 sync 1회 검증, `evidence-dummy-client-test.md` 작성.
- SUB-2 handoff, Foreman handoff 검증, SUB-3 외부 감리, SUB-5 final-report 작성.

### 5.2 명시적 제외 (out of scope)

- 9개 스킬 본문 및 scripts 수정.
- r7 운영 문서 정비.
- `silkroadhub` 실제 적용 또는 `silkroadhub` 파일 읽기·수정·복사.
- API 키 파일, 키 로드 스크립트 생성.
- 실제 `.env` 생성 및 commit.
- `tmp/` dummy 클라이언트 자료 commit.
- commit·push·merge·deploy·force push·history rewrite·reset hard.

### 5.3 산출물 (Deliverables)

| 산출물 | 경로 |
|---|---|
| task-card | `.harness/runs/20260518_sync-script-implementation/task-card.md` |
| 단위 검증 evidence | `.harness/runs/20260518_sync-script-implementation/evidence-unit-tests.md` |
| dummy client evidence | `.harness/runs/20260518_sync-script-implementation/evidence-dummy-client-test.md` |
| handoff | `.harness/runs/20260518_sync-script-implementation/handoff.md` |
| handoff 검증 | `.harness/runs/20260518_sync-script-implementation/handoff-verification.md` |
| Reviewer/Judge 입력·원문 | `.harness/runs/20260518_sync-script-implementation/reviewer-*.md`, `judge-*.md` |
| gate-review | `.harness/runs/20260518_sync-script-implementation/gate-review.md` |
| final-report | `.harness/runs/20260518_sync-script-implementation/final-report.md` |
| sync script | `scripts/sync-to-client.sh` |
| exclude file | `.harness/sync-exclude.txt` |
| env template | `.env.template` |

---

## 6. 진행 트리 (두별 워크트리)

본 task의 카테고리: 4 (문서·운영). 다만 실제 zsh 스크립트를 구현하고 dummy 대상 실제 sync를 수행하므로 카테고리 4의 “scripts 작성” 범위에 해당한다. SUB-2는 Builder 새 세션에서 `using-superpowers → brainstorming → 구현 → 자체 review → verification-before-completion → finishing-a-development-branch` 변형으로 진행한다. Tier A이므로 SUB-3 외부 감리를 수행한다.

---

## 7. 검증 명령

```bash
cd /Users/twostars/ClaudeAi/dubyeol-workflow
RUN=.harness/runs/20260518_sync-script-implementation

test -x scripts/sync-to-client.sh
test -f .harness/sync-exclude.txt
test -f .env.template
test -f "$RUN/evidence-unit-tests.md"
test -f "$RUN/evidence-dummy-client-test.md"

./scripts/sync-to-client.sh --help
./scripts/sync-to-client.sh
./scripts/sync-to-client.sh /path/that/does/not/exist
mkdir -p tmp/no-git-client && ./scripts/sync-to-client.sh tmp/no-git-client
./scripts/sync-to-client.sh /Users/twostars/ClaudeAi/dubyeol-workflow
./scripts/sync-to-client.sh /

mkdir -p tmp/dummy-client
cd tmp/dummy-client && git init && git commit --allow-empty -m "init dummy client" && cd -
./scripts/sync-to-client.sh tmp/dummy-client --dry-run
./scripts/sync-to-client.sh tmp/dummy-client --client-name dummy

git status --short -- 01-load-sub-manual 02-create-task-card 03-dispatch-to-builder 04-invoke-plan-review 05-verify-handoff 06-invoke-reviewer 07-invoke-judge 08-write-final-report 09-update-project-md AGENTS.md SUB-1-기획의도.md SUB-2-워크플로우.md SUB-3-외부감리.md SUB-4-수정.md SUB-5-종료.md PROJECT.md
```

---

## 8. 권한 천장·금지 사항 (재확인)

[Owner] 명시 승인 없이 실행 금지:

- [ ] commit / push / merge / deploy
- [ ] 9개 스킬 본문 또는 scripts 수정
- [ ] AGENTS.md, SUB-1~5, PROJECT.md 임의 수정
- [ ] `silkroadhub` 파일 읽기·수정·복사·삭제
- [ ] 실제 client 경로 sync 실행
- [ ] API 키·키 파일·키 로드 스크립트 생성 또는 출력
- [ ] force push, history rewrite, reset hard
- [ ] Tier 강등

---

## 9. 의도 변경 기록 (해당 시만 추가)

없음.

---

## 10. PROJECT.md 갱신 사항 (task 종료 시 [Foreman] 작성, SUB-5)

### 10.1 §C.1 모듈 갱신

PROJECT.md §C.1에 Task 2 sync 스크립트 구현 완료를 반영한다. 완료 내용은 `scripts/sync-to-client.sh`, `.harness/sync-exclude.txt`, `.env.template`, `.gitignore` 보강이며, 검증 결과는 단위 테스트 7/7 PASS, dummy dry-run·실제 sync 2/2 PASS, 대표 체크섬 3/3 MATCH다. SUB-3 외부 감리는 API 키 문제로 [Owner] 지시에 따라 미수행했고, 본 채널 검수가 SUB-3 대체 수행했다. SUB-4에서는 `.env.template` placeholder 정정과 `.harness/sync-reports/` ignore 확인을 완료했다. 다음 마일스톤은 Task 3(9개 스킬 수정) + r7 정비 동시 진입으로 둔다.

### 10.2 §D 결정 이력 추가

| 날짜 | 결정 | 사유 | 영향 모듈 |
|---|---|---|---|
| 2026-05-17 | Task 2 sync 스크립트 구현을 완료하고 후속 Task 3 + r7 동시 진입 준비 상태로 전환한다. | sync-to-client.sh가 dummy dry-run·실제 sync 검증을 통과해 후속 스킬 수정과 client 적용의 인프라가 마련되었다. | §C.1 |
| 2026-05-17 | Task 2에서도 본 채널 검수를 SUB-3 대체 수행으로 인정한다. | API 키 문제로 외부 감리를 진행할 수 없어 [Owner] 본 채널 검수가 Reviewer+Judge 대체 역할을 수행했다. | §C.1 |
| 2026-05-17 | Foreman 직접 정정 가능 범위를 문서 placeholder·검증·보고 영역으로 한정해 인정한다. | SUB-4에서 코드 본문이 아닌 `.env.template` placeholder와 검증 기록을 Foreman이 직접 정정했으며, 추적성을 위해 final-report에 명시했다. | §C.1 |

### 10.3 §A·§B 갱신

카테고리 4 task이므로 §A·§B 갱신 없음.

### 10.4 PROJECT.md 반영 확인

- [x] task-card §10.1 모듈 갱신 → PROJECT.md §C.1 반영 완료
- [x] task-card §10.2 결정 이력 → PROJECT.md §D 반영 완료
- [x] task-card §10.3 §A·§B 갱신 → 해당 없음
- [x] PROJECT.md §E.마지막 갱신 task run ID: `20260518_sync-script-implementation` 반영 완료
- [x] commit·push는 [Owner] final-report 검수 후 별도 결재 대기

---

## 11. 다음 단계 진행 가이드

- [x] [Owner] SUB-1 정렬 검수 및 SUB-2 진입 결재
- [ ] 새 Builder 세션 시작
- [ ] sync 스크립트 구현 및 단위 검증
- [ ] dummy 클라이언트 dry-run·실제 sync 검증
- [ ] handoff 작성 및 Foreman 직접 검증
- [ ] SUB-3 외부 감리
- [ ] SUB-5 종료 보고

---

**task-card 끝.**
