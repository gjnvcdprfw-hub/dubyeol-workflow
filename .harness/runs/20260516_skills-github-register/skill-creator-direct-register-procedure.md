# skill-creator direct register procedure — Phase D 재해석 근거

**run ID**: 20260516_skills-github-register  
**작성일시**: 2026-05-17 KST  
**작성자**: [Foreman]

---

## 1. 확인된 스킬 이름

마누스 환경에 이미 설치된 자체 스킬 생성 스킬의 정확한 이름은 `skill-creator`다. `/home/ubuntu/skills/skill-creator/SKILL.md`의 frontmatter에는 다음과 같이 기록되어 있다.

| 항목 | 값 |
|---|---|
| name | `skill-creator` |
| description 핵심 | 전문 지식, 워크플로 또는 도구 통합을 통해 Manus를 확장하는 스킬을 생성하거나 업데이트하기 위한 가이드 |

`skill-creator`는 새 스킬을 `/home/ubuntu/skills/<skill-name>/` 아래에 만들고, `SKILL.md`와 선택 리소스(`scripts/`, `references/`, `templates/`)를 구성한 뒤 검증·전달하는 절차를 제공한다.

---

## 2. 핵심 사용법

`skill-creator` 문서 기준의 핵심 절차는 다음과 같다.

| 단계 | 절차 | 본 Phase F 적용 |
|---|---|---|
| 초기화 | `python /home/ubuntu/skills/skill-creator/scripts/init_skill.py <skill-name>` | 이미 9개 스킬 폴더가 있으므로 신규 템플릿 초기화는 생략 가능 |
| 편집 | `/home/ubuntu/skills/<skill-name>/SKILL.md` 및 resources 구성 | `r6-rollout-package/dubyeol-workflow-skills/<skill>/`를 `/home/ubuntu/skills/<skill>/`로 복사 |
| 검증 | `python /home/ubuntu/skills/skill-creator/scripts/quick_validate.py <skill-name>` | 9개 스킬 각각 quick_validate 실행 |
| 전달 | `/home/ubuntu/skills/{skill-name}/SKILL.md`를 사용자에게 첨부 | 시스템이 `.skill` card로 패키징하고 “Add to My Skills” 옵션 제공 |

`skill-creator` 문서에는 SKILL.md 경로를 메시지 첨부로 전달하면 시스템이 `/home/ubuntu/skills/*/SKILL.md` 패턴을 감지해 스킬 디렉터리를 `.skill` 파일로 패키징하고, 프론트엔드에서 `Add to My Skills`, `Download`, `Preview` 옵션을 제공한다고 적혀 있다.

---

## 3. Phase D 재해석

GitHub import 경로가 실패한 것은 “스킬 자체 동작 실패”가 아니라 **등록 경로 가정 오류**로 재해석한다. GitHub 저장소는 백업·공개 자료·버전 추적용으로 유효하며, 실제 마누스 내 등록은 `skill-creator` 전달 메커니즘을 통해 진행하는 것이 현재 확인된 정답 경로다.

| 항목 | 기존 해석 | 정정 해석 |
|---|---|---|
| GitHub 저장소 push | import 전제 산출물 | 백업·공개·버전 추적 산출물로 유효 |
| Import from GitHub 미인식 | import 실패 또는 multi-skill 미지원 | 애초에 본 목적에 맞지 않는 등록 경로를 사용한 것 |
| 정정안 A·B·C·D | 하위 폴더 import·루트 SKILL.md·9개 repo·zip upload | 모두 보류/무효. `skill-creator` 직접 등록 절차로 전면 재설계 |
| PROJECT.md 상태 | 검증중 | GitHub import 경로 무효 확인. 마누스 자체 스킬 생성 스킬 활용으로 후속 재진입 예정 |

---

## 4. Phase F 직접 등록 절차 초안

Phase F의 실무 절차는 다음과 같이 잡는 것이 타당하다.

| 순서 | 작업 | 검증 |
|---:|---|---|
| 1 | `r6-rollout-package/dubyeol-workflow-skills/01-*`~`09-*`를 `/home/ubuntu/skills/` 아래로 복사 | 각 폴더에 `SKILL.md`, `scripts/`, `references/` 존재 확인 |
| 2 | README.md와 LICENSE는 스킬 디렉터리 밖 보조 문서로 유지하거나 각 스킬에는 포함하지 않음 | `skill-creator` 지침상 Skills에는 README.md를 포함하지 않는 것이 원칙 |
| 3 | 9개 스킬 각각 `quick_validate.py <skill-name>` 실행 | validation 통과 또는 수정 필요 사항 기록 |
| 4 | 9개 `SKILL.md`를 final delivery 메시지에 첨부 | 프론트엔드에서 9개 `.skill` card 또는 Add to My Skills 가능 여부 확인 |
| 5 | 추가 후 `/01-load-sub-manual` 등 slash command 노출 여부 확인 | 9개 명칭 검색 또는 slash command 목록 확인 |

---

## 5. 남은 확인 사항

| 확인 사항 | 현재 상태 |
|---|---|
| 9개 SKILL.md를 한 메시지에 모두 첨부할 때 9개 카드가 생성되는지 | [미확인] |
| 대표님이 “Add to My Skills”를 직접 눌러야 하는지, 마누스가 자동 등록 가능한지 | [미확인] — 계정 설정 변경이므로 사용자 확인/조작 가능성 있음 |
| 기존 동일명 스킬이 있을 때 overwrite/update 동작 | [미확인] |

---

**procedure 끝.**
