# sync 설계서: sync-to-client.sh 설계

**run ID**: 20260518_skills-policy-and-sync-design  
**작성일시**: 2026-05-18 KST  
**작성자**: [Builder] (클로드코드)  
**상태**: 초안 (SUB-3 감리 전)  
**대상**: 구현 task 입력용 설계서 (본 문서에서 스크립트를 구현하지 않음)

---

## 1. 명령 인터페이스

### 1.1 기본 사용법

```
./sync-to-client.sh <client-path> [options]
```

| 인자·옵션 | 필수 여부 | 설명 |
|---|---|---|
| `<client-path>` | 필수 | 클라이언트 저장소 절대 경로 (예: `/Users/twostars/ClaudeAi/silkroadhub`) |
| `--dry-run` | 선택 | 실제 복사 없이 대상 파일 목록만 출력 |
| `--force` | 선택 | 충돌 경고 무시 후 진행 (기본값: 충돌 시 중단) |
| `--client-name <name>` | 선택 | sync 보고서에 표시할 클라이언트 이름 |
| `--help` | 선택 | 사용법 출력 |

### 1.2 실행 예시

```bash
# 1단계: dry-run으로 변경 사항 확인
./sync-to-client.sh /Users/twostars/ClaudeAi/silkroadhub --dry-run

# 2단계: [Owner] 검토 후 실제 sync 실행
./sync-to-client.sh /Users/twostars/ClaudeAi/silkroadhub --client-name silkroadhub
```

### 1.3 종료 코드

| 코드 | 의미 |
|---|---|
| `0` | 성공 (또는 dry-run 완료) |
| `1` | 인자 오류 또는 경로 검증 실패 |
| `2` | 충돌 감지, 중단 |
| `3` | 검증 실패 (비밀 파일 감지 등) |
| `127` | 필수 도구 누락 (`rsync` 등) |

---

## 2. Dry-run 모드 설계

### 2.1 목적

실제 파일을 복사하기 전 [Owner] 또는 운영자가 변경 사항을 검토할 수 있도록 한다.

### 2.2 동작 설계

- `--dry-run` 플래그 지정 시 `rsync --dry-run`으로 실행한다.
- 복사될 파일 목록, 삭제될 파일 목록, 총 파일 수를 출력한다.
- 출력 예시:
  ```
  [DRY-RUN] sync-to-client.sh → /path/to/client
  복사 예정 파일: 42개
    + 01-load-sub-manual/SKILL.md
    + 01-load-sub-manual/scripts/load_sub.sh
    ...
  삭제 예정 파일: 0개 (--delete 비활성화)
  제외 파일: .env, .harness/runs/**, tmp/**
  
  실제 sync를 실행하려면 --dry-run 없이 다시 실행하세요.
  ```
- 스크립트는 dry-run 결과를 `.harness/runs/<run-id>/sync-report-dryrun-<timestamp>.md`에 저장하는 것을 권고한다.

### 2.3 권장 워크플로우

1. dry-run 실행 → 보고서 검토
2. [Owner] 승인
3. 실제 sync 실행
4. 검증 수행

---

## 3. 클라이언트 경로 검증 설계

### 3.1 검증 항목 (순서 중요)

| 순서 | 검증 항목 | 실패 시 행동 |
|---|---|---|
| 1 | `<client-path>` 인자 제공 여부 | 사용법 출력 후 exit 1 |
| 2 | 경로가 존재하는가 (`test -d`) | 오류 메시지 후 exit 1 |
| 3 | `.git` 디렉토리가 존재하는가 | 오류 메시지 후 exit 1 |
| 4 | 마스터 경로와 동일하지 않은가 | 오류 메시지 후 exit 1 |
| 5 | 경로가 비어있지 않은가 (`/` 또는 `~`) | 오류 메시지 후 exit 1 |
| 6 | 금지 경로 목록에 포함되지 않는가 | 오류 메시지 후 exit 1 |

### 3.2 금지 경로 목록

다음 경로는 클라이언트 경로로 지정할 수 없다:
- 마스터 저장소 경로 자체 (`MASTER_ROOT`)
- `/` (시스템 루트)
- `~` 또는 `$HOME` (홈 디렉토리)
- `/tmp` 및 하위 경로
- 환경변수 `SYNC_FORBIDDEN_PATHS`로 추가 지정 가능

### 3.3 검증 메시지 설계

```
[ERROR] 클라이언트 경로가 존재하지 않습니다: /path/to/client
[ERROR] 클라이언트 경로에 .git 디렉토리가 없습니다. git 저장소인지 확인하세요.
[ERROR] 클라이언트 경로가 마스터 저장소와 동일합니다. 자기 자신에게 sync할 수 없습니다.
[ERROR] 위험한 경로입니다: /. 지정 가능한 경로가 아닙니다.
```

