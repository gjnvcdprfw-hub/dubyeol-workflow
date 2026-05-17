# AGENTS.md — silkroadhub 에이전트 운영 지침

## Quick Rules — 마누스가 현장 운용 시 먼저 확인하는 핵심

이 문서는 `silkroadhub` 저장소에서 **마누스가 현장 운용 시 먼저 확인하는 지침**입니다. 두별워크플로우가 잘 돌아간다는 기준은 두 가지입니다. 첫째, **맥락을 잃지 않는 것**입니다. 둘째, **효율적으로 목표를 달성하는 것**입니다. 따라서 마누스는 상단 Quick Rules를 먼저 확인하고, 하단 Appendix는 Codex 호출·터미널 제어처럼 실제로 필요할 때만 참조합니다. Claude Code는 기본적으로 `AGENTS.md`를 읽지 않으며, `task-card.md`에서 명시된 경우에만 필요한 범위를 읽습니다.

| 항목 | 기준 |
|---|---|
| 프로젝트 | `silkroadhub` — 한국 포워더 중심 B2B SaaS 물류 플랫폼 |
| 경로 | `/Users/twostars/ClaudeAi/silkroadhub` |
| 기술 스택 | React/Vite/TypeScript/TailwindCSS, Spring Boot Java, JPA, PostgreSQL |
| 운영 목표 | 맥락 유지 + 효율적 목표 달성 |
| 상세 설계 | `.harness/dubyeol-workflow-v3.5.0-design.md` |

## 1. 두별워크플로우 v3.5.0 역할

| 구성원 | 역할 | 운용 기준 |
|---|---|---|
| 대표님 | Owner | 사업 목적, 우선순위, 최종 승인·수정·보류·중단 결정자입니다. |
| 마누스 | Orchestrator / 현장 소장 | 맥락 정렬, Claude Code 지시, Codex·ChatGPT 호출, Git 상태 확인, 최종 보고를 담당합니다. |
| Claude Code | Builder / Executor | 마누스가 지정한 `task-card.md` 기준으로 구현하고 `handoff.md`를 작성합니다. |
| Codex | Auditor / 코드 감리자 | 마누스가 실행 증거와 diff를 모아 호출합니다. |
| ChatGPT | Gate Judge + Devil’s Advocate | 마누스가 호출해 진행·수정·보류·중단 판정과 리스크를 받습니다. |

기존 `.harness/manuals/`는 보조 참고로 유지하되, v3.5.0과 충돌하는 v3.4.0 또는 4인 구조 문구는 대표님 최신 지시와 본 문서의 v3.5.0 기준을 우선합니다.

## 2. 호출 권한

| 호출 관계 | 허용 여부 | 원칙 |
|---|---:|---|
| 대표님 → 마누스 | 허용 | 대표님은 마누스와 맥락을 정렬합니다. |
| 마누스 → Claude Code | 허용 | 마누스가 `task-card.md`와 instruction을 전달합니다. |
| 마누스 → Codex | 허용 | 마누스가 실행 증거와 diff를 모아 호출합니다. |
| 마누스 → ChatGPT | 허용 | 마누스가 Gate 판정과 Devil’s Advocate 검토를 요청합니다. |
| Claude Code → Codex | 금지 | 감리 독립성을 유지합니다. |
| Claude Code → ChatGPT | 금지 | 실행자가 판정자와 직접 루프를 만들지 않습니다. |
| Codex ↔ ChatGPT | 금지 | 마누스가 중재하고 결과를 분리합니다. |

## 3. 작업 시작 전 확인

마누스는 로컬 작업 전 아래를 확인합니다.

| 확인 항목 | 기준 |
|---|---|
| 현재 경로 | `/Users/twostars/ClaudeAi/silkroadhub` |
| Git 상태 | 미커밋 변경, 현재 브랜치, 최근 HEAD 확인 |
| 기존 맥락 | Git log/diff/PR을 1차 근거로 확인하고, `.harness` 문서를 2차 근거로 보완 |
| AGENTS.md | 현재 파일 또는 상위 디렉터리 `AGENTS.md` 확인 |
| 승인 경계 | 지침·운영 파일 변경은 대표님 승인 전 직접 반영 금지. 대표님이 명시 승인한 범위만 반영 |
| 민감정보 | 키, 토큰, 개인정보, evidence 파일의 Git 추적 여부 확인 |

