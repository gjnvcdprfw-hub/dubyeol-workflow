# task-card: 정책+sync 설계

**run ID**: 20260518_skills-policy-and-sync-design  
**작성일시**: 2026-05-17 16:39 KST  
**작성자**: [Foreman]  
**상태**: SUB-1 결재 완료, SUB-2 진입 준비  
**두별 워크트리 카테고리**: 4 (문서·운영)  
**Tier**: A

---

## 1. [Owner] 발화 원문

> [다음 task 진입 — 정책+sync 설계]
>
> G-2 종결 확인. 정책+sync 설계 task 진입.
>
> run_id: 20260518_skills-policy-and-sync-design  
> Tier: A  
> 카테고리: 4 (문서·운영)  
> 작업 대상: dubyeol-workflow 마스터  
> 작업 위치: /Users/twostars/ClaudeAi/dubyeol-workflow/  
> silkroadhub 손대지 않음 (사업 자산 보존)
>
> 대응 G-2: 20260518_g2-skills-verification-execution (commit 72f8ab2)
>
> [Owner] 결정 사항 (G-2 final-report §12.4에서 이미 박힘, 본 task에서 정책서로 정합 박음)
>
> 1. 정책 원천: 두별 워크플로우 마스터
> 2. 배포 방식: sync 스크립트 자동 복사
> 3. 운영 전제: 같은 로컬·같은 사용자 (현재 시점)
> 4. 키 출처: 시스템 환경변수 (~/.zshrc) 단일
> 5. 금지: 마스터·클라이언트 어느 쪽도 키 자료 sync 안 함
> 6. 보안: 마스터에 API 키 미박음
> 7. drift 방지: sync 자동화
> 8. silkroadhub 사업 자산 보존 (silkroadhub/scripts/load_openai_key.sh 등 손대지 않음)
>
> 본 task는 위 결정 사항을 구체 정책서 + sync 스크립트 설계서로 박는 것.
>
> 본 task는 설계 전용. 실제 sync 스크립트 구현 + 9개 스킬 수정은 후속 task.
>
> 본 task 작업 — 정책+sync 설계서 작성
>
> 다음 7개 항목 박는다:
>
> 1. 마스터·클라이언트 자료 경계 정책
> 2. REPO_ROOT 등 환경 변수화 정책
> 3. 시스템 환경변수 정책
> 4. sync-to-client.sh 스크립트 설계
> 5. .env 정책
> 6. SKILL.md / scripts 정정 가이드라인 (9개 스킬 수정 task 입력)
> 7. 후속 task 명시
>
> 산출물 위치: /Users/twostars/ClaudeAi/dubyeol-workflow/.harness/runs/20260518_skills-policy-and-sync-design/
>
> 진행 트리: SUB-1 의도 정렬 → SUB-2 설계서 작성 → SUB-3 외부 감리 (Tier A) → SUB-5 종료
>
> 권한 천장:
> - 본 task는 설계 작성만. 9개 스킬 본문·sync 스크립트 실제 구현 안 함
> - AGENTS.md, SUB-1~5, PROJECT.md 임의 수정 금지 (정책 결과는 r7 정비에서 일괄 반영)
> - commit·push 사전 승인 없음. final-report 검수 후 별도 결재
>
> SUB-1 의도 정렬 보고 받은 뒤 [Owner] 결재
>
> 본 발화로 task 진입 결재. SUB-1 보고 후 SUB-2 진입 결재 별도.
>
> 진행해.

### 1.1 SUB-1 정렬 검수 및 결재 발화

> SUB-1 정렬 검수 완료.
>
> 평가:
> - What·Looks Like·Looks Wrong·모호어 해소·가정 모두 정합
> - 본 SUB-1은 본 세션에서 가장 정밀한 정렬
> - 회고 23·28·31 및 Tier 강등 금지 학습 반영
> - 부정합 발견 없음
>
> 진행
>
> SUB-1 결재. SUB-2 정책+sync 설계서 작성 진입.
>
> 권한 천장 재확인:
> - 본 task는 설계 작성만. 9개 스킬 본문·sync 스크립트 실제 구현 안 함
> - AGENTS.md, SUB-1~5, PROJECT.md 임의 수정 금지
> - commit·push 사전 승인 없음
> - silkroadhub 사업 자산 손대지 않음 (읽기·수정·복사 모두 금지)
> - force push, history rewrite, reset --hard 금지
>
> 진행해.