---

## 4. Sync 원본·대상 테이블

| 원본 (마스터) | 대상 (클라이언트) | 설명 |
|---|---|---|
| `01-load-sub-manual/` | `01-load-sub-manual/` | 스킬 전체 (SKILL.md + scripts/) |
| `02-create-task-card/` | `02-create-task-card/` | 스킬 전체 |
| `03-dispatch-to-builder/` | `03-dispatch-to-builder/` | 스킬 전체 |
| `04-invoke-plan-review/` | `04-invoke-plan-review/` | 스킬 전체 |
| `05-verify-handoff/` | `05-verify-handoff/` | 스킬 전체 |
| `06-invoke-reviewer/` | `06-invoke-reviewer/` | 스킬 전체 |
| `07-invoke-judge/` | `07-invoke-judge/` | 스킬 전체 |
| `08-write-final-report/` | `08-write-final-report/` | 스킬 전체 |
| `09-update-project-md/` | `09-update-project-md/` | 스킬 전체 |
| `.harness/templates/` | `.harness/templates/` | 공통 템플릿 |
| `.harness/manuals/` | `.harness/manuals/` | 운영 매뉴얼 |
| `.env.template` | `.env.template` | 환경변수 템플릿 (키 값 없음) |

### 4.1 명시적 비 sync 대상

| 항목 | 이유 |
|---|---|
| `.harness/runs/` | 클라이언트 고유 운영 이력 |
| `tmp/` | 임시 작업 파일 |
| `.env`, `.env.*` | 키 자료 포함 가능 |
| `scripts/load_openai_key.sh` 류 | 키 로더 파일 |
| `CLAUDE.md` (마스터 전용 설정) | 클라이언트 자체 CLAUDE.md가 있음 |
| `PROJECT.md` | 클라이언트 고유 프로젝트 문서 |
| `*.log` | 로그 파일 |
| `.git/` | git 내부 데이터 |

---

## 5. 제외 규칙 설계

### 5.1 필수 제외 패턴

rsync `--exclude` 또는 `--exclude-from` 파일로 관리한다.

```
# 비밀·키 자료
.env
.env.*
*.env
*key*
*secret*
*credentials*
*password*
*token*

# 클라이언트 고유 자료
.harness/runs/
tmp/
*.log
*.tmp

# git 내부
.git/
.gitmodules

# OS/편집기
.DS_Store
*.swp
*.swo
__pycache__/
*.pyc
node_modules/
```

### 5.2 제외 파일 관리

제외 패턴은 마스터 측 `.harness/sync-exclude.txt`에 관리한다. `sync-to-client.sh`는 이 파일을 `rsync --exclude-from`으로 사용한다.

---

## 6. rsync 설계

### 6.1 권장 rsync 명령 설계

```bash
rsync \
  --archive \           # -a: 재귀, 권한, 타임스탬프, 심볼릭링크 보존
  --verbose \           # 복사 파일 목록 출력
  --human-readable \    # 사람이 읽기 쉬운 크기 표시
  --checksum \          # 크기+타임스탬프 대신 체크섬 비교 (정확도 우선)
  --exclude-from="$MASTER_ROOT/.harness/sync-exclude.txt" \
  [--dry-run] \         # dry-run 모드 시 추가
  "$MASTER_ROOT/" \
  "$CLIENT_ROOT/"
```

### 6.2 `--delete` 정책

| 옵션 | 의미 | 권고 |
|---|---|---|
| `--delete` 없음 (기본) | 마스터에 없는 클라이언트 파일을 보존 | **기본값으로 권고** — 안전, 클라이언트 고유 파일 보존 |
| `--delete` 활성화 | 마스터에 없는 파일을 클라이언트에서 삭제 | 스킬 디렉토리에 한해 선택적 사용 가능. `--dry-run`으로 먼저 확인 필수 |
| `--delete-after` | 전송 완료 후 삭제 | `--delete` 사용 시 더 안전한 변형 |

**기본 정책**: `--delete` 없이 실행한다. 삭제가 필요한 경우 별도 `--delete` 플래그로 명시적으로 활성화하고, 반드시 dry-run 먼저 실행한다.

---

## 7. 충돌 처리 설계

### 7.1 충돌 정의

클라이언트 측에서 sync 대상 파일이 직접 수정된 경우를 충돌로 간주한다.

### 7.2 충돌 감지 설계

sync 실행 전 다음을 확인한다:

```bash
# 클라이언트 git status로 변경된 파일 확인
git -C "$CLIENT_ROOT" status --short -- \
  01-load-sub-manual/ 02-create-task-card/ ... 09-update-project-md/ \
  .harness/templates/ .harness/manuals/
```

변경된 파일이 있으면 경고를 출력하고 처리 방식을 결정한다.

