---
name: 09-update-project-md
description: 마누스가 SUB-5 §3 진입 시 PROJECT.md를 자동 갱신하는 스킬. task-card §10 PROJECT.md 갱신 사항을 읽어 PROJECT.md §C 모듈 진행과 §D 결정 이력에 반영. 변경 diff는 자동 commit 안 하고 마누스 검토·[Owner] 승인 후 commit. silkroadhub 두별 워크플로우 v3.6.0 r1 베타 SUB-5 §3 표준 절차.
---

# 09-update-project-md

마누스가 task 종료 시 PROJECT.md *살아있는 트래커* 자동 갱신.

## 언제 호출하는가

- SUB-5 §3 진입 시 (final-report 작성 완료 후)
- task-card §10에 PROJECT.md 갱신 사항이 채워진 상태

## 동작 순서

1. `scripts/update_project_md.sh <run_id>` 실행
2. task-card §10에서 갱신 사항 추출
3. PROJECT.md *백업* (`.harness/runs/<run_id>/PROJECT-before.md`)
4. PROJECT.md §C.[N] 모듈 진행 갱신
5. task-card §10.2에 결정 이력 있으면 PROJECT.md §D에 추가
6. PROJECT.md §E 운영 정보 갱신 (마지막 task ID·갱신 시각)
7. diff 출력
8. 마누스가 *diff 검토 후* [Owner] 승인 받음
9. 승인 후 commit (별도 단계)

## 호출

```bash
# 저장소 루트에서 실행
zsh 09-update-project-md/scripts/update_project_md.sh <run_id>

# 비대화형 (드래프트만 생성, PROJECT.md 미적용)
zsh 09-update-project-md/scripts/update_project_md.sh <run_id> --no-interactive
```

## 핵심 안전선

- *자동 commit 절대 금지* — diff 출력만. commit은 [Owner] 명시 승인 후 *별도 단계*
- task-card §10이 *비어있거나 부정확*하면 마누스가 수동 보강 후 재실행
- PROJECT.md 변경은 *운영 문서 변경*에 해당 — Tier A 처리

## 산출물

- `.harness/runs/<run_id>/PROJECT-before.md` — 갱신 전 백업
- `.harness/runs/<run_id>/project-md-diff.patch` — 변경 diff
- `PROJECT.md` (작업 디렉터리 변경 상태)

## 결과 처리

1. 마누스가 diff 검토
2. [Owner]께 PROJECT.md 갱신 사실 + 주요 변경 보고
3. [Owner] 명시 승인 후:
   - 변경 적용 유지
   - 별도 단계로 git commit (push는 또 별도 승인)
4. 거부 시:
   - 백업에서 복원 (`cp PROJECT-before.md PROJECT.md`)

## 참조

- silkroadhub `SUB-5-종료.md` §3
- silkroadhub `PROJECT.md` §E 갱신 메커니즘
