# gate-review: G-2 9개 Manus Agent Skills 실제 동작 검증

**run ID**: 20260518_g2-skills-verification-execution  
**작성일시**: 2026-05-17 KST  
**작성자**: [Foreman]  
**대응 task-card**: `.harness/runs/20260518_g2-skills-verification-execution/task-card.md`  
**대응 handoff**: `.harness/runs/20260518_g2-skills-verification-execution/handoff.md`  
**Tier**: A  
**두별 워크트리 카테고리**: 4 (문서·운영)

---

## 0. 정보 격리 원칙 (재확인)

본 gate-review는 [Reviewer]와 [Judge]를 **별도 세션·다른 정보로** 호출한 결과를 종합한다.

| 역할 | 입력으로 받음 | 입력으로 받지 않음 |
|---|---|---|
| [Reviewer] | 스킬 `SKILL.md`, 스킬별 `scripts/`, G-2 evidence, handoff/verification의 기술 결과 | [Owner] 의도 배경, PROJECT.md, 사업·우선순위 판단 |
| [Judge] | task-card §1·§3 의도, handoff §1 산출물 요약, PROJECT.md §C 연결 모듈, Reviewer 판정 요약 | 코드 diff, 스크립트 본문, 명령어 상세, 파일 라인 단위 기술 판정 |

같은 지피티 계열을 사용하더라도 Reviewer 폴백과 Judge는 입력 파일·세션 역할을 분리했다. Codex는 [Judge] 역할을 수행하지 않았고, Reviewer 폴백은 사업 판단을 하지 않았다.

---

## 1. [Reviewer] 섹션 — 기술적 정합성

### 1.1 호출 정보

| 항목 | 내용 |
|---|---|
| 호출 일시 | 2026-05-17 KST |
| 도구·세션 | 지피티 [Reviewer] 폴백. Codex는 지역·네트워크 문제로 유효 응답 생성 실패 |
| 모델·세팅 | `gpt-5.5`, temperature 파라미터 생략, `max_completion_tokens` 사용 |
| 입력 파일 | `reviewer-input.md`, `reviewer-fallback-packaged-input.md` |
| 원문 저장 | `reviewer-raw.md` |
| 실행 위치 | `/Users/twostars/ClaudeAi/dubyeol-workflow` 로컬 |
| `silkroadhub` 사용 범위 | `scripts/load_openai_key.sh` 키 로드 파일의 복사 출처로만 사용. 호출 입력·출력·산출물 저장은 모두 `dubyeol-workflow` run 폴더 기준 |
| 민감값 처리 | 키 값은 출력하지 않고 존재 여부만 확인 |

Codex 시도 이력은 `codex-call-correction.md`와 `reviewer-fallback-decision.md`에 남겼다. 첫 `codex exec` 직접 실행은 [Owner] 정정에 따라 절차 오류로 중단했고, 이후 Codex REPL 선진입 방식을 시도했으나 `stream disconnected before completion`, `Connection reset by peer`, `Reconnecting...` 오류가 반복되어 [Owner] 승인으로 지피티 Reviewer 폴백을 사용했다.

### 1.2 [Reviewer] 판정

| 항목 | 판정 |
|---|---|
| 종합 판정 | HOLD |
| 경계 준수 | 코드·기술 범위만 검토, 사업·Judge 역할 회피, 코드 직접 수정 없음 |
| 핵심 사유 | 9개 스킬 모두 증거와 스크립트는 존재하나, 전체 스크립트가 `REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"`를 하드코딩하여 `dubyeol-workflow` 마스터 독립 실행 기준으로는 차단성 결함이 있음 |

### 1.3 기술 리스크 지적

