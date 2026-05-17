# G-1 9개 Manus Agent Skills 동작 검증 설계서

**run ID**: 20260517_g1-skills-verification-design  
**작성일시**: 2026-05-17  
**작성자**: [Builder] (클로드코드)  
**Tier**: B  
**문서 성격**: 설계 전용 — 실제 검증 실행은 G-2 영역

---

## 1. 9개 스킬별 의도 정리

두별 워크플로우 v3.6.0 r1 베타에서 [Foreman](마누스)이 운영하는 9개 Manus Agent Skills의 역할과 검증 필요성을 정리한다.

| # | 스킬 ID | 담당 단계 | 핵심 의도 | 비고 |
|---|---|---|---|---|
| 1 | `01-load-sub-manual` | SUB 전환 시마다 | SUB-1~5 매뉴얼을 [Foreman] 세션에 로드 | **G-2 우선 검증** (의심 신호 기록 — 하단 참조) |
| 2 | `02-create-task-card` | SUB-1 기획·의도 | 템플릿 기반 task-card.md 생성 | SUB-1 SOP 핵심 산출물 |
| 3 | `03-dispatch-to-builder` | SUB-2 워크플로우 | 새 Claude Code 세션 열고 Builder 진입 명령 전달 | AGENTS.md Appendix B 절차 구현 |
| 4 | `04-invoke-plan-review` | SUB-2 §2.5 | writing-plans 결과를 ChatGPT plan-review에 전달 | 구현 전 계획 외부 검토 |
| 5 | `05-verify-handoff` | SUB-2 종료 수신 | Builder handoff.md 완결성·권한 천장·마스킹 점검 | [Foreman]의 수신 직후 의무 |
| 6 | `06-invoke-reviewer` | SUB-3 외부 감리 | Codex [Reviewer] 호출 — 기술적 코드 정합성 | 코드 영역 한정 |
| 7 | `07-invoke-judge` | SUB-3 외부 감리 | ChatGPT [Judge] Devil's Advocate — 사업·기획·논리 | 코드 디테일 미열람 |
| 8 | `08-write-final-report` | SUB-5 종료 | task-card/handoff/gate-review 종합 final-report.md 작성 | [Owner] 대면 보고 근거 |
| 9 | `09-update-project-md` | SUB-5 종료 | task-card §10 내용을 PROJECT.md §C/§D에 반영 | [Owner] 명시 승인 필수 |

### 1.1 01-load-sub-manual 의심 신호 (G-2 우선 검증 근거)

SUB-1 진행 중 `01-load-sub-manual` 스킬을 호출했으나 `scripts/load_sub.sh`가 마스터 저장소(`/Users/twostars/ClaudeAi/dubyeol-workflow`)에서 발견되지 않아 매뉴얼을 수동으로 로드했다. 이는 다음 두 가지 중 하나를 의미한다:

- (a) `scripts/load_sub.sh`가 아직 작성되지 않았고 스킬 지시문이 존재하지 않는 스크립트를 참조한다.
- (b) 스크립트가 다른 경로에 존재하거나 스킬 지시문에 경로 오류가 있다.

G-2에서 이 사실을 최우선으로 검증한다. 본 G-1 task 진행에는 영향이 없다.

---

## 2. G-1과 G-2 경계

| 구분 | G-1 (본 task) | G-2 (후속 task) |
|---|---|---|
| 성격 | 설계 전용 | 실제 실행 검증 |
| 산출물 | 설계서, handoff.md | 스킬별 실행 로그, 증거 파일, 회고 결과 |
| 스킬 수정 | 금지 | 발견된 결함 수정 가능 (별도 승인) |
| 외부 감리 | SUB-3 생략 ([Owner] 명시 지시) | SUB-3 외부 감리 집중 적용 권고 |
| 운영 문서 변경 | 금지 | r7 개정으로 연결 (별도 승인) |
| commit/push | 금지 ([Owner] 승인 전) | 별도 승인 후 가능 |

