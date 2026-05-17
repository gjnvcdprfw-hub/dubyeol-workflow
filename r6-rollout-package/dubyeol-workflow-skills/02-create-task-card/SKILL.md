---
name: 02-create-task-card
description: 마누스가 SUB-1 의도 정렬 5단계 SOP 완료 후 task-card.md를 자동 작성하는 스킬. [Owner] 발화·의도 정렬 증거 블록·Tier 판정·카테고리 결정을 task-card 양식에 맞춰 채움. 초안 생성 후 마누스가 §3.5 가정·§5 산출물·§6 진행 트리 등 판단 영역을 직접 보강. silkroadhub 두별 워크플로우 v3.6.0 r1 베타 SUB-1 §3·SUB-2 §1 표준 절차.
---

# 02-create-task-card

마누스가 의도 정렬 5단계 SOP 완료 후 task-card.md 자동 작성.

## 언제 호출하는가

- SUB-1 §2 의도 정렬 SOP 완료 (3중 재구성·모호어 스캔·가정 명시·정렬 확인·증거 고정 모두 통과)
- run_id 결정 후 (`<YYYYMMDD>_<task-slug>`)

## 입력

| 필드 | 설명 |
|---|---|
| `run_id` | 예: `20260516_manifest-fix` |
| `owner_utterance_file` | [Owner] 원 발화 저장 파일 |
| `intent_alignment_file` | SOP 5단계 결과 (한 문장 목표·Looks Like·Looks Wrong·가정·증거) |
| `tier` | A/B/C |
| `category` | 1~5 |

## 동작 순서

1. `scripts/create_task_card.sh` 실행
2. `.harness/runs/<run_id>/task-card.md` 자동 생성:
   - §1 [Owner] 원 발화 (입력 파일에서)
   - §2 상위 맥락 연결 (마누스가 PROJECT.md에서 추출 — *수동 보강 필요*)
   - §3 의도 정렬 증거 블록 (입력 파일에서)
   - §4 Tier·카테고리·플랜
   - §5 산출물 + 완료 기준 — *수동 보강 필요*
   - §6 진행 트리 (카테고리별 자동) — 변형 사유 *수동 보강*
   - §7 마스킹 적용 영역
   - §8 권한 천장·금지 사항
   - §9 변경 이력
   - §10 PROJECT.md 갱신 사항 *템플릿만 박음 — SUB-5에서 채움*
3. 자동 생성 후 *마누스가 수동 보강 영역* 채우기:
   - §2 상위 맥락 연결
   - §5 산출물 + 완료 기준
   - §6 변형 사유 (해당 시)
4. [Owner] 결재 요청

## 호출

```bash
# 저장소 루트에서 실행
zsh 02-create-task-card/scripts/create_task_card.sh <run_id> <owner_utterance_file> <intent_alignment_file> <tier> <category>
```

## 핵심 안전선

- 스킬은 *초안 자동 생성*만. 마누스의 *판단 영역*은 수동 보강 의무
- §3.5 가정은 *반드시 3개 이상*. 자동 생성에서 부족하면 마누스가 추가
- §5 산출물·완료 기준은 *마누스 판단* — 자동 생성 안 함
- §8 권한 천장 *기본값* 자동 박힘. 추가 금지 항목은 수동

## 산출물

- `.harness/runs/<run_id>/task-card.md` — 초안 (수동 보강 필요)

## 참조

- `.harness/templates/task-card-template.md` (REPO_ROOT 기준)
- `SUB-1-기획의도.md` §3