| 영역 | 지적 내용 | 심각도 | 구체 근거 |
|---|---|---|---|
| 경로·아키텍처 | 9개 스킬 workflow가 `dubyeol-workflow`에서 독립 실행되지 않는다. | Critical | 모든 검토 대상 script가 `silkroadhub` `REPO_ROOT`를 하드코딩한다고 Reviewer가 확인 |
| wrong-repo write | task-card, handoff, plan-review, reviewer, judge, final-report, PROJECT.md 갱신 출력이 `silkroadhub`로 향할 수 있다. | Critical | Reviewer raw §2 finding 2 |
| 호출 경로 | SKILL.md 예시는 root `scripts/<script>.sh` 형태인데 실제 script는 skill-local `scripts/`에 있다. | High | Reviewer raw §2 finding 3 |
| interpreter 불일치 | scripts는 `#!/bin/zsh`인데 SKILL.md 예시는 `bash` 호출이다. | High | Reviewer raw §2 finding 4 |
| 입력 격리 구현 | 04·06·07 scripts는 isolated input file을 생성하지 않고 기존 파일 존재만 확인한다. | High | Reviewer raw §2 finding 7 |
| 외부 호출 안전성 | 04·06·07은 shell-expanded heredoc 안에 Python triple-quoted prompt를 삽입해 malformed input에 취약하다. | High | Reviewer raw §4 missed risk |
| PROJECT.md 갱신 | 09 script는 승인 전 PROJECT.md를 append하고 §C/§D/§E 자동 배치를 실제 구현하지 않는다. | High | Reviewer raw §2 findings 10~11 |
| 검증 수준 | Builder evidence는 PARTIAL PASS에는 충분하지만 end-to-end executable correctness를 입증하지 않는다. | Medium | Reviewer raw §2 finding 12 |

### 1.4 개선 제안

| 제안 | 우선순위 | 범위 |
|---|---|---|
| `silkroadhub` `REPO_ROOT` 하드코딩 제거 또는 명시적 safe root 인자/환경변수화 | P0 | 10개 scripts 전체 |
| SKILL.md 호출 경로와 실제 script layout 정렬 | P0 | 9개 SKILL.md 및 script layout |
| zsh/bash 실행 지침 통일 | P0 | 9개 SKILL.md 및 scripts |
| `run_id` 검증과 output path confinement 추가 | P0 | `.harness/runs`, `tmp` 쓰기 scripts |
| input isolation 생성·검증을 script가 강제하거나 manual prerequisite로 명확화 | P1 | 04·06·07 |
| Python heredoc prompt embedding을 JSON/file 기반 입력으로 교체 | P1 | 04·06·07 |
| `.harness/templates/*` 실제 사용 또는 템플릿 의존 claim 제거 | P1 | 02·08 |
| 09를 diff-first·approval-first 방식으로 전환 | P0 | 09 |
| verify-handoff의 push/destructive/uncommitted secret scan 강화 | P1 | 05 |
| path/interpreter 수정 후 안전 dummy end-to-end 재검증 | P0 | 9개 스킬 전체 |

### 1.5 [Reviewer] 권한 천장 점검

- [x] 코드 직접 수정하지 않음. Reviewer는 지적·제안만 수행했다.
- [x] Tier 분류 시도 안 함. Reviewer는 기술 HOLD만 판정했다.
- [x] 사업적 판단 안 함. Reviewer boundary check에서 `Business/Judge role avoided: yes`를 명시했다.

---

## 2. [Judge] 섹션 — 사업적·논리적 정합성

### 2.1 호출 정보

| 항목 | 내용 |
|---|---|
| 호출 일시 | 2026-05-17 KST |
| 도구·세션 | 지피티 [Judge] 별도 세션. Reviewer 폴백과 다른 입력 파일 및 다른 역할로 호출 |
| 모델·세팅 | `gpt-5.5`, temperature 파라미터 생략, `max_completion_tokens` 사용 |
| 입력 파일 | `judge-input.md` |
| 원문 저장 | `judge-raw.md` |
| 입력 금지 자료 | 코드 diff, 스크립트 본문, 파일 라인 단위 기술 판정, 명령어 상세 |

### 2.2 [Judge] 판정

| 항목 | 판정 |
|---|---|
| 의도 정렬 판정 | 완전 정렬 |
| 종합 판정 | 수정 |
| 핵심 근거 | G-2 검증 활동 자체는 [Owner] 의도와 정렬되지만, PASS 0·PARTIAL PASS 9·Reviewer HOLD 상태이므로 SUB-5 종료가 아니라 수정 분기 판단이 필요함 |

Judge는 “검증 완료”와 “스킬 운영 가능 상태”를 분리해야 한다고 지적했다. 현재 상태에서 SUB-5 종료로 가면 Reviewer HOLD를 무시한 closure가 되므로, SUB-4 수정 또는 별도 수정 task 분리 결재가 필요하다는 판정이다.

### 2.3 Devil's Advocate 질문

