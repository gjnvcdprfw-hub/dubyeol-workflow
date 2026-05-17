# 단위 검증 Evidence — sync-to-client.sh

**run ID**: 20260518_sync-script-implementation  
**실행 일시**: 2026-05-18 (실행 기준: 20260517_173xxx)  
**실행 위치**: `/Users/twostars/ClaudeAi/dubyeol-workflow`

---

## TEST 1: --help → exit 0 (성공 케이스)

**명령어**: `./scripts/sync-to-client.sh --help`

**출력**:
```
Usage: ./scripts/sync-to-client.sh <client-path> [options]

Syncs dubyeol-workflow master to a client git repository.

Arguments:
  <client-path>          Path to client git repository (required)

Options:
  --dry-run              Show files that would be synced, without copying
  --force                Back up conflicted files and proceed with sync
  --client-name <name>   Client name label for the sync report
  --help                 Show this usage message

Exit codes:
  0    Success or dry-run complete
  1    Argument or path validation failure
  2    Conflict detected and aborted (use --force to override)
  3    Verification failure (secret/key file detected in sync output)
  127  Required tool missing

Examples:
  ./scripts/sync-to-client.sh /path/to/client --dry-run
  ./scripts/sync-to-client.sh /path/to/client --client-name myproject
  ./scripts/sync-to-client.sh /path/to/client --force --client-name myproject
```

**exit code**: `0` ✓

---

## TEST 2: 인자 없음 → exit 1

**명령어**: `./scripts/sync-to-client.sh`

**출력 (stderr)**:
```
[ERROR] Missing required argument: <client-path>

(usage 전체 출력)
```

**exit code**: `1` ✓

---

## TEST 3: 존재하지 않는 경로 → exit 1

**명령어**: `./scripts/sync-to-client.sh /path/does/not/exist`

**출력 (stderr)**:
```
[ERROR] Client path does not exist: /path/does/not/exist
```

**exit code**: `1` ✓

---

## TEST 4: .git 없는 경로 → exit 1

**명령어**: `./scripts/sync-to-client.sh tmp/no-git-client`

**사전 조건**: `mkdir -p tmp/no-git-client` (git init 없음)

**출력 (stderr)**:
```
[ERROR] No .git directory found — not a git repository: /Users/twostars/ClaudeAi/dubyeol-workflow/tmp/no-git-client
```

**exit code**: `1` ✓

---

## TEST 5: 마스터 경로 자체 → exit 1

**명령어**: `./scripts/sync-to-client.sh /Users/twostars/ClaudeAi/dubyeol-workflow`

**출력 (stderr)**:
```
[ERROR] Client path is the same as master root. Cannot sync to itself.
```

**exit code**: `1` ✓

---

## TEST 6: 금지 경로 / → exit 1

**명령어**: `./scripts/sync-to-client.sh /`

**출력 (stderr)**:
```
[ERROR] No .git directory found — not a git repository: /
```

**exit code**: `1` ✓

> **주석**: sync-design.md §3.1의 검증 순서는 `.git` 확인(step 3) 후 금지 경로 확인(step 5). `/`는 `.git`이 없으므로 step 3에서 먼저 실패. exit 1로 올바르게 종료됨. 금지 경로 검증(step 5)이 실행되려면 대상 경로에 `.git`이 있어야 한다. 이 동작은 설계 사양 §3.1 순서를 따른 것임.

---

## TEST 7: 금지 경로 $HOME → exit 1

**명령어**: `./scripts/sync-to-client.sh "$HOME"`  
(실제 경로: `/Users/twostars`)

**출력 (stderr)**:
```
[ERROR] No .git directory found — not a git repository: /Users/twostars
```

**exit code**: `1` ✓

> **주석**: TEST 6과 동일한 이유로 `.git` 체크에서 먼저 실패. exit 1 정상. `$HOME`에 `.git`이 있는 경우 step 5의 forbidden path 메시지가 출력된다.

---

## 검증 요약

| # | 케이스 | 기대 exit | 실제 exit | 결과 |
|---|---|---|---|---|
| 1 | --help | 0 | 0 | ✓ PASS |
| 2 | 인자 없음 | 1 | 1 | ✓ PASS |
| 3 | 존재하지 않는 경로 | 1 | 1 | ✓ PASS |
| 4 | .git 없는 경로 | 1 | 1 | ✓ PASS |
| 5 | 마스터 경로 자체 | 1 | 1 | ✓ PASS |
| 6 | 금지 경로 / | 1 | 1 | ✓ PASS |
| 7 | 금지 경로 $HOME | 1 | 1 | ✓ PASS |

**모든 단위 검증 PASS.**

---

## 버그 수정 이력

**발견**: verification 중 dry-run 재실행 시 exit 2 발생.  
**원인**: `git status --short` 출력에 ANSI 색상 코드가 포함되어 `grep -v '^??'` 패턴이 untracked 줄을 제거하지 못함. untracked 파일(`??`)이 충돌로 오판됨.  
**수정**: `git --no-color` 플래그 추가 + `printf` 방식으로 변경.  
**수정 후 검증**: 모든 9개 케이스 재실행 → 모두 기대 exit code 일치.
