# handoff: 정책+sync 설계

**run ID**: 20260518_skills-policy-and-sync-design  
**작성일시**: 2026-05-18 KST  
**작성자**: [Builder] (클로드코드)  
**상태**: ready_for_review  
**두별 워크트리 카테고리**: 4 (문서·운영)  
**Tier**: A

---

## §1. 의도 정렬 증거 블록 (task-card §3과 항목별 대조)

| task-card §3 항목 | 실제 결과 | 정렬 |
|---|---|---|
| **§3.1 한 문장 목표**: 마스터·클라이언트 자료 경계, 환경변수·키 출처, sync-to-client 설계, .env 정책, 9개 스킬 수정 가이드라인을 정책+sync 설계서로 확정한다. | `policy.md`, `sync-design.md`, `skills-fix-guidelines.md` 3종 작성 완료. | ✅ |
| **§3.2 Looks Like**: `.harness/runs/20260518_skills-policy-and-sync-design/` 아래에 설계 산출물이 생성된다. | `policy.md`, `sync-design.md`, `skills-fix-guidelines.md`, `handoff.md` 생성 완료. | ✅ |
| **§3.2 Looks Like**: 정책서에 마스터·클라이언트·클라이언트 자체·API 키 경계가 분리되어 있다. | `policy.md §2` 자료 경계 테이블 작성. 4분류 명확히 구분. | ✅ |
| **§3.2 Looks Like**: `REPO_ROOT` 결정 방식 4가지를 비교하고 권고안을 정한다. | `policy.md §4` 옵션 A~D 비교표 + 옵션 D 권고 및 근거 작성. | ✅ |
| **§3.2 Looks Like**: `sync-to-client.sh <client-path>` 인터페이스·동작·제외 규칙·검증 방식이 설계 수준으로 명확하다. | `sync-design.md` §1~10: 명령 인터페이스, dry-run, 경로 검증, sync 테이블, 제외 규칙, rsync 설계, 충돌 처리, 검증, gitignore, 보고서 구조 작성. | ✅ |
| **§3.2 Looks Like**: 9개 스킬 수정 task가 바로 사용할 수 있도록 SKILL.md/scripts 정정 가이드와 후속 task 순서가 남는다. | `skills-fix-guidelines.md` §2~12: 각 수정 방향과 9행 테이블, 후속 task 순서 5개 작성. | ✅ |
| **§3.3 Looks Wrong 방어**: 실제 9개 스킬 본문이나 sync 스크립트를 구현·수정하지 않는다. | 9개 스킬 디렉토리, AGENTS.md, SUB-1~5, PROJECT.md, .harness/templates: git status 변경 없음 확인. | ✅ |
| **§3.3 Looks Wrong 방어**: `silkroadhub` 사업 자산 읽기·수정·복사 없음. | 설계 문서에서 `silkroadhub`는 "정책 위반 예시" 또는 "CLI 사용 예시"로만 언급. 파일 읽기·수정·복사 없음. | ✅ |
| **§3.3 Looks Wrong 방어**: API 키나 키 로드 파일을 sync 대상에 포함하지 않는다. | `sync-design.md §5` 제외 규칙에 `.env`, `*key*`, `*secret*` 등 명시. `policy.md §2` sync 불가 항목에 API 키 포함. | ✅ |
| **§3.3 Looks Wrong 방어**: commit·push 미실행. | 미실행. | ✅ |

---

## §2. 변경 요약

본 task에서 수행한 작업:

1. **`policy.md` 작성**: 마스터·클라이언트 자료 경계 테이블, silkroadhub 사업 자산 보존 원칙, REPO_ROOT 옵션 4가지 비교 및 옵션 D 권고, 기타 환경변수 정책, 시스템 환경변수 정책, 보안 및 drift 방지 원칙.

