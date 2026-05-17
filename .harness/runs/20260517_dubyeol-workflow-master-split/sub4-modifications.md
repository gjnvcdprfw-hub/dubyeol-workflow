# sub4-modifications: Phase H — gate-review 수정·검증 결과

**run ID**: `20260517_dubyeol-workflow-master-split`  
**작성일시**: 2026-05-17 KST  
**작성자**: [Foreman] Manus  
**상태**: SUB-4 수정·검증 완료  
**수정 범위**: gate-review §4.3의 6개 항목에 한정. 새 기능 구현, push, merge, history rewrite는 수행하지 않음.

---

## 1. SUB-4 진단

SUB-3 gate-review는 Phase H의 큰 방향이 [Owner] 의도와 일치한다고 보았지만, 완료 선언 전 검증·문서화가 필요한 항목을 남겼다. SUB-4 진단상 본 건은 **의도 정렬 실패(A)**나 **구현 어긋남(B)**이 아니라, 감리에서 요구한 검증 증거와 후속 처리 계획을 보강하는 **절차 누락·검증 보강(C)** 성격이다.

| 진단 항목 | 판정 | 근거 |
|---|---|---|
| 새어 들어간 단계 | 혼합이 아닌 절차 보강 | 산출 방향은 맞으나 remote HEAD·dangling reference·오염 확인이 gate 통과 전 요구됨 |
| 회복 옵션 | SUB-4 §5.C 성격 | 누락된 검증·문서화를 복구하고 증거 파일을 남김 |
| fix-loop 카운트 | 1회 | 본 SUB-4에서 검증·문서화 1회 수행 |
| 의도 변경 | 없음 | [Owner] 의도 변경이 아니라 gate-review 수정 요구 처리 |
| 권한 위반 | 없음 | push, merge, force push, history rewrite, broad cleanup 미수행 |

---

## 2. gate-review §4.3 항목별 처리 결과

| 번호 | 항목 | 처리 결과 | 증거 파일 |
|---:|---|---|---|
| 1 | `dubyeol-workflow` remote existing HEAD 확인 | 완료 | `sub4-remote-head-check.md` |
| 2 | `silkroadhub` dangling reference 확인 | 완료 | `sub4-silkroadhub-reference-check.md`, `sub4-dangling-reference-active-docs.txt` |
| 3 | business code 보존 확인 | 완료 | `sub4-silkroadhub-reference-check.md` |
| 4 | target repo 오염 확인 | 완료, `.gitignore` 신설 | `sub4-dubyeol-contamination-check.md`, `sub4-dubyeol-secret-suspect-files.txt` |
| 5 | legacy residue 처리 계획 문서화 | 완료 | `sub4-legacy-and-phasec-plan.md` |
| 6 | `test_claude_dispatch` Phase C 명칭 보정 판단 | 완료, 즉시 본문 수정 없이 후속 보정 계획 기록 | `sub4-legacy-and-phasec-plan.md` |

---

## 3. remote existing HEAD 확인 및 initial commit/push 전략

`dubyeol-workflow`는 local branch가 `main`이고 아직 모든 workflow 파일이 untracked 상태다. remote는 이미 `origin/main`과 `origin/HEAD`를 가지고 있으며, `git ls-remote --symref origin HEAD` 결과는 `refs/heads/main`을 가리킨다. `git fetch origin` 결과 원격 `main`이 fetch 되었고, `git log --oneline --decorate --graph --all --max-count=20`에는 다음 원격 이력이 확인되었다.

```text
* d555e9f (origin/main, origin/HEAD) Initial: 두별 워크플로우 v3.6.0 r1 베타 — Manus Agent Skills 9개
```

따라서 local no-commit `main`에서 별도 root initial commit을 만든 뒤 push하는 방식은 **unrelated history** 또는 **non-fast-forward** 위험이 있다. 안전한 전략은 `origin/main`을 기준으로 작업 브랜치를 만들거나, local `main`을 원격 `main` 기반으로 정렬한 다음 그 위에 import commit을 쌓는 것이다. force push 또는 history rewrite는 금지된다.

