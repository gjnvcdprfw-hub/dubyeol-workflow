# task-card: G-2 9개 Manus Agent Skills 실제 동작 검증

**run ID**: 20260518_g2-skills-verification-execution  
**작성일시**: 2026-05-17 14:29 KST  
**작성자**: [Foreman]  
**상태**: 기획 완료  
**두별 워크트리 카테고리**: 4 (문서·운영)  
**Tier**: A

---

## 1. [Owner] 발화 원문

> [다음 task 진입 — Phase G-2 9개 스킬 실제 동작 검증]
>
> G-1 종결 확인. G-2 진입.
>
> run_id: 20260518_g2-skills-verification-execution
> Tier: A
> 카테고리: 4 (문서·운영)
> 작업 대상: dubyeol-workflow 마스터
> 작업 위치: /Users/twostars/ClaudeAi/dubyeol-workflow/
> silkroadhub 손대지 않음
>
> 대응 G-1: 20260517_g1-skills-verification-design (commit 4f7a103)
>
> [Owner] 결정 사항 (확정)
>
> 1. 진입 범위: G-2 전체 (9개 스킬 일괄 검증)
>    - 01-load-sub-manual부터 09-update-project-md까지 9개 모두
>
> 2. Tier: A (SUB-3 외부 감리 발동)
>    - 9개 스킬 검증 결과를 한 번에 외부 감리로 평가
>    - Codex [Reviewer] + GPT [Judge] 호출 1회
>
> 3. 실패 분기: 일괄 보고
>    - 실패 발견 시 내용 기록하고 다음 스킬 계속 검증
>    - 9개 모두 검증 후 SUB-3 진입
>    - SUB-3 결과 위에서 수정 분기 결정
>
> 4. 외부 도구 호출 운영 (회고 17 사전 적용)
>    - 검증 자체가 외부 도구 호출 포함 (06 Codex, 07 GPT)
>    - 새 Terminal 창 + 새 세션 시작 의무
>    - 이전 세션 컨텍스트 무시
>    - AGENTS.md §12 베타 운영 절차 준용
>
> 5. commit·push 사전 승인: 미부여
>    - 본 G-2 task의 commit·push는 결과 검수 후 별도 결재
>    - 본 발화로 commit·push 사전 승인되지 않음
>
> 본 task 작업 — G-2 실제 검증 실행
>
> 다음 순서로 진행:
>
> 1. SUB-1 task-card 작성
>    - G-1 설계서 (.harness/runs/20260517_g1-skills-verification-design/g1-skills-verification-design.md) 입력으로 박기
>    - 9개 스킬별 검증 케이스 5건 (목적/전제조건/기대동작/실패신호/증거파일) 모두 task-card §3에 반영
>    - SUB-1 의도 정렬 보고 후 [Owner] 결재 받기
>
> 2. SUB-2 검증 실행 (9개 스킬 일괄)
>    ...
>
> SUB-1 의도 정렬 보고 받은 뒤 [Owner] 결재
>
> 본 발화로 G-2 task 진입 결재. SUB-1 의도 정렬 보고 후 SUB-2 진입 결재 별도.
>
> 진행해.

### 1.1 SUB-1 정렬 검수 및 결재 발화

> SUB-1 정렬 검수 완료.
>
> 평가:
> - What·Looks Like·Looks Wrong·모호어 해소·가정 모두 정합
> - 본 SUB-1 정렬은 G-1 SUB-1보다 한 단계 정밀
> - 본 세션 누적 학습 충실 반영
> - 부정합 발견 없음
>
> 진행
>
> SUB-1 결재. SUB-2 검증 실행 진입.
>
> 권한 천장 재확인:
> - commit·push 사전 승인 없음 (본 G-2 결과 검수 후 별도 결재)
> - 운영 문서 (AGENTS.md, SUB-1~5, PROJECT.md) 임의 수정 금지
> - 결함 발견 시 r7 정비 후보로 누적
> - force push, history rewrite, reset --hard 금지
>
> 진행해.