---

## 2. 상위 맥락 연결 (PROJECT.md 진입 시점)

- **연결 모듈**: §C.1 두별 워크플로우 운영 인프라
- **진입 시점 마일스톤**: §C.1 다음 마일스톤 중 `정책+sync 설계 task: 마스터·클라이언트 자료 경계, REPO_ROOT 환경 변수화, sync 스크립트 설계, 키 자료 sync 제외, 시스템 환경변수(~/.zshrc) 단일 키 출처 정책 확정.`
- **이번 task로 전진시키는 것**: G-2에서 확인된 9개 스킬 공통 결함과 master/client 경계 부정합을 바탕으로, 후속 9개 스킬 수정 task와 silkroadhub 첫 클라이언트 적용 task가 재해석 없이 사용할 수 있는 정책+sync 설계 기준을 고정한다.
- **PROJECT.md 진입 시점 스냅샷**:
  - 모듈 상태: Phase G-2 실제 동작 검증 완료. 9개 Manus Agent Skills는 PASS 0 / PARTIAL PASS 9 / FAIL 0이며, Reviewer HOLD·Judge 수정 판정에 따라 실제 수정은 별도 task로 분리되었다.
  - 현재 막힌 점: 9개 스킬 공통 `silkroadhub` hardcoded root와 master/client sync 정책 부재. 실제 수정은 별도 task-card로 진입해야 한다.

---

## 3. 의도 정렬 증거 블록 (SUB-1 §2 SOP 결과 — 불변)

> 본 블록은 task 진행 중 **수정 금지**. 의도 변경 발생 시 §9에 *추가* 블록으로 기록.

### 3.1 한 문장 목표 (What)

`dubyeol-workflow` 마스터에서 마스터·클라이언트 자료 경계, 환경변수·키 출처, sync-to-client 설계, .env 정책, 9개 스킬 수정 가이드라인을 정책+sync 설계서로 확정한다.

### 3.2 성공 시 보이는 모습 (Looks Like)

- `.harness/runs/20260518_skills-policy-and-sync-design/` 아래에 `task-card.md`, `policy.md`, `sync-design.md`, `skills-fix-guidelines.md`, `handoff.md`, `handoff-verification.md`, `gate-review.md`, `final-report.md`가 생성된다.
- 정책서에는 마스터에 둘 것, 클라이언트로 sync할 것, 클라이언트가 자체 보유할 것, 어느 쪽에도 두지 않을 것(API 키)이 분리되어 적힌다.
- `REPO_ROOT` 결정 방식 옵션 4개를 비교하고 권고안을 정한다.
- `sync-to-client.sh <client-path>`의 dry-run, rsync, exclude, 충돌 처리, 검증 방식이 구현 전 설계 수준으로 명확해진다.
- 9개 스킬 수정 task가 바로 사용할 수 있도록 SKILL.md/scripts 정정 가이드와 후속 task 순서가 남는다.

### 3.3 실패 시 보이는 모습 (Looks Wrong)

- 설계 task인데 실제 9개 스킬 본문이나 sync 스크립트를 구현·수정한다.
- `silkroadhub/scripts/load_openai_key.sh` 등 silkroadhub 사업 자산을 읽기·수정·복사 대상으로 삼는다.
- API 키나 키 로드 파일을 마스터 또는 클라이언트 sync 대상으로 포함한다.
- 마스터→클라이언트 sync 대상과 제외 대상이 모호해 후속 구현 task에서 재해석이 필요해진다.
- SUB-3에서 Reviewer/Judge 입력 격리가 깨지거나, commit·push가 [Owner] 별도 승인 없이 실행된다.

### 3.4 모호어 해소 기록

- “정책+sync 설계” → “정책서와 sync 스크립트 설계서를 작성하되, 실제 sync 구현과 9개 스킬 수정은 하지 않는다.”
- “silkroadhub 손대지 않음” → “사업 자산 보존, 특히 `scripts/load_openai_key.sh` 등 키 자료를 읽기·수정·복사하지 않는다.”
- “시스템 환경변수 단일 출처” → “현재 같은 로컬·같은 사용자 전제에서 `~/.zshrc` 등 사용자 환경변수를 키 출처로 두고, 저장소에는 API 키를 두지 않는다.”

### 3.5 마누스가 가정한 것 3가지