| 반대 논리·놓친 리스크 | 영향 | 확인 질문 |
|---|---|---|
| PARTIAL PASS 9를 “대체로 동작함”으로 해석하면 위험하다. | 후속 task가 실제 운영 가능 상태로 오인할 수 있음 | PARTIAL PASS를 “증거는 있으나 수정 필요”로 명확히 구분했는가? |
| Reviewer HOLD를 무시하고 종료하면 Tier A 외부 감리 절차의 의미가 약화된다. | 후속 감사에서 의사결정 근거 취약 | HOLD 상태를 닫기 위한 명시적 Owner waiver가 있는가? |
| 9개 스킬이 같은 hardcoded root 문제를 공유하면 개별 스킬 문제가 아니라 운영 인프라 문제다. | 일부 수정 시 동일 결함 재발 | 공통 root/path 정책을 먼저 정한 뒤 일괄 적용할 것인가? |
| run 오염 없음은 현재 테스트 조건에서만 안전했다는 뜻일 수 있다. | 다른 run_id·환경에서 wrong-repo write 가능 | root path와 output confinement가 스크립트 수준에서 강제되는가? |

### 2.4 비즈니스 사이드이펙트 지적

| 영향 | 심각도 | 근거 |
|---|---|---|
| 마스터 저장소 독립 운영 불가 | 높음 | 9개 스킬 모두 마스터 독립 실행 기준에서 부분 통과에 그쳤고, Reviewer가 wrong-repo write 위험을 HOLD 사유로 판단했다. |
| `silkroadhub` 오염 또는 잘못된 저장소 쓰기 위험 | 높음 | [Owner]는 `silkroadhub`를 손대지 말라고 명시했다. 현재 run 오염은 없었지만 공통 하드코딩 문제가 남아 있으면 후속 실운영에서 위험이 유지된다. |
| r7 또는 후속 task의 신뢰도 저하 | 높음 | 9개 전부 PARTIAL PASS인 상태에서 종료하면 후속 단계가 “검증된 스킬”을 전제로 진행할 수 있다. |
| 외부 감리 대응 취약 | 중간~높음 | Reviewer 판정이 HOLD인데 closure하면 감리 지적을 수용하지 않은 종료가 된다. |
| 권한·승인 경계 혼선 | 중간 | 수정으로 들어갈 경우 SUB-4 범위와 승인선을 명확히 해야 한다. |
| 부분 수정에 따른 일관성 붕괴 | 중간~높음 | 공통 경로 문제를 일부만 고치면 운영 표준 혼란이 증가한다. |

### 2.5 의도 ↔ 결과 정렬 점검

| task-card §3 의도 요소 | 산출물 정렬 정도 | 의문 |
|---|---|---|
| 한 문장 목표 (What) | 완전 | 9개 실제 검증과 evidence·handoff·감리 결과 생성까지 진행 중이다. |
| Looks Like 핵심 | 부분~완전 | SUB-2 산출물과 외부 감리는 완료되었으나, 결과가 전부 PARTIAL PASS라 종료가 아니라 수정 분기가 필요하다. |
| Looks Wrong 방어 | 부분 | 검증 누락·증거 없는 선언·silkroadhub run 오염·commit/push 위반은 방어되었다. 다만 스크립트 자체의 wrong-repo write 위험은 결함으로 남았다. |

### 2.6 [Judge] 권한 천장 점검

- [x] 코드 디테일 판정 시도 안 함. Judge는 Reviewer 요약과 운영 리스크만 기반으로 판단했다.
- [x] [Reviewer]와 동일 인스턴스 겸임 안 함. Reviewer 폴백과 별도 입력·별도 호출로 진행했다.
- [x] 모델·세팅 변경 없음. `gpt-5.5`를 사용했고 temperature 파라미터를 생략했다.

---

## 3. 충돌 해결

### 3.1 충돌 발생 여부

- **충돌 있음**: ☐
- **충돌 없음**: ☑

### 3.2 충돌 유형

해당 없음. Reviewer는 기술 HOLD, Judge는 운영 판단상 수정 필요를 제시했다. 두 판정은 모두 종료 직행 반대 방향이며 충돌하지 않는다.

### 3.3 충돌 처리

충돌 없음. 다만 SUB-4를 G-2 안에서 진행할지, 별도 후속 수정 task로 분리할지는 [Owner] 결재가 필요하다.

---

## 4. 종합 게이트 결정

### 4.1 최종 게이트 상태

- ☐ **통과** — SUB-5 (종료) 진입
- ☑ **수정 필요** — SUB-4 (수정) 진입 또는 별도 수정 task 결재 필요
- ☐ **보류** — [Owner] 추가 결정 대기
- ☐ **중단** — task 폐기 검토