### 7.3 처리 방식 (abort-first 정책)

| 방식 | 기본값 | 설명 |
|---|---|---|
| **abort-first** | ✅ 기본 | 충돌 감지 시 즉시 중단. 운영자가 수동 해결 후 재실행. |
| **backup-then-overwrite** | `--force` 플래그 | 충돌 파일을 `.bak-<timestamp>`로 백업 후 마스터 파일로 덮어씀. |
| **skip-conflicted** | 미지원 | 충돌 파일을 건너뛰면 sync 불완전 상태가 될 수 있어 지원하지 않음. |

### 7.4 충돌 백업 설계 (`--force` 사용 시)

```
<client-path>/.sync-backups/<timestamp>/
  01-load-sub-manual/SKILL.md.bak
  ...
```

백업 위치는 sync 보고서에 기록한다.

### 7.5 diff 제공

충돌 시 마스터 버전과 클라이언트 버전의 diff를 출력한다:

```bash
diff "$MASTER_ROOT/$file" "$CLIENT_ROOT/$file"
```

---

## 8. 검증 설계

### 8.1 sync 후 검증 항목

| 항목 | 방법 | 실패 시 |
|---|---|---|
| 파일 수 일치 | `find` 결과 비교 | 경고 출력 |
| 체크섬 일치 | `md5` 또는 `shasum -a 256` | 오류 출력, 재실행 권고 |
| `.env` 파일 미복사 | `find "$CLIENT_ROOT" -name ".env*"` 결과 확인 | **exit 3** — 즉시 중단, [Owner] 보고 |
| 키 패턴 파일 미복사 | `find "$CLIENT_ROOT" -name "*key*" -o -name "*secret*"` | **exit 3** — 즉시 중단 |
| sync 보고서 생성 | 보고서 파일 존재 여부 | 경고 출력 |

### 8.2 체크섬 검증 설계

```bash
# sync 후 주요 파일 체크섬 비교
for file in "${SYNC_FILES[@]}"; do
  master_sum=$(shasum -a 256 "$MASTER_ROOT/$file" | awk '{print $1}')
  client_sum=$(shasum -a 256 "$CLIENT_ROOT/$file" | awk '{print $1}')
  if [[ "$master_sum" != "$client_sum" ]]; then
    echo "[WARN] 체크섬 불일치: $file"
  fi
done
```

### 8.3 비밀 파일 감지 설계

sync 완료 후 클라이언트 측에서 다음 패턴을 검색한다:

```bash
find "$CLIENT_ROOT" \
  -not -path "*/.git/*" \
  \( -name ".env" -o -name ".env.*" -o -name "*key*" -o -name "*secret*" -o -name "*credentials*" \) \
  -type f
```

발견 시 파일 목록을 출력하고 exit 3으로 종료한다.

---

## 9. `.gitignore` 정책

### 9.1 마스터 `.gitignore` 필수 포함 항목

```gitignore
# 비밀·키 자료
.env
.env.*
*key*.sh
*secret*
*credentials*

# 클라이언트 자체 파일
client.env

# 임시·로그
tmp/
*.log
*.tmp
.sync-backups/

# OS
.DS_Store
```

### 9.2 클라이언트 `.gitignore` 필수 포함 항목

마스터에서 sync되는 `.gitignore`를 기반으로, 클라이언트가 다음 항목을 추가로 관리한다:

```gitignore
# 클라이언트 고유 비밀
client.env
.env.local

# sync 백업
.sync-backups/
```

---

## 10. Sync 보고서 구조

sync 실행마다 `.harness/runs/<run-id>/sync-report-<timestamp>.md` 또는 클라이언트 측 지정 경로에 생성한다.

```markdown
# sync 보고서

**실행 일시**: YYYY-MM-DD HH:MM KST
**마스터**: /path/to/dubyeol-workflow
**클라이언트**: /path/to/client
**클라이언트 이름**: <client-name>
**모드**: dry-run / 실제 sync
**실행자**: [마누스 / 운영자]

## 결과 요약

| 항목 | 값 |
|---|---|
| 복사된 파일 수 | 42 |
| 건너뛴 파일 수 | 3 |
| 삭제된 파일 수 | 0 |
| 총 크기 | 1.2 MB |
| 소요 시간 | 0.8초 |

## 복사된 파일 목록

(rsync --verbose 출력)

## 제외된 파일 목록

(--exclude 적용 목록)

## 충돌 처리 내역

없음 / (충돌 파일 목록과 처리 방식)

## 검증 결과

- [ ] 파일 수 일치
- [ ] 체크섬 일치
- [ ] .env 미복사 확인
- [ ] 키 패턴 파일 미복사 확인

## 비고

```

---

**sync 설계서 끝.**