| 전략 | 판정 | 이유 |
|---|---|---|
| local no-commit main에서 root commit 후 push | 금지 | 원격 main에 이미 `d555e9f` 이력이 있어 unrelated history 위험 |
| `git switch -c workflow-import origin/main` 후 import commit | 권고 | 원격 이력을 보존하고 import를 후속 commit으로 쌓음 |
| local main을 origin/main 기반으로 정렬 후 import commit | 가능 | Owner 승인 후 수행 가능, 단 현재 untracked 파일 보존·충돌 처리 필요 |
| force push/history rewrite | 금지 | task-card §8 및 Owner 지시 위반 |

---

## 4. silkroadhub dangling reference 및 business code 보존 확인

`backend/`와 `frontend/`에 대한 `git status --short backend frontend` 및 `git diff --stat -- backend frontend` 결과는 비어 있었다. 즉 Phase H cleanup은 silkroadhub business code를 변경하지 않았다.

루트 workflow 원본의 존재 여부는 다음과 같이 확인되었다.

| 항목 | 결과 |
|---|---|
| `AGENTS.md` | 없음 |
| `SUB-*.md` | 없음 |
| `r6-rollout-package` | 없음 |
| `backend/`, `frontend/` 변경 | 없음 |

처음 전체 저장소 대상으로 grep을 수행했을 때 `.harness/runs` 및 `tmp`의 대량 과거 산출물을 모두 스캔하면서 과도한 원시 출력 파일이 생성되었다. 해당 과도한 grep 프로세스는 중단했고, 대용량 원시 파일은 제거했다. 이후 검사 범위를 Phase H 이후 client에 남는 활성 운영 문서(`PROJECT.md`, `CLAUDE.md`, `.harness/templates`, `.harness/manus-prompts`, `.harness/proposals`)로 제한해 재수행했다.

제한 grep 결과에서 `PROJECT.md`의 `dubyeol-workflow` 참조는 의도된 새 master 참조다. `.harness/proposals` 내부의 `AGENTS.md`, `CLAUDE.md`, 구 v3.5 문서 참조는 과거 승인 제안 초안의 잔존으로 판단되며, 현재 실행 기준 문서가 아니므로 **client-local legacy residue**로 분류한다. 현재 지침처럼 제거된 root workflow 파일을 계속 사용하라는 활성 참조는 확인되지 않았다.

---

## 5. dubyeol-workflow target repo 오염 확인 및 `.gitignore` 보정

신규 `dubyeol-workflow`에는 `.gitignore`가 없었으므로, 신규 repo 추적 안정화를 위해 `.gitignore`를 신설했다. 이는 코드 구현이 아니라 신규 repository 운영 안정성 보정이다.

```gitignore
.DS_Store
*.log
*.tmp
.env
.env.*
!.env.example
node_modules/
dist/
build/
coverage/
```

오염 확인 결과는 다음과 같다.

| 항목 | 결과 | 해석 |
|---|---|---|
| secret suspect file path scan | 15개 파일 경로 감지 | 값은 출력하지 않았고, 대부분 `TOKEN`, `API_KEY` 같은 단어가 문서·스크립트에 등장한 경로다. 실제 비밀값 여부는 commit 전 추가 spot-check 권고 |
| nested `.git` | `./.git`만 확인 | 중첩 git repository 없음 |
| 대용량 파일 > 10M | 없음 | 대용량 불필요 파일 없음 |
| `.harness/runs` ignore 여부 | ignore되지 않음 | run evidence는 추적 대상이어야 하므로 정상 |
| `.harness/templates` ignore 여부 | ignore되지 않음 | template은 추적 대상이어야 하므로 정상 |

Secret scan은 민감값 노출 방지를 위해 파일 경로만 기록했다. `sub4-dubyeol-secret-suspect-files.txt`의 경로들은 commit 전 사람이 한 번 더 확인해야 하지만, 현재 SUB-4 범위에서는 값을 출력하거나 파일 내용을 수정하지 않았다.

---

## 6. legacy residue 처리 계획

`silkroadhub/.harness/backups`와 `silkroadhub/.harness/manuals`는 존재하지 않았다. `silkroadhub/.harness/proposals`는 존재하며 과거 v3.5 운영 제안 초안이 다수 남아 있다. 해당 디렉터리는 현재 Phase H 범위에서 삭제하지 않는다.