**가정 1**: 이번 task의 주 산출물은 문서 3종(`policy.md`, `sync-design.md`, `skills-fix-guidelines.md`)이며, `sync-to-client.sh`는 구현하지 않고 인터페이스·동작·제외 규칙·검증 방식만 설계한다.  
→ 근거: [Owner] 발화에서 “본 task는 설계 전용. 실제 sync 스크립트 구현 + 9개 스킬 수정은 후속 task”라고 명시했다.  
→ 검증: SUB-2 handoff와 Foreman 검증에서 9개 스킬 본문·scripts·sync-to-client.sh 실제 구현 파일이 변경되지 않았는지 확인한다.

**가정 2**: `silkroadhub`는 이번 task에서 파일 작업 대상이 아니며, 사례로 언급하더라도 사업 자산을 보존한다는 정책 원칙만 문서화한다.  
→ 근거: [Owner] 발화에서 `silkroadhub 손대지 않음`, `silkroadhub 사업 자산 보존`, `읽기·수정·복사 모두 금지`가 명시되었다.  
→ 검증: `silkroadhub` 경로에서 산출물·diff·파일 복사·읽기 시도가 발생하지 않았는지 확인한다.

**가정 3**: Tier A는 키 정책·sync 정책·운영 인프라 경계와 외부 감리를 포함하기 때문에 유지하며, 코드 구현이 없어도 자동 강등하지 않는다.  
→ 근거: [Owner]가 Tier A를 지정했고, AGENTS.md §6 #6 Tier 강등 금지 원칙이 적용된다.  
→ 검증: SUB-2 후 SUB-3에서 Reviewer·Judge를 분리 호출하고 `gate-review.md`를 작성한다.

### 3.6 정렬 확인

- **정렬 일시**: 2026-05-17 16:39 KST
- **[Owner] 명시 응답**: “SUB-1 정렬 검수 완료. ... SUB-1 결재. SUB-2 정책+sync 설계서 작성 진입. ... 진행해.”

---

## 4. Tier 판정

- **Tier**: A
- **판정 근거**: [Owner]가 Tier A를 명시했다. 본 task는 API 키 출처, sync 제외 규칙, master/client 자료 경계, 9개 운영 스킬 수정 기준, 외부 감리 분기까지 정의하므로 최악의 경우 보안·운영 경계·미래 운영 전체에 영향을 준다.
- **Blast Radius**: 설계서가 잘못되면 후속 9개 스킬 수정 task, 클라이언트 적용 task, r7 정비 전반이 잘못된 전제를 공유할 수 있다. 특히 키 자료 sync 제외와 silkroadhub 사업 자산 보존 정책이 흔들리면 보안·권한 경계 리스크가 커진다.
- **Gate 의무**: Tier A이므로 SUB-3에서 [Reviewer]와 [Judge]를 분리 호출하고 `gate-review.md`를 작성한다. Codex 불가 시 G-2에서 입증한 GPT Reviewer 폴백 절차를 사용하되, [Judge]와 입력·세션을 반드시 분리한다.

---

## 5. 작업 범위 (Scope)

### 5.1 포함

- `.harness/runs/20260518_skills-policy-and-sync-design/` run 디렉터리 구성.
- `policy.md`: 마스터·클라이언트 자료 경계, `REPO_ROOT` 환경 변수화 정책, 시스템 환경변수 정책 작성.
- `sync-design.md`: `sync-to-client.sh <client-path>` 설계, dry-run, rsync, exclude, 충돌 처리, 검증 방식, `.env` 정책 작성.
- `skills-fix-guidelines.md`: 9개 스킬 수정 task가 사용할 SKILL.md/scripts 정정 가이드 작성.
- `handoff.md`, `handoff-verification.md`, `gate-review.md`, `final-report.md` 작성.
- Tier A 외부 감리: Reviewer는 기술·sync 설계 정합성, Judge는 정책·운영 정합성을 검토.

### 5.2 명시적 제외 (out of scope)

- 9개 스킬 본문(`01`~`09` SKILL.md) 또는 scripts 실제 수정.
- `sync-to-client.sh` 실제 구현.
- AGENTS.md, SUB-1~5, PROJECT.md 운영 문서 임의 수정. 단 SUB-5에서 task-card §10에 따른 PROJECT.md 갱신은 [Owner] 검수 후 별도 결재 범위로만 진행한다.
- `silkroadhub` 파일 읽기·수정·복사·삭제. 특히 `silkroadhub/scripts/load_openai_key.sh` 등 사업 운영 자산 접근 금지.
- API 키, 키 로드 파일, `.env` 파일을 master/client sync 대상에 포함.
- commit·push·merge·deploy·history rewrite·reset hard.