---

## 2. 상위 맥락 연결 (PROJECT.md 진입 시점)

- **연결 모듈**: §C.1 두별 워크플로우 운영 인프라
- **진입 시점 마일스톤**: §C.1 다음 마일스톤 중 `Phase G-2: 9개 스킬 실제 동작 검증 수행 및 외부 감리 집중. 01-load-sub-manual을 최우선 검증 대상으로 시작.`
- **이번 task로 *전진시키는 것***: G-1 설계서를 실행 기준으로 삼아 9개 Manus Agent Skills의 실제 동작을 검증하고, 실패·의존성·외부 감리 결과를 G-2 증거로 고정한다.
- **PROJECT.md 진입 시점 스냅샷**:
  - 모듈 상태: Phase G-1 검증 설계서 작성 완료. 9개 스킬별 검증 목적·입력·기대 동작·실패 신호·증거 기준·G-2 우선순위를 문서화했고, `01-load-sub-manual`의 `scripts/load_sub.sh` 부재 의심 신호를 G-2 최우선 검증 대상으로 확정.
  - 현재 막힌 점: G-2 실제 검증 전 `01-load-sub-manual`의 스크립트 의존성(`scripts/load_sub.sh`) 존재 여부와 스킬 지시문 정합성 확인 필요.

---

## 3. 의도 정렬 증거 블록 (SUB-1 §2 SOP 결과 — 불변)

> 본 블록은 task 진행 중 **수정 금지**. 의도 변경 발생 시 §9에 *추가* 블록으로 기록.

### 3.1 한 문장 목표 (What)

`dubyeol-workflow` 마스터에서 9개 Manus Agent Skills를 G-1 설계 기준대로 실제 실행 검증하고, 스킬별 증거 파일·handoff·외부 감리 결과까지 남긴다.

### 3.2 성공 시 보이는 모습 (Looks Like)

- `.harness/runs/20260518_g2-skills-verification-execution/` 아래에 G-2 산출물이 저장된다.
- 9개 스킬 각각에 대해 `g2-01`~`g2-09` 증거 파일이 생성되고 PASS/FAIL/부분 PASS 판정이 남는다.
- 실패가 발견되어도 즉시 중단하지 않고 의존성·우회 여부를 기록한 뒤 9개 검증을 끝까지 진행한다.
- Codex [Reviewer]와 GPT [Judge]가 별도 세션·별도 입력으로 1회씩 호출되어 `gate-review.md`가 작성된다.
- commit·push는 본 task 결과 검수 후 별도 결재 전까지 실행되지 않는다.

### 3.3 실패 시 보이는 모습 (Looks Wrong)

- 9개 스킬 중 일부만 검증되고 누락 스킬이 발생한다.
- 실행 증거 없이 “동작 확인”으로 기록된다.
- dummy run이 아닌 실 운영 run이나 `silkroadhub` 경로가 오염된다.
- Reviewer·Judge 입력이 섞이거나 Codex가 Judge 역할을 수행한다.
- [Owner] 별도 승인 없이 commit·push·운영 문서 수정·파괴적 git 명령이 실행된다.

### 3.4 모호어 해소 기록

- "G-2 전체" → "9개 스킬 일괄 검증"
- "실제 실행" → "스킬 호출·외부 도구 호출·증거 파일 생성까지 수행하되, 실 사업 데이터와 운영 반영은 제외"
- "일괄 보고" → "실패 발견 시 기록 후 계속 진행하고, 9개 완료 뒤 종합 보고·SUB-3 진입"

### 3.5 마누스가 가정한 것 3가지

