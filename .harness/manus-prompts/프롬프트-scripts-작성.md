# 마누스 task 프롬프트 — scripts/ 표준 호출 스크립트 작성

> 이 문서는 [Owner]가 마누스에게 전달하는 task 프롬프트.
> 두별 워크트리 카테고리: **4 (문서·운영)**
> Tier: **B** (내부 도구 표준화, 외부 시스템 영향 없음)
> r6 매뉴얼·CLAUDE.md 갱신 *후* 진행. AGENTS.md §7.2가 가리키는 표준 스크립트 4개 작성.

---

## task 개요

**목표**: `silkroadhub/scripts/` 폴더에 외부 도구 호출(Codex, ChatGPT) 표준 스크립트 4개 작성. 매번 osascript·heredoc 새로 짜는 *왔다갔다 현상* 제거.

**배경**: r5 시절 Codex 호출 절차는 AGENTS.md Appendix A에 있었으나 매번 미세하게 다른 방식으로 호출됨. r6에서 표준 스크립트로 고정.

**범위**:
1. 현재 환경 조사
2. 표준 스크립트 4개 설계·작성
3. 동작 테스트 (실제 호출 한 번)
4. AGENTS.md §7.2 표를 갱신해서 *베타* 표시 제거 → *운영* 표시로

**제외**: 기존 호출 코드 수정·일괄 마이그레이션. 본 task는 *스크립트 작성·검증까지*.

---

## Step 1 — 환경 조사

추측 금지. 직접 명령어 실행해서 확인.

### 1.1 Codex 환경

```bash
which codex
codex --version
codex exec --help 2>&1 | head -30
echo $PATH | tr ':' '\n' | grep -i node
```

### 1.2 ChatGPT API 호출 환경

```bash
# OpenAI CLI 또는 SDK 확인
which openai 2>/dev/null && openai --version 2>&1 | head -3
pip show openai 2>/dev/null | head -3
python3 -c "import openai; print('openai version:', openai.__version__)" 2>/dev/null

# 키 로딩
ls -la scripts/load_openai_key.sh
source scripts/load_openai_key.sh && echo "${OPENAI_API_KEY:0:7}"   # 첫 7글자만

# curl·jq
which curl && curl --version | head -1
which jq && jq --version

# 과거 호출 흔적
grep -r "gpt-5.5\|chatgpt\|invoke" .harness/ scripts/ 2>/dev/null | head -20
```

### 1.3 Claude Code 환경

```bash
which claude
claude --version
```

### 1.4 osascript·macOS

```bash
osascript -e 'tell application "Terminal" to get {id, name} of every window' 2>&1
sw_vers
```

### 1.5 산출

위 결과를 `.harness/runs/<run_id>/scripts-env-survey.md`에 표 형식 기록.

**마스킹 의무**: OpenAI 키는 *첫 7글자만*. 다른 비밀값 출력 금지.

---

## Step 2 — 표준 스크립트 4개 설계

각 스크립트의 동작 명세를 *먼저 명세*로 박고, 코드 작성은 그 다음.

### 2.1 `scripts/invoke_codex.sh`

**용도**: Codex 호출 표준화 (Gate 또는 Review)

**호출 형식**:
```bash
scripts/invoke_codex.sh <run_id> <prompt_file>
```

**입력**:
- `$1` run_id (예: `20260516_manifest-save-fix`)
- `$2` prompt 파일 경로 (예: `.harness/runs/<run_id>/codex-prompt.md`)

**동작**:
1. PATH 보정 — `export PATH="/Users/twostars/.local/node/bin:$PATH"`
2. 작업 디렉터리 이동 — `cd /Users/twostars/ClaudeAi/silkroadhub`
3. run 디렉터리 자동 생성 (`mkdir -p .harness/runs/$1`)
4. `codex exec --sandbox read-only --output-last-message` heredoc stdin 호출
5. 응답 → `.harness/runs/$1/reviewer-raw.md` 저장
6. 로그 → `.harness/runs/$1/codex-exec.log` 저장
7. exit code 반환

**실패 모드**:
- prompt 파일 없음 → exit 1, "prompt file not found: $2"
- codex CLI 없음 → exit 2, "codex CLI not in PATH"
- run 디렉터리 생성 실패 → exit 3

