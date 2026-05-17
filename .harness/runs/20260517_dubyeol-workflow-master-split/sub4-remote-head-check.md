# SUB-4 remote existing HEAD check

## 1. 현재 local branch 및 status
```text
main
[31m??[m .harness/
[31m??[m AGENTS.md
[31m??[m PROJECT.md
[31m??[m "SUB-1-\352\270\260\355\232\215\354\235\230\353\217\204.md"
[31m??[m "SUB-2-\354\233\214\355\201\254\355\224\214\353\241\234\354\232\260.md"
[31m??[m "SUB-3-\354\231\270\353\266\200\352\260\220\353\246\254.md"
[31m??[m "SUB-4-\354\210\230\354\240\225.md"
[31m??[m "SUB-5-\354\242\205\353\243\214.md"
[31m??[m r6-rollout-package/
```

## 2. remote URL
```text
origin	https://github.com/gjnvcdprfw-hub/dubyeol-workflow.git (fetch)
origin	https://github.com/gjnvcdprfw-hub/dubyeol-workflow.git (push)
```

## 3. git ls-remote --symref origin HEAD
```text
ref: refs/heads/main	HEAD
d555e9fbda1cbe03b733e03ae2631a9512206d01	HEAD
```

## 4. git fetch origin 결과
```text
From https://github.com/gjnvcdprfw-hub/dubyeol-workflow
 * [new branch]      main       -> origin/main
```

## 5. remote branches
```text
  [31morigin/HEAD[m -> origin/main
  [31morigin/main[m
```

## 6. graph all max 20
```text
* [33md555e9f[m[33m ([m[1;31morigin/main[m[33m, [m[1;31morigin/HEAD[m[33m)[m Initial: 두별 워크플로우 v3.6.0 r1 베타 — Manus Agent Skills 9개
```

## 7. initial commit/push strategy
원격 origin/HEAD는 origin/main을 가리키며 기존 원격 main 이력이 존재한다. 따라서 로컬 no-commit main에서 별도 root initial commit을 만든 뒤 push하면 unrelated history 또는 non-fast-forward 위험이 있다. 안전 전략은 origin/main을 먼저 fetch한 뒤, 원격 main 기반 작업 브랜치에서 import commit을 만들거나, 원격 main을 로컬 main으로 체크아웃/동기화한 다음 그 위에 import commit을 쌓는 방식이다. force push 또는 history rewrite는 금지한다.