2. **`sync-design.md` 작성**: `sync-to-client.sh <client-path>` 명령 인터페이스, dry-run 모드, 클라이언트 경로 검증 설계, sync 원본·대상 테이블, 제외 규칙 설계, rsync 설계 (`--delete` 정책 포함), 충돌 처리 (abort-first 기본), 검증 설계 (비밀 파일 감지 포함), `.gitignore` 정책, sync 보고서 구조.

3. **`skills-fix-guidelines.md` 작성**: SKILL.md 호출 경로 정렬, zsh/bash 통일, REPO_ROOT 제거·루트 감지, run_id 검증·출력 경로 제한, 04·06·07 입력 격리 강화, Python heredoc 안전성, 09 diff-first·approval-first, 05 강화, 02·08 템플릿 연동, 9행 수정 방향 테이블, 후속 task 순서.

---

## §3. 두별 워크트리 진행 이력 (카테고리 4)

| 단계 | 결과 |
|---|---|
| `using-superpowers` | 세션 시작 시 실행. 카테고리 4 트리 확인. |
| `brainstorming` (축약) | REPO_ROOT 옵션 D 권고 정렬 확인. 시각 요소 없음. |
| 문서 3종 작성 | `policy.md`, `sync-design.md`, `skills-fix-guidelines.md` 작성 완료. |
| 자체 검증 | 산출물 존재 확인, git status 미수정 확인, silkroadhub 절대경로 정당성 확인, API 키 부재 확인. |
| handoff 작성 | 본 문서. |
| finishing-a-development-branch | SUB-3 감리 통과 후 [Owner] 지시 시 수행. |

---

## §4. 변경 파일 목록

새로 생성된 파일:
- `.harness/runs/20260518_skills-policy-and-sync-design/policy.md`
- `.harness/runs/20260518_skills-policy-and-sync-design/sync-design.md`
- `.harness/runs/20260518_skills-policy-and-sync-design/skills-fix-guidelines.md`
- `.harness/runs/20260518_skills-policy-and-sync-design/handoff.md` (본 문서)

수정된 파일: **없음**

---

## §5. 실행 명령어 및 검증 결과

```bash
cd /Users/twostars/ClaudeAi/dubyeol-workflow
RUN=.harness/runs/20260518_skills-policy-and-sync-design

# 산출물 존재 확인
test -f "$RUN/policy.md"              # ✅ 통과
test -f "$RUN/sync-design.md"         # ✅ 통과
test -f "$RUN/skills-fix-guidelines.md"  # ✅ 통과
test -f "$RUN/task-card.md"           # ✅ 통과

# 9개 스킬·운영 문서 미수정 확인
git status --short -- 01-load-sub-manual 02-create-task-card 03-dispatch-to-builder \
  04-invoke-plan-review 05-verify-handoff 06-invoke-reviewer 07-invoke-judge \
  08-write-final-report 09-update-project-md AGENTS.md SUB-1-기획의도.md \
  SUB-2-워크플로우.md SUB-3-외부감리.md SUB-4-수정.md SUB-5-종료.md \
  PROJECT.md .harness/templates
# 결과: (빈 출력) ✅ 미수정 확인
```

---

## §6. 권한 천장 점검

- [x] 9개 스킬 SKILL.md/scripts 수정 없음
- [x] `sync-to-client.sh` 구현 없음
- [x] AGENTS.md, SUB-1~5, PROJECT.md 수정 없음
- [x] `silkroadhub` 읽기·수정·복사·삭제 없음
- [x] API 키, 키 파일, `.env` 산출물 포함 없음
- [x] commit·push·merge·deploy 미실행
- [x] force push, history rewrite, reset hard 미실행
- [x] Tier 강등 없음 (Tier A 유지)

---

## §7. 마스킹 점검

- [x] API 키 값이 산출물에 포함되지 않음
- [x] 키 로드 파일 경로가 산출물에 포함되지 않음 (정책 위반 예시로만 언급)
- [x] `.env` 실제 내용이 산출물에 포함되지 않음
- [x] silkroadhub 사업 데이터·운영 정보 포함 없음

