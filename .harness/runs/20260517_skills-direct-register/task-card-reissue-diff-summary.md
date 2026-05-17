# Phase F task-card 재발행 비교 요약

**run ID**: 20260517_skills-direct-register  
**작성자**: [Foreman]  
**목적**: `skill-creator` 입력 방식 사실 확인 결과를 반영해 task-card 보강 6건의 정정 전·후를 요약한다.

---

## 1. 보강 반영 요약

| 보강 | 반영 위치 | 정정 전 | 정정 후 |
|---|---|---|---|
| 1 | §3.1 한 문장 목표 | `skill-creator` 전달 메커니즘을 활용해 9개 스킬을 Manus에 직접 등록 | 로컬 기존 9개 스킬 자료를 `/home/ubuntu/skills/<skill-name>/` 표준 위치에 **1개씩** 준비·검증하고, `skill-creator` validation·delivery 절차(Step 3 skip → Step 4·5)로 등록 |
| 2 | §3.5 가정 1 | `/home/ubuntu/skills/*/SKILL.md` 첨부가 `.skill` 카드로 패키징됨 | `/home/ubuntu/skills/<skill-name>/`에 **1개 스킬**이 준비된 상태에서 `SKILL.md`를 첨부하면 `.skill` 카드가 노출되며, 9개는 1회씩 9번 반복하는 기본 가정으로 명시 |
| 3 | §3.5 가정 3 | Add to My Skills 클릭은 계정 설정성 조작일 수 있어 확인 또는 takeover 필요 | `.skill` 카드 노출까지가 [Builder] 자동 단계이고, “Add to My Skills” 클릭은 [Owner] 계정 등록 행위이므로 [Owner] 권한으로 명시 |
| 4 | §5.1 Scope | 9개 스킬 폴더를 `/home/ubuntu/skills/`로 준비 | `01-*`~`09-*`를 `/home/ubuntu/skills/<skill-name>/`에 1개씩 복사. GitHub URL 입력 경로는 미명시이므로 사용하지 않음. 마누스 환경에 자료가 없으면 git clone 또는 동등 명령으로 로컬 확보 후 복사 |
| 5 | §7, §5.3, §10.5 | 환경 기준·산출물 흐름·handoff 의무가 충분히 분리되지 않음 | §7 머리에 마누스 [Builder] 환경 기준을 명시. §5.3에 환경간 산출물 흐름 추가. §10.5에 handoff 필수 기록 항목 7개 추가 |
| 6 | §8 권한 경계 | [Owner] 확인 없는 계정 설정성 최종 등록 클릭 금지 | `.skill` 카드 노출은 [Builder] 권한, “Add to My Skills” 클릭은 [Owner] 권한으로 더 명확히 추가 |

---

## 2. §9 의도 변경 기록 추가 여부

| 항목 | 결과 |
|---|---|
| §9 추가 블록 | **추가 없음** |
| 사유 | 본 보강은 task 목표 자체 변경이 아니라 `skill-creator` 입력 방식 사실 확인 결과를 반영한 절차 명료화다. [Owner] 지시대로 §3.4·§3.5 본문 정정 및 관련 Scope·검증·권한 보강만 수행했다. |
| 현재 §9 문구 | `없음.` 유지 |

---

## 3. 재발행 산출물

| 산출물 | 경로 |
|---|---|
| 보강 반영 task-card | `.harness/runs/20260517_skills-direct-register/task-card.md` |
| 입력 방식 사실 확인 보고 | `.harness/runs/20260517_skills-direct-register/skill-creator-input-mode-check.md` |
| 본 비교 요약 | `.harness/runs/20260517_skills-direct-register/task-card-reissue-diff-summary.md` |

---

**비교 요약 끝.**