| residue | 분류 | Phase H 처리 | 후속 계획 |
|---|---|---|---|
| `.harness/proposals` | client-local legacy residue | 삭제하지 않음 | r7 정비 또는 별도 cleanup task에서 master 이전/보존/삭제 기준 판단 |
| `.harness/backups` | 없음 | 해당 없음 | 없음 |
| `.harness/manuals` | 없음 | 해당 없음 | 없음 |
| 과거 proposal 내 `AGENTS.md` 참조 | legacy proposal 문맥 | 현재 지침으로 보지 않음 | r7 정비 시 archive 또는 master migration 후보 |

이 판단의 핵심은 proposals가 승인 전 초안 보관소이며, 현재 운영 기준 문서가 아니라는 점이다. 단, 장기적으로는 client repository에 오래된 운영 초안이 남아 있으면 master/client 분리 원칙을 흐릴 수 있으므로 후속 task로 정리하는 것이 바람직하다.

---

## 7. `test_claude_dispatch` Phase C 명칭 판단

`test_claude_dispatch`는 공식 “Phase C” task-card가 있는 run은 아니다. 그러나 `dispatch-comparison-report.md`는 Claude Code 지시 전달 방식 A/B 비교 검증을 수행했고, 파일 경유 짧은 명령 + 2단계 확정 실행 방식이 r6 표준 절차로 채택되는 근거를 제공한다. 따라서 두별 워크플로우 운영 자료로 `dubyeol-workflow`에 이전한 판단은 유지한다.

다만 `dubyeol-workflow/PROJECT.md`에 이를 “Phase C”로 단정 표기하면 provenance와 purpose가 혼동될 수 있다. 이번 SUB-4에서는 즉시 `PROJECT.md` 본문을 수정하지 않고, SUB-5 회고와 r7 정비 후보에 **“Phase C 후보/dispatch 검증 run” 명칭 보정**을 명시한다. 즉, 이전 판단은 유지하되 명칭 정합성은 후속 문서 정비 항목으로 넘긴다.

| 선택지 | 판단 | 사유 |
|---|---|---|
| `test_claude_dispatch` 이전 취소 | 비권고 | dispatch 표준 절차 수립 근거이므로 workflow master 자료가 맞음 |
| `PROJECT.md` 즉시 수정 | 보류 | 현재 SUB-4 범위는 검증·문서화 중심이며, 명칭 정비는 r7에서 더 넓게 반영하는 것이 안전 |
| SUB-5/r7 회고로 명칭 보정 | 채택 | “Phase C 후보/dispatch 검증 run”으로 한계를 기록해 혼선 완화 |

---

## 8. SUB-4 후 재검증 판단

SUB-4는 새 기능 구현이 아니라 감리 지적 6건에 대한 검증·문서화·경미한 `.gitignore` 보정이다. Reviewer와 Judge가 요구한 핵심 차단 항목은 검증 결과로 닫혔거나 후속 계획으로 명시되었다. 다만 `.gitignore` 신설과 remote commit 전략은 실제 commit/push 전 다시 확인되어야 한다.

| 재검증 항목 | 결과 |
|---|---|
| task-card §3 Looks Like 충족 | 유지됨 |
| task-card §3 Looks Wrong 방어 | 강화됨 |
| 권한 천장 | 미위반 |
| 마스킹 | 값 출력 없이 파일 경로 중심으로 기록 |
| SUB-3 재감리 필요 여부 | 본 SUB-4가 검증·문서화 보강이므로 전체 재감리는 필수로 보지 않음. 단 Owner가 원하면 제한 재감리 가능 |

---

## 9. 남은 Owner 승인 필요 사항

본 SUB-4는 commit/push를 수행하지 않았다. 다음 단계에서 실제 저장소 정리를 commit하려면 Owner 승인과 전략 선택이 필요하다.

| 항목 | Owner 승인 필요성 | 이유 |
|---|---|---|
| `dubyeol-workflow` import commit | 필요 | origin/main 기존 이력 위에 import commit을 쌓아야 함 |
| `dubyeol-workflow` push | 필요 | 권한 천장 |
| `silkroadhub` cleanup commit | 필요 | 삭제·PROJECT.md 변경이 포함됨 |
| `.harness/proposals` cleanup | 별도 task-card 권고 | Phase H 범위 밖 legacy residue |

---

**SUB-4 결론**: gate-review §4.3의 6개 수정·검증 항목은 완료되었다. 다음은 [Owner] 판단에 따라 SUB-5 종료로 진행하거나, 원하면 제한 재감리를 수행할 수 있다.
