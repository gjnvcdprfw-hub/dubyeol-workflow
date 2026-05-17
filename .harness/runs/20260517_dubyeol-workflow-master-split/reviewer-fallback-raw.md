판정: **조건부 통과**

제공된 변경 요약 기준으로는 재배치 방향 자체는 기술적으로 성립합니다. 다만 `dubyeol-workflow`가 **initial commit 전 상태**이고, 원격 `HEAD`가 이미 `d555e9f...`를 반환한다는 점 때문에, 커밋 전 반드시 원격 기준 이력 확인과 provenance 기록 보강이 필요합니다.

---

## 1. cross-repo copy + source `git log --follow` 증거 방식의 충분성

**판정: 조건부 통과**

`git mv`는 동일 Git repository 내부 이동에서만 이력을 자연스럽게 추적할 수 있습니다. 이번처럼

- source: `/Users/twostars/ClaudeAi/silkroadhub`
- target: `/Users/twostars/ClaudeAi/dubyeol-workflow`

처럼 서로 다른 로컬 Git 작업공간 간 이동이면 `git mv`로 이력을 보존할 수 없습니다. 따라서 **copy + source repo에서 `git log --follow` 증거를 남기는 방식은 기술적으로 타당**합니다.

다만 충분하려면 최소한 다음 근거가 commit 전 또는 commit 메시지/문서에 남아야 합니다.

### 필요 근거

source repo에서 각 주요 이전 대상에 대해 원본 이력을 확인한 기록:

```bash
cd /Users/twostars/ClaudeAi/silkroadhub

git log --follow -- AGENTS.md
git log --follow -- SUB-1
git log --follow -- SUB-2
git log --follow -- SUB-3
git log --follow -- SUB-4
git log --follow -- SUB-5
git log --follow -- r6-rollout-package
git log --follow -- .harness/runs
git log --follow -- .harness/templates
git log --follow -- .harness/manus-prompts
```

또한 target repo에서 파일 수 및 경로 매칭이 확인되어야 합니다.

```bash
cd /Users/twostars/ClaudeAi/dubyeol-workflow

find .harness/runs -type f | wc -l
# 기대값: 71
```

제공된 정보상 이전 대상 run 파일 수가 `22 + 33 + 3 + 13 = 71`이고, 이전 후 `dubyeol-workflow/.harness/runs` 파일 수도 `71`이라고 되어 있으므로 수량 검증은 일단 일치합니다.

### 결론

cross-repo 특성상 Git history 자동 보존은 불가능하므로, `git log --follow` 샘플 또는 목록 기록 방식은 기술적으로 적절합니다. 단, **source commit hash와 주요 파일별 provenance 기록이 commit message 또는 별도 문서에 남는 조건**에서 충분합니다.

---

## 2. client repo에서 workflow 원본 제거 후 templates/manus-prompts만 client 사본으로 남긴 구조의 일관성

**판정: 조건부 통과**

제공된 구조는 다음과 같습니다.

### `/Users/twostars/ClaudeAi/silkroadhub`에 제거됨

- `AGENTS.md`
- `SUB-1~5`
- `r6-rollout-package`
- workflow run 4개

### `/Users/twostars/ClaudeAi/silkroadhub`에 유지됨

- `backend/`
- `frontend/`
- business runs
- `CLAUDE.md`
- `.harness/templates`
- `.harness/manus-prompts`

### `/Users/twostars/ClaudeAi/dubyeol-workflow`에 복사됨

- `AGENTS.md`
- `SUB-1~5`
- `.harness/templates`
- `.harness/manus-prompts`
- `r6-rollout-package`
- workflow run 4개
- 신규 `PROJECT.md`

구조적으로는 다음 기준을 만족하면 일관적입니다.

1. `silkroadhub`는 client/business code 중심 repo로 남는다.
2. workflow 원본은 `dubyeol-workflow`로 이동한다.
3. 단, `.harness/templates`, `.harness/manus-prompts`는 client 실행 또는 business runs에 필요한 local copy로 유지한다.
4. `silkroadhub` 내부에서 제거된 `AGENTS.md`, `SUB-1~5`, `r6-rollout-package`, workflow run 4개에 대한 깨진 참조가 없어야 한다.

