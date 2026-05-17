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

## 6. AGENTS.md Appendix A·B 정정안

아래 정정안은 **초안**이며, 대표님 승인 전까지 `AGENTS.md`에는 반영하지 않는다. 본 검증에서는 실제 `AGENTS.md`를 수정하지 않았다.

### 6.1 Appendix A 정정안: Codex Gatekeeper 호출 표준 절차

Appendix A의 Codex 호출은 `zsh /Users/twostars/ClaudeAi/silkroadhub/tmp/run_codex.sh` 형태의 일반 셸 스크립트 실행이다. 무해한 대체 스크립트 `tmp/test_appendix_A_do_script.sh`로 확인한 결과, 일반 Terminal zsh 창에서는 단일 `do script "zsh ..." in window id WINDOW_ID`만으로도 스크립트가 실행되어 `.harness/runs/test_claude_dispatch/appendix-a-do-script-check.txt`가 생성되었다. 따라서 Claude Code REPL처럼 2단계 Enter 보정이 필수인 것은 아니지만, `activate`는 제거해야 하며, 창 ID를 명시하고 실행 결과 파일을 반드시 확인해야 한다.

````markdown
## Appendix A. Codex Gatekeeper 호출 표준 절차

### Step 1 — 새 터미널 창 열기
```applescript
osascript << 'APPLESCRIPT'
tell application "Terminal"
  do script "cd /Users/twostars/ClaudeAi/silkroadhub"
end tell
APPLESCRIPT
```

### Step 2 — 터미널 창 ID 조회
```bash
osascript -e 'tell application "Terminal" to get {id, name} of every window' 2>&1
```

### Step 3 — 실행 스크립트 작성
```bash
cat > /Users/twostars/ClaudeAi/silkroadhub/tmp/run_codex.sh << 'SCRIPT'
#!/bin/zsh
export PATH="/Users/twostars/.local/node/bin:$PATH"
source ~/.zshrc 2>/dev/null || true
cd /Users/twostars/ClaudeAi/silkroadhub
OUTPUT_FILE=".harness/runs/PHASE_RUN_ID/codex-review.md"
LOG_FILE=".harness/runs/PHASE_RUN_ID/codex-exec.log"
echo "=== Codex Review Start: $(date) ===" | tee "$LOG_FILE"
codex exec \
  --sandbox read-only \
  --output-last-message \
  - << 'PROMPT' > "$OUTPUT_FILE" 2>> "$LOG_FILE"
여기에 프롬프트 내용 작성
PROMPT
EXIT_CODE=$?
echo "=== Codex Review End: $(date), exit=$EXIT_CODE ===" | tee -a "$LOG_FILE"
head -5 "$OUTPUT_FILE"
SCRIPT
chmod +x /Users/twostars/ClaudeAi/silkroadhub/tmp/run_codex.sh
```

### Step 4 — 스크립트 실행
```applescript
osascript << 'APPLESCRIPT'
tell application "Terminal"
  do script "zsh /Users/twostars/ClaudeAi/silkroadhub/tmp/run_codex.sh" in window id WINDOW_ID
end tell
APPLESCRIPT
```

### Step 5 — 결과 확인
```bash
sleep 60
cat /Users/twostars/ClaudeAi/silkroadhub/.harness/runs/PHASE_RUN_ID/codex-review.md
cat /Users/twostars/ClaudeAi/silkroadhub/.harness/runs/PHASE_RUN_ID/codex-exec.log
```

> 주의: Appendix A의 `do script "zsh ..."`는 일반 Terminal zsh 명령 실행이므로 본 검증의 무해한 대체 스크립트에서는 단일 `do script`로 실행되었다. 반면 Claude Code REPL에 자연어 지시를 넣는 Appendix B는 단일 `do script`로 입력만 되고 실행되지 않을 수 있으므로 2단계 확정 실행을 표준으로 둔다.
````

### 6.2 Appendix B 정정안: Claude Code 터미널 표준 절차

````markdown
## Appendix B. Claude Code 터미널 표준 절차

### Step 1 — 새 Claude Code 세션 열기
```applescript
osascript << 'APPLESCRIPT'
tell application "Terminal"
  do script "cd /Users/twostars/ClaudeAi/silkroadhub && claude"
end tell
APPLESCRIPT
```

### Step 2 — 터미널 창 ID 조회
```bash
sleep 5
osascript -e 'tell application "Terminal" to get {id, name} of every window' 2>&1
```

Claude Code REPL이 진입 완료된 창의 ID를 `WINDOW_ID`로 둔다. `activate`는 포커스 탈취와 중복 창 문제를 유발할 수 있으므로 표준 절차에서 사용하지 않는다.