---

## 3. 공통 검증 원칙

G-2 실제 검증 시 모든 스킬에 공통 적용되는 원칙이다.

| 원칙 | 내용 |
|---|---|
| **Evidence-first** | 실행 증거(로그·파일·출력) 없이 "동작 확인"을 선언하지 않는다. |
| **No silent success** | 스킬이 오류 없이 종료해도 기대 산출물이 존재하는지 별도 확인한다. |
| **역할 격리** | Builder·Reviewer·Judge 입력 파일을 혼합하지 않는다. [Reviewer]와 [Judge]는 별도 세션에서 실행한다. |
| **마스킹** | 운송장·BL·개인통관고유부호·API 키 등은 증거 파일에도 마스킹 적용 (AGENTS.md §8). |
| **No push/merge/deploy** | 검증 중 외부 시스템 배포·반영 금지. [Owner] 명시 승인 없이 git push 금지. |
| **운영 문서 불변** | 검증 결과로 스킬 내용·AGENTS.md·PROJECT.md를 임의 수정하지 않는다. 수정이 필요하면 별도 task로 분리한다. |

---

## 4. 스킬별 검증 설계 매트릭스

### 4.0 개요 테이블

| 스킬 ID | 검증 목적 | 핵심 전제조건 | G-2 우선순위 |
|---|---|---|---|
| `01-load-sub-manual` | scripts/load_sub.sh 존재 여부·스킬 지시문 정합성 | 마스터 저장소 접근 가능 | **최우선** |
| `02-create-task-card` | 템플릿 준수 task-card.md 생성 확인 | task-card-template.md 존재 | 높음 |
| `03-dispatch-to-builder` | 새 Claude Code 세션 2단계 확정 실행 확인 | Terminal 접근 가능, claude CLI 설치 | 높음 |
| `04-invoke-plan-review` | writing-plans 결과 plan-review 입력 격리·결과 수신 | plan.md 존재, ChatGPT 접근 가능 | 중간 |
| `05-verify-handoff` | handoff.md 완결성·권한 천장 항목 전부 점검 | Builder handoff.md 수신 완료 | 중간 |
| `06-invoke-reviewer` | Codex [Reviewer] 호출·코드 전용 스코프 확인 | handoff.md 수신, Codex CLI 설치 | 중간 |
| `07-invoke-judge` | ChatGPT [Judge] 호출·기획/사업 전용 스코프 확인 | handoff.md 수신, ChatGPT 접근 가능 | 중간 |
| `08-write-final-report` | final-report.md 섹션 구성·입력 소스 정합성 | task-card/handoff/gate-review 존재 | 낮음 |
| `09-update-project-md` | PROJECT.md diff 제안 + [Owner] 승인 경계 확인 | task-card §10 완성, SUB-5 진입 | 낮음 |

---

### 4.1 `01-load-sub-manual`

**목적**: 각 SUB 단계 진입 시 해당 매뉴얼 파일(`SUB-1.md`~`SUB-5.md`)을 [Foreman] 세션에 정확히 로드한다.

**전제조건**
- 마스터 저장소 `.harness/manuals/` 또는 `scripts/` 아래 매뉴얼·스크립트 파일 존재

**테스트 입력**
- `01-load-sub-manual` 스킬 호출 + 대상 SUB 번호 인자

**기대 동작**
1. 스킬 지시문이 `scripts/load_sub.sh` 또는 직접 파일 경로를 지정한다.
2. 지정된 경로의 매뉴얼이 세션 컨텍스트에 로드된다.
3. 로드 성공 메시지 또는 파일 내용이 출력된다.

**실패 신호**
- `scripts/load_sub.sh: No such file or directory`
- 스킬 지시문이 존재하지 않는 경로를 참조
- 매뉴얼 로드 없이 스킬이 정상 종료

**증거 파일**
- `g2-01-load-sub-manual-evidence.md`: `find . -name "load_sub.sh"` 출력, `ls .harness/manuals/` 출력, 스킬 지시문 원문 캡처