특히 4번은 반드시 확인해야 합니다.

### 권장 확인 명령

```bash
cd /Users/twostars/ClaudeAi/silkroadhub

find . -path ./.git -prune -o -type f -print \
  | xargs grep -nE "AGENTS\.md|SUB-[1-5]|r6-rollout-package|dubyeol-workflow|workflow run" 
```

또는 제거된 경로가 실제로 남아 있지 않은지 확인:

```bash
cd /Users/twostars/ClaudeAi/silkroadhub

test ! -e AGENTS.md
test ! -e SUB-1
test ! -e SUB-2
test ! -e SUB-3
test ! -e SUB-4
test ! -e SUB-5
test ! -e r6-rollout-package
```

`.harness/templates`, `.harness/manus-prompts` 유지 여부:

```bash
cd /Users/twostars/ClaudeAi/silkroadhub

test -d .harness/templates
test -d .harness/manus-prompts
```

### 결론

`workflow 원본은 master repo`, `client repo에는 필요한 template/prompt 사본만 유지`라는 구조는 기술적으로 일관적입니다. 다만 client repo 내부에서 제거된 workflow 경로를 참조하는 문서, 스크립트, run metadata가 남아 있으면 불일치가 발생하므로 **grep 기반 참조 검증 조건부 통과**입니다.

---

## 3. 신규 repo가 initial commit 전 remote만 연결된 상태의 위험

**판정: 조건부 통과**

이 항목은 가장 큰 기술적 위험이 있습니다.

제공된 정보에 따르면:

- `/Users/twostars/ClaudeAi/dubyeol-workflow`는 `git init` 완료
- remote 연결됨
- 아직 local commit 없음
- remote URL: `https://github.com/gjnvcdprfw-hub/dubyeol-workflow.git`
- `git ls-remote` 결과 원격 `HEAD`가 `d555e9f...` 반환

즉, local repo는 아직 root commit이 없지만, remote는 이미 `HEAD` commit을 가진 상태로 보입니다. 이 경우 다음 위험이 있습니다.

### 주요 위험

#### 1. unrelated history 생성 위험

로컬에서 바로 initial commit을 만들면, 원격 `d555e9f...` 이력과 무관한 별도 root commit이 생길 수 있습니다.

그 상태에서 push하면 다음 중 하나가 발생할 수 있습니다.

- non-fast-forward 거절
- 강제 push 시 원격 이력 손상
- default branch 불일치
- local branch와 remote branch가 서로 다른 root를 가진 상태가 됨

#### 2. 원격 default branch 미확인 위험

`git init` 직후 local branch 이름이 `main`, `master` 또는 환경 설정에 따라 다를 수 있습니다. 반면 GitHub remote의 default branch는 별도로 존재합니다.

확인 필요:

```bash
cd /Users/twostars/ClaudeAi/dubyeol-workflow

git branch --show-current
git ls-remote --symref origin HEAD
```

#### 3. remote에 기존 내용이 있는지 미확인 위험

`git ls-remote HEAD d555e9f...`가 있다는 것은 remote가 완전 빈 repo가 아닐 가능성이 큽니다. 따라서 반드시 fetch 후 원격 이력을 확인해야 합니다.

```bash
cd /Users/twostars/ClaudeAi/dubyeol-workflow

git fetch origin
git branch -r
git log --oneline --decorate --graph --all --max-count=20
```

#### 4. 의도하지 않은 push 대상 위험

remote URL은 확인되어야 합니다.

```bash
cd /Users/twostars/ClaudeAi/dubyeol-workflow

git remote -v
```

기대값:

```text
origin  https://github.com/gjnvcdprfw-hub/dubyeol-workflow.git (fetch)
origin  https://github.com/gjnvcdprfw-hub/dubyeol-workflow.git (push)
```

### 권장 안전 절차

