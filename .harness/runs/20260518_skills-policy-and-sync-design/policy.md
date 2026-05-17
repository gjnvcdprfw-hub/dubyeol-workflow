# 정책서: 두별 워크플로우 마스터·클라이언트 운영 정책

**run ID**: 20260518_skills-policy-and-sync-design  
**작성일시**: 2026-05-18 KST  
**작성자**: [Builder] (클로드코드)  
**상태**: 초안 (SUB-3 감리 전)  
**Tier**: A

---

## 1. 목표와 비목표

### 1.1 목표

- 두별 워크플로우 마스터(`dubyeol-workflow`)와 각 클라이언트 프로젝트 사이의 **자료 경계**를 명확히 정의한다.
- **API 키 자료를 저장소에 두지 않는다**는 원칙과 시스템 환경변수 단일 키 출처 정책을 성문화한다.
- `REPO_ROOT`를 포함한 환경변수 결정 방식 4가지를 비교하고 권고안을 확정한다.
- 후속 sync 설계 task와 9개 스킬 수정 task가 재해석 없이 사용할 수 있는 운영 기준을 고정한다.

### 1.2 비목표

- `sync-to-client.sh` 실제 구현 (→ 별도 구현 task에서 수행).
- 9개 스킬 SKILL.md 또는 scripts 실제 수정 (→ 별도 스킬 수정 task).
- `silkroadhub` 사업 자산 접근 또는 수정 (명시적 금지).
- API 키 값 저장, 출력, 전달.

---

## 2. 마스터·클라이언트 자료 경계 테이블

| 구분 | 자료 예시 | 위치 | sync 대상 여부 |
|---|---|---|---|
| **마스터 소유** | 9개 스킬 소스(SKILL.md + scripts/), `.harness/templates/`, `.harness/manuals/`, sync 스크립트 소스·설계, `.env.template`, 정책 문서, PROJECT.md, AGENTS.md, SUB-1~5 | `dubyeol-workflow/` | 마스터 → 클라이언트 sync 원천 |
| **클라이언트가 sync로 수신** | 9개 스킬 복사본, 템플릿 복사본, 정책 문서 복사본 | `<client>/` | sync 대상 ✅ |
| **클라이언트 자체 보유** | `.harness/runs/`, `client.env` (키 없음), 비즈니스 데이터·자산, 클라이언트 CLAUDE.md | `<client>/` | sync 제외 ❌ |
| **어느 쪽도 sync 안 함** | API 키, 키 로드 파일, `.env` 실제 내용, 비밀 자료 | 시스템 환경변수 (`.zshrc` 등) | sync 불가 ❌ |

### 2.1 자료 경계 원칙

1. **마스터가 정책 원천**: 두별 워크플로우의 모든 스킬·템플릿·매뉴얼·정책 문서는 `dubyeol-workflow` 마스터에서 정의하고 관리한다.
2. **클라이언트는 수신자**: 클라이언트는 sync를 통해 최신 복사본을 받되, 원본을 직접 수정하지 않는다.
3. **run 산출물은 클라이언트 고유**: `.harness/runs/`는 각 프로젝트의 운영 이력으로, sync 대상이 아니다.
4. **키 자료는 항상 시스템 환경변수**: API 키를 포함한 비밀 자료는 저장소 파일에 두지 않는다.

---

## 3. `silkroadhub` 사례 — 사업 자산 보존 원칙

### 3.1 현황과 정책 결정

G-2 검증 과정에서 `silkroadhub/scripts/load_openai_key.sh`가 GPT Reviewer 폴백을 위해 `dubyeol-workflow` 마스터로 복사된 부정합이 발생했다 (회고 31). [Owner]는 이를 정정했다:

> `silkroadhub/scripts/load_openai_key.sh`는 **silkroadhub 사업 서비스 자체 운영 자산**이다. 손대지 않는다.

### 3.2 `silkroadhub` 관련 정책