### Step 3 — 진입 명령을 파일로 저장
```bash
cat > /Users/twostars/ClaudeAi/silkroadhub/tmp/claude-entry-instruction.md << 'EOF'
여기에 task-card 경로, 권한 천장, 산출물, 검증 기준, handoff 작성 위치를 포함한 진입 명령을 작성한다.
EOF

head -20 /Users/twostars/ClaudeAi/silkroadhub/tmp/claude-entry-instruction.md
wc -l /Users/twostars/ClaudeAi/silkroadhub/tmp/claude-entry-instruction.md
```

### Step 4 — 파일 경로를 짧은 명령으로 전달하고 2단계로 실행 확정
```applescript
osascript << 'APPLESCRIPT'
tell application "Terminal"
  do script "Read tmp/claude-entry-instruction.md and follow the instructions inside." in window id WINDOW_ID
  do script "" in window id WINDOW_ID
end tell
APPLESCRIPT
```

### Step 5 — 응답과 산출물 확인
```bash
ls -la /Users/twostars/ClaudeAi/silkroadhub/.harness/runs/RUN_ID/handoff.md 2>&1
cat /Users/twostars/ClaudeAi/silkroadhub/.harness/runs/RUN_ID/handoff.md 2>&1
```

### 금지·주의

- `activate`를 표준 절차에 넣지 않는다.
- 한글·특수문자·긴 지시문을 Claude Code에 직접 전달하지 않는다. 원문은 파일로 저장하고 짧은 파일 경유 명령만 전달한다.
- Claude Code REPL에는 단일 `do script "명령"`만 보내지 않는다. 입력 대기 상태에 머물 수 있으므로 `do script ""`를 추가로 보내 실행을 확정한다.
- `[Builder]`가 task 완료 후 commit, 추가 확인, cleanup 등 task-card 범위 밖 행동을 제안하더라도 `[Foreman]`은 이를 명령으로 해석하지 않는다. 대표님 승인 또는 task-card 기준이 없으면 실행하지 않는다.
````

## 7. 발견된 추가 문제

| 번호 | 발견 사항 | 영향 | 정정 방향 |
|---:|---|---|---|
| 1 | `AGENTS.md` Appendix A·B에 `activate` 포함 절차가 존재하며, 이는 기존 프로젝트 지침의 안전선과 충돌한다. | 포커스 탈취, 중복 창, 엉뚱한 창 입력 위험이 있다. | Appendix A·B 표준 절차에서 `activate`를 제거한다. |
| 2 | Claude Code REPL에 대한 단일 `do script`는 Enter가 확정되지 않아 실행되지 않을 수 있다. | 지시문이 프롬프트에 올라가지만 `result-A.md`가 생성되지 않는 상태가 관찰되었다. | Appendix B에 `do script "..."` 후 `do script ""`를 보내는 2단계 확정 실행을 표준화한다. |
| 3 | `[Builder]`가 task 완료 후 task-card 범위 밖 행동인 `git commit`을 자동 제안했다. | 권한 천장 위반으로 오해하고 실행할 위험이 있다. | `[Foreman]`은 이를 명령으로 해석하지 않고, 승인 없는 commit·push·merge를 금지한다. |
| 4 | Appendix A의 Codex 호출 패턴은 일반 zsh 스크립트 실행이라 단일 `do script`로 실행됨이 확인되었다. | Appendix B와 동일한 Enter 미확정 문제는 재현되지 않았다. | Appendix A는 `activate` 제거와 결과 확인 강화 중심으로 정정한다. |
| 5 | 방식 B 완료 후 Claude Code 화면에 `result-A.md도 확인해봐`라는 추가 확인 제안이 표시되었다. | 읽기 전용 제안이지만 task-card 범위 밖 자동 제안으로 해석될 수 있다. | 승인·필요성 없는 추가 행동은 실행하지 않고 관찰로만 남긴다. |

## 8. 다음 단계

| 단계 | 상태 | 설명 |
|---|---|---|
| 대표님 정정안 승인 | 대기 | 본 보고서의 Appendix A·B 정정안을 검토 후 승인 여부 결정 필요 |
| `AGENTS.md` 실제 갱신 | 미수행 | 승인 전 실제 파일 변경 금지 원칙에 따라 미반영 |
| Appendix A·C 검증 task 진입 | 대기 | 본 권고 방식, 즉 파일 경유 + 2단계 확정 실행을 기반으로 진행 권고 |
| Git commit/push | 미수행 | 대표님 승인 전 금지 |

## References

[^source-prompt]: 출처: 대표님 제공 첨부 파일 `프롬프트-클로드코드-지시전달-검증.md` (`/home/ubuntu/upload/pasted_content.txt`, 2026-05-16 확인) 및 저장소 `AGENTS.md` Appendix A·B (`/Users/twostars/ClaudeAi/silkroadhub/AGENTS.md`, 2026-05-16 확인).