remote가 이미 commit을 갖고 있다면, local initial commit을 바로 만드는 것보다 먼저 다음을 수행해야 합니다.

```bash
cd /Users/twostars/ClaudeAi/dubyeol-workflow

git fetch origin
git ls-remote --symref origin HEAD
git log --oneline --decorate --graph --all --max-count=20
```

그 후 원격 default branch 기준으로 작업 브랜치를 만드는 방식이 안전합니다.

예:

```bash
git switch -c workflow-import origin/main
```

단, 실제 branch 이름은 `git ls-remote --symref origin HEAD` 결과에 따라 결정해야 합니다.

### 결론

remote에 `HEAD d555e9f...`가 존재하는 상태에서 local이 no-commit이면, **그대로 initial commit을 만드는 것은 위험**합니다. commit 전 반드시 `git fetch origin` 및 원격 default branch 확인이 필요합니다.

---

## 4. push 없이 `gh repo view` + `git ls-remote`로 rename redirect를 검증한 것이 충분한가

**판정: 조건부 통과**

제공된 정보:

- old URL: `dubyeol-workflow-skills`
- new URL: `dubyeol-workflow`
- 둘 다 `git ls-remote`에서 동일한 `HEAD d555e9f...` 반환
- `gh repo view`도 사용
- push/merge/deploy/history rewrite 없음

기술적으로, GitHub rename redirect 확인에는 다음 조합이 충분한 편입니다.

```bash
gh repo view gjnvcdprfw-hub/dubyeol-workflow
git ls-remote https://github.com/gjnvcdprfw-hub/dubyeol-workflow.git HEAD
git ls-remote https://github.com/gjnvcdprfw-hub/dubyeol-workflow-skills.git HEAD
```

두 URL이 동일한 `HEAD d555e9f...`를 반환했다면, old URL redirect가 현재 Git fetch 계층에서 정상 동작한다는 근거가 됩니다.

다만 이것만으로 다음까지 보장되지는 않습니다.

### 보장되지 않는 것

1. push 권한
2. branch protection 설정
3. default branch 이름
4. GitHub Actions 또는 deploy hook 동작
5. 기존 remote repo 내용과 local import 작업의 history 호환성
6. old URL에 대한 장기적 운영 안정성

따라서 redirect 검증 자체는 충분하나, push 가능성이나 branch protection까지 확인한 것은 아닙니다.

### 추가 권장 확인

```bash
gh repo view gjnvcdprfw-hub/dubyeol-workflow \
  --json nameWithOwner,url,defaultBranchRef,isPrivate

git ls-remote --symref https://github.com/gjnvcdprfw-hub/dubyeol-workflow.git HEAD
git ls-remote --symref https://github.com/gjnvcdprfw-hub/dubyeol-workflow-skills.git HEAD
```

### 결론

push 없이 `gh repo view` + `git ls-remote`로 rename redirect를 확인한 것은 **redirect 확인 목적에는 충분**합니다. 단, push 권한, branch protection, remote history 호환성 확인까지 포함하지는 않으므로 조건부 통과입니다.

---

## 5. commit 전 추가 확인해야 할 기술적 위험

**판정: 조건부 통과**

commit 전 다음 항목은 추가 확인이 필요합니다.

---

### A. target repo 파일 수 및 누락 확인

```bash
cd /Users/twostars/ClaudeAi/dubyeol-workflow

find .harness/runs -type f | wc -l
```

기대값:

```text
71
```

또한 주요 경로 존재 확인:

```bash
test -f AGENTS.md
test -d SUB-1
test -d SUB-2
test -d SUB-3
test -d SUB-4
test -d SUB-5
test -d .harness/templates
test -d .harness/manus-prompts
test -d r6-rollout-package
test -f PROJECT.md
```

---

### B. source repo에서 제거 대상이 실제 제거되었는지 확인

```bash
cd /Users/twostars/ClaudeAi/silkroadhub

git status --short

test ! -e AGENTS.md
test ! -e SUB-1
test ! -e SUB-2
test ! -e SUB-3
test ! -e SUB-4
test ! -e SUB-5
test ! -e r6-rollout-package
```

