# skill-creator 입력 방식 사실 확인 보고

**run ID**: 20260517_skills-direct-register  
**작성자**: [Foreman]  
**목적**: Phase F task-card 보강 전, `skill-creator`의 입력 방식이 GitHub URL, 로컬 디렉터리, 기존 스킬 리팩토링, 9개 일괄 처리 중 무엇을 명시적으로 지원하는지 확인한다.

---

## 1. GitHub URL 직접 입력 지원 여부

| 항목 | 결론 |
|---|---|
| 지원 여부 | **미명시** |
| 판단 | `SKILL.md`, `scripts/`, `references/`에서 `https://github.com/<owner>/<repo>` 형식 URL을 받아 원격 자료를 가져오거나 clone/import/refactor하는 절차는 확인되지 않았다. |

**인용 근거**: `SKILL.md`의 생성 절차는 예시 수집, 리소스 계획, `init_skill.py` 초기화, 편집, 검증·전달 순서로 설명된다. GitHub URL 입력 절차는 없다.

> “Skill creation involves these steps: 1. Understand the skill with concrete examples 2. Plan reusable skill contents (scripts, references, templates) 3. Initialize the skill (run init_skill.py) 4. Edit the skill (implement resources and write SKILL.md) 5. Deliver the skill (send SKILL.md path via notify_user) 6. Iterate based on real usage” — `/home/ubuntu/skills/skill-creator/SKILL.md`, lines 102–111.

`init_skill.py`도 사용법을 `init_skill.py <skill-name>`으로만 제시하며, GitHub URL 인자는 없다.

> “Usage: init_skill.py <skill-name>” and “Skills are created at /home/ubuntu/skills/<skill-name>/” — `/home/ubuntu/skills/skill-creator/scripts/init_skill.py`, lines 5–12.

---

## 2. 로컬 디렉터리 입력 지원 여부

| 항목 | 결론 |
|---|---|
| `/home/ubuntu/skills/<name>/` 생성 | **지원 명시** |
| 임의 절대 경로 validation | **validation에 한해 지원 명시** |
| 임의 경로를 입력으로 받아 리팩토링 | **미명시** |

`SKILL.md`는 신규 스킬을 `/home/ubuntu/skills/<skill-name>/`에 생성한다고 명시한다.

> “Creates the skill directory at `/home/ubuntu/skills/<skill-name>/`” — `/home/ubuntu/skills/skill-creator/SKILL.md`, lines 149–154.

`quick_validate.py`는 validation 입력으로 `<skill-name>` 또는 `<absolute-path-to-skill>`를 지원한다고 명시한다.

> “Usage: quick_validate.py <skill-name>; quick_validate.py <absolute-path-to-skill>” — `/home/ubuntu/skills/skill-creator/scripts/quick_validate.py`, lines 5–8.

또한 `quick_validate.py`는 절대 경로가 주어지면 그대로 사용하고, 그렇지 않으면 `/home/ubuntu/skills` 아래로 해석한다고 명시한다.

> “If given an absolute path, use it directly. If given a skill name or relative path, resolve it under SKILLS_BASE_PATH.” — `/home/ubuntu/skills/skill-creator/scripts/quick_validate.py`, lines 24–38.

단, 이 근거는 **validation 입력**에 관한 것이다. `/home/ubuntu/dubyeol-workflow-skills/` 같은 임의 로컬 폴더를 받아 스킬로 리팩토링하는 생성·변환 워크플로는 `SKILL.md`에 **미명시**다.

---

## 3. 기존 스킬 자료 리팩토링 vs 신규 스킬 생성

| 항목 | 결론 |
|---|---|
| 기존 스킬 자료를 입력으로 받아 표준 포맷으로 자동 변환 | **미명시** |
| 이미 존재하는 skill 개발 시 init 생략 가능 | **명시** |
| 기본 워크플로 | **신규 생성 + 수동 편집 중심** |

`SKILL.md` Step 3은 신규 생성 시 `init_skill.py`를 항상 실행하라고 말하며, 이미 존재하는 스킬을 개발 중이면 초기화를 생략하고 다음 단계로 가라고 한다.

> “When creating a new skill from scratch, always run the `init_skill.py` script.” — `/home/ubuntu/skills/skill-creator/SKILL.md`, lines 141–147.

