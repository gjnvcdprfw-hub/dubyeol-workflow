# G-2 증거 파일 — 01-load-sub-manual

**스킬 ID**: `01-load-sub-manual`  
**스킬 경로**: `/Users/twostars/ClaudeAi/dubyeol-workflow/01-load-sub-manual/`  
**검증 일시**: 2026-05-18  
**판정**: **PARTIAL PASS**

---

## 1. 테스트 목표

`scripts/load_sub.sh` 존재 여부, SKILL.md 정합성, 실제 실행 시 SUB 매뉴얼 경로 출력 여부 확인.
G-1 설계에서 기록된 의심 신호(`scripts/load_sub.sh` 미발견) 사실 여부 확정.

---

## 2. 전제조건 점검

| 전제조건 | 확인 결과 |
|---|---|
| 마스터 저장소 접근 가능 | ✅ `/Users/twostars/ClaudeAi/dubyeol-workflow` 접근 확인 |
| SUB 파일 존재 | ✅ `SUB-1-기획의도.md` ~ `SUB-5-종료.md` 루트에 존재 |
| 루트 `scripts/` 디렉토리 존재 | ❌ 존재하지 않음 |

---

## 3. 테스트 입력

- 스킬 호출 대상: `01-load-sub-manual` SKILL.md 분석 + `scripts/load_sub.sh` 직접 검사
- SUB 인자: `1` (SUB-1 로드 테스트)

---

## 4. 실제 수행 명령·행동

```bash
# 루트 scripts/ 디렉토리 확인
ls /Users/twostars/ClaudeAi/dubyeol-workflow/scripts/
# → "scripts/ 디렉토리 없음"

# 스킬 내부 scripts/ 확인
ls /Users/twostars/ClaudeAi/dubyeol-workflow/01-load-sub-manual/scripts/
# → load_project_md.sh  load_sub.sh

# 스크립트 존재 확인
file /Users/twostars/ClaudeAi/dubyeol-workflow/01-load-sub-manual/scripts/load_sub.sh
# → Paul Falstad's zsh script text executable

# 스크립트 주요 내용 검사
cat /Users/twostars/ClaudeAi/dubyeol-workflow/01-load-sub-manual/scripts/load_sub.sh
```

---

## 5. G-1 설계 / SKILL.md 기대 동작

1. `scripts/load_sub.sh` 또는 직접 파일 경로를 지정한다.
2. 지정된 경로의 매뉴얼이 세션 컨텍스트에 로드된다.
3. 로드 성공 메시지 또는 파일 내용이 출력된다.

SKILL.md 호출 방식:
```bash
bash scripts/load_sub.sh 1
```
(암시적으로 스킬 디렉토리에서 실행 또는 루트에 scripts/ 존재 가정)

---

## 6. 실제 결과

### 6.1 스크립트 위치

| 항목 | 기대 | 실제 |
|---|---|---|
| 루트 `scripts/load_sub.sh` | 존재 (SKILL.md 표기 기준) | ❌ **없음** |
| `01-load-sub-manual/scripts/load_sub.sh` | — | ✅ **존재** |

### 6.2 스크립트 내용 분석

```
REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"   ← 하드코딩 경로
```

**결함 1**: `REPO_ROOT`가 `/Users/twostars/ClaudeAi/silkroadhub`로 하드코딩됨.  
`dubyeol-workflow` 마스터에서 호출 시 silkroadhub의 SUB 파일을 참조하려 시도.

```
SUB_FILES[1]="SUB-1-기획의도.md"
FULL_PATH="${REPO_ROOT}/${FILE}"
```

**결함 2**: 스크립트는 경로 출력 + `head -30` 미리보기만 수행. SKILL.md에서 "전체 파일 읽음 (cat·view)"을 요구하지만 스크립트는 미리보기만 제공하고 전체 로드는 수동 단계로 남김.

### 6.3 G-1 의심 신호 확정