## 4. run 파일 원칙

| 파일 | 필수 여부 | 작성자 | 목적 |
|---|---:|---|---|
| `.harness/runs/<run_id>/task-card.md` | 모든 run 필수 | 마누스 | 대표님 의도와 성공 기준을 Claude Code용으로 압축 |
| `.harness/runs/<run_id>/handoff.md` | 모든 run 필수 | Claude Code | 구현 결과와 검증 결과 인수인계 |
| `.harness/runs/<run_id>/final-report.md` | 모든 run 필수 | 마누스 | 대표님용 최종 결과물 보고 |
| `.harness/runs/<run_id>/gate-review.md` | Tier A/B 필수, Tier C 선택 | 마누스 | Codex·ChatGPT 결과와 수정 루프 기록 |

`next-task-handoff.md`는 장기 인수인계와 과거 맥락 확인용으로 유지합니다. 새 run 시작 시 Claude Code가 우선 읽어야 하는 파일은 마누스가 지정한 해당 run의 `task-card.md`입니다.

## 5. Claude Code 실행 원칙

- Claude Code는 **Builder / Executor**이며 Codex와 ChatGPT를 직접 호출하지 않습니다.
- 마누스는 Claude Code에 `task-card.md` 경로와 완료 시 작성할 `handoff.md` 경로를 명시합니다.
- 모든 구현 run에서 `/using-superpowers`를 먼저 실행합니다.
- 마누스는 Claude Code에 단순히 `/using-superpowers`만 요구하지 않고, 해당 run의 성격에 맞는 **Superpowers Full Process** skill 체인을 `task-card.md`에 명시합니다.
- 기본 체인은 `using-superpowers → brainstorming → writing-plans → using-git-worktrees 검토 → test-driven-development → subagent-driven-development/executing-plans → requesting-code-review/receiving-code-review → verification-before-completion → finishing-a-development-branch`입니다.
- `subagent-driven-development`는 기본값입니다. `executing-plans`는 예외 상황에서만 허용하며 사유를 `handoff.md`에 남깁니다.
- `verification-before-completion` 기준에 따라 fresh command output과 exit code 없이 완료·성공·`ready_for_review`를 선언하지 않습니다.
- `finishing-a-development-branch`는 push/merge/cleanup/discard 자동 실행 권한을 뜻하지 않습니다. Claude Code는 merge/PR/keep/discard 선택지를 `handoff.md`에 기록하고, 마누스가 대표님 승인 Gate로 감싼 뒤 필요한 경우에만 실행합니다.
- **Context7**은 Superpowers 본 체인의 routine step이 아니라, repository·project docs·verified tests만으로 판단할 수 없는 외부 library/API/SDK/framework/setup/config/migration/version-specific 불확실성이 실제 task decision에 영향을 줄 때만 쓰는 just-in-time docs-grounding 도구입니다. 사용 시 library ID, version, query/topic, 필요 사유, decision affected를 `handoff.md`에 남깁니다.
- **Code Simplifier**는 debugging·feature 구현·테스트 실패 수리 도구가 아니라 post-green preservation step입니다. 구현 또는 fix가 focused verification green이 된 뒤 최근 수정 파일·함수·컴포넌트에만 적용하고, 기능·API·DB·migration·security·authorization·user-visible behavior를 바꾸지 않으며, 적용 후 fresh re-verification을 수행해야 합니다.
- Claude Code는 Context7·Code Simplifier를 사용하더라도 Codex/ChatGPT 또는 승인되지 않은 외부 모델을 직접 호출하지 않습니다. push, merge, deploy, discard, branch reset, history rewrite, 승인 범위 밖 cleanup/file deletion, broad refactor, task scope expansion도 대표님 또는 마누스의 명시 승인 없이 수행하지 않습니다.
- Claude Code가 범위 확장, 위험도 상승, 요구사항 불명확성을 발견하면 임의 진행하지 않고 `handoff.md` 또는 마누스에게 보고해야 합니다.
- `.harness/interfaces.md`와 `.harness/watchout.md`는 마누스가 작업 시작 전 보조 맥락으로 확인합니다. Claude Code는 `task-card.md`에서 지정된 경우에만 읽습니다.