| 항목 | 정책 |
|---|---|
| `silkroadhub/scripts/load_openai_key.sh` | silkroadhub 사업 운영 자산. 읽기·수정·복사·삭제 금지. |
| `silkroadhub` 경로 전반 | `dubyeol-workflow` 운영 작업에서 접근 금지. |
| sync 적용 대상 여부 | `silkroadhub`는 `sync-to-client.sh`의 별도 클라이언트로 적용할 수 있으나, 사업 자산(`scripts/`, `.env` 등)은 sync 제외 규칙에 명시적으로 포함한다. |
| 키 자료 의존 | 마스터가 `silkroadhub` 키 파일에 의존하는 구조는 정책 위반. 마스터는 시스템 환경변수로만 키를 로드해야 한다. |

---

## 4. `REPO_ROOT` 환경변수 정책

### 4.1 옵션 비교

| 옵션 | 방식 | 장점 | 단점 | 적합 상황 |
|---|---|---|---|---|
| **A. 쉘/env 파일 환경변수** | `$DUBYEOL_MASTER_ROOT`를 `~/.zshrc`에 설정 | 명시적, 이식성 높음 | 초기 설정 필요, 설정 누락 시 오류 | 다중 사용자, 파트너 배포 |
| **B. 현재 작업 디렉토리 자동 감지** | `pwd` 또는 `git rev-parse --show-toplevel` | 설정 불필요, 단순 | 실행 위치에 의존, 서브 디렉토리 실행 시 오류 가능 | 단일 사용자, 항상 루트에서 실행 |
| **C. 명시적 CLI 인자** | `./script.sh <client-path>` 형태 | 최대 명시성, 실수 방지 | 매 실행마다 인자 필요, 자동화 어려움 | 일회성 실행, 감사 추적 필요 |
| **D. 기본값 + 재정의** | 스크립트 위치 기반 자동 감지, `DUBYEOL_MASTER_ROOT` 재정의 가능 | 현재 편의성 + 미래 유연성 | 약간 복잡, 자동 감지 실패 케이스 처리 필요 | 현재~미래 점진적 전환 |

### 4.2 권고안 — 옵션 D

**현재 단계**: 스크립트 자신의 위치(`dirname "$(readlink -f "$0")"`)를 기반으로 마스터 루트를 자동 감지한다. `sync-to-client.sh`는 `dubyeol-workflow/` 루트에 위치하므로, 스크립트 위치 = 마스터 루트.

**재정의 방법**: `DUBYEOL_MASTER_ROOT` 환경변수가 설정되어 있으면 이를 우선 사용한다.

```
MASTER_ROOT="${DUBYEOL_MASTER_ROOT:-$(dirname "$(readlink -f "$0")")}"
```

**선택 근거**:
- 현재 "같은 로컬·같은 사용자" 전제에서는 옵션 B와 동일하게 동작한다.
- 추가 설정 없이 바로 사용 가능하다.
- 미래 파트너/고객 환경에서는 환경변수만 설정하면 전환이 가능하다.
- 스크립트 위치 기반이므로 `pwd`에 의존하지 않는다.

### 4.3 `REPO_ROOT` 명칭 정책

9개 스킬 scripts 내의 `REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"` 하드코딩은 **정책 위반**이다.

수정 방향:
- 스킬 scripts에서 `REPO_ROOT` 하드코딩을 제거한다.
- 대신 `REPO_ROOT`는 다음 우선순위로 결정한다:
  1. `REPO_ROOT` 환경변수 (설정된 경우)
  2. 스크립트 실행 디렉토리 기반 자동 감지
  3. `git rev-parse --show-toplevel` (git 저장소 내 실행 시)

---

## 5. 기타 환경변수 정책

