# handoff 검증 — 6개 항목 상세

본 문서는 `verify_handoff.sh`가 자동 실행하는 *6개 검증 항목의 git 명령·해석 기준*.

## A. git push 흔적 점검

**목적**: [Builder]가 로컬 commit 외 *push 시도*했는지 검출.

**명령**:
```bash
# 로컬과 원격 HEAD 차이 확인
cd /Users/twostars/ClaudeAi/silkroadhub
git fetch origin
git log origin/HEAD..HEAD --oneline 2>&1
git log HEAD..origin/HEAD --oneline 2>&1
```

**해석**:
- 로컬 → 원격: push 발생 의심
- reflog에 `push` 또는 `force-update` 흔적

**판정**:
- 차이 없음 + reflog 정상 → **PASS**
- 차이 있음 + reflog에 push → **FAIL** (즉시 [Owner] 보고)

## B. 파괴적 git 명령 흔적

**목적**: `reset --hard`, `rebase -i`, `push --force`, `branch -D` 흔적 검출.

**명령**:
```bash
git reflog | head -30
```

**해석**:
- `reset: moving to ...` (--hard 의심)
- `rebase ...`
- `branch -D <name>` 또는 `forced-update`

**판정**:
- task 진행 중 *예상치 못한* 파괴적 명령 → **FAIL**
- 정상 commit·checkout만 → **PASS**

## C. 운영 문서 변경 점검

**목적**: AGENTS.md·CLAUDE.md·PROJECT.md·.harness/templates/* 무단 변경 검출.

**명령**:
```bash
git diff HEAD --name-only | grep -E "^(AGENTS\.md|CLAUDE\.md|PROJECT\.md|\.harness/templates/)"
git log <start_commit>..HEAD --name-only --pretty=format: | sort -u | grep -E "^(AGENTS\.md|CLAUDE\.md|PROJECT\.md|\.harness/templates/)"
```

**판정**:
- 변경 없음 → **PASS**
- task-card §8에 *명시 허용된 변경*만 → **PASS**
- 미명시 변경 → **FAIL**

## D. scope 침범 점검

**목적**: task-card §5.2 *제외 범위* 파일이 변경됐는지 검출.

**명령**:
```bash
# task-card §5.2 제외 범위를 *별도 파일*에 추출 후 패턴 매칭
EXCLUDE_PATTERNS=$(grep -A 20 "§5.2" .harness/runs/<run_id>/task-card.md | grep "^- ")
CHANGED_FILES=$(git diff HEAD --name-only)
# 두 목록 교집합 확인
```

**판정**:
- 교집합 없음 → **PASS**
- 교집합 있음 → **FAIL**

## E. 마스킹 위반 점검

**목적**: 운송장·BL·HBL·MBL·CLP·개인통관고유부호·OpenAI 키 등 *원본 노출* 검출.

**명령**:
```bash
# commit 메시지
git log <start_commit>..HEAD --pretty=format:"%B" | grep -E "P[0-9]{12}|sk-[A-Za-z0-9]{20,}|[0-9]{10,14}" || echo "OK"
# 코드 안 노출
git diff HEAD | grep -E "P[0-9]{12}|sk-[A-Za-z0-9]{20,}" || echo "OK"
```

**패턴 (silkroadhub 도메인)**:
- `P[0-9]{12}` — 개인통관고유부호
- `sk-[A-Za-z0-9]{20,}` — OpenAI 키
- `[0-9]{10,14}` *맥락 검토* — 운송장 가능성
- `(BL|HBL|MBL|CLP)[A-Z0-9]+` — BL 번호

**판정**:
- 모두 OK → **PASS**
- 패턴 적중 + 마스킹 안 됨 → **FAIL** (history rewrite 검토)

## F. handoff §1 의도 정렬 대조

**목적**: handoff §1 의도 정렬 증거 블록이 task-card §3과 *항목별 1:1 매칭*되는지.

**명령**:
```bash
# task-card §3와 handoff §1 항목 추출 후 대조
TC=$(awk '/^## §3/,/^## §4/' .harness/runs/<run_id>/task-card.md)
HO=$(awk '/^## §1/,/^## §2/' .harness/runs/<run_id>/handoff.md)
# 항목 수·키워드 대조
```

**해석**:
- 한 문장 목표 / Looks Like / Looks Wrong / 가정 *모두* handoff에 인용·검증되어 있는가?
- handoff §1.3에 "가정 X 검증 결과" 항목 있는가?

**판정**:
- 모두 매칭 + 검증 결과 명시 → **PASS**
- 일부 누락 → **WARN**
- 매칭 무시 + 자체 의도로 진행 → **FAIL**

## 결과 종합표 양식

```
| 항목 | 결과 | 상세 |
|---|---|---|
| A. git push 흔적 | PASS / WARN / FAIL | [한 줄] |
| B. 파괴적 git 명령 | PASS / WARN / FAIL | [한 줄] |
| C. 운영 문서 변경 | PASS / WARN / FAIL | [한 줄] |
| D. scope 침범 | PASS / WARN / FAIL | [한 줄] |
| E. 마스킹 위반 | PASS / WARN / FAIL | [한 줄] |
| F. 의도 정렬 대조 | PASS / WARN / FAIL | [한 줄] |
```

저장: `.harness/runs/<run_id>/handoff-verification.md`

## 한계 — 자동 검증의 *형식적 성격*

자동 검증은 *형식적 신호*만 잡음. 다음은 *마누스 판단 영역*:

- handoff가 *겉으로는 의도 정렬*하지만 *실제로는 다른 방향* — 자동 검증 PASS이지만 *실패한 task*
- 코드 변경이 *task-card 범위 안*이지만 *과도하거나 부족함* — 마누스 의미 판단 필요
- 마스킹 패턴이 *정규식에서 누락된 새 패턴* — 마누스가 도메인 지식으로 점검

→ **자동 검증 PASS = *최소 안전선 통과*. *완전 통과 아님*.** 마누스 추가 점검 필수.