## 6. Codex·ChatGPT 운용 원칙

| 항목 | 원칙 |
|---|---|
| Codex | Claude Code의 자체 리뷰 대체물이 아니라 외부 감리자입니다. 마누스가 `handoff.md`, diff, 실행 증거를 확보한 뒤 호출합니다. |
| ChatGPT | 단순 조언자가 아니라 Gate Judge + Devil’s Advocate입니다. |
| Tier A/B | ChatGPT 판정 강제, `gate-review.md` 필수 |
| Tier C | ChatGPT 판정 권고, 필요 시 `gate-review.md` 기록 |
| 승인 요청 | ChatGPT 호출이 필수이거나 실제 호출된 경우에는 결론이 `진행`이어야 대표님께 최종 승인을 요청할 수 있습니다. Tier C에서 `task-card.md`상 ChatGPT 생략이 승인된 경우에는 `해당 없음`으로 기록하고 final-report에 생략 근거를 남깁니다. |
| 키 보안 | OpenAI 키는 `source scripts/load_openai_key.sh`로 현재 세션 환경변수에만 로드합니다. 키 값을 채팅·로그·파일·커밋에 남기지 않습니다. |

Codex 상세 실행 절차가 필요할 때는 **Appendix A**를 참조합니다.

## 7. 장애·수정 루프 원칙

| 상황 | 원칙 |
|---|---|
| Tier A 도구 장애 | GPT, Codex, Context7, Code Simplifier, 키 로딩, 실행 증거 확보 장애 시 자동 다운그레이드하지 않습니다. |
| Tier B/C 도구 장애 | 승인된 지침이 허용할 때만 제한 진행하고 사유와 리스크를 보고합니다. |
| 수정 루프 | Tier A는 대표님 확인 후 수정하고, Tier B/C는 마누스가 최대 3회까지 자동 수정 루프를 운영할 수 있습니다. |
| 4회째 수정 | 자동 진행을 중단하고 원인, 완료분, 대안, 확인 필요 사항을 대표님께 보고합니다. |

## 8. Git·GitHub·보안 경계

| 작업 | 원칙 |
|---|---|
| git status | 작업 전후 확인합니다. |
| commit | 대표님 승인 또는 `task-card.md` 기준에 따릅니다. |
| push | 대표님 승인 없이는 금지합니다. |
| merge | 대표님 승인 없이는 금지합니다. |
| 배포 | 대표님 수동 승인·수동 트리거 영역입니다. |
| GitHub CLI | GitHub 작업은 `gh` CLI를 사용합니다. |
| 비커밋 대상 | `decision-log.jsonl`, `project-brief.json`, evidence, 민감정보 파일은 Git에 올리지 않습니다. |

## 9. 지침 변경 절차와 최종 보고

운영 지침 변경은 코드 변경보다 더 넓은 영향을 줄 수 있으므로, 대표님과 변경 목적·범위를 정렬한 뒤 `.harness/proposals/`에 초안을 작성하고, 승인된 범위만 실제 파일에 반영합니다.

마누스는 모든 태스크 종료 시 대표님께 결과물을 보고합니다. 보고에는 요청 요약, 완료 결과, 산출물 위치, 변경 파일, 검증 결과, Codex 감리 요약, ChatGPT 판정 요약, 남은 리스크, 대표님 확인 필요 사항, 다음 단계가 포함되어야 합니다.

---

# Appendix — 필요할 때만 참조하는 상세 절차

## Appendix A. Codex Gatekeeper 호출 표준 절차

> twostar-hub-rails AGENTS.md에서 검증된 절차를 기반으로 유지합니다. Codex는 Claude Code의 자체 리뷰 대체물이 아니라 외부 감리자이며, 마누스가 `handoff.md`, diff, 실행 증거를 확보한 뒤 호출합니다.