**가정 1**: 작업 대상은 `/Users/twostars/ClaudeAi/dubyeol-workflow` 마스터이며, `silkroadhub`는 읽기·쓰기 대상이 아니다.  
→ 근거: [Owner] 발화에서 작업 대상·위치와 `silkroadhub 손대지 않음`이 명시되었고, PROJECT.md §A.3도 마스터 로컬 경로를 동일하게 둔다.  
→ 검증: run 디렉터리를 `dubyeol-workflow/.harness/runs/20260518_g2-skills-verification-execution/`에 생성하고, `silkroadhub` 경로 오염 여부를 검증 명령에 포함한다.

**가정 2**: 02·03·04 등 검증 중 생성되는 dummy 자료는 `.harness/runs/g2-dummy-runs/<skill_id>/`에 격리하고, 본 task commit 대상이 아니다.  
→ 근거: [Owner] 발화에서 dummy task 위치와 검증 종료 시 dummy 자료 별도 정리를 명시했다.  
→ 검증: handoff에서 dummy run 생성·정리 여부와 commit 대상 제외 여부를 증거로 확인한다.

**가정 3**: Tier A는 스킬 실제 실행과 외부 도구 호출, SUB-3 외부 감리, 운영 프레임워크 영향 때문에 확정이며, 자동 강등하지 않는다.  
→ 근거: [Owner]가 `Tier: A`와 `SUB-3 외부 감리 발동`, Codex [Reviewer] + GPT [Judge] 호출을 확정했다. AGENTS.md §6의 Tier 강등 금지 원칙에 따라 자동 강등하지 않는다.  
→ 검증: SUB-2 완료 후 SUB-3에 진입하고, Reviewer·Judge 입력 파일과 원시 결과를 분리 보존한다.

### 3.6 정렬 확인

- **정렬 일시**: 2026-05-17 14:29 KST
- **[Owner] 명시 응답**: "SUB-1 정렬 검수 완료. ... SUB-1 결재. SUB-2 검증 실행 진입. ... 진행해."

### 3.7 G-1 설계서 기반 9개 스킬별 검증 케이스 요약

| # | 스킬 ID | 목적 | 전제조건 | 기대 동작 | 실패 신호 | 증거 파일 |
|---:|---|---|---|---|---|---|
| 1 | `01-load-sub-manual` | SUB 매뉴얼 로드 스킬의 스크립트·경로 정합성 확인 | 마스터 저장소 접근, SUB 파일 존재 | 매뉴얼 경로 확인 및 로드 성공 | `scripts/load_sub.sh` 부재, 경로 오류, 로드 없이 종료 | `g2-01-load-sub-manual-evidence.md` |
| 2 | `02-create-task-card` | task-card 생성 지시와 템플릿 준수 확인 | task-card template, dummy run | 올바른 경로에 §1~§11 포함 task-card 생성 또는 생성 절차 검증 | 파일 미생성, 섹션 누락, 잘못된 경로 | `g2-02-create-task-card-evidence.md` |
| 3 | `03-dispatch-to-builder` | 새 Claude Code 세션·파일 경유·2단계 확정 실행 검증 | Terminal, claude CLI, entry 파일 | 새 창 ID 확보, 짧은 명령 전달, Builder 초기 응답 확인 | 기존 세션 재사용, Enter 미확정, 직접 긴 명령 전달 | `g2-03-dispatch-to-builder-evidence.md` |
| 4 | `04-invoke-plan-review` | plan-review 입력 격리와 결과 저장 확인 | dummy plan, GPT 접근 | plan-review-input 생성, 코드 없는 plan 검토 결과 저장 | 코드/handoff 섞임, 동일 세션 오염, 결과 미생성 | `g2-04-invoke-plan-review-evidence.md` |
| 5 | `05-verify-handoff` | handoff 완결성·권한 천장·마스킹 점검 확인 | dummy handoff, git 접근 | git 상태·권한 천장·마스킹 결과 기록 | push/merge 흔적 미탐지, 운영 문서 변경 누락, 마스킹 누락 | `g2-05-verify-handoff-evidence.md` |
| 6 | `06-invoke-reviewer` | Codex [Reviewer] 코드 전용 감리 호출 확인 | reviewer-input, Codex CLI | 코드·스크립트 영역 입력만 전달하고 reviewer-raw 저장 | 기획 내용 혼입, reviewer-raw 미생성, Codex가 Judge 역할 수행 | `g2-06-invoke-reviewer-evidence.md` |
| 7 | `07-invoke-judge` | GPT [Judge] 사업·기획·논리 검토 호출 확인 | judge-input, GPT 세션 | 코드 디테일 없이 별도 세션에서 judge-raw 저장 | 코드 diff 혼입, Reviewer와 같은 세션 사용, Codex Judge 역할 | `g2-07-invoke-judge-evidence.md` |
| 8 | `08-write-final-report` | final-report 작성 절차·섹션 매핑 확인 | task-card/handoff/gate 자료 | §1~§13 구조와 입력 소스 매핑 확인 | 섹션 누락, Builder가 final-report 작성, 입력 소스 오배치 | `g2-08-write-final-report-evidence.md` |
| 9 | `09-update-project-md` | PROJECT.md 갱신 승인 경계 확인 | task-card §10, PROJECT.md | 승인 전 diff/제안만 작성, 직접 수정 금지 확인 | 승인 없이 PROJECT.md 수정, §E 누락, Builder 역할 침범 | `g2-09-update-project-md-evidence.md` |