### 2.2 `scripts/invoke_chatgpt_gate.sh`

**용도**: ChatGPT Gate Judge 호출 (진행/수정/보류/중단 판정)

**호출 형식**:
```bash
scripts/invoke_chatgpt_gate.sh <run_id> <prompt_file>
```

**동작**: Step 1 환경 조사 결과에 따라 셋 중 택일:
- **옵션 A — curl 직접**: `POST https://api.openai.com/v1/chat/completions`, `model=gpt-5.5`, `temperature 파라미터 생략`, max_tokens 4000
- **옵션 B — openai CLI**: 마누스 환경에 있으면 우선
- **옵션 C — Python 스크립트**: openai Python 패키지 사용

**핵심 제약**:
- `temperature=0` 미지원 → temperature 파라미터 *생략* (값 안 박음)
- OpenAI 키는 *환경변수로만*. 스크립트에 하드코딩 절대 금지
- 응답 → `.harness/runs/$1/chatgpt-gate.md` 저장
- 메타데이터(model, token 사용량) 응답 끝에 부록으로

**실패 모드**:
- 키 미로딩 (`OPENAI_API_KEY` 비어있음) → exit 1, "load OPENAI_API_KEY first: source scripts/load_openai_key.sh"
- 네트워크 오류 → exit 2, 로그 보존
- rate limit (429) → exit 3, 60초 후 재시도 안내

### 2.3 `scripts/invoke_chatgpt_advocate.sh`

**용도**: ChatGPT Devil's Advocate 호출 (반대 논리·리스크 제시)

**입력·동작**: §2.2와 동일. *프롬프트 처리만 다름*. 응답 → `.harness/runs/$1/chatgpt-advocate.md` 저장.

**의문**: gate.sh와 advocate.sh를 분리할지, 하나로 합치고 모드 파라미터 분기할지? — 마누스가 환경 조사 후 결정. 분리하는 게 호출자에 명확하지만 코드 중복. *결정 결과를 handoff §3에 사유 명시*.

### 2.4 `scripts/open_claude_code.sh`

**용도**: Claude Code 새 세션 열기 + 명령 전달 표준화 (AGENTS.md Appendix B 검증 결과 반영)

**호출 형식**:
```bash
scripts/open_claude_code.sh                          # 빈 세션
scripts/open_claude_code.sh <instruction_file>       # 즉시 지시 전달
```

**동작**:
1. osascript로 새 Terminal 창 열기 — **`activate` 사용 금지** (검증 발견 2026-05-16)
2. `cd /Users/twostars/ClaudeAi/silkroadhub && claude` 실행
3. instruction_file 인자 있으면:
   - 파일 경로 읽으라는 짧은 명령 전달
   - **2단계 확정 실행 의무** — `do script "..."` 후 `do script ""`로 Enter 확정 (검증 발견 2026-05-16)
4. 창 ID·이름 반환 (마누스가 이후 명령 전달 시 사용)

**한글·특수문자 명령 전달 시**: 마누스가 *파일로 저장 후 경로*만 전달. 직접 keystroke 금지.

**[Builder] 자동 제안 처리**: Claude Code가 task 완료 후 *task-card 범위 밖 행동을 자동 제안*하면 (예: git commit 입력 필드 자동 채움), 마누스는 이를 명령으로 해석하지 않는다. 스크립트가 *자동 제안을 명령으로 실행하지 않도록* 보장.

---

## Step 3 — 스크립트 작성

§2 명세 따라 작성. 작성 후 *각 스크립트에 docstring 형태 헤더* 박음:

```bash
#!/bin/zsh
# scripts/invoke_codex.sh — Codex 표준 호출 (두별 워크플로우 v3.6.0 r1 베타)
# 호출: $0 <run_id> <prompt_file>
# 출력: .harness/runs/<run_id>/reviewer-raw.md
# 로그: .harness/runs/<run_id>/codex-exec.log
# 작성: <마누스>, <YYYY-MM-DD>
```

권한: `chmod +x scripts/*.sh`

---

## Step 4 — 동작 검증

작성 후 *실제 호출 한 번* 수행:

### 4.1 Codex 호출 테스트

```bash
mkdir -p .harness/runs/test_codex_invoke
cat > .harness/runs/test_codex_invoke/codex-prompt.md << 'EOF'
Status: TEST
Simple test of standardized codex invocation. Respond with "Status: OK" and one sentence.
EOF
scripts/invoke_codex.sh test_codex_invoke .harness/runs/test_codex_invoke/codex-prompt.md
cat .harness/runs/test_codex_invoke/reviewer-raw.md
```

응답이 정상 수신되면 통과.

### 4.2 ChatGPT Gate 테스트

```bash
mkdir -p .harness/runs/test_gate_invoke
cat > .harness/runs/test_gate_invoke/gate-prompt.md << 'EOF'
You are a test gate. Respond with: "Status: PASS" and one sentence acknowledging this is a connectivity test.
EOF
source scripts/load_openai_key.sh
scripts/invoke_chatgpt_gate.sh test_gate_invoke .harness/runs/test_gate_invoke/gate-prompt.md
cat .harness/runs/test_gate_invoke/chatgpt-gate.md
```

### 4.3 Advocate 테스트
동상.

### 4.4 Claude Code 세션 테스트
```bash
scripts/open_claude_code.sh
# Terminal 창이 열리고 claude REPL 진입되는지 확인
```

---

## Step 5 — handoff·AGENTS.md 갱신 요청

### 5.1 handoff 작성

`.harness/runs/<run_id>/handoff.md`에 다음 기록:
- 환경 조사 결과 요약 (§1)
- 선택한 호출 방식 (curl / openai CLI / Python) + 사유
- 작성된 스크립트 4개 경로
- 검증 결과 (§4 응답 캡처)
- gate.sh와 advocate.sh 분리·통합 결정 + 사유

### 5.2 AGENTS.md §7.2 갱신 제안 (실제 변경은 [Owner] 승인 후)

scripts/ 작성 완료 후 AGENTS.md §7.2 표의 "베타 (마누스 작성 예정)" 표기를 *작성 완료 일자*로 변경 제안:

```markdown
| 도구 | 스크립트 | 비고 |
|---|---|---|
| Codex | `scripts/invoke_codex.sh <run_id> <prompt_file>` | 작성 완료 YYYY-MM-DD |
| ChatGPT Gate Judge | `scripts/invoke_chatgpt_gate.sh <run_id> <prompt_file>` | 작성 완료 YYYY-MM-DD |
| ChatGPT Devil's Advocate | `scripts/invoke_chatgpt_advocate.sh <run_id> <prompt_file>` | 작성 완료 YYYY-MM-DD |
| Claude Code 새 세션 | `scripts/open_claude_code.sh` | 작성 완료 YYYY-MM-DD |
| OpenAI 키 로드 | `scripts/load_openai_key.sh` | 기존 |
```

AGENTS.md 실제 변경은 [Owner] 명시 승인 후 별도 commit.

---

## 권한·금지

- 본 task로 변경되는 것: `scripts/` 폴더의 4개 신규 파일 + AGENTS.md §7.2 (별도 승인 후)
- **AGENTS.md 변경 실제 commit은 [Owner] 명시 승인 후** ([Owner] 명시 승인 = SUB-5 §7.6 안전 행동)
- scripts/ 작성 자체는 코드 변경이 아닌 *도구 추가*. 권한 천장 §3 (파괴적 git 명령) 위반 없음
- OpenAI 키 하드코딩 절대 금지. 키 로그·commit 메시지·handoff 노출 절대 금지
- 동작 검증 시 실제 호출 비용 발생 — 최소 호출 1회씩만

---

## 검증 통과 조건

- [ ] §1 환경 조사 완료, scripts-env-survey.md 작성
- [ ] §2 명세 4건 작성
- [ ] §3 스크립트 4개 작성, `chmod +x` 적용
- [ ] §4 동작 검증 4건 통과
- [ ] §5.1 handoff 작성
- [ ] §5.2 AGENTS.md 갱신안 제안

---

**프롬프트 끝.**

본 프롬프트의 의문점·환경 차이 발견 시 마누스가 [Owner]에 확인 후 진행.
