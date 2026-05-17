# handoff-verification: Task 2 sync 스크립트 구현

**run ID**: 20260518_sync-script-implementation  
**작성일시**: 2026-05-17 KST  
**작성자**: [Foreman]  
**검증 대상**: Builder handoff 및 SUB-2 구현 산출물  
**상태**: SUB-2 구현 수신 완료, Foreman 직접 검증 완료, SUB-3 API 키 문제로 미진입

---

## 1. 검증 요약

Builder handoff만 신뢰하지 않고 Foreman이 로컬 저장소에서 직접 파일 존재, 실행 권한, 단위 smoke test, dummy 클라이언트 경계, protected path 변경 여부, secret-like placeholder 여부를 확인했다.

| 항목 | 결과 |
|---|---|
| `scripts/sync-to-client.sh` 존재 | OK |
| `scripts/sync-to-client.sh` 실행 권한 | OK |
| `.harness/sync-exclude.txt` 존재 | OK |
| `.env.template` 존재 | OK |
| `evidence-unit-tests.md` 존재 | OK |
| `evidence-dummy-client-test.md` 존재 | OK |
| `handoff.md` 존재 | OK |
| protected files 변경 | 없음 |
| 마지막 commit | `8c2394f` 유지, commit·push 미실행 |

---

## 2. Foreman 직접 smoke test 결과

Foreman은 핵심 exit code를 직접 재확인했다.

| 검증 | 명령 | 결과 |
|---|---|---|
| help | `./scripts/sync-to-client.sh --help` | exit `0` |
| 인자 없음 | `./scripts/sync-to-client.sh` | exit `1` |
| 존재하지 않는 경로 | `./scripts/sync-to-client.sh /path/does/not/exist` | exit `1` |
| 마스터 경로 자체 | `./scripts/sync-to-client.sh .` | exit `1` |
| dummy git repo | `test -d tmp/dummy-client/.git` | OK |
| tmp ignore | `git check-ignore --no-index tmp/dummy-client/somefile` | `.gitignore:29:tmp/` 적용 확인 |

Builder evidence 기준으로 전체 단위 테스트는 7/7 PASS, dummy dry-run·실제 sync는 2/2 PASS, 대표 체크섬 3/3 MATCH로 기록되어 있다.

---

## 3. 권한 천장 점검

| 권한 천장 항목 | Foreman 확인 |
|---|---|
| commit·push | 미실행 |
| force push/history rewrite/reset hard | 미실행 |
| 9개 스킬 본문 수정 | 없음 |
| AGENTS.md·SUB-1~5·PROJECT.md·templates 수정 | 없음 |
| `silkroadhub` 접근 | handoff 기준 미접근, 변경 상태에 관련 경로 없음 |
| API 키 출력·키 파일 생성 | 키 파일 생성 없음. 단 `.env.template` placeholder에 secret-like 문자열 존재 |
| 실제 client sync | dummy client만 사용 |
| tmp commit 대상 | `tmp/` ignore 확인 |

---

## 4. 발견 이슈: `.env.template` secret-like placeholder

Foreman 직접 검증 중 `.env.template`의 아래 주석 예시가 secret-like pattern으로 감지되었다.

| 파일 | 줄 | 내용 | 판정 |
|---|---:|---|---|
| `.env.template` | 30 | `# OPENAI_API_KEY=sk-...` | 실제 키는 아니나 secret-like placeholder |
| `.env.template` | 33 | `# ANTHROPIC_API_KEY=sk-ant-...` | 실제 키는 아니나 secret-like placeholder |

이는 실제 API 키 값이 아니므로 즉시 유출 사고는 아니다. 그러나 회고 32의 “키 값 출력 금지, SET/NOT SET 또는 키 유사 문자열 최소화” 원칙과 Task 2의 키 자료 정책을 기준으로 보면, SUB-4에서 다음처럼 정정하는 것이 안전하다.

| 현재 | 권고 정정 |
|---|---|
| `# OPENAI_API_KEY=sk-...` | `# OPENAI_API_KEY=<SET_IN_SHELL_PROFILE>` |
| `# ANTHROPIC_API_KEY=sk-ant-...` | `# ANTHROPIC_API_KEY=<SET_IN_SHELL_PROFILE>` |

---

## 5. 추가 관찰: sync 보고서 위치

Builder 실행 중 `.harness/sync-reports/` 아래 sync 보고서가 생성되었다. 설계상 `DUBYEOL_SYNC_REPORT_DIR`를 통해 run 폴더로 redirect할 수 있으나, 현재 기본값은 `.harness/sync-reports`다. 본 task commit 범위에 포함할지, `.gitignore` 대상으로 둘지 SUB-4 또는 SUB-5에서 결정이 필요하다.

| 항목 | 관찰 |
|---|---|
| 보고서 디렉터리 | `.harness/sync-reports/` |
| 생성 원인 | dummy dry-run·실제 sync 실행 |
| 권고 | run evidence에 이미 결과가 있으므로 sync-reports는 commit 제외 또는 `.gitignore` 반영 검토 |

---

## 6. SUB-3 상태

[Owner]가 “sub3은 api키 문제로 못해”라고 지시했다. 따라서 SUB-3 외부 감리는 본 시점에서 진행하지 않는다. 별도 기록은 `sub3-skip-decision.md`에 남겼다.

---

## 7. Foreman 판정

SUB-2 구현은 대체로 완료되었고, sync script 자체는 동작 가능 상태로 보인다. 다만 `.env.template`의 secret-like placeholder와 `.harness/sync-reports/` 처리 정책이 남아 있어, **SUB-4 수정 후 제한 종료**가 가장 정합한 분기다.

| 분기 | 판정 |
|---|---|
| SUB-4 수정 | 권고 |
| waiver 종료 | 비권고 |

**handoff-verification 끝.**
