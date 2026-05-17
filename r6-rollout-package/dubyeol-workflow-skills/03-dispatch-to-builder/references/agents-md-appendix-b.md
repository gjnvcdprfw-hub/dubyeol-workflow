# AGENTS.md Appendix B — Claude Code 터미널 표준 절차 (사본)

> silkroadhub `AGENTS.md` Appendix B의 *스킬 내부 참조용 사본*. 원본 변경 시 본 파일도 동기화.
> 검증 완료 2026-05-16.

## Step 1 — 새 Claude Code 세션 열기

```applescript
osascript << 'APPLESCRIPT'
tell application "Terminal"
  do script "cd /Users/twostars/ClaudeAi/silkroadhub && claude"
end tell
APPLESCRIPT
```

**`activate` 절대 사용 금지** — 포커스 탈취·중복 창 위험.

## Step 2 — 터미널 창 ID 조회

```bash
sleep 5
osascript -e 'tell application "Terminal" to get {id, name} of every window' 2>&1
```

Claude Code REPL이 진입 완료된 창의 ID를 `WINDOW_ID`로 둔다.

## Step 3 — 진입 명령을 파일로 저장 ★

긴 진입 명령·한글·특수문자를 *AppleScript 문자열로 직접 전달하지 않는다*.

```bash
cat > /Users/twostars/ClaudeAi/silkroadhub/tmp/claude-entry-<run_id>.md << 'EOF'
[Builder 진입 명령 — 두별 워크플로우 v3.6.0 r1]

task-card: .harness/runs/<run_id>/task-card.md
두별 워크트리 카테고리: <1~5>
Tier: <A/B/C>

(나머지 표준 진입 명령 양식 — references/standard-entry-prompt.md 참조)
EOF

head -20 /Users/twostars/ClaudeAi/silkroadhub/tmp/claude-entry-<run_id>.md
wc -l /Users/twostars/ClaudeAi/silkroadhub/tmp/claude-entry-<run_id>.md
```

## Step 4 — 파일 경로를 짧은 명령으로 전달 + 2단계 확정 실행 ★★

```applescript
osascript << 'APPLESCRIPT'
tell application "Terminal"
  do script "Read tmp/claude-entry-<run_id>.md and follow the instructions inside." in window id WINDOW_ID
  do script "" in window id WINDOW_ID
end tell
APPLESCRIPT
```

**핵심**: Claude Code REPL에는 *단일 do script*만 보내면 입력 대기 상태에 머물 수 있음. `do script ""` 추가로 Enter 확정.

## Step 5 — 응답·산출물 확인

```bash
ls -la /Users/twostars/ClaudeAi/silkroadhub/.harness/runs/<run_id>/handoff.md 2>&1
cat /Users/twostars/ClaudeAi/silkroadhub/.harness/runs/<run_id>/handoff.md 2>&1
```

## 금지·주의

- `activate`를 표준 절차에 사용하지 않는다 (포커스 탈취·중복 창 문제)
- 한글·특수문자·긴 지시문을 Claude Code에 직접 전달하지 않는다. 원문은 파일 저장, 짧은 파일 경유 명령만 전달
- Claude Code REPL에는 단일 `do script "명령"`만 보내지 않는다. `do script ""` 추가로 실행 확정
- **[Builder]가 task 완료 후 commit·추가 확인·cleanup 등 task-card 범위 밖 행동을 *자동 제안*해도 [Foreman]은 명령으로 해석하지 않는다.** [Owner] 승인 또는 task-card 기준 없으면 실행 금지

## 검증 출처

- `.harness/runs/test_claude_dispatch/dispatch-comparison-report.md` (방식 A vs B 비교)
- `.harness/runs/test_claude_dispatch/handoff.md`