**G-2 우선순위**: 최우선 — SUB-1 진행 중 `scripts/load_sub.sh` 미발견 사실이 기록됨.

---

### 4.2 `02-create-task-card`

**목적**: 신규 run 시작 시 `.harness/templates/task-card-template.md`를 기반으로 올바른 경로에 `task-card.md`를 생성한다.

**전제조건**
- `.harness/templates/task-card-template.md` 존재
- run_id가 `YYYYMMDD_task-slug` 형식으로 확정됨

**테스트 입력**
- 스킬 호출 + run_id 인자

**기대 동작**
1. `.harness/runs/<run_id>/task-card.md` 생성
2. 템플릿 섹션(§1~§11)이 전부 포함됨
3. run_id·작성일시·카테고리·Tier 메타데이터 채워짐

**실패 신호**
- 파일이 생성되지 않음
- 섹션 누락 (§3 의도 정렬 증거 블록 등 필수 항목)
- 잘못된 경로에 저장 (예: silkroadhub 경로)

**증거 파일**
- `g2-02-create-task-card-evidence.md`: 생성된 task-card.md 경로·파일 크기·`diff` 또는 섹션 확인 출력

---

### 4.3 `03-dispatch-to-builder`

**목적**: 새 Terminal 창과 새 Claude Code 세션을 열고, `tmp/claude-entry-<run_id>.md` 파일 경유 진입 명령을 2단계 확정 실행으로 전달한다.

**전제조건**
- `tmp/claude-entry-<run_id>.md` 파일 작성 완료
- macOS Terminal 접근 가능
- `claude` CLI 설치 및 정상 동작

**테스트 입력**
- 스킬 호출 + run_id + 진입 명령 파일 경로

**기대 동작**
1. osascript로 새 Terminal 창 생성 (`do script "cd ... && claude"`)
2. 창 ID 조회 후 `WINDOW_ID` 확정
3. `do script "Read tmp/claude-entry-<run_id>.md and follow the instructions inside."` 전달
4. `do script ""` 추가로 Enter 확정 (2단계 확정 실행)
5. Builder 세션이 진입 명령 읽고 작업 시작

**실패 신호**
- 새 창 없이 기존 세션에 명령 전달
- `do script ""` 없어 REPL이 입력 대기 상태
- 진입 명령이 파일 경유 없이 직접 전달 (한글·특수문자 깨짐 위험)
- 이전 세션 컨텍스트가 남아 있는 창 재사용

**증거 파일**
- `g2-03-dispatch-to-builder-evidence.md`: osascript 출력(창 ID), `tmp/claude-entry-<run_id>.md` 파일 확인, 2단계 확정 실행 스크립트 원문, Builder 세션 초기 응답 캡처

---

### 4.4 `04-invoke-plan-review`

**목적**: writing-plans 산출물(`plan.md`)을 ChatGPT [Judge] plan-review 세션에 격리 전달하고 `plan-review.md` 결과를 수신한다.

**전제조건**
- `plan.md` 또는 동등한 계획 문서 존재
- ChatGPT 접근 가능
- [Judge] 세션과 별도 세션 사용 의무 확인

**테스트 입력**
- 스킬 호출 + plan.md 경로

**기대 동작**
1. plan-review 전용 입력 파일 생성 (`plan-review-input.md`)
2. plan.md 내용만 포함 (코드·handoff·gate 내용 혼합 금지)
3. ChatGPT 세션에 전달하고 응답 수신
4. 결과를 `plan-review.md`로 저장

**실패 신호**
- plan-review-input.md에 코드 디테일·handoff 내용 포함 (입력 오염)
- 동일 세션에서 [Judge] 역할과 plan-review 역할 수행
- plan-review.md 미생성

**증거 파일**
- `g2-04-invoke-plan-review-evidence.md`: plan-review-input.md 내용, 세션 분리 확인 기록, plan-review.md 경로·첫 5줄

---