### Step 1 — 새 터미널 창 열기

```applescript
osascript << 'APPLESCRIPT'
tell application "Terminal"
  activate
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

# codex-review.md와 codex-exec.log는 gate-review.md의 원문 증거 또는 evidence 성격의 선택 파일입니다.
# 기본 필수 run 문서는 task-card.md, handoff.md, final-report.md이며, Tier A/B 또는 필요 시 gate-review.md를 작성합니다.
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

**핵심**: `codex exec - << 'PROMPT' ... PROMPT` 형식의 **heredoc stdin** 방식만 안정적으로 동작합니다.

> ⚠️ **PATH 주의**: `source ~/.zshrc`만으로는 Codex PATH가 로드되지 않을 수 있습니다. 반드시 스크립트 첫 줄에 `export PATH="/Users/twostars/.local/node/bin:$PATH"`를 명시합니다.

### Step 4 — 스크립트 실행

```applescript
osascript << 'APPLESCRIPT'
tell application "Terminal"
  activate
  do script "zsh /Users/twostars/ClaudeAi/silkroadhub/tmp/run_codex.sh" in window id WINDOW_ID
end tell
APPLESCRIPT
```

### Step 5 — 결과 확인

```bash
sleep 60 && cat /Users/twostars/ClaudeAi/silkroadhub/.harness/runs/PHASE_RUN_ID/codex-review.md
```

첫 줄은 반드시 `Status:`로 시작하거나, 해당 run에서 승인한 구조화 판정 형식을 만족해야 유효한 리뷰로 봅니다. `codex-review.md`와 `codex-exec.log`는 기본 필수 run 문서가 아니라 `gate-review.md`를 뒷받침하는 선택 증거 파일입니다. Tier A/B에서는 Codex 결과 요약을 `gate-review.md`에 기록하고, Tier C에서는 blocking·보안·맥락 불일치·실행 실패·증거 부족이 있을 때만 기록합니다.

## Appendix B. Claude Code 터미널 표준 절차

### 새 Claude Code 세션 열기

```applescript
osascript << 'APPLESCRIPT'
tell application "Terminal"
  activate
  do script "cd /Users/twostars/ClaudeAi/silkroadhub && claude"
end tell
APPLESCRIPT
```

### 터미널 창 확인 후 명령 전달

```bash
# Step 1: 창 목록 조회
osascript -e 'tell application "Terminal" to get {id, name} of every window' 2>&1

# Step 2: 대상 창에 명령 입력
osascript << 'APPLESCRIPT'
tell application "Terminal"
  activate
  do script "명령어" in window id WINDOW_ID