> “Skip this step only if the skill being developed already exists, and iteration or packaging is needed. In this case, continue to the next step.” — `/home/ubuntu/skills/skill-creator/SKILL.md`, lines 135–140.

Step 4는 새로 생성되었거나 이미 존재하는 스킬을 “편집”하라고 설명한다. 이는 사람이 `scripts/`, `references/`, `templates/`, `SKILL.md`를 구현·작성하는 절차이지, 외부 repo/폴더를 자동 리팩토링하는 절차로 명시되어 있지는 않다.

> “When editing the (newly-generated or existing) skill…” — `/home/ubuntu/skills/skill-creator/SKILL.md`, lines 158–160.

> “Begin with the `scripts/`, `references/`, and `templates/` files identified in Step 2.” — `/home/ubuntu/skills/skill-creator/SKILL.md`, lines 172–176.

> “Write the YAML frontmatter with `name` and `description`…” and “Write instructions for using the skill and its bundled resources.” — `/home/ubuntu/skills/skill-creator/SKILL.md`, lines 180–194.

따라서 기존 스킬 폴더를 “입력으로 받아 자동 리팩토링”하는 기능은 **미명시**이며, 확인된 워크플로는 **기존 스킬이면 초기화를 건너뛰고 수동 편집·검증·전달**하는 형태다.

---

## 4. 9개 일괄 처리 vs 1개씩 처리

| 항목 | 결론 |
|---|---|
| 9개 또는 다수 스킬 일괄 리팩토링·등록 | **미명시** |
| `init_skill.py` 호출 단위 | **1개 skill-name** |
| `quick_validate.py` 호출 단위 | **1개 skill-name 또는 1개 absolute path** |
| 잠정 보고 | **1개씩 호출이 기본 가정** |

`init_skill.py`는 인자 1개만 받는다.

> “Usage: init_skill.py <skill-name>” — `/home/ubuntu/skills/skill-creator/scripts/init_skill.py`, lines 5–7.

`quick_validate.py`도 인자 1개만 받으며, `<skill-name>` 또는 `<absolute-path-to-skill>` 하나를 validation 대상으로 한다.

> “Usage: quick_validate.py <skill-name>; quick_validate.py <absolute-path-to-skill>” — `/home/ubuntu/skills/skill-creator/scripts/quick_validate.py`, lines 5–8.

`progressive-disclosure-patterns.md`는 “multiple domains”나 “multiple frameworks or variants”를 하나의 skill 내부 reference 구성으로 다루는 구조 예시를 제공하지만, 다수의 독립 skill을 한 번에 생성·등록하는 절차는 아니다.

> “For Skills with multiple domains, organize content by domain…” and “Similarly, for skills supporting multiple frameworks or variants, organize by variant…” — `/home/ubuntu/skills/skill-creator/references/progressive-disclosure-patterns.md`, lines 26–53.

따라서 다수 스킬 일괄 처리 방식은 **미명시**이며, 현재 문서 근거로는 **1개씩 호출이 기본 가정**이다.

---

## 종합 결론

| 확인 항목 | 결론 | task-card 보강 시 주의점 |
|---|---|---|
| GitHub URL 직접 입력 | 미명시 | GitHub repo URL을 `skill-creator` 입력으로 넣는 설계는 근거 없음 |
| 로컬 디렉터리 입력 | 생성 위치 `/home/ubuntu/skills/<name>/` 명시, validation 절대경로 지원 명시 | “임의 폴더를 자동 리팩토링”은 미명시 |
| 기존 자료 리팩토링 | 자동 변환 미명시, 기존 skill이면 init 생략 후 편집 가능 | “리팩토링”은 마누스가 수동 파일 조정·검증하는 작업으로 정의 필요 |
| 9개 일괄 처리 | 미명시 | 1개 스킬당 1회 준비·검증·전달을 기본 가정으로 잡아야 함 |

**최종 판단**: Phase F task-card의 목표 문장은 “GitHub repo를 `skill-creator`가 직접 받아 리팩토링한다”가 아니라, “GitHub 백업본과 로컬 `r6-rollout-package/dubyeol-workflow-skills/`의 기존 9개 스킬 자료를 [Foreman]/[Builder]가 `/home/ubuntu/skills/<skill-name>/` 표준 위치에 1개씩 준비·검증하고, `skill-creator`의 검증·전달 절차로 Manus에 등록한다”로 보강하는 것이 사실 근거에 맞다.