### 4.5 `05-verify-handoff`

**목적**: Builder가 제출한 `handoff.md`가 두별 워크플로우 기준(완결성·권한 천장·마스킹·scope)을 모두 충족하는지 [Foreman]이 직접 점검한다.

**전제조건**
- Builder handoff.md 수신 완료
- git log 접근 가능

**테스트 입력**
- 스킬 호출 + handoff.md 경로

**기대 동작**
1. handoff §6 권한 천장 체크박스 7개 전부 미위반 확인
2. handoff §7 마스킹 점검 체크박스 전부 확인
3. `git log` 로 push·merge·파괴적 명령 흔적 없음 확인
4. task-card §5.2 제외 범위와 handoff §2.2 변경 파일 목록 대조
5. 외부 시스템 실호출 여부 확인

**실패 신호**
- push/merge 커밋이 git log에 존재
- 운영 문서(AGENTS.md·PROJECT.md)가 변경 파일 목록에 포함
- 마스킹 미적용 민감정보가 handoff 본문에 노출
- task-card §5.2 제외 범위에 해당하는 파일 변경 발견

**증거 파일**
- `g2-05-verify-handoff-evidence.md`: `git log --oneline -20` 출력, `git status --short` 출력, 권한 천장 점검 체크박스 채운 결과, 마스킹 점검 결과

---

### 4.6 `06-invoke-reviewer`

**목적**: Codex [Reviewer]를 호출해 코드 변경에 대한 기술적 정합성을 감사하고 `reviewer-raw.md`를 수신한다.

**전제조건**
- Codex CLI 설치 및 정상 동작
- handoff.md 수신 완료
- `reviewer-input.md` 작성 (코드 영역 한정)

**테스트 입력**
- 스킬 호출 + handoff.md + diff 범위

**기대 동작**
1. `reviewer-input.md` 생성 (코드 diff·테스트 결과·handoff §2·§4 포함, 기획/사업 내용 제외)
2. AGENTS.md Appendix A 절차로 Codex exec heredoc stdin 호출
3. `reviewer-raw.md` 수신 및 저장
4. 결과 첫 줄이 유효한 판정 형식인지 확인

**실패 신호**
- `reviewer-input.md`에 기획·사업 내용 포함 (역할 오염)
- `keystroke` 방식 직접 입력 (특수문자 깨짐 발생)
- `reviewer-raw.md` 미생성 또는 첫 줄이 유효 판정 형식 아님
- Codex가 [Judge] 역할(기획·사업 판단) 수행

**증거 파일**
- `g2-06-invoke-reviewer-evidence.md`: reviewer-input.md 경로·섹션 목록, codex-exec.log, reviewer-raw.md 경로·첫 10줄

---

### 4.7 `07-invoke-judge`

**목적**: ChatGPT [Judge]를 별도 세션에서 호출해 사업·기획·논리에 대한 Devil's Advocate 검토를 수행하고 `judge-raw.md`를 수신한다.

**전제조건**
- ChatGPT 접근 가능
- [Reviewer] 세션과 분리된 별도 세션 사용 의무
- `judge-input.md` 작성 (기획·사업·논리 영역 한정)

**테스트 입력**
- 스킬 호출 + task-card + handoff §8·§9 + plan-review.md

**기대 동작**
1. `judge-input.md` 생성 (task-card §1~§3·§4·handoff §8·§9 포함, 코드 디테일 제외)
2. [Reviewer] 세션과 물리적으로 분리된 ChatGPT 세션 호출
3. `judge-raw.md` 수신 및 저장
4. [Judge]가 코드 디테일을 열람하지 않았음을 입력 파일로 확인

**실패 신호**
- `judge-input.md`에 코드 diff·함수 시그니처 포함 (역할 오염)
- [Reviewer]와 동일 세션 사용
- Codex가 [Judge] 역할 수행 (절대 금지)
- judge-raw.md 미생성

