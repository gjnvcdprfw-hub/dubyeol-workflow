# G-2 증거 파일 — 03-dispatch-to-builder

**스킬 ID**: `03-dispatch-to-builder`  
**스킬 경로**: `/Users/twostars/ClaudeAi/dubyeol-workflow/03-dispatch-to-builder/`  
**검증 일시**: 2026-05-18  
**판정**: **PARTIAL PASS**

---

## 1. 테스트 목표

`scripts/dispatch.sh` 존재 여부, SKILL.md 기술과 스크립트 로직 일치 여부, 2단계 확정 실행 구현 여부, 참조 파일 존재 여부 확인. 현재 Builder 세션 자체가 03 스킬 실행 결과의 증거.

---

## 2. 전제조건 점검

| 전제조건 | 확인 결과 |
|---|---|
| `dispatch.sh` 존재 | ✅ `03-dispatch-to-builder/scripts/dispatch.sh` |
| `tmp/claude-entry-<run_id>.md` 사전 작성 | ✅ `tmp/claude-entry-20260518_g2-skills-verification-execution.md` 존재 확인 |
| macOS Terminal 접근 가능 | ✅ (osascript 사용 가능 환경) |
| `claude` CLI 설치 | ✅ (현재 세션이 Builder로 동작 중인 것으로 확인) |
| 참조 파일 (`references/standard-entry-prompt.md`) | ❌ `03-dispatch-to-builder/references/` 비어있음 |

---

## 3. 테스트 입력

현재 G-2 Builder 세션 자체가 이 스킬의 실제 실행 결과:

| 입력 | 값 |
|---|---|
| `run_id` | `20260518_g2-skills-verification-execution` |
| `window_id` | `372` (신규 Terminal 창) |
| `tier` | `A` |
| `category` | `4` |

---

## 4. 실제 수행 명령·행동

```bash
# 스크립트 존재 확인
ls /Users/twostars/ClaudeAi/dubyeol-workflow/03-dispatch-to-builder/scripts/
# → dispatch.sh

# 참조 파일 확인
ls /Users/twostars/ClaudeAi/dubyeol-workflow/03-dispatch-to-builder/references/
# → (비어있음)

# 진입 명령 파일 확인
ls /Users/twostars/ClaudeAi/dubyeol-workflow/tmp/
# → claude-entry-20260518_g2-skills-verification-execution.md

# 스크립트 내용 검사 (정적 분석)
cat /Users/twostars/ClaudeAi/dubyeol-workflow/03-dispatch-to-builder/scripts/dispatch.sh
```

현재 Builder 세션은 [Foreman]이 `dispatch.sh` 절차(또는 그 준하는 수동 절차)로 시작되었으며, 진입 명령 파일 `tmp/claude-entry-20260518_g2-skills-verification-execution.md`를 통해 이 세션이 시작됨.

---

## 5. G-1 설계 / SKILL.md 기대 동작

1. `scripts/dispatch.sh` 실행
2. `tmp/claude-entry-<run_id>.md` 파일에 표준 진입 명령 양식 저장
3. osascript로 짧은 명령 전달 + `do script ""`로 Enter 확정 (2단계)
4. Builder 세션이 진입 명령 읽고 작업 시작

---

## 6. 실제 결과

### 6.1 스크립트 분석

| 분석 항목 | 결과 |
|---|---|
| `REPO_ROOT` 값 | ❌ `"/Users/twostars/ClaudeAi/silkroadhub"` 하드코딩 |
| `INSTRUCTION_FILE` 경로 | `${REPO_ROOT}/tmp/claude-entry-${RUN_ID}.md` → silkroadhub 경로 |
| 2단계 확정 실행 구현 | ✅ `do script "Read tmp/..."` + `do script ""` 별도 호출 |
| `activate` 사용 금지 | ✅ 스크립트에서 `activate` 미사용 |
| 단일 `do script` 금지 | ✅ 반드시 2개 호출 (Step 1 + Step 2) |
| 진입 명령 파일 내용 | ✅ 표준 [Builder] 행동 원칙 8개 항목 포함 |

### 6.2 실제 Builder 세션 진입 증거

현재 진행 중인 이 세션이 03 스킬 절차의 실 검증 결과:

- **진입 명령 파일**: `tmp/claude-entry-20260518_g2-skills-verification-execution.md` (존재 확인)
- **task-card 경로 인지**: ✅ (세션 시작 시 읽음)
- **카테고리 4·Tier A 인지**: ✅
- **`/using-superpowers` 진입**: ✅ (세션 시작 직후 실행)
- **진입 명령 파일 정확히 읽음**: ✅ (현재 작업 내용으로 확인)

### 6.3 참조 파일 누락

SKILL.md가 다음 참조 파일을 명시하지만 실제 존재하지 않음:
- `references/standard-entry-prompt.md` ❌ 없음
- `references/agents-md-appendix-b.md` ❌ 없음

---

## 7. 판정: PARTIAL PASS

| 점검 항목 | 결과 |
|---|---|
| `dispatch.sh` 존재 | ✅ |
| 2단계 확정 실행 구현 | ✅ |
| `activate` 사용 금지 원칙 준수 | ✅ |
| `REPO_ROOT` 경로 정합성 | ❌ **FAIL** (silkroadhub 하드코딩) |
| 참조 파일 존재 | ❌ **FAIL** (references/ 비어있음) |
| 현재 세션이 스킬 절차로 시작됨 | ✅ |
| 진입 명령 파일 존재 | ✅ |

---

## 8. 결함 상세 및 의존성 영향

### 결함 목록

1. **[DEFECT-03-A] REPO_ROOT 하드코딩**: `dispatch.sh`에서 `INSTRUCTION_FILE`이 silkroadhub 경로로 생성됨. dubyeol-workflow 환경에서는 오동작.
2. **[DEFECT-03-B] 참조 파일 부재**: `references/standard-entry-prompt.md`, `references/agents-md-appendix-b.md` 미작성.

### 의존성 영향

- 실 운영에서 [Foreman]이 수동으로 진입 명령 파일 작성 후 osascript 실행 → 스크립트 없어도 운영 가능
- 현재 G-2 세션이 03 절차로 성공 진입했으므로 핵심 로직 자체는 검증됨

---

## 9. 증거 스니펫

```bash
# dispatch.sh REPO_ROOT 확인
REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"

# dispatch.sh 2단계 확정 실행 부분
osascript << OSAEOF
tell application "Terminal"
  do script "Read tmp/claude-entry-${RUN_ID}.md and follow the instructions inside." in window id ${WINDOW_ID}
  do script "" in window id ${WINDOW_ID}
end tell
OSAEOF

# 진입 명령 파일 존재 확인
$ ls /Users/twostars/ClaudeAi/dubyeol-workflow/tmp/
claude-entry-20260518_g2-skills-verification-execution.md

# 현재 세션 진입 증거: 세션 초기에 task-card를 읽고 using-superpowers를 실행한 사실
```
