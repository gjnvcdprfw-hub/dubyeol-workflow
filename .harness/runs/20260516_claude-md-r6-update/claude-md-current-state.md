# CLAUDE.md current state

## 글로벌 위치
-rw-r--r--@ 1 twostars  staff  9768 May 14 00:59 /Users/twostars/.claude/CLAUDE.md
     149 /Users/twostars/.claude/CLAUDE.md

## 프로젝트 위치
-rw-r--r--@ 1 twostars  staff  14751 May 15 21:27 /Users/twostars/ClaudeAi/silkroadhub/CLAUDE.md
     166 /Users/twostars/ClaudeAi/silkroadhub/CLAUDE.md

## 글로벌 버전 표시 grep
13:# 두별워크플로우 하네스 전환 규칙
15:예전 하네스 문서(`context.md`, `workflow.md`, `watchout.md`, `structure.md`, `interfaces.md`)는 두별워크플로우 v3.5.0의 주 운영 문서가 아니라 **legacy 참고자료**다. Claude Code는 기본적으로 프로젝트 `CLAUDE.md`와 마누스가 지정한 run별 `task-card.md`를 읽고 작업한다.
17:| 구분 | v3.5.0 기준 |
34:## 두별워크플로우 v3.5.0 연동 규칙
41:# 두별워크플로우 v3.5.0 — Claude Code 전역 실행 규칙
43:본 섹션은 두별워크플로우를 사용하는 모든 프로젝트에서 Claude Code에 적용되는 전역 규칙이다. 프로젝트별 `CLAUDE.md`는 기술스택, 도메인 위험 기준, 테스트·빌드 명령, 프로젝트별 마스킹 패턴만 보강한다. 본 섹션과 프로젝트 `CLAUDE.md`가 충돌하면 프로젝트 `CLAUDE.md`를 우선하되, 대표님 최신 명시 지시와 승인된 두별워크플로우 설계안이 있으면 그것을 최우선으로 한다.
47:Claude Code는 두별워크플로우에서 **Builder / Executor**다. Claude Code는 대표님과 직접 기획하거나 Gate를 판단하지 않고, 마누스가 제공한 run별 `task-card.md`와 프로젝트 `CLAUDE.md`를 기준으로 설계·구현·검증을 수행한다.
147:예전 v3.3.0/v3.4.0 하네스 자동 설치 절차는 두별워크플로우 v3.5.0의 공식 초기화 절차가 아니다. 새 프로젝트 초기화 방식은 두별워크플로우 하네스(`task-card`, `handoff`, `gate-review`, `final-report`, `project-context-bridge`)가 완성된 뒤 다시 정의한다.

## 프로젝트 버전 표시 grep
1:# CLAUDE.md — silkroadhub (두별워크플로우 v3.5.0 프로젝트 실행 보강본)
3:본 문서는 Claude Code가 `silkroadhub` 프로젝트에서 작업할 때 따르는 **프로젝트 전용 실행 지침**입니다. 공통 실행 규칙은 글로벌 `~/.claude/CLAUDE.md`의 `두별워크플로우 v3.5.0 — Claude Code 전역 실행 규칙`을 따르고, 본 문서는 `silkroadhub`의 기술스택, 도메인 위험 기준, 마스킹, 운영 참고 문서만 보강합니다.
13:## 2. 두별워크플로우 v3.5.0 적용 원칙
15:`silkroadhub`는 대표님, 마누스, Claude Code, Codex, ChatGPT가 협업하는 **두별워크플로우 v3.5.0**을 따릅니다. Claude Code는 이 구조에서 **Builder / Executor**이며, 마누스가 정리한 run별 `task-card.md`를 기준으로 구현·검증하고 결과를 `handoff.md`로 남깁니다.
29:Claude Code의 기본 실행 기준은 글로벌 `~/.claude/CLAUDE.md`, 프로젝트 루트 `CLAUDE.md`, 그리고 마누스가 지정한 run별 `task-card.md`입니다. `AGENTS.md`와 두별워크플로우 설계안은 마누스의 운영 기준이며, Claude Code는 마누스가 `task-card.md`에서 명시적으로 지시한 경우에만 해당 문서를 읽습니다.
41:모든 구현 run은 글로벌 지침에 따라 `/using-superpowers`로 시작합니다. Claude Code는 마누스가 지정한 `task-card.md`를 기준으로 **Superpowers 전체 프로세스**를 명시적으로 사용합니다. Superpowers skill은 Claude Code의 실행 방법을 정하지만, 대표님 지시와 두별워크플로우 권한 경계를 변경하지 않습니다.
