# PROJECT.md 갱신 메커니즘 + 안전 절차

본 문서는 `update_project_md.sh`의 *PROJECT.md 변경 안전 절차*를 정리.

## PROJECT.md의 5개 절

| 절 | 내용 | 갱신 빈도 |
|---|---|---|
| §A 기획 맥락 | 사업 비전·목표·문제 정의 | 분기 또는 카테고리 5 task |
| §B 중기 목표 | 현재 분기 목표·KPI | 분기 시작·종료 |
| §C 모듈 지도 + 진행 트래커 | 각 모듈의 진행 상태 ★ | **모든 task의 SUB-5 종료 시** |
| §D 결정 이력 | 큰 결정 누적 (append-only) | 큰 결정 발생 시 |
| §E 운영 정보 | 최근 task ID·갱신 시각 | 모든 task 종료 시 자동 |

본 스킬이 *자동 갱신*하는 영역: **§C·§D·§E**.

## 갱신 경로 — task-card §10 → PROJECT.md

**원칙**: PROJECT.md는 *task-card를 통해서만* 갱신. [Foreman] 단독 임의 수정 절대 금지.

```
task 진행 중
   ↓ 모듈 진행 변화 발생
task-card §10.1 작성 (마누스)
   ↓ 큰 결정 발생 시
task-card §10.2 작성 (마누스)
   ↓ SUB-5 §3 진입
update_project_md.sh 실행
   ↓
PROJECT.md §C·§D·§E 갱신
   ↓
diff 출력 — 마누스 검토
   ↓
[Owner] 승인
   ↓
별도 단계로 commit (push 또 별도 승인)
```

## 안전 절차 — 5단계

### Step 1 — task-card §10 확인

```bash
# task-card §10이 채워져 있는지
awk '/^## §10/,EOF' .harness/runs/<run_id>/task-card.md
```

§10이 *비어있거나 부정확*하면:
- 마누스가 task 결과 회상해서 §10 수동 작성
- 작성 못 하겠으면 PROJECT.md 갱신 *건너뜀* + [Owner] 보고

### Step 2 — PROJECT.md 백업

```bash
cp PROJECT.md .harness/runs/<run_id>/PROJECT-before.md
echo "백업: .harness/runs/<run_id>/PROJECT-before.md"
```

백업 의무 — 자동 갱신 실수 시 복원 경로.

### Step 3 — §C 모듈 진행 갱신

task-card §10.1에서:
- "§C.[N] 모듈" 식별
- "어떤 항목이 어떻게 변경됐는지" 추출
- PROJECT.md §C.[N] 해당 위치에 *append* 또는 *상태 표시 변경*

**자동 갱신 제한**:
- 새 모듈 추가 (§C.[N+1]) — *자동 금지*. [Owner] 명시 승인 + 카테고리 5 task 필요
- 모듈 삭제 — *자동 금지*. [Owner] 명시 승인 필요
- 모듈 *진행 상태 변경* — 자동 OK

### Step 4 — §D 결정 이력 (해당 시)

task-card §10.2에 결정 이력 있으면:
- PROJECT.md §D *맨 아래에 append*
- 양식: `- YYYY-MM-DD: <한 줄 결정> (run_id: <id>)`
- 기존 §D 항목 *절대 수정·삭제 금지*

### Step 5 — diff 출력 + 검토 대기

```bash
git diff PROJECT.md > .harness/runs/<run_id>/project-md-diff.patch
cat .harness/runs/<run_id>/project-md-diff.patch
```

diff 출력 후 *스크립트는 종료*. *commit 실행 안 함*.

마누스가 diff 검토 후 [Owner]께 보고:
```
[PROJECT.md 갱신 보고]
run_id: <run_id>
변경 절: §C.[N] / §D / §E
변경 요약: <한 줄>
diff: .harness/runs/<run_id>/project-md-diff.patch

승인 시 commit 진행, 거부 시 백업에서 복원.
```

## [Owner] 거부 시 — 복원

```bash
cp .harness/runs/<run_id>/PROJECT-before.md PROJECT.md
echo "복원 완료. 변경 사항 제거됨."
```

## [Owner] 승인 시 — commit (별도 단계)

```bash
git add PROJECT.md
git commit -m "docs: PROJECT.md update — <run_id> SUB-5 §3"
# push는 또 별도 [Owner] 승인 필요
```

## 자동 갱신 절대 금지 영역

| 영역 | 사유 |
|---|---|
| §A 기획 맥락 | 사업 비전 영역. 카테고리 5 task만 |
| §B 중기 목표 | 분기 영역. 일반 task 변경 금지 |
| 새 모듈 (§C.[N+1]) | [Owner] 명시 승인 + 카테고리 5 task 필요 |
| 모듈 삭제 | [Owner] 명시 승인 필요 |
| §D 기존 항목 수정·삭제 | append-only 원칙 (역사 보존) |
| commit/push 자동 | 권한 천장 — [Owner] 명시 승인 후만 |

## 자가 점검 (스킬 실행 후 의무)

- [ ] PROJECT-before.md 백업 생성됨
- [ ] §A·§B 변경 없음
- [ ] 새 모듈 추가 안 함
- [ ] 모듈 삭제 안 함
- [ ] §D 기존 항목 보존 (append만)
- [ ] diff 출력만 — commit 안 함
- [ ] 마누스가 diff 검토 + [Owner] 보고

7개 모두 통과한 후에만 다음 단계 (commit 별도).