### 4.2 결정 근거

G-2 검증 실행 자체는 [Owner] 의도와 정렬되어 9개 스킬 전부 evidence를 남겼고 권한 천장도 지켰다. 그러나 Reviewer는 기술 HOLD를, Judge는 수정 판정을 냈으며, 9개 스킬 전부 PARTIAL PASS 상태로 `silkroadhub` hardcoded root라는 공통 결함이 남아 있다. 따라서 SUB-5 종료로 직행하지 않고, [Owner]에게 G-2 내 SUB-4 수정 진입 또는 별도 수정 task 분리를 결재받아야 한다.

### 4.3 [Owner] 에스컬레이션 필요 사항

| 선택지 | 의미 | 권고 |
|---|---|---|
| G-2 내 SUB-4 진입 | 본 run 안에서 9개 스킬 공통 결함을 수정하고 재검증 | 조건부 권고 |
| 별도 수정 task 분리 | G-2는 “수정 필요” 상태로 정리하고 별도 task-card로 공통 root/path 정책 및 스킬 수정 진입 | 조건부 권고 |
| Owner waiver 후 종료 | Reviewer HOLD·Judge 수정 판정을 risk 인수로 명시하고 SUB-5 종료 | 비권고 |

---

## 5. 도구 불가 시 처리

| 항목 | 내용 |
|---|---|
| 불가 발생 도구 | Codex [Reviewer] |
| 불가 사유 | 중국/지역 네트워크 환경으로 추정되는 backend 연결 불안정. `stream disconnected before completion`, `Connection reset by peer`, `Reconnecting...` 반복 |
| 시도 횟수 | `codex exec` 직접 실행 1회(절차 오류로 중단), Codex REPL 선진입 후 지시 전달 2회(연결 실패) |
| [Owner] risk 인수·폴백 승인 | “중국에 있어서 어렵나봐, 코덱스말고 지피티로 이어해” |
| 제한 진행 결정 | 지피티 Reviewer 폴백으로 진행. Judge는 별도 지피티 세션·별도 입력으로 진행 완료 |

Tier 강등은 수행하지 않았다. 본 task는 계속 Tier A다.

---

## 6. 권고 추가 작업 (수정 단계로 넘길 항목)

| 권고 | 분류 | 비고 |
|---|---|---|
| 공통 root/path 정책 확정 후 9개 스크립트의 `REPO_ROOT` 하드코딩 제거 | SUB-4 또는 별도 Tier A/B 수정 task | P0 |
| SKILL.md 호출 예시와 실제 script layout 정렬 | SUB-4 또는 r7 정비 | P0 |
| zsh/bash 실행 지침 통일 | SUB-4 또는 r7 정비 | P0 |
| run_id validation 및 output path confinement 추가 | SUB-4 권고 | P0 |
| 04·06·07의 input isolation과 Python heredoc 안전성 개선 | SUB-4 권고 | P1 |
| 02·08 템플릿 연동 방식 정리 | r7 정비 또는 SUB-4 | P1 |
| 09-update-project-md를 diff-first·approval-first 방식으로 전환 | SUB-4 권고 | P0 |
| 05 verify-handoff의 push/destructive/uncommitted secret scan 강화 | SUB-4 또는 r7 정비 | P1 |
| Codex 지역 네트워크 실패와 GPT Reviewer 폴백 절차 문서화 | r7 회고 | 운영 절차 |
| GPT Reviewer 폴백이 `dubyeol-workflow` 로컬에서 실행되고 `silkroadhub`는 키 로드 파일 출처로만 사용되었다는 사실 기록 | final-report 회고 | [Owner] 요청 반영 |

---

## 7. SUB-3 종료 시 [Foreman] 다음 행동

[Owner]에게 감리 결과를 보고하고 다음 중 하나를 명시 결재받아야 한다.

| 선택지 | 의미 |
|---|---|
| G-2 내 SUB-4 진입 | 본 run 안에서 9개 스킬 공통 결함을 수정하고 재검증한다. |
| 별도 수정 task 분리 | G-2는 “수정 필요” 상태로 정리하고, 별도 task-card로 공통 root/path 정책 및 스킬 수정에 진입한다. |
| Owner waiver 후 종료 | Reviewer HOLD·Judge 수정 판정을 risk 인수로 명시하고 SUB-5로 종료한다. 비권고. |

---

**gate-review 끝.**