**증거 파일**
- `g2-07-invoke-judge-evidence.md`: judge-input.md 경로·섹션 목록 (코드 없음 확인), 세션 분리 기록, judge-raw.md 경로·첫 10줄

---

### 4.8 `08-write-final-report`

**목적**: task-card·handoff·gate-review(reviewer-raw+judge-raw)·plan-review를 종합하여 `final-report.md`를 작성하고 [Owner] 대면 보고를 준비한다.

**전제조건**
- task-card.md, handoff.md, reviewer-raw.md 또는 judge-raw.md, plan-review.md 전부 존재
- SUB-5 진입 승인 완료

**테스트 입력**
- 스킬 호출 + run_id

**기대 동작**
1. `.harness/templates/final-report-template.md` 기반으로 final-report.md 생성
2. 섹션 §1~§12 전부 포함 (회고 §12 포함)
3. 입력 소스(task-card/handoff/gate-review/plan-review)별 내용이 해당 섹션에 정확히 매핑
4. [Owner] 발화 원문이 §1에 수록됨

**실패 신호**
- 섹션 누락 (특히 §12 회고)
- 입력 소스 혼합 오류 (예: gate-review 내용이 §2 변경 요약에 삽입)
- final-report.md를 [Builder]가 작성 (작성 주체는 [Foreman])

**증거 파일**
- `g2-08-write-final-report-evidence.md`: final-report.md 경로·섹션 목록, 입력 소스 매핑 확인

---

### 4.9 `09-update-project-md`

**목적**: task-card §10의 PROJECT.md 갱신 내용을 `PROJECT.md §C/§D`에 반영하고, [Owner] 승인 경계가 준수되었는지 확인한다.

**전제조건**
- task-card §10 완성 (SUB-5 [Foreman] 작성 완료)
- [Owner] 명시 승인 확보
- PROJECT.md 최신 상태

**테스트 입력**
- 스킬 호출 + task-card §10 내용 + PROJECT.md 현재 내용

**기대 동작**
1. PROJECT.md 갱신 diff 생성 (§C.N 모듈 상태·다음 마일스톤, §D 결정 이력)
2. [Owner] 승인 없이 PROJECT.md 직접 수정 금지
3. 승인 후에만 `git add PROJECT.md && git commit`

**실패 신호**
- [Owner] 승인 없이 PROJECT.md 수정
- task-card §10 내용이 PROJECT.md에 잘못된 섹션에 삽입
- §E.마지막 갱신 task run ID가 갱신되지 않음
- [Builder]가 직접 PROJECT.md 수정 ([Foreman] 역할 침범)

**증거 파일**
- `g2-09-update-project-md-evidence.md`: [Owner] 승인 발화 원문, PROJECT.md diff (`git diff PROJECT.md`), §E 갱신 확인

---

## 5. G-2 실행 순서 제안

### 5.1 실행 우선순위 근거

`01-load-sub-manual`이 최우선이다. 이 스킬이 제대로 동작하지 않으면 이후 모든 SUB 매뉴얼 로드가 수동으로 처리되어야 하며, 실제 검증 실행 자체의 신뢰도가 떨어진다. 의심 신호(scripts/load_sub.sh 미발견)가 이미 기록되어 있다.

### 5.2 실행 그룹 및 순서

| 그룹 | 스킬 | 의존 관계 | 실행 시점 |
|---|---|---|---|
| **그룹 0 (독립)** | `01-load-sub-manual` | 없음 | G-2 첫 번째 |
| **그룹 1 (SUB-1 생성)** | `02-create-task-card` | `01` 정상 동작 후 | G-2 두 번째 |
| **그룹 2 (SUB-2 파견·계획)** | `03-dispatch-to-builder`, `04-invoke-plan-review` | `02` 완료 후 (task-card 필요) | G-2 세 번째 |
| **그룹 3 (SUB-2 수신 검증)** | `05-verify-handoff` | Builder handoff.md 수신 후 | G-2 네 번째 |
| **그룹 4 (SUB-3 감리)** | `06-invoke-reviewer`, `07-invoke-judge` | `05` 완료 후 (handoff 검증 후) | G-2 다섯 번째 (병렬 가능) |
| **그룹 5 (SUB-5 종료)** | `08-write-final-report`, `09-update-project-md` | `06`+`07` 완료 후 | G-2 마지막 |

