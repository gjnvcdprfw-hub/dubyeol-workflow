# 두별 워크플로우 스킬 (dubyeol-workflow-skills)

> 두별 워크플로우 v3.6.0 r1 베타 — 마누스 Agent Skills 9개 모음

## 소개

비전공자 [Owner] + AI 다중 에이전트 협업을 위한 *현장 운영 표준*. 마누스가 [Foreman] 역할로 동작하며, 9개 스킬이 *행동 자동화·라우팅·판단 보조*를 담당.

**구성원**:
- `[Owner]` — 대표님
- `[Foreman]` — 마누스
- `[Builder]` — 클로드코드 (Claude Code)
- `[Reviewer]` — 코덱스 (코덱스 불가 시 지피티 폴백)
- `[Judge]` — 지피티 (Devil's Advocate, 별도 세션)

## 스킬 9개 (호출 순서 = 번호 순서)

| # | 스킬 | 트리거 위치 |
|---|---|---|
| 01 | `load-sub-manual` | [Owner] 발화 (모든 단계의 진입점) — SUB-N 매뉴얼 로드 |
| 02 | `create-task-card` | SUB-1 §2 SOP 완료 후 — task-card 초안 자동 생성 |
| 03 | `dispatch-to-builder` | SUB-2 §2 진입 — 클로드코드에 진입 명령 전달 |
| 04 | `invoke-plan-review` | SUB-2 §2.5 — 구현 진입 전 plan 검토 (Tier A·큰 task) |
| 05 | `verify-handoff` | SUB-2 §4 (handoff 수신 직후) — 6개 항목 자동 검증 |
| 06 | `invoke-reviewer` | SUB-3 §3 — 코드 감리 (코덱스 + 지피티 폴백) |
| 07 | `invoke-judge` | SUB-3 §4 — Devil's Advocate + 종합 판정 |
| 08 | `write-final-report` | SUB-5 §2 — final-report 초안 자동 작성 |
| 09 | `update-project-md` | SUB-5 §3 — PROJECT.md 자동 갱신 (commit은 별도) |

## 마누스 import 방법

1. 마누스 Settings → Skills → + Add 클릭
2. *Import from GitHub* 선택
3. 본 저장소 URL 붙여넣기
4. *Import* 클릭 — 9개 스킬 모두 자동 등록

이후 마누스 채팅에서 `/01-load-sub-manual` 같은 슬래시 명령으로 호출.

## 환경 가정

- macOS (Terminal·osascript)
- 작업 디렉터리: `/Users/twostars/ClaudeAi/silkroadhub`
- 코덱스 CLI 설치 (`/Users/twostars/.local/node/bin/codex`)
- OpenAI 키 (`scripts/load_openai_key.sh`로 환경변수 로드)
- 클로드코드 CLI 설치 (`claude` 명령)

**Phase 1 (현재)**: 마누스 전용. silkroadhub 프로젝트 특화.
**Phase 2 (향후)**: 다른 오케스트레이터·다른 프로젝트로 리팩토링.

## 핵심 안전선 (r6 베타 검증으로 박힌 것)

- `activate` 사용 금지 (Terminal 포커스 탈취·중복 창 문제)
- 단일 `do script` 금지 (Enter 미확정으로 입력 대기) — 2단계 확정 실행 의무
- [Builder] 자동 제안 (`git commit` 등)은 명령 아님 — [Foreman] 무시
- 코덱스 = [Reviewer] 단독 / 지피티 = [Judge] 단독 (정보 격리)
- [Reviewer] ↔ [Judge] 세션 *반드시 분리*
- PROJECT.md 자동 commit 금지 — [Owner] 승인 후 별도

## 라이선스

MIT License. 자유롭게 사용·수정·재배포 가능. 다만 *민감 정보·운영 데이터를 박지 않을 의무*.

## 참조

- 메인 매뉴얼: silkroadhub 저장소의 `AGENTS.md`·`SUB-1`~`SUB-5`·`PROJECT.md`
- 양식: `.harness/templates/*`
- Manus Skills 공식 문서: https://manus.im/docs/features/skills
- Anthropic Agent Skills: https://github.com/anthropics/skills

---

**버전**: r6 베타 (2026-05-16)
**다음 r 개정 시점**: r6 dry-run 후 누적 회고 종합