---

### C. client repo business code 보존 확인

`backend/`, `frontend/`가 삭제나 대량 변경되지 않았는지 확인해야 합니다.

```bash
cd /Users/twostars/ClaudeAi/silkroadhub

git status --short backend frontend
```

또는 변경량 확인:

```bash
git diff --stat -- backend frontend
```

기대 상태는 변경 없음 또는 의도된 business 변경 없음입니다.

---

### D. 제거된 workflow 경로에 대한 dangling reference 확인

```bash
cd /Users/twostars/ClaudeAi/silkroadhub

find . -path ./.git -prune -o -type f -print \
  | xargs grep -nE "AGENTS\.md|SUB-[1-5]|r6-rollout-package|dubyeol-workflow-skills|dubyeol-workflow"
```

특히 `CLAUDE.md`, `PROJECT.md`, `.harness/runs/*`, `.harness/templates/*`, `.harness/manus-prompts/*`에서 깨진 경로가 없는지 확인해야 합니다.

---

### E. target repo의 remote history 확인

가장 중요합니다.

```bash
cd /Users/twostars/ClaudeAi/dubyeol-workflow

git remote -v
git ls-remote --symref origin HEAD
git fetch origin
git log --oneline --decorate --graph --all --max-count=20
```

remote HEAD가 이미 `d555e9f...`이면, local import commit이 remote history와 어떻게 연결될지 확인하지 않고 commit/push하면 위험합니다.

---

### F. 민감정보 및 불필요한 산출물 포함 여부 확인

workflow 자료 이동 중 API key, token, local path, 실행 로그가 포함될 수 있습니다.

```bash
cd /Users/twostars/ClaudeAi/dubyeol-workflow

grep -RInE "API_KEY|SECRET|TOKEN|PASSWORD|PRIVATE_KEY|BEGIN RSA|BEGIN OPENSSH|ghp_|github_pat_" .
```

대용량 파일 확인:

```bash
find . -type f -size +10M -print
```

`.git` 중첩 복사 여부 확인:

```bash
find . -name .git -type d -print
```

기대값은 root의 `.git` 외 중첩 `.git` 없음입니다.

---

### G. `.gitignore` 및 추적 대상 확인

```bash
cd /Users/twostars/ClaudeAi/dubyeol-workflow

git status --short
git check-ignore -v .harness/runs/* 2>/dev/null
git check-ignore -v .harness/templates/* 2>/dev/null
git check-ignore -v .harness/manus-prompts/* 2>/dev/null
```

이전 대상 파일이 `.gitignore` 때문에 누락될 수 있으므로 확인이 필요합니다.

---

## 최종 종합 판정

**조건부 통과**

기술적으로 다음 사항은 타당합니다.

- cross-repo 이동에서 `git mv` 대신 copy 사용
- source repo의 `git log --follow`로 provenance 확보
- `silkroadhub`에서 workflow 원본 제거 후 business code 보존
- `dubyeol-workflow`에 workflow 자산 집중
- `gh repo view` + `git ls-remote`로 GitHub rename redirect 확인
- push/merge/deploy/history rewrite 미수행

다만 commit 전 반드시 아래 조건을 충족해야 합니다.

1. `/Users/twostars/ClaudeAi/dubyeol-workflow`에서 `git fetch origin` 후 원격 `HEAD d555e9f...`의 실제 branch와 이력을 확인할 것.
2. local no-commit 상태에서 원격 이력과 무관한 root commit을 만들지 않도록 branch 기준을 명확히 할 것.
3. `.harness/runs` 파일 수 71개 및 주요 경로 존재를 재확인할 것.
4. `/Users/twostars/ClaudeAi/silkroadhub`에서 제거된 workflow 경로에 대한 dangling reference를 grep으로 확인할 것.
5. target repo에 secret, 중첩 `.git`, 대용량 불필요 파일, `.gitignore` 누락 문제가 없는지 확인할 것.

위 조건이 충족되면 기술 정합성 측면에서 commit 진행은 가능하다고 판단합니다.