### 5.3 병렬 실행 가능 쌍

- `06-invoke-reviewer` + `07-invoke-judge`: 입력 파일이 분리되고 도구가 다름 → 병렬 실행 가능. 단 세션 분리 명시 필수.
- `08-write-final-report` + `09-update-project-md`: `08` 완료 후 `09` 진입 권고 (final-report 내용을 PROJECT.md에 연결).

---

## 6. 역할·정보 격리 설계

### 6.1 [Builder] (클로드코드)

- **입력**: task-card.md, entry-instruction.md
- **출력**: 구현·검증 결과, handoff.md
- **금지**: 기획 결정, Gate 통과 선언, final-report.md 직접 작성, push/merge

### 6.2 [Reviewer] (코덱스)

- **입력**: reviewer-input.md (코드 diff, 테스트 결과, handoff §2·§4)
- **금지 입력**: task-card §1 [Owner] 발화, judge-input.md 내용, 기획 의사결정 자료
- **출력**: reviewer-raw.md (기술적 정합성 판정만)
- **금지**: 기획·사업 판단, [Judge] 역할 수행

### 6.3 [Judge] (지피티)

- **입력**: judge-input.md (task-card §1~§4, handoff §8·§9, plan-review.md)
- **금지 입력**: 코드 diff, 함수 시그니처, reviewer-input.md 내용
- **출력**: judge-raw.md (사업·기획·논리 검토만)
- **금지**: 코드 디테일 검토, [Reviewer] 역할 수행

### 6.4 격리 강제 메커니즘

| 상황 | 격리 방법 |
|---|---|
| 정상 (코덱스 + 지피티) | 도구가 달라 물리적 격리 자동 강제 |
| 폴백 (지피티가 [Reviewer] 대행) | [Foreman]이 세션 분리 수동 강제. 세션명 "Reviewer_Fallback" 라벨링. 두 세션 동시 사용 금지. |
| G-2 검증 시 | 입력 파일을 `reviewer-input.md` / `judge-input.md`로 분리. [Foreman]이 교차 확인. |

---

## 7. 권한 천장 및 중단 조건

### 7.1 G-2에서도 유지되는 권한 천장

G-2 실제 검증 중에도 [Owner] 명시 승인 없이 [Builder]가 수행할 수 없는 행동:

| # | 금지 행동 |
|---|---|
| 1 | git push / merge / deploy |
| 2 | AGENTS.md, CLAUDE.md, PROJECT.md, `.harness/templates/*` 운영 문서 수정 |
| 3 | reset --hard, force push, history rewrite 등 파괴적 git 명령 |
| 4 | task-card §5.2 제외 범위 침범 |
| 5 | 외부 시스템 프로덕션 실호출 |
| 6 | Tier 자동 강등 |

### 7.2 즉각 중단 조건

G-2 진행 중 다음 상황 발생 시 [Builder]는 즉시 작업을 중단하고 [Foreman]에게 보고한다:

| 조건 | 중단 이유 |
|---|---|
| systematic-debugging Phase 4.5 발동 (3회 fix 실패) | architecture 의심 → [Foreman] 보고 |
| spec과 실제 구현 어긋남 발견 | spec 재검토 필요 |
| 권한 천장 위반 불가피 판단 | [Owner] 승인 절차 필요 |
| 마스킹 위반이 git history 진입 | [Owner] 명시 승인 후에만 history rewrite 가능 |
| fix-loop 6회 도달 (동일 문제) | 7회째 절대 금지, [Foreman] 보고 |

---

## 8. 증거 파일 명명 규칙

### 8.1 G-2 증거 파일 위치

