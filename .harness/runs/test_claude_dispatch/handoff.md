# Handoff — 클로드코드 지시 전달 방식 검증

**Run ID**: `test_claude_dispatch`  
**작성 일시**: 2026-05-16 18:01 KST  
**카테고리 / Tier**: 문서·운영 / Tier A  
**범위**: 방식 A와 방식 B의 지시 전달 안정성 비교, 권고 방식 결정, `AGENTS.md` Appendix A·B 정정안 작성. 실제 `AGENTS.md` 변경, commit, push, merge는 수행하지 않았다.

## 1. 검증 결과 요약

본 검증은 대표님 제공 첨부 파일 `프롬프트-클로드코드-지시전달-검증.md`의 Step 1~6을 기준으로 진행했다. 다만 검증 중 기존 프로젝트 지침과 충돌하는 `activate` 사용 문제가 발견되어 대표님 승인에 따라 `activate`를 제외했고, 단일 `do script`가 Claude Code REPL에서 Enter를 확정하지 않는 문제가 발견되어 대표님 승인에 따라 양쪽 방식 모두 **2단계 확정 실행**으로 비교했다.

| 항목 | 결과 |
|---|---|
| 방식 A 직접 입력 | 성공. `result-A.md` 생성 및 `테스트 완료` 응답 확인 |
| 방식 B 파일 경유 | 성공. `result-B.md` 생성 및 `테스트 완료` 응답 확인 |
| 권고 방식 | 방식 B: 파일 경유 + 짧은 명령 + 2단계 확정 실행 |
| Appendix A 점검 | 일반 zsh 스크립트 실행에서는 단일 `do script "zsh ..."`로 실행됨을 무해한 스크립트로 확인. 단, `activate` 제거 필요 |
| Appendix B 점검 | Claude Code REPL에는 단일 `do script`가 입력 대기에 머물 수 있어 2단계 확정 실행 필요 |
| AGENTS.md 실제 변경 | 미수행. 대표님 승인 전 변경 금지 원칙 준수 |

## 2. 산출물 위치

| 산출물 | 위치 | 상태 |
|---|---|---|
| 비교 보고서 및 Appendix A·B 정정안 | `.harness/runs/test_claude_dispatch/dispatch-comparison-report.md` | 작성 완료 |
| Handoff | `.harness/runs/test_claude_dispatch/handoff.md` | 작성 완료 |
| 방식 A 결과 | `.harness/runs/test_claude_dispatch/result-A.md` | 생성 확인 |
| 방식 B 결과 | `.harness/runs/test_claude_dispatch/result-B.md` | 생성 확인 |
| Appendix A do script 확인 증거 | `.harness/runs/test_claude_dispatch/appendix-a-do-script-check.txt` | 생성 확인 |
| 방식 B 지시 원문 | `tmp/test-instruction-B.md` | 생성 확인 |

## 3. 권고 방식과 사유

권고 방식은 **방식 B: 파일 경유 + 짧은 명령 + 2단계 확정 실행**이다. 방식 A도 최종적으로 성공했지만, 긴 한글 지시문과 특수문자를 AppleScript 문자열로 직접 전달하는 과정은 escape 부담이 크고, 실제 첫 시도에서 문자열 깨짐·혼입 위험이 관찰되었다. 방식 B는 원문 지시가 파일로 보존되어 검토·재실행·회고가 쉽고, Claude Code에 전달되는 명령은 짧은 ASCII 문장으로 제한할 수 있어 r6 운영 표준으로 적합하다.

## 4. AGENTS.md Appendix A·B 정정안 요약

정정안 전문은 `dispatch-comparison-report.md`의 **6. AGENTS.md Appendix A·B 정정안** 섹션에 포함되어 있다. 핵심은 다음과 같다.

| Appendix | 정정 방향 |
|---|---|
| Appendix A | `activate` 제거. Codex 호출은 일반 zsh 스크립트 실행이므로 단일 `do script "zsh ..." in window id WINDOW_ID` 사용 가능하되, 창 ID 명시와 결과 파일 확인을 강화 |
| Appendix B | `activate` 제거. 긴 지시문은 파일로 저장. Claude Code에는 짧은 파일 경유 명령만 전달. `do script "..."` 후 `do script ""`를 보내는 2단계 확정 실행 표준화 |

## 5. 발견된 추가 문제

| 번호 | 발견 사항 | 처리 |
|---:|---|---|
| 1 | `AGENTS.md` Appendix A·B에 `activate` 포함 절차가 있어 기존 프로젝트 지침과 충돌 | 보고서에 명시하고 정정안에 `activate` 제거 반영 |
| 2 | Claude Code REPL에서 단일 `do script`는 Enter 미확정으로 실행되지 않음 | Appendix B 정정안에 2단계 확정 실행 반영 |
| 3 | `[Builder]`가 task 완료 후 task-card 범위 밖 행동인 `git commit`을 자동 제안 | `[Foreman]`은 명령으로 해석하지 않았고 실행하지 않음. 보고서에 기록 |
| 4 | 방식 B 완료 후 `result-A.md도 확인해봐`라는 추가 확인 제안이 표시됨 | task-card 범위 밖 제안으로 보고 실행하지 않음 |

## 6. 마누스 확인 필요점

대표님 확인이 필요한 사항은 두 가지다. 첫째, `dispatch-comparison-report.md`의 Appendix A·B 정정안을 `AGENTS.md`에 실제 반영해도 되는지 승인 여부가 필요하다. 둘째, 다음 Appendix A·C 검증 task에서 본 검증의 권고 방식인 **파일 경유 + 짧은 명령 + 2단계 확정 실행**을 표준 진입 방식으로 사용해도 되는지 확인이 필요하다.

## 7. Git 및 권한 상태

| 항목 | 상태 |
|---|---|
| 현재 브랜치 | `feature/mbl-document-workspace-phase1` |
| HEAD | `a7f1236` |
| `AGENTS.md` 실제 수정 | 미수행. 단, 작업 시작 시점부터 `git status`에 `M AGENTS.md`가 존재했으며 본 검증에서 수정하지 않음 |
| 새로 생성된 run 증거 | `.harness/runs/test_claude_dispatch/` |
| commit / push / merge | 미수행 |

## References

[^source-prompt]: 출처: 대표님 제공 첨부 파일 `프롬프트-클로드코드-지시전달-검증.md` (`/home/ubuntu/upload/pasted_content.txt`, 2026-05-16 확인) 및 저장소 `AGENTS.md` Appendix A·B (`/Users/twostars/ClaudeAi/silkroadhub/AGENTS.md`, 2026-05-16 확인).
