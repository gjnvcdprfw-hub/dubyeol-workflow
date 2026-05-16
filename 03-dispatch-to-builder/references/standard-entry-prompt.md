# 표준 진입 명령 양식 (영문 ASCII 권고 — AppleScript escape 안전)

본 양식이 `scripts/dispatch.sh`가 자동 생성하는 `tmp/claude-entry-<run_id>.md`의 기반.

## 양식

```
[Builder 진입 명령 — 두별 워크플로우 v3.6.0 r1]

task-card: .harness/runs/<run_id>/task-card.md
두별 워크트리 카테고리: <1~5>
Tier: <A/B/C>

본 task는 두별 워크플로우 v3.6.0 r1 SUB-2 단계.

[Builder] 행동 원칙:
1. 글로벌 ~/.claude/CLAUDE.md + 프로젝트 silkroadhub/CLAUDE.md 자동 로드 확인
2. task-card를 우선 입력으로 읽음. task-card §3 의도 정렬 증거 블록은 해석 기준
3. /using-superpowers 진입 후 task-card §[두별 워크트리 카테고리] 진행 트리 따름
4. 모든 산출물에 CLAUDE.md §6 마스킹 규칙 적용
5. task-card §8 권한 천장·금지 사항 절대 위반 금지
6. 작업 완료 또는 block 시 .harness/runs/<run_id>/handoff.md 작성 후 정지
7. push/merge/deploy/운영 문서 변경/파괴적 git/scope 확장은 [Foreman] 또는 [Owner] 명시 승인 후
8. task 완료 후 commit·cleanup·추가 확인 등 task-card 범위 밖 행동을 자동 제안하지 않음. handoff.md만 작성하고 정지.

진입.
```

## 변형 시 주의

- 영문 ASCII 위주 권고 — 단, 한글도 검증 결과 *깨짐 없이* 전달됨 (방식 B 파일 경유 덕분)
- 클로드코드에 직접 입력하지 *말 것*. 파일에 저장 후 `Read <path>` 명령으로 전달
- 항목 8번 *반드시 포함* — Builder 친절 제안 자제 의무