### 5.3 산출물 (Deliverables)

| 산출물 | 경로 |
|---|---|
| task-card | `.harness/runs/20260518_skills-policy-and-sync-design/task-card.md` |
| 정책서 | `.harness/runs/20260518_skills-policy-and-sync-design/policy.md` |
| sync 설계서 | `.harness/runs/20260518_skills-policy-and-sync-design/sync-design.md` |
| 스킬 수정 가이드 | `.harness/runs/20260518_skills-policy-and-sync-design/skills-fix-guidelines.md` |
| handoff | `.harness/runs/20260518_skills-policy-and-sync-design/handoff.md` |
| handoff 검증 | `.harness/runs/20260518_skills-policy-and-sync-design/handoff-verification.md` |
| gate-review | `.harness/runs/20260518_skills-policy-and-sync-design/gate-review.md` |
| final-report | `.harness/runs/20260518_skills-policy-and-sync-design/final-report.md` |

---

## 6. 진행 트리 (두별 워크트리)

본 task의 카테고리: 4 (문서·운영).

카테고리 4 표준 트리는 `using-superpowers → brainstorming → 작성 → 자체 review → finishing-a-development-branch`다. 본 task는 정책 설계 전용이며 실제 구현을 금지하므로, SUB-2에서는 Builder가 새 세션에서 문서 3종을 작성하고 자체 review 후 handoff를 남긴다. Tier A이므로 SUB-3 외부 감리를 수행한다. SUB-4는 감리 결과가 수정 필요일 때만 [Owner] 결정으로 진입한다.

---

## 7. 검증 명령

```bash
cd /Users/twostars/ClaudeAi/dubyeol-workflow
RUN=.harness/runs/20260518_skills-policy-and-sync-design

test -f "$RUN/task-card.md"
test -f "$RUN/policy.md"
test -f "$RUN/sync-design.md"
test -f "$RUN/skills-fix-guidelines.md"
test -f "$RUN/handoff.md"
test -f "$RUN/handoff-verification.md"
test -f "$RUN/gate-review.md"

git status --short -- 01-load-sub-manual 02-create-task-card 03-dispatch-to-builder 04-invoke-plan-review 05-verify-handoff 06-invoke-reviewer 07-invoke-judge 08-write-final-report 09-update-project-md AGENTS.md SUB-1-기획의도.md SUB-2-워크플로우.md SUB-3-외부감리.md SUB-4-수정.md SUB-5-종료.md PROJECT.md
```

검증 핵심은 설계 산출물 존재, 9개 스킬·운영 문서·silkroadhub 미수정, 키 자료 미포함, Reviewer/Judge 정보 격리다.

---

## 8. 권한 천장·금지 사항 (재확인)

[Owner] 명시 승인 없이 실행 금지:

- [ ] push / merge / deploy
- [ ] 9개 스킬 본문 또는 scripts 실제 수정
- [ ] `sync-to-client.sh` 실제 구현
- [ ] AGENTS.md, SUB-1~5, PROJECT.md 임의 수정
- [ ] `silkroadhub` 사업 자산 읽기·수정·복사·삭제
- [ ] API 키·키 파일·`.env` sync 대상 포함
- [ ] force push, history rewrite, reset hard
- [ ] Tier 강등

---

## 9. 의도 변경 기록 (해당 시만 추가)

없음.

---

## 10. PROJECT.md 갱신 사항 (task 종료 시 [Foreman] 작성, SUB-5)

SUB-5에서 작성한다. 본 task 종료 시 PROJECT.md §C.1에는 정책+sync 설계 완료 여부, 후속 9개 스킬 수정 task·silkroadhub 첫 클라이언트 적용 task·G-2 v2/부분 재검증·r7 정비 순서를 반영한다. commit·push는 [Owner] final-report 검수 후 별도 결재를 받는다.

---

## 11. 다음 단계 진행 가이드

- [x] [Owner] SUB-1 정렬 검수 및 SUB-2 진입 결재
- [ ] 새 Builder 세션 시작
- [ ] 정책서 3종 작성
- [ ] handoff 작성 및 Foreman 직접 검증
- [ ] SUB-3 외부 감리
- [ ] SUB-5 종료 보고

---

**task-card 끝.**
