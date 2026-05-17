---
name: 08-write-final-report
description: 마누스가 SUB-5 §2 진입 시 final-report.md 초안을 자동 작성하는 스킬. task-card·handoff·gate-review·plan-review를 읽어 final-report §1~§9를 자동 채움. §10 PROJECT.md 갱신 사항·§11 후속 task 후보·§12 회고는 마누스가 직접 작성. silkroadhub 두별 워크플로우 v3.6.0 r1 베타 SUB-5 §2 표준 절차.
---

# 08-write-final-report

마누스가 task 종료 시 [Owner]께 final-report 작성. 자동 인용 + 수동 판단 결합.

## 언제 호출하는가

- SUB-5 §2 진입 시 (handoff·gate-review 모두 완료된 후)

## 동작 순서

1. `scripts/write_final_report.sh <run_id>` 실행
2. `.harness/runs/<run_id>/final-report.md` 자동 생성:
   - §1 task 요약 — task-card §1·§3에서 추출
   - §2 진행 결과 — handoff에서 추출
   - §3 산출물 — handoff §2.2·task-card §5에서 매칭
   - §4 검증 결과 — handoff §4·§5에서 추출
   - §5 외부 감리 결과 — gate-review §1·§2에서 추출
   - §6 plan-review 결과 — plan-review.md 있으면 추출 (선택)
   - §7 변경 파일 (git status) — git에서 직접
   - §8 fix-loop 기록 — handoff 또는 별도 fix-log
   - §9 권한 천장 점검 — verify-handoff 결과 인용
   - §10 PROJECT.md 갱신 사항 *마누스 수동 작성*
   - §11 후속 task 후보 *마누스 수동 작성*
   - §12 회고 (베타 어색함) *마누스 수동 작성*
   - §13 마누스 짚을 점 *수동*
3. 마누스가 §10~§13 채우기
4. [Owner]께 final-report 제출

## 호출

```bash
bash scripts/write_final_report.sh <run_id>
```

## 핵심 안전선

- *자동 인용은 기계적 복사*. 의미 손실 위험 — 마누스가 *검토*
- §10·§11·§12·§13은 *판단 영역*. 자동 생성 안 함
- 자동 인용이 *마스킹된 데이터*만 다루는지 확인 (마스킹 위반 재발 방지)

## 산출물

- `.harness/runs/<run_id>/final-report.md` — 초안 (수동 보강 필요)

## 참조

- silkroadhub `.harness/templates/final-report-template.md`
- silkroadhub `SUB-5-종료.md` §2
