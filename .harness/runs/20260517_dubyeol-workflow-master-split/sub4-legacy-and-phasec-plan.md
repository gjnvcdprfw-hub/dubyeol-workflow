# SUB-4 legacy residue and test_claude_dispatch naming plan

## 1. silkroadhub .harness legacy dirs
```text
.harness
.harness/backlog
.harness/backups
.harness/backups/rollback-v350-20260514-005744
.harness/manuals
.harness/manus-prompts
.harness/proposals
.harness/runs
.harness/runs/20260513-1158-dry-run-docs-only
.harness/runs/20260513-1238-v350-dry-run
.harness/runs/20260513-1315-context-bridge
.harness/runs/20260513-1320-stale-context-sync
.harness/runs/20260513-1600-manifest-demo-edit-ready
.harness/runs/20260513-1730-doc-workbench-ai20-status
.harness/runs/20260514-0049-mcp-superpowers-smoke
.harness/runs/20260514-0100-forwarder-planning-brainstorm
.harness/runs/20260515-0000-forwarder-document-mvp-context
.harness/runs/20260515-0145-forwarder-document-mvp-dev
.harness/runs/20260515-0900-forwarder-document-mvp-gpt-revise-fix
.harness/runs/20260515-0935-document-retry-flaky-test-fix
.harness/runs/20260515-1005-forwarder-document-code-simplifier
.harness/runs/20260515-1020-start-local-backend-selection-fix
.harness/runs/20260515-1035-finalize-forwarder-document-mvp
.harness/runs/20260515-1110-forwarder-document-real-upload-fix
.harness/runs/20260515-1500-forwarder-document-workspace-persistence-followup
.harness/runs/20260515-2000-document-workspace-mbl-persistence
.harness/runs/20260515-2000-document-workspace-redesign
.harness/runs/20260515-2030-document-workspace-code-simplifier
.harness/runs/20260515-2100-document-workspace-classification
.harness/runs/20260516-document-parsing-orchestrator-transaction-review
.harness/runs/20260517_dubyeol-workflow-master-split
.harness/runs/gate2-cbm-event-scale
.harness/runs/gate2-container-matching
.harness/runs/gate2-fcl-lcl
.harness/runs/gate2-hard-delete
.harness/runs/gate2-logisview
.harness/runs/gate2-logisview-ui
.harness/runs/gate2-null-fix
.harness/runs/gate2-openai-decimal
.harness/runs/gate2-parser-scheduler
.harness/runs/gate2-parsing-status
.harness/runs/gate2-upload-fix
.harness/runs/manifest-container-defects-fix
.harness/runs/operations
.harness/runs/phase-1a
.harness/runs/phase-1b
.harness/runs/phase-1c
.harness/runs/phase-1d
.harness/runs/phase-1d-shipper
.harness/runs/phase-1d-shipper-fixturefix
.harness/runs/phase-1d-shipper-testfix
.harness/runs/phase-1e-clp
.harness/runs/phase-1e-delivery
.harness/runs/phase-1f-debt
.harness/runs/phase-1f-testfix
.harness/runs/phase-1f-ui
.harness/runs/phase-1g
.harness/runs/phase-1h
.harness/runs/phase-alpha-account-mapping
.harness/runs/phase-bl-parsing-baseline-regression
.harness/runs/phase-cargo-type-column-split
.harness/runs/phase-concurrency-hardening
.harness/runs/phase-domain-patch-audit
.harness/runs/phase-frontend-api-url-fix
.harness/runs/phase-hbl-patch-regression-fix
.harness/runs/phase-manifest-data-dictionary
.harness/runs/phase-manifest-full-edit-mode
.harness/runs/phase-manifest-hbl-tab-redesign
.harness/runs/phase-manifest-mapping-status
.harness/runs/phase-manifest-ui-polish-A
.harness/runs/phase-mbl-update-fix
.harness/runs/phase-model-upgrade
.harness/runs/phase-next-planning
.harness/runs/phase-port-lookup-db
.harness/runs/phase-v23-migration-conflict-fix
.harness/runs/phase-v23-migration-fix
.harness/templates
```

## 2. proposals file count
```text
      35
```