---

## 4. Tier 판정

- **Tier**: A
- **판정 근거**: [Owner]가 Tier A와 SUB-3 외부 감리 발동을 확정했다. 본 task는 9개 운영 스킬의 실제 실행 검증과 Codex·GPT 외부 도구 호출을 포함하며, 두별 워크플로우 운영 프레임워크의 신뢰성에 직접 영향을 준다.
- **Blast Radius**: 최악의 경우 스킬 동작 검증 기준이 틀리거나 외부 감리 입력 격리가 깨져 r7 정비와 향후 운영 task 전반의 검증 신뢰도가 손상될 수 있다. 다만 실 사업 데이터·고객 데이터·결제·통관 운영 시스템은 직접 접근하지 않는다.
- **Gate 의무**:
  - Tier A: [Reviewer] + [Judge] 둘 다, `gate-review.md` 필수.
  - [Reviewer]는 Codex 우선, 코드·스크립트·기술 명세만 본다.
  - [Judge]는 GPT 별도 세션, 기획·전략·논리만 본다.

---

## 5. 작업 범위 (Scope)

### 5.1 포함

- `.harness/runs/20260518_g2-skills-verification-execution/` run 디렉터리 구성.
- G-1 설계서 기준으로 9개 스킬 실제 실행 검증 수행.
- 스킬별 증거 파일 `g2-01`~`g2-09` 작성.
- dummy run 생성·활용·정리 또는 보존 필요성 기록.
- SUB-2 handoff 작성 및 Foreman 직접 검증.
- Tier A SUB-3 외부 감리: Codex [Reviewer] 1회 + GPT [Judge] 1회.
- `gate-review.md`, 필요 시 `sub4-modifications.md`, `final-report.md` 작성.

### 5.2 명시적 제외 (out of scope)

- `silkroadhub` 저장소 읽기·쓰기.
- 실 사업 데이터, 고객 데이터, 운송장, BL, 개인통관고유부호, 결제, 통관 운영 시스템 접근.
- [Owner] 별도 승인 없는 commit·push·merge·deploy.
- [Owner] 별도 승인 없는 AGENTS.md, SUB-1~5, PROJECT.md 운영 문서 임의 수정.
- force push, history rewrite, reset hard, destructive cleanup.
- 결함 발견 즉시 스킬 수정. 수정은 SUB-3 결과와 [Owner] 결재 후 SUB-4에서 제한적으로 수행.

### 5.3 산출물 (Deliverables)