| 환경변수 | 역할 | 출처 | 저장소 포함 여부 |
|---|---|---|---|
| `REPO_ROOT` | 현재 작업 저장소 루트 | 스크립트 자동 감지 또는 env | ❌ 하드코딩 금지 |
| `DUBYEOL_MASTER_ROOT` | 마스터 저장소 루트 재정의 | `~/.zshrc` (옵션) | ❌ |
| `DUBYEOL_CLIENT_ROOT` | 클라이언트 저장소 루트 | CLI 인자 또는 환경변수 | ❌ |
| `CLIENT_NAME` | 클라이언트 식별자 (로그·보고용) | CLI 인자 또는 환경변수 | ❌ |
| `OPENAI_API_KEY` | OpenAI API 인증 | `~/.zshrc` 시스템 환경변수 | ❌ 절대 금지 |
| `ANTHROPIC_API_KEY` | Anthropic API 인증 | `~/.zshrc` 시스템 환경변수 | ❌ 절대 금지 |

### 5.1 `DUBYEOL_CLIENT_ROOT` 설정 방식

`sync-to-client.sh <client-path>` CLI 인자를 우선으로 사용한다. 환경변수 `DUBYEOL_CLIENT_ROOT`가 설정되어 있으면 기본값으로 사용하고, CLI 인자가 있으면 인자가 우선한다.

---

## 6. 시스템 환경변수 정책

### 6.1 현재 단계 가정

- **운영 전제**: 같은 로컬 머신, 같은 사용자 계정.
- **키 단일 출처**: `~/.zshrc` 또는 `~/.zprofile`에 환경변수로 설정.
- 마스터 저장소에 API 키를 두지 않는다.
- 클라이언트 저장소에 API 키를 두지 않는다.
- sync 스크립트가 API 키를 복사하거나 이동하지 않는다.

### 6.2 누락 환경변수 처리

스크립트는 필수 환경변수 누락 시 오류 메시지를 출력하고 즉시 종료해야 한다. 기본값으로 폴백하거나 빈 값으로 진행하지 않는다.

```bash
if [[ -z "$OPENAI_API_KEY" ]]; then
    echo "[ERROR] OPENAI_API_KEY is not set. Set it in ~/.zshrc."
    exit 1
fi
```

### 6.3 미래 파트너·고객 환경 준비

현재 단계는 단일 로컬 운영이므로 `~/.zshrc` 단일 출처로 충분하다. 미래 파트너/고객 배포 시:
- 각 사용자가 자신의 `~/.zshrc`에 환경변수를 설정한다.
- 마스터 측 `.env.template`에 필요한 환경변수 목록을 문서화한다.
- `.env.template`은 키 값을 포함하지 않고 변수명과 설명만 포함한다.

---

## 7. 보안 및 Drift 방지 원칙

### 7.1 보안 원칙

| 원칙 | 세부 내용 |
|---|---|
| 키 자료 저장소 금지 | API 키, 키 로드 파일, `.env` 실제 내용은 어떤 저장소에도 커밋하지 않는다. |
| `.gitignore` 의무화 | `.env`, `.env.*`, `*key*`, `*secret*`, `*credentials*`, `client.env`는 마스터와 클라이언트 모두 `.gitignore`에 포함한다. |
| 로그 마스킹 | 스크립트 실행 로그에 키 값을 출력하지 않는다. `SET/NOT SET` 형식으로만 기록한다. |
| 복사된 키 자료 즉시 정리 | 실수로 키 자료가 저장소 파일로 유입된 경우 즉시 삭제하고 `.gitignore`를 보강한다. 커밋 전 발견 시 파일 삭제로 충분. 커밋 후 발견 시 [Owner] 승인 후 git history rewrite. |

### 7.2 Drift 방지 원칙

| 원칙 | 세부 내용 |
|---|---|
| sync 자동화 | 마스터→클라이언트 sync를 수동 복사 대신 `sync-to-client.sh`로 수행하여 drift를 방지한다. |
| dry-run 기본 | sync 실행 전 dry-run을 [Owner] 또는 운영자가 검토한다. |
| 동기화 이력 | sync 실행 시 날짜·파일 수·결과를 sync 보고서에 기록한다. |
| 클라이언트 자체 수정 금지 | sync 대상 파일을 클라이언트 측에서 직접 수정하지 않는다. 수정이 필요하면 마스터에서 정책 변경 후 sync한다. |

---

**정책서 끝.**