모든 G-2 증거 파일은 해당 run의 `.harness/runs/<g2_run_id>/` 아래에 저장한다.

### 8.2 증거 파일 명명 규칙

| 유형 | 파일명 패턴 | 예시 |
|---|---|---|
| 스킬별 검증 증거 | `g2-<skill-id>-evidence.md` | `g2-01-load-sub-manual-evidence.md` |
| Reviewer 입력 | `reviewer-input.md` | — |
| Reviewer 원본 출력 | `reviewer-raw.md` | — |
| Codex 실행 로그 | `codex-exec.log` | — |
| Judge 입력 | `judge-input.md` | — |
| Judge 원본 출력 | `judge-raw.md` | — |
| Plan-review 입력 | `plan-review-input.md` | — |
| Plan-review 결과 | `plan-review.md` | — |
| Gate-review 종합 | `gate-review.md` | — |

### 8.3 증거 파일 내용 원칙

- **민감정보 마스킹 적용** (AGENTS.md §8 기준)
- **실행 일시·명령·출력 원문 포함** (요약만으로 대체 불가)
- **검증 통과/실패 판정 명시** (silent success 금지)

---

## 9. G-2 회고 입력 후보

G-2 완료 후 SUB-5 §12 회고에 반드시 포함할 항목이다.

| # | 항목 | 배경 |
|---|---|---|
| 1 | `01-load-sub-manual` scripts/load_sub.sh 존재 여부 최종 확인 결과 | G-1에서 의심 신호 기록됨 |
| 2 | G-1에서 SUB-3 외부 감리 생략 타당성 (설계 단계에서는 불필요했는가) | [Owner] 명시 지시에 따라 생략 |
| 3 | 9개 스킬 중 G-2에서 실제 결함 발견된 스킬 목록 및 수정 범위 | r7 개정 입력 |
| 4 | Reviewer·Judge 정보 격리가 실제 운영에서 유지됐는가 | 폴백 발생 여부 포함 |
| 5 | [Foreman]이 스킬 없이 수동으로 처리한 단계 목록 | scripts/ 미작성 구간 파악 |
| 6 | G-2 실행 중 fix-loop 발동 횟수 및 architecture 의심 발생 여부 | 안정성 지표 |

---

## 10. 자체 검토 결과

### 10.1 플레이스홀더 점검

- TBD·TODO·미완성 섹션 없음.
- "상세 추후 작성" 등 보류 표현 없음.

### 10.2 내부 일관성 점검

- §1 스킬 목록(9개)과 §4 매트릭스 소제목(4.1~4.9) 수 일치.
- `01-load-sub-manual` 의심 신호가 §1.1, §4.1, §5.1, §9에 모두 일관되게 기록됨.
- §2 G-1/G-2 경계와 entry instruction §2 Scope 일치.
- §3 공통 원칙이 §6 역할 격리 및 §7 권한 천장과 중복 없이 보완.
- §5.2 실행 그룹이 두별 워크플로우 5단계(SUB-1~5)와 논리적으로 매핑됨.

### 10.3 범위 점검

- 9개 스킬 전부 §1 테이블과 §4 소제목에 각 1회씩 등장.
- `scripts/load_sub.sh` 미발견 사실이 설계서에 명시됨.
- G-2 우선 검증 표현("G-2 우선")이 §1·§4.1·§5.1에 포함됨.
- silkroadhub 경로에 대한 산출물 없음.
- commit/push/merge 수행 없음.
- 운영 문서(AGENTS.md·PROJECT.md·SUB-1~5) 수정 없음.

### 10.4 모호성 점검

- "G-2 우선 검증" 의미: G-2 실행 순서에서 가장 먼저 검증한다는 의미로 §5.1에 명시.
- "코드 영역 한정" 의미: [Reviewer] 입력에서 기획·사업 내용 제외를 §4.6·§6.2에 명시.
- "[Foreman]이 직접 검증": §4.5에서 git log·status 명령 포함.

---

**설계서 끝.**