---

## §8. 자체 리뷰

### 장점

1. **policy.md**: REPO_ROOT 옵션 D(기본값+재정의)의 zsh 구현 예시까지 제공하여 후속 스킬 수정 task가 바로 copy-paste 가능한 수준.
2. **sync-design.md**: abort-first 충돌 처리 + dry-run 기본값 + 비밀 파일 감지 exit 3 설계로 안전성 우선.
3. **skills-fix-guidelines.md**: G-2 evidence 근거 항목을 9행 테이블로 정리, 후속 task 순서와 선행 조건까지 명시.

### 주의 사항

1. **sync-design.md §9.2 클라이언트 `.gitignore`**: sync로 마스터 `.gitignore`가 덮어씌워지면 클라이언트 고유 항목이 사라질 수 있다. 구현 task에서 merge 방식 설계가 필요할 수 있음.
2. **skills-fix-guidelines.md §7 Python heredoc**: 파일 기반 전환 권고이지만, 기존 Anthropic SDK 호출 방식과의 호환성 확인이 필요하다.
3. **policy.md §4.2 readlink**: macOS에서 `readlink -f`는 GNU readlink와 동작이 다를 수 있어 (`greadlink` 필요). 구현 시 `$(cd "$(dirname "$0")" && pwd)` 방식이 더 안전할 수 있음.

---

## §9. 남은 리스크

| 리스크 | 심각도 | 처리 방향 |
|---|---|---|
| `readlink -f` macOS 호환성 | 낮음 | 구현 task에서 `$(cd "$(dirname "$0")" && pwd)` 방식으로 대체 가능 |
| 클라이언트 `.gitignore` merge 정책 미정 | 중간 | sync 구현 task에서 merge-first 또는 append-only 방식 결정 필요 |
| sync 실행 중 클라이언트 git commit 미완료 상태 | 낮음 | sync 전 클라이언트 git status 확인 항목 추가 고려 |
| 9개 스킬 수정 범위가 크면 Tier B 강등 요청 가능성 | 낮음 | AGENTS.md Tier 강등 금지 원칙에 따라 마누스에게 확인 |

---

## §10. Scope 밖 발견 사항 (제안만, 실행 금지)

1. **`01-load-sub-manual` DEFECT-01-C** (전체 로드 미수행): 현재 `head -30` 미리보기만 수행. 전체 로드가 필요한 경우 파일 크기·청크 방식 설계가 필요할 수 있음. 스킬 수정 task에서 고려 권고.

2. **references/ 파일 작성**: `03-dispatch-to-builder`, `06-invoke-reviewer`, `07-invoke-judge`의 `references/` 디렉토리가 비어 있음. `standard-entry-prompt.md`, `codex-prompt-pattern.md`, `judge-prompt-pattern.md` 등의 실제 내용 작성이 스킬 수정 task와 병행 필요.

3. **`.env.template` 현재 존재 여부**: sync 테이블에 `.env.template`을 포함했으나 현재 마스터에 이 파일이 없을 수 있음. 구현 task에서 작성 여부 확인 필요.

---

## §11. 마누스 확인 필요점

1. **REPO_ROOT 옵션 D 권고 승인 여부**: `policy.md §4.2`에 기술. 다른 옵션(A: 환경변수 전용)을 선호하면 수정 가능.
2. **`--delete` 정책 기본값**: `sync-design.md §6.2`에서 기본값 `--delete` 없음으로 설계. [Owner]가 더 엄격한 일방향 동기화를 원하면 기본값 변경 가능.
3. **SUB-3 Reviewer·Judge 진행 방식**: Tier A 외부 감리 필요. 현재 중국 네트워크 환경이면 G-2에서 사용한 GPT Reviewer 폴백 절차 재사용.

---

**handoff 끝.**