- `.harness/runs/20260518_g2-skills-verification-execution/task-card.md`
- `.harness/runs/20260518_g2-skills-verification-execution/g2-01-load-sub-manual-evidence.md` ~ `g2-09-update-project-md-evidence.md`
- `.harness/runs/20260518_g2-skills-verification-execution/handoff.md`
- `.harness/runs/20260518_g2-skills-verification-execution/handoff-verification.md`
- `.harness/runs/20260518_g2-skills-verification-execution/reviewer-input.md`
- `.harness/runs/20260518_g2-skills-verification-execution/reviewer-raw.md`
- `.harness/runs/20260518_g2-skills-verification-execution/judge-input.md`
- `.harness/runs/20260518_g2-skills-verification-execution/judge-raw.md`
- `.harness/runs/20260518_g2-skills-verification-execution/gate-review.md`
- `.harness/runs/20260518_g2-skills-verification-execution/final-report.md`
- 필요 시 `.harness/runs/20260518_g2-skills-verification-execution/sub4-modifications.md`

---

## 6. 진행 트리 (두별 워크트리)

선택한 카테고리에 따른 진행 트리는 **AGENTS.md §3 진행 트리**를 따른다.

본 task의 카테고리: 4 (문서·운영).

### 6.1 변형 사유 (해당 시)

카테고리 4 표준 트리는 `using-superpowers → brainstorming → 작성 → 자체 review → finishing-a-development-branch`다. 본 task는 단순 문서 작성이 아니라 9개 스킬 실제 실행 검증과 Tier A 외부 감리를 포함하므로 다음 변형을 적용한다.

- SUB-2에서 새 Builder 세션을 열고 9개 스킬 검증을 일괄 수행한다.
- 실패 발견 시 즉시 중단하지 않고 증거를 기록한 뒤 다음 스킬로 진행한다.
- SUB-2 완료 후 Tier A 원칙에 따라 SUB-3 외부 감리를 필수 진행한다.
- 수정은 SUB-3 결과와 [Owner] 결재 후 SUB-4에서만 수행한다.
- commit·push는 SUB-5 결과 검수 후 별도 결재 전까지 실행하지 않는다.

---

## 7. 검증 명령

본 task의 성공 여부는 코드 테스트가 아니라 산출물 존재, 9개 스킬 증거 파일, 권한 천장, 역할 격리, 외부 감리 결과로 확인한다.

```bash
cd /Users/twostars/ClaudeAi/dubyeol-workflow
RUN=.harness/runs/20260518_g2-skills-verification-execution

test -f "$RUN/task-card.md"
for n in 01 02 03 04 05 06 07 08 09; do
  test -f "$RUN/g2-$n-"*.md
done

test -f "$RUN/handoff.md"
test -f "$RUN/handoff-verification.md"
test -f "$RUN/reviewer-input.md"
test -f "$RUN/reviewer-raw.md"
test -f "$RUN/judge-input.md"
test -f "$RUN/judge-raw.md"
test -f "$RUN/gate-review.md"

test ! -d /Users/twostars/ClaudeAi/silkroadhub/.harness/runs/20260518_g2-skills-verification-execution

git status --short
```

명령이 명확하지 않거나 wildcard가 환경별로 실패하면 [Builder]가 동등한 확인 명령을 handoff에 기록한다.

---

## 8. 권한 천장·금지 사항 (재확인)

[Owner] 명시 승인 없이 [Builder]·[Foreman] 실행 금지:

- [ ] push / merge / deploy
- [ ] 운영 문서 변경 반영 (AGENTS.md, CLAUDE.md, PROJECT.md, templates 등)
- [ ] 파괴적 git 명령 (reset --hard, force push, history rewrite)
- [ ] task scope 확장 (§5.2 제외 범위 침범)
- [ ] 외부 시스템 프로덕션 실호출
- [ ] Tier 강등

본 task 특유의 추가 금지 사항:

- 이전 Claude Code, Codex, GPT 세션을 본 task용으로 재사용하지 않는다.
- Reviewer 입력과 Judge 입력을 혼합하지 않는다.
- Codex가 Judge 역할을 수행하지 않는다.
- dummy run 자료를 본 task 승인 없이 commit 대상에 포함하지 않는다.
- 실 사업 데이터나 silkroadhub 경로를 사용하지 않는다.
- 결함 발견 즉시 수정하지 않는다. SUB-3 후 [Owner] 결재를 받는다.

---

## 9. 의도 변경 기록 (해당 시만 추가)

없음.

---

## 10. PROJECT.md 갱신 사항 (task 종료 시 [Foreman] 작성, SUB-5)

### 10.1 §C.1 모듈 갱신

- **현재 상태**: Phase G-2 실제 동작 검증 완료. 9개 Manus Agent Skills는 PASS 0 / PARTIAL PASS 9 / FAIL 0으로 판정되었고, Reviewer HOLD·Judge 수정 판정에 따라 수정 필요 상태로 종료한다. `silkroadhub` hardcoded root라는 회고 13급 잔재와 master/client 키 자료 의존 부정합이 확인되었다.
- **최근 마일스톤 추가**: 2026-05-17 Phase G-2 — 9개 스킬 실제 동작 검증 및 Tier A 외부 감리 완료. 마스터 측 키 복사본 삭제 및 `.gitignore` 보강 완료. (run: `20260518_g2-skills-verification-execution`)
- **다음 마일스톤**: 정책+sync 설계 task, 9개 스킬 수정 task, silkroadhub 첫 클라이언트 적용 task, G-2 v2 또는 부분 재검증, r7 정비.
- **현재 막힌 점**: 9개 스킬 공통 `silkroadhub` hardcoded root와 master/client sync 정책 부재. 실제 수정은 별도 task-card로 진입한다.

### 10.2 §D 결정 이력 추가 (큰 결정 발생 시)

| 날짜 | 결정 | 사유 | 영향 모듈 |
|---|---|---|---|
| 2026-05-17 | G-2 결과는 수정 필요 상태로 종료하고 실제 수정은 별도 task로 분리한다. | Reviewer HOLD와 Judge 수정 판정이 일치한다. | §C.1 |
| 2026-05-17 | 마스터→클라이언트 sync 패턴을 후속 정책 설계의 기본 방향으로 삼는다. | 마스터 정책 정의와 client sync 자동화가 drift 방지에 정합하다. | §C.1 |
| 2026-05-17 | 외부 도구 키는 시스템 환경변수(`~/.zshrc`) 단일 출처 정책을 우선 검토한다. | 키 자료를 master/client 간 sync하지 않기 위함이다. | §C.1 |
| 2026-05-17 | `silkroadhub/scripts/load_openai_key.sh`는 silkroadhub 사업 서비스 운영 자산으로 보존한다. | 본 부정합은 master가 client 사업 자산에 의존한 것이며, client 운영 자산은 손대지 않는다. | §C.1, silkroadhub |

### 10.3 §A·§B 갱신 (카테고리 5 기획 task일 때만)

해당 없음.

### 10.4 PROJECT.md 반영 확인

- [x] task-card §10.1 모듈 갱신 → PROJECT.md §C.1 반영
- [x] task-card §10.2 결정 이력 → PROJECT.md §D 반영
- [x] task-card §10.3 §A·§B 갱신 → 해당 없음
- [x] PROJECT.md §E 마지막 갱신 task run ID: `20260518_g2-skills-verification-execution`
- [x] PROJECT.md §E 마지막 갱신 일시: 2026-05-17 KST

---

## 11. 다음 단계 진행 가이드

- [x] [Owner] task-card 결재 및 SUB-2 진입 승인
- [x] 새 Builder 세션 시작
- [x] 9개 스킬 실제 검증 실행
- [x] handoff 작성 및 Foreman 직접 검증
- [x] SUB-3 외부 감리
- [x] SUB-5 종료 진입 — 수정 필요 상태로 종료 보고, 실제 수정은 별도 task 분리

---

**task-card 끝.**
