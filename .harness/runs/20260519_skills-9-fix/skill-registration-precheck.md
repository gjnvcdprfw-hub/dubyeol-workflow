# skill-registration-precheck — Task 3 정정본 9개 스킬 등록 준비

**run ID**: `20260519_skills-9-fix`  
**작성일시**: 2026-05-17 KST  
**작성자**: [Foreman]  
**목적**: Task 3 SUB-2 정정본 9개 스킬을 commit 없이 마누스 환경 등록 카드로 전달하기 전, 로컬 마스터 정정본과 sandbox staging의 일치성을 확인한다.

---

## 1. 소스와 staging

| 구분 | 경로 | 상태 |
|---|---|---|
| 로컬 마스터 소스 | `/Users/twostars/ClaudeAi/dubyeol-workflow/r6-rollout-package/dubyeol-workflow-skills/` | Task 3 SUB-2 정정본 존재 |
| sandbox staging | `/home/ubuntu/skill-registration-20260519-skills-9-fix/` | tar 복사·해제 완료 |
| 원격 tar | `/Users/twostars/ClaudeAi/dubyeol-workflow/tmp/skills9-task3-registration.tgz` | 생성 완료 |

---

## 2. 구조 검증

| 항목 | 결과 |
|---|---|
| `SKILL.md` 개수 | 9개 |
| `scripts/*.sh` 개수 | 10개 |
| macOS AppleDouble `._*` 보조 파일 | staging에서 삭제 완료 |
| frontmatter `name` | 9개 모두 디렉터리명과 일치 |
| frontmatter `description` | 9개 모두 존재 |

---

## 3. 일치성 검증

로컬 마스터 소스와 sandbox staging의 30개 파일에 대해 SHA-256 매니페스트를 생성해 비교했다. 비교 결과는 `MANIFEST_MATCH=YES`다.

| 매니페스트 | 파일 수 | 결과 |
|---|---:|---|
| source | 30 | 정상 |
| staging | 30 | 정상 |
| source ↔ staging diff | 0 | 일치 |

---

## 4. zsh syntax 검증 관련 주의

sandbox에는 `zsh` 명령이 없어 staging에서 `zsh -n`을 직접 실행하지 못했다. 다만 Builder SUB-2 handoff 및 Foreman raw verification에서 로컬 macOS 원본 소스 기준 10개 스크립트의 `zsh -n` 검증이 모두 통과했고, 이번 precheck에서 원본 소스와 staging의 SHA-256 매니페스트가 1:1 일치함을 확인했다. 따라서 staging 스크립트는 로컬 원본과 동일한 정정본으로 판단한다.

---

## 5. 등록 확정 경계

본 단계는 등록 카드 준비까지만 수행한다. 최종 Add/Save 또는 등록 확정 클릭은 [Owner]가 수행해야 하며, Foreman은 [Owner] 클릭 전 등록 확정을 수행하지 않는다.

---

**skill-registration-precheck 끝.**
