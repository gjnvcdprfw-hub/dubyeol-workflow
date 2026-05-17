# SUB-5 pre-report check

## task-card headings
```text
12:## 1. [Owner] 발화 원문
26:## 2. 상위 맥락 연결 (PROJECT.md 진입 시점)
37:## 3. 의도 정렬 증거 블록 (SUB-1 §2 SOP 결과 — 불변)
89:## 4. Tier 판정
101:## 5. 작업 범위 (Scope)
144:## 6. 진행 트리 (두별 워크트리)
158:## 7. 검증 명령
185:## 8. 권한 천장·금지 사항 (재확인)
206:## 9. 의도 변경 기록 (해당 시만 추가)
212:## 10. PROJECT.md 갱신 사항 (task 종료 시 [Foreman] 작성, SUB-5)
254:## 11. 다음 단계 진행 가이드
263:## References
```

## task-card section 10 candidate
```text
## 10. PROJECT.md 갱신 사항 (task 종료 시 [Foreman] 작성, SUB-5)

### 10.1 §C.[N] 모듈 갱신

- **현재 상태**: silkroadhub §C.1에 두별 워크플로우 운영 인프라가 존재 → 두별 워크플로우 마스터 `dubyeol-workflow/PROJECT.md` §C로 이전됨.
- **최근 마일스톤에 추가**: Phase H에서 두별 워크플로우 마스터/클라이언트 분리 완료.
- **다음 마일스톤에서 완료 처리(체크)**: Phase F 9개 스킬 직접 등록 완료 및 Phase H 마스터 분리 완료.
- **다음 마일스톤에 추가**: Phase G-1 동작 검증 설계, Phase G 스킬 동작 검증, r7 정비.
- **현재 막힌 점**: Phase H 완료 전까지 Phase G-1 보류. Phase H 완료 후 해소.

### 10.2 §D 결정 이력 추가 (큰 결정 발생 시)

- **날짜**: 2026-05-17
- **결정**: 두별 워크플로우를 silkroadhub 내부 운영물이 아니라 독립 마스터 운영 프레임워크/도구킷으로 분리한다.
- **사유**: silkroadhub는 첫 번째 사업 클라이언트이며, 향후 다른 사업 프로젝트도 같은 운영 프레임워크를 가져와 적용해야 하므로 운영 원본·회고·스킬·매뉴얼을 마스터에서 관리해야 한다.
- **영향 모듈**: silkroadhub `PROJECT.md` §C.1 제거, `dubyeol-workflow/PROJECT.md` §C·§D 신설.

### 10.3 §A·§B 갱신 (카테고리 5 기획 task일 때만)

해당 없음.

### 10.4 PROJECT.md 반영 확인

- **반영 일시**: SUB-5에서 작성.
- **PROJECT.md §E.마지막 갱신 task run ID에 박은 값**: 20260517_dubyeol-workflow-master-split

### 10.5 handoff.md 작성 의무

| 의무 항목 | 필수 기록 내용 |
|---|---|
| 단계별 결과 | §5.1의 7개 실행 체크포인트별 PASS/FAIL/보류 및 근거 |
| 이전 파일 수 대조 | silkroadhub 이전 전 파일 수, silkroadhub 이전 후 파일 수, `dubyeol-workflow` 이전 후 파일 수 |
| 이전 범위 확정 | Phase A~F로 확정한 run 목록, 제외한 run 목록, `test_claude_dispatch` 이전/잔존 결정 근거 |
| git log 무결성 | `git log --follow` 샘플 검증 대상 파일과 결과 요약 |
| GitHub rename 검증 | rename 전 URL, rename 후 URL, old URL redirect, clone/fetch/push redirect 확인 결과. push는 Owner 승인 전 실제 수행 금지 |
| remote URL 기록 | silkroadhub local remote URL은 변경 없음으로 기록. `dubyeol-workflow` local에서 GitHub remote 연결 시점과 URL 기록 |
| PROJECT.md 분리 | `silkroadhub/PROJECT.md` §C.1 제거·§D 추가 결과와 `dubyeol-workflow/PROJECT.md` §C 재배치·§D 회고 1~14 이전 결과를 별개로 기록 |
| cleanup 검증 | silkroadhub에 두별 원본이 중복 잔존하지 않는지, 사업 자료가 삭제되지 않았는지 확인 결과 |
| 권한 천장 | push/merge/deploy/history rewrite/파괴적 삭제 미수행 여부, Owner rename 수행 시점 |

---

## 11. 다음 단계 진행 가이드
```

## silkroadhub PROJECT E
```text
94:- **마지막 갱신**: 2026-05-17 KST
95:- **마지막 갱신 task run ID**: 20260517_dubyeol-workflow-master-split
96-
97-### E.1 갱신 메커니즘
--
113:1. 본 §E 상단의 *마지막 갱신 task run ID* — 가장 최근 1건
114-2. `.harness/runs/*/task-card.md`의 *PROJECT.md 갱신 사항* 섹션 — 전체 이력
115-
--
150:- PROJECT.md §E.마지막 갱신 task run ID 박은 값: [run ID]
151-```
152-
```

## dubyeol PROJECT markers
```text
53:## C. 자주 갱신 — 모듈별 진행 상황 ★
55:### §C.1 두별 워크플로우 운영 인프라
76:## D. 매번 갱신 — 결정 이력 + 회고 1~14
116:## E. 운영 정보
118:- **마지막 갱신**: 2026-05-17 KST
119:- **마지막 갱신 task run ID**: 20260517_dubyeol-workflow-master-split (Phase H)
```

## silkroadhub status count
```text
      70
```

## dubyeol status
```text
[31m??[m .gitignore
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