## 3. backups/manuals existence
```text
EXISTS .harness/backups
EXISTS .harness/manuals
EXISTS .harness/proposals
```

## 4. test_claude_dispatch evidence in dubyeol-workflow
```text
total 256
drwxr-xr-x@ 15 twostars  staff    480 May 17 10:38 [34m.[39;49m[0m
drwxr-xr-x@  6 twostars  staff    192 May 17 10:38 [34m..[39;49m[0m
-rw-r--r--@  1 twostars  staff  18374 May 17 10:38 AGENTS-before-appendix-ab-update.md
-rw-r--r--@  1 twostars  staff  20119 May 17 10:38 AGENTS-before-cowork-removal.md
-rw-r--r--@  1 twostars  staff   6744 May 17 10:38 agents-appendix-ab-update-only.diff
-rw-r--r--@  1 twostars  staff   4168 May 17 10:38 agents-cowork-removal-only.diff
-rw-r--r--@  1 twostars  staff  12523 May 17 10:38 agents-post-appendix-ab-diff.patch
-rw-r--r--@  1 twostars  staff   7981 May 17 10:38 agents-post-cowork-removal-diff.patch
-rw-r--r--@  1 twostars  staff   4667 May 17 10:38 agents-pre-existing-diff.patch
-rw-r--r--@  1 twostars  staff     45 May 17 10:38 appendix-a-do-script-check.txt
-rw-r--r--@  1 twostars  staff  15404 May 17 10:38 dispatch-comparison-report.md
-rw-r--r--@  1 twostars  staff   3668 May 17 10:38 final-report.md
-rw-r--r--@  1 twostars  staff   5441 May 17 10:38 handoff.md
-rw-r--r--@  1 twostars  staff    445 May 17 10:38 result-A.md
-rw-r--r--@  1 twostars  staff    399 May 17 10:38 result-B.md

# 클로드코드 지시 전달 방식 비교 검증 결과

**검증 일시**: 2026-05-16 18:01 KST  
**환경**: macOS 26.2, Claude Code 2.1.143  
**저장소**: `/Users/twostars/ClaudeAi/silkroadhub`  
**브랜치 / HEAD**: `feature/mbl-document-workspace-phase1` / `a7f1236`  
**검증 창 ID**: 방식 A `187`, 방식 B `234`, Appendix A 일반 zsh 스크립트 확인 `239`  
**적용 보정**: 대표님 승인에 따라 `activate`를 제외했고, Claude Code REPL 명령 확정에는 `do script "..."` 후 `do script ""`를 보내는 **2단계 확정 실행**을 양쪽 방식에 동일 적용했다.[^source-prompt]

## 1. 검증 목적과 판정 전제

본 검증의 목적은 마누스가 Claude Code 세션에 진입 명령을 전달할 때, **긴 텍스트 직접 입력 방식(A)**과 **파일 경유 후 짧은 명령 전달 방식(B)** 중 어느 쪽이 r6 운영 표준으로 더 안전하고 재현 가능한지를 확인하는 것이다. 검증 도중 발견된 `activate` 충돌과 단일 `do script`의 Enter 미확정 문제는 대표님 승인에 따라 별도 관찰 사항으로 보존하되, A/B 비교 자체에는 동일한 2단계 확정 실행 조건을 적용했다.

| 구분 | 방식 A | 방식 B |
|---|---|---|
| 검증 대상 | 긴 테스트 지시문을 `do script` 인자로 직접 전달 | 테스트 지시문을 `tmp/test-instruction-B.md`에 저장하고 짧은 명령으로 파일 읽기 지시 |
| 실행 보정 | `activate` 제외 + 2단계 확정 실행 | `activate` 제외 + 2단계 확정 실행 |
| 산출 파일 | `.harness/runs/test_claude_dispatch/result-A.md` | `.harness/runs/test_claude_dispatch/result-B.md` |
| 최종 응답 | `테스트 완료` 확인 | `테스트 완료` 확인 |

## 2. 비교 표

| 항목 | 방식 A: 직접 입력 | 방식 B: 파일 경유 |
|---|---|---|
| 명령 전송 성공 | 성공. 단, 단일 `do script`는 입력 대기 상태에 머물렀고 `do script ""` 추가 후 실행됨 | 성공. 짧은 명령 + `do script ""`로 실행됨 |
| 한글 보존 | 정확 | 정확 |
| 큰따옴표 보존 | 정확 | 정확 |
| 작은따옴표 보존 | 정확 | 정확 |
| 백슬래시 보존 | 정확 | 정확 |
| `$` 변수 보존 | 정확. `$PATH`가 셸 확장되지 않음 | 정확. `$PATH`가 셸 확장되지 않음 |
| 백틱 보존 | 정확. 백틱이 실행되지 않음 | 정확. 백틱이 실행되지 않음 |
| 줄바꿈 보존 | 정확. Claude Code 화면과 결과 파일에서 문단·항목 구조가 보존됨 | 정확. 파일 원문과 결과 파일에서 구조가 보존됨 |
| 들여쓰기 보존 | 정확. 입력 화면상 항목 들여쓰기와 결과 파일 항목 구조가 보존됨 | 정확. 파일 원문과 결과 파일 항목 구조가 보존됨 |
| 파일 생성 의무 수행 | 생성됨: `.harness/runs/test_claude_dispatch/result-A.md` | 생성됨: `.harness/runs/test_claude_dispatch/result-B.md` |
| `테스트 완료` 응답 | 받음 | 받음 |
| 명령 작성 부담 | 큼. AppleScript 문자열에서 큰따옴표, 백슬래시, 줄바꿈, 백틱, `$` 등을 모두 신경 써야 함 | 작음. 원문은 파일에 보존하고 Claude Code에는 짧은 영문 명령만 전달하면 됨 |
| 재현성 | 낮음. 긴 AppleScript 문자열 생성·escape 과정에서 실수 가능성이 큼 | 높음. 지시 원문 파일과 짧은 전달 명령이 분리되어 재실행·검토가 쉬움 |
| 진입 명령 전체 이력 보존 | 낮음. 실행 문자열이 터미널·스크립트 히스토리에 묻히기 쉬움 | 높음. `tmp/test-instruction-B.md`가 그대로 남아 회고와 재검증에 유리함 |

## 3. 방식 A 세부 평가

방식 A는 최종적으로 성공했다. `result-A.md`는 생성되었고 Claude Code는 `테스트 완료`를 응답했다. 결과 파일에는 첫 줄 인용, 한글, 큰따옴표, 작은따옴표, `$PATH`, 백틱, 백슬래시가 정확히 보존되었다. 다만 첫 시도에서 확인된 것처럼 단일 `do script "긴 지시문" in window id 187`만으로는 Claude Code REPL에서 입력이 프롬프트에 올라간 채 실행되지 않았고, 추가로 `do script ""`를 보내야 실행이 확정되었다.

| 평가 항목 | 방식 A 결과 | 근거 |
|---|---|---|
| 명령 전송 자체 | 조건부 성공 | 2단계 확정 실행 후 `result-A.md` 생성 |
| 한글 표시 | 정확 | `두별 워크플로우 v3.6.0 r1 베타` 보존 |
| 큰따옴표 표시 | 정확 | `"double"` 및 한글 문구의 큰따옴표 보존 |
| 작은따옴표 표시 | 정확 | `'single'` 보존 |
| 백슬래시 표시 | 정확 | `\backslash` 보존 |
| `$PATH` 표시 | 정확 | `$PATH`가 결과 파일에서 그대로 표시됨 |
| 백틱 표시 | 정확 | `` `backtick` ``이 실행되지 않고 그대로 표시됨 |
| 줄바꿈 보존 | 정확 | 지시문 항목 구조가 Claude Code 화면과 결과 파일에 보존됨 |
| 들여쓰기 보존 | 정확 | 항목 구조가 보존됨 |
| 파일 생성 | 생성됨 | `.harness/runs/test_claude_dispatch/result-A.md` |
| `테스트 완료` 응답 | 받음 | Claude Code 화면에서 `테스트 완료` 확인 |

## 4. 방식 B 세부 평가

방식 B도 성공했다. `tmp/test-instruction-B.md`에 원문 지시문을 저장한 뒤, `Read tmp/test-instruction-B.md and follow the instructions inside.`라는 짧은 명령을 Claude Code 창에 전달하고 `do script ""`로 실행을 확정했다. `result-B.md`는 생성되었고, 결과 파일은 테스트 기준의 한글·특수문자·줄바꿈·들여쓰기 항목을 정확히 보존했다.

| 평가 항목 | 방식 B 결과 | 근거 |
|---|---|---|
| 명령 전송 자체 | 성공 | 짧은 명령 + 2단계 확정 실행 후 `result-B.md` 생성 |
| 한글 표시 | 정확 | `두별 워크플로우 v3.6.0 r1 베타` 보존 |
| 큰따옴표 표시 | 정확 | `"double"` 및 한글 문구의 큰따옴표 보존 |
| 작은따옴표 표시 | 정확 | `'single'` 보존 |
| 백슬래시 표시 | 정확 | `\backslash` 보존 |
| `$PATH` 표시 | 정확 | `$PATH`가 결과 파일에서 그대로 표시됨 |
| 백틱 표시 | 정확 | `` `backtick` ``이 실행되지 않고 그대로 표시됨 |
| 줄바꿈 보존 | 정확 | 지시 파일과 결과 파일 모두 항목 구조 보존 |
| 들여쓰기 보존 | 정확 | 원문 파일의 들여쓰기와 항목 구조가 보존됨 |
| 파일 생성 | 생성됨 | `.harness/runs/test_claude_dispatch/result-B.md` |
| `테스트 완료` 응답 | 받음 | Claude Code 화면에서 `테스트 완료` 확인 |

## 5. 권고 방식

권고 방식은 **방식 B: 파일 경유 + 짧은 명령 + 2단계 확정 실행**이다. 방식 A도 2단계 확정 실행을 적용하면 동작했지만, 긴 한글 지시문과 특수문자를 AppleScript 문자열 안에 직접 넣는 순간 escape 부담이 커지고, 실제 첫 시도에서 문자열 생성 과정의 깨짐·혼입 위험이 관찰되었다. 반면 방식 B는 지시문 원문이 별도 파일로 남아 회고·재검증·diff 확인이 쉽고, Claude Code에 전달하는 명령은 짧은 ASCII 문장으로 제한할 수 있어 r6 운영 표준으로 더 안정적이다.

Devil’s Advocate 관점에서 보면, 방식 B도 파일 경로가 틀리거나 Claude Code가 파일을 읽지 못하면 실패할 수 있다. 그러나 이 리스크는 `cat`, `head`, `wc -l`, `ls -l`로 사전 검증 가능하며, 긴 문자열 escape 실패처럼 전송 과정에서 의미가 변형되는 리스크보다 통제 가능성이 높다. 따라서 Appendix B 표준 절차는 **지시문 파일 작성 → 파일 확인 → 짧은 파일 경유 명령 전달 → 빈 `do script`로 실행 확정 → 결과 확인** 순서로 정정하는 것이 타당하다.
```

## 5. classification decision
silkroadhub .harness/proposals는 과거 운영 제안 초안 묶음으로, 현재 Phase H 범위에서는 삭제하지 않고 client-local legacy residue로 분류한다. .harness/backups와 .harness/manuals는 현재 존재하지 않는다. proposals는 r7 정비 후보로 등록하며, 마스터 이전 대상 여부는 별도 task-card에서 판단한다.

test_claude_dispatch는 공식 Phase C task-card가 있는 run은 아니지만, dispatch 방식 A/B 비교 검증 및 AGENTS Appendix B 표준 절차 수립 근거이므로 두별 워크플로우 운영 자료로 이전한 판단은 유지한다. 다만 dubyeol-workflow PROJECT.md의 “Phase C” 표기는 “Phase C 후보/dispatch 검증 run”이라는 설명을 SUB-5 회고와 r7 정비 후보에 남겨 명명 혼선을 줄인다. 즉시 PROJECT.md 본문 수정은 하지 않고, sub4-modifications.md에 한계와 후속 보정 계획을 명시한다.