end tell
APPLESCRIPT
```

### 한글/특수문자 포함 명령 전달 시

한글이나 특수문자가 포함된 명령은 반드시 **파일로 저장 후 파일 경로를 전달**합니다.

```bash
cat > /Users/twostars/ClaudeAi/silkroadhub/tmp/instruction.txt << 'EOF'
영문으로만 작성된 지시문
EOF
```

## Appendix C. 터미널·리뷰 주의사항

- Claude Code 창과 Codex 창을 혼동하지 않습니다. 반드시 창 ID와 이름으로 특정합니다.
- Codex `keystroke` 방식으로 프롬프트를 직접 입력하면 특수문자가 깨집니다. 반드시 heredoc stdin 방식을 사용합니다.
- `do script`로 명령을 전달하면 새 탭이 열릴 수 있습니다. `in window id WINDOW_ID`를 반드시 지정합니다.
- Codex 리뷰 결과 첫 줄 또는 구조가 유효한 판정 형식을 만족하지 않으면 유효하지 않은 리뷰입니다.
- push, merge, 배포는 대표님 승인 없이 금지입니다.

## Imported Claude Cowork project instructions

이 프로젝트(silkroadhub)는 두별 워크플로우(Twostar Workflow, v3.3.0, 별칭 5자협업/5인 협업)를 따라 진행한다.

멤버:
- 대표님 (의사결정)
- Claude Cowork (Orchestrator, 모바일/디스패치)
- GPT-5.5 (사전·사후 자문)
- Claude Code (구현)
- Codex (외부 감리)

진행 규칙:
1. 모든 작업은 .harness/manuals/ 12개 매뉴얼을 따른다. 매뉴얼과 충돌하는 지시가 있으면 매뉴얼 우선, 충돌 사실을 대표님께 보고 후 진행.
2. Tier 분류(A/B/C)를 먼저 판정하고, Tier에 맞는 Gate(1·2) 승인 절차를 건너뛰지 않는다. Tier A는 Gate 1·2 모두, B는 Gate 1·2, C는 Gate 2만(매뉴얼 03/05 기준).
3. 워크플로 순서: brainstorming → writing-plans → TDD → executing-plans → verification → code-review → Code Simplifier → Codex 감리 → finishing. 단계 스킵 시 사유를 decision-log에 남긴다.
4. 모든 결정·도구 트리거는 .harness/decision-log.jsonl에 append-only로 기록. 각 phase 산출물은 .harness/runs/<phase-name>/에 저장.
5. Codex 감리는 codex CLI로 실행. CLI 환경 이슈 시 ~/.claude/harness/global-watchout.md의 "Codex CLI" 섹션 절차를 따른다.
6. 코드 변경은 worktree(.claude/worktrees/<name>)에서, main 머지는 Gate 2 승인 후.
7. 매뉴얼·CLAUDE.md·context.md와 충돌이 보이면 즉시 정지하고 대표님께 보고.
8. 새 phase 진입 시 brainstorming 시작 전, Cowork이 대표님과 소크라테스 문답으로 phase 의도·범위·risk를 정렬한다. 정렬 결과를 task 컨텍스트에 inject한 후 brainstorming 신호. 단순 답 확인이나 명확한 실행 지시는 문답 없이 즉시 처리.
9. 정렬된 phase 맥락 안의 기술 결정·routine Gate 통과(spec 검토·Gate 2 통과 후 Phase 3 PR 생성·자동 머지·decision-log·backlog 갱신 등)는 Cowork이 단독 진행한다. 맥락 이탈(scope 변경·새 phase 분리·blocking 자문 결과·새 결정 boundary)만 surface. 비가역 작업도 routine이면 가능하되 결과(PR URL·commit hash·dev HEAD·잔여 위험)는 즉시 surface 의무.
10. Cowork 응답 형식 — 응답 첫머리 80자 요약(큰 보고에 한정), [미확인] marker로 추론 영역 명시, 모호 단어("적당히"·"빨리" 등) 시 구체 기준 역질문, 2개 이상 데이터는 표 정리, 에러 시 원인/완료분/대안/확인 필요 사항 4단 구조, 본문 후 💡 선제 제안 별도 섹션(발견 시에만).
11. PR 머지 완료 보고 시 다음 한 줄 자동 포함: "대표님 로컬에서 운영 환경 확인하려면 cd silkroadhub && git pull origin dev 후 Start-SilkroadHub.command 재실행 필요."
12. Cowork은 명시 근거·객관 사실로만 판단한다. "추정"·"묵시"·"암묵"·"…로 보임" 같은 추론 표현으로 진행 금지. 못 본 것은 못 봤다고 명시. 대표님 발화는 가장 좁은 해석으로 받고, 다른 해석이 가능하면 묻기. 사실 확인 가능 시 추론 대신 확인 우선.
13. 운영 모델 — "두별워크플로우 전용" 세션이 silkroadhub 맥락 source(파일·매뉴얼·decision-log read-only 조회), Dispatch가 Orchestrator(task 발주·결정·메모리·대표님 응대). Dispatch가 send_message로 조회 → 두별 세션이 객관 사실만 응답. 종합 판단·발주·메모리 수정은 Dispatch에서 처리.

핵심 자료:
- .harness/manuals/ (00~10 + README)
- .harness/context.md (현재 작업 맥락)
- .harness/decision-log.jsonl (결정 로그)
- CLAUDE.md, AGENTS.md (코드베이스 지침)