G-1에서 기록한 "scripts/load_sub.sh 미발견" 의심 신호는 **부분적으로 확인됨**:
- 루트 `scripts/` 디렉토리가 없어서 `scripts/load_sub.sh`를 루트에서 찾을 수 없음 → **사실**
- 스크립트 자체는 `01-load-sub-manual/scripts/load_sub.sh`에 **존재함**
- G-1에서 "스크립트가 없다"고 의심했으나 실제로는 "위치가 다르고 경로 하드코딩 결함이 있음"

---

## 7. 판정: PARTIAL PASS

| 점검 항목 | 결과 |
|---|---|
| SKILL.md 존재 | ✅ |
| 스크립트 파일 존재 (`01-load-sub-manual/scripts/load_sub.sh`) | ✅ |
| 루트 `scripts/load_sub.sh` 참조 경로 일치 | ❌ **FAIL** |
| `REPO_ROOT` 경로 정합성 (dubyeol-workflow 기준) | ❌ **FAIL** (silkroadhub 하드코딩) |
| SUB 파일 로드 전체 동작 | ❌ **FAIL** (미리보기만, silkroadhub 경로) |
| SKILL.md 호출 방식 명확성 | ⚠️ **WARN** (실행 디렉토리 미명시) |

---

## 8. 결함 상세 및 의존성 영향

### 결함 목록

1. **[DEFECT-01-A] REPO_ROOT 하드코딩**: `scripts/load_sub.sh` 내 `REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"`. dubyeol-workflow에서 독립 실행 불가. → r7 정비 대상
2. **[DEFECT-01-B] 호출 경로 비명시**: SKILL.md가 `bash scripts/load_sub.sh 1`로 안내하지만, 이는 `01-load-sub-manual/` 디렉토리에서 실행해야 정확. 루트에서는 `bash 01-load-sub-manual/scripts/load_sub.sh 1`이 맞음.
3. **[DEFECT-01-C] 전체 로드 미수행**: 스크립트가 `head -30`만 출력. 마누스가 별도로 `cat <path>` 실행 필요.

### 의존성 영향

- `02-create-task-card` ~ `09-update-project-md` 모든 스킬도 동일한 `REPO_ROOT` 하드코딩 패턴이 예상됨 → 연쇄 PARTIAL PASS 예상
- `01-load-sub-manual` 스크립트 결함이 있어도 마누스가 수동으로 SUB 파일을 읽어 운영 중이므로 실 운영 차단은 아님

---

## 9. 증거 스니펫

```bash
# 확인 1: 루트 scripts/ 없음
$ ls /Users/twostars/ClaudeAi/dubyeol-workflow/scripts/
→ "scripts/ 디렉토리 없음"

# 확인 2: 스킬 내부 scripts/ 있음
$ ls /Users/twostars/ClaudeAi/dubyeol-workflow/01-load-sub-manual/scripts/
load_project_md.sh  load_sub.sh

# 확인 3: 스크립트 REPO_ROOT 확인
$ grep "REPO_ROOT" /Users/twostars/ClaudeAi/dubyeol-workflow/01-load-sub-manual/scripts/load_sub.sh
REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"

# 확인 4: dubyeol-workflow에 SUB 파일 실제 존재
$ ls /Users/twostars/ClaudeAi/dubyeol-workflow/SUB-*.md
SUB-1-기획의도.md  SUB-2-워크플로우.md  SUB-3-외부감리.md  SUB-4-수정.md  SUB-5-종료.md

# 확인 5: silkroadhub SUB 파일 확인 (스크립트가 찾아가는 경로)
$ ls /Users/twostars/ClaudeAi/silkroadhub/SUB-*.md (별도 확인 필요 — Builder 접근 제한)
```

---

**G-2 우선 검증 결론**: G-1 의심 신호 확정. `load_sub.sh`는 존재하나 silkroadhub 경로 하드코딩으로 dubyeol-workflow 독립 실행 불가. r7 정비 대상.
