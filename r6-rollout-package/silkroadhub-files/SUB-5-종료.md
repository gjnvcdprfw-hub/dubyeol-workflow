# SUB-5: 종료 매뉴얼

> **두별 워크플로우 v3.6.0 r1 (베타)**
> **상위**: 본 매뉴얼은 마누스 프로젝트 지침의 5단계 라우팅 중 *단계 5*에 해당
> **호출 트리거**: SUB-2 통과 (Tier C) / SUB-3 통과 (Tier A/B) / SUB-4 재검증 후 / [Owner] "종료 매뉴얼 봐" 발화
> **독자**: [Foreman] (manus.im)
> **주인공**: [Foreman] (작성) + [Owner] (결재)
> **산출물**: `runs/<run_id>/final-report.md` + PROJECT.md §C.N 갱신 + task-card §10 작성

---

## 0. 본 매뉴얼의 강제력

- **§3 PROJECT.md 갱신 의무**: task-card §10 작성 후 PROJECT.md §C.N에 *실제 옮김*. 옮기지 않으면 SUB-5 종료 금지
- **§4 final-report §2 의도↔결과 매칭표는 *필수***. task-card §3과 항목별 1:1 매칭
- **§6 [Owner] 결재는 *명시 응답*만 유효**. 침묵 동의 금지
- **§7 후속 명시 승인 없이 push/merge/deploy 절대 금지**
- final-report 작성 없이 task 종료 금지

---

## 1. SUB-5 진입 직후 [Foreman] 첫 행동

1. 진입 경로 확인:
   - SUB-2 직접 진입 (Tier C) — handoff 통과
   - SUB-3 진입 (Tier A/B) — 감리 통과
   - SUB-4 후 진입 — 수정 후 재검증 통과 또는 폐기 결정
2. run 폴더 내 파일 점검:
   - `task-card.md` 존재
   - `handoff.md` 존재
   - `gate-review.md` 존재 (Tier A/B만)
3. `final-report-template.md` 양식 로드
4. PROJECT.md 로드 — §C 모듈 *현재 상태* 확인 (갱신 전 비교용)

---

## 2. final-report 작성 순서

> **스킬 호출 가능**: `/08-write-final-report` (마누스 Skills 설치 시). §1~§9 자동 인용, §10~§13은 마누스 수동 보강.

`final-report-template.md` 양식 따라 *순서대로*:

| 절 | 작성 내용 | 입력 자료 |
|---|---|---|
| §1 요청 요약 | task-card §1 발화를 한 단락으로 재확인 | task-card §1 |
| §2 의도↔결과 매칭표 ★ | task-card §3 vs handoff §1 항목별 매칭 | task-card §3, handoff §1 |
| §3 완료 결과 | 완료·보류·실패 항목 + 산출물 위치 | handoff §2 |
| §4 검증 결과 | 명령·exit code·fresh 여부 | handoff §2.2 |
| §5 감리 결과 요약 | gate-review 핵심 인용 (Tier A/B) 또는 "해당 없음" (Tier C) | gate-review §1·§2·§3 |
| §6 두별 워크트리 준수 요약 | 카테고리·트리 준수 여부 | handoff §3 |
| §7 권한 천장·마스킹 준수 | handoff §6·§7 종합 | handoff §6·§7 |
| §8 수정 루프 기록 | SUB-4 발동 시 fix-loop 차수·결과 | SUB-4 산출 |
| §9 남은 리스크 | 운영·보안·데이터·스코프·환경 | 종합 판단 |
| §10 PROJECT.md 갱신 반영 확인 | §3 결과 (아래 §3 절차) | — |
| §11 [Owner] 결재 안건 | 결재 옵션 + 후속 명시 승인 필요 사항 | §7 권고 |
| §12 회고 ★ | r6 매뉴얼·양식 어색함 + 새 발견 패턴 | SUB-4 §6.2 누적 자료 |
| §13 최종 결론 | 항목화된 종합 | 전 절 종합 |

---

## 3. PROJECT.md

> **스킬 호출 가능**: `/09-update-project-md` (마누스 Skills 설치 시). diff 출력만, commit은 별도. 갱신 — task-card §10을 PROJECT.md §C.N에 옮기기 ★

### 3.1 task-card §10 작성

task-card §10에 다음을 박음 (task-card-template.md §10 그대로):

- §10.1 §C.[N] 모듈 갱신 (현재 상태·최근 마일스톤·다음 마일스톤·막힌 점)
- §10.2 §D 결정 이력 추가 (해당 시)
- §10.3 §A·§B 갱신 (카테고리 5 기획 task일 때만)
- §10.4 PROJECT.md 반영 확인

### 3.2 PROJECT.md §C.N 실제 반영

task-card §10에 박힌 내용을 PROJECT.md §C.N에 *그대로 옮김*. 옮길 때:

1. PROJECT.md §C.N 모듈 섹션 찾기
2. **현재 상태** 갱신
3. **최근 마일스톤**에 항목 추가 (시간 역순, 최신이 위)
4. **다음 마일스톤** 갱신:
   - 완료된 항목: `- [x]` 또는 *최근 마일스톤으로 이동*
   - 새 항목 추가
5. **현재 막힌 점** 갱신

### 3.3 §D 결정 이력 추가 (해당 시)

큰 결정이 발생했으면 PROJECT.md §D에 한 줄 추가 (시간 역순):

| 날짜 | 결정 | 사유 | 영향 모듈 |
|---|---|---|---|
| YYYY-MM-DD | [한 줄] | [한 줄] | §C.[N], §C.[M] |

### 3.4 §A·§B 갱신 (카테고리 5 기획 task만)

카테고리 5 task에서 §A·§B가 갱신됐으면 해당 절 반영.

### 3.5 §E 운영 정보 갱신

- **마지막 갱신**: 오늘 날짜
- **마지막 갱신 task run ID**: 본 task run ID

### 3.6 final-report §10에 반영 확인 박음

```
- [x] task-card §10.1 모듈 갱신 → PROJECT.md §C.[N] 반영
- [x] task-card §10.2 결정 이력 → PROJECT.md §D 반영 (해당 시)
- [x] task-card §10.3 §A·§B 갱신 → PROJECT.md §A·§B 반영 (카테고리 5만)
- [x] PROJECT.md §E.마지막 갱신 task run ID: <run_id>
- [x] PROJECT.md §E.마지막 갱신 일시: YYYY-MM-DD
```

---

## 4. 의도↔결과 매칭표 작성 (final-report §2)

본 매칭표가 final-report의 *핵심*. 의도 추적성의 결산.

### 4.1 §2.1 Looks Like 매칭

task-card §3.2 Looks Like 항목 N개를 *각각* 매칭:

| task-card §3.2 항목 | 실제 결과 | 정렬 |
|---|---|---|
| [원문 그대로] | [handoff §1.1 또는 직접 검증 결과] | ✅ / ⚠️ / ❌ |

*과반수가 ❌·⚠️면* SUB-4 회귀 검토 (이미 SUB-4 거쳤다면 fix-loop 추가).

### 4.2 §2.2 Looks Wrong 방어 결과

task-card §3.3 Looks Wrong 항목을 *각각* 매칭:

| task-card §3.3 항목 | 발생 여부 | 방어 성공 |
|---|---|---|
| [원문 그대로] | 미발생 / 발생 | ✅ / ❌ |

*하나라도 발생*하면 SUB-4 회귀 검토.

### 4.3 §2.3 가정 사후 검증

task-card §3.5 가정 3가지 *각각*:

| 가정 | 사후 검증 결과 |
|---|---|
| 가정 1 | 맞았음 ✅ / 틀렸음 ❌ / 부분 ⚠️ — [근거] |
| 가정 2 | ... |
| 가정 3 | ... |

*2개 이상 틀림*이면 의도 정렬 실패 가능성 — SUB-4 §1.3 카테고리 A 회귀 검토.

### 4.4 §2.4 의도 변경 이력

task-card §9 변경 이력이 있으면 요약 + *최종 의도와 일치 여부*.

---

## 5. 회고 작성 (final-report §12)

r6 베타의 *다음 r 개정* 입력. *어색한 부분*과 *새 발견*을 누적.

### 5.1 §12.1 잘 작동한 부분

본 task에서 r6 매뉴얼·양식의 어느 부분이 *잘 작동*했는지.

### 5.2 §12.2 어색했던 부분

| 어디 | 무엇 | 다음 r 개정 제안 |
|---|---|---|
| [매뉴얼·양식 위치] | [어색했던 것] | [제안] |

SUB-4를 거쳤다면 SUB-4 §6.2 누적 자료를 *여기로 이전*.

### 5.3 §12.3 새 모호어·실패 패턴

SUB-1 §2.4 모호어 사전·부록 A 실패 패턴에 *추가할 후보*:

- [발견 1]
- [발견 2]

### 5.4 §12.4 두별 워크트리 카테고리 조정 제안

5가지 카테고리 외 *새 패턴* 발견이나 *경계 모호* 경험:

- [내용]

---

## 6. [Owner] 결재 절차

### 6.1 결재 안건 작성 (final-report §11)

§11.1 결재 옵션 제시:
- ☐ **승인**
- ☐ **보류** (사유 명시)
- ☐ **거절** (SUB-4 재진입 또는 폐기)

§11.2 후속 명시 승인 필요 사항 체크박스:
- ☐ git push (대상 branch)
- ☐ merge to main
- ☐ PR 생성
- ☐ 운영 문서 변경 반영
- ☐ DB migration 실행
- ☐ 외부 시스템 실호출
- ☐ 기타

§11.3 다음 task 진입 권고 (승인 시).

### 6.2 [Owner]께 보고

final-report.md 경로 + 핵심 요약 3~5줄을 [Owner]께 전달:

```
[종료 보고]
run ID: <run_id>
완료 상태: 완료 / 부분 완료 / 보류 / 실패
의도 정렬 종합: Looks Like N/N, Looks Wrong N/N 방어, 가정 N/3 적중
권고: 승인 / 보류 / 거절
final-report 경로: .harness/runs/<run_id>/final-report.md
```

### 6.3 [Owner] 명시 응답 처리

| [Owner] 응답 | [Foreman] 다음 행동 |
|---|---|
| "승인" | §7 후속 명시 승인 처리 |
| "승인, 그리고 push해" | 후속 승인 받은 것으로 처리 후 push |
| "보류" | task 보류 상태 유지. final-report §11.1 "보류" 체크 + 사유 박음 |
| "거절" | SUB-4 재진입 또는 task 폐기 결정 받음 |
| 침묵 / 모호 | **task 종료 불가**. 명시 응답 받을 때까지 대기 |

---

## 7. 후속 명시 승인 처리 ★

§6.3에서 [Owner] *추가 승인*을 받은 경우만 다음 행동 실행.

### 7.1 [Owner] 자주 쓰는 발화 패턴 — 4가지

| [Owner] 발화 | 실제 행동 |
|---|---|
| "push해줘" | §7.2 git push |
| "머지해줘" | §7.3 merge to main |
| "로컬에서 테스트하게 준비해줘" | §7.4 로컬 테스트 준비 |
| "깃허브에 등록해줘" | §7.5 PR 생성 또는 release tag |

### 7.2 git push

명시 승인 받은 branch만 push:
```
git push origin <branch>
```

push 후 final-report §11.2 해당 체크박스 ✅ + 일시 박음.

### 7.3 merge to main

[Owner] 명시 승인 후 merge:
- 일반 merge 또는 fast-forward 결정은 [Foreman]이 *task 성격에 맞게*. 의문 시 [Owner] 확인.
- merge 완료 후 final-report §11.2 체크 + 일시 박음.

### 7.4 로컬에서 테스트하게 준비

[Owner]가 로컬에서 결과 확인하시는 단계 준비:
- 필요 시 DB seed 또는 fixture 데이터 적용
- 환경변수 점검 (.env 등 — *실제 값 절대 노출 금지*)
- 빌드·실행 명령 안내 (task-card §7 검증 명령 재인용)
- 접근 URL·포트·로그인 정보 안내 (마스킹 적용)

준비 완료 후 [Owner]께 *어떻게 확인하면 되는지* 한 단락 안내.

### 7.5 깃허브에 등록 (PR 생성)

GitHub CLI 사용:
```
gh pr create --base main --head <branch> --title "..." --body-file <path>
```

PR body는 final-report §1·§3·§4 핵심 내용 발췌 (마스킹 적용).

### 7.6 안전 행동 — 별도 [Owner] 명시 승인 의무

§7.1 발화 패턴 밖의 *위험도 높은 행동*. 발화 패턴으로 묶이지 *않으며*, *반드시 별도 명시 승인* 필요.

| 행동 | 추가 의무 |
|---|---|
| 운영 문서 변경 반영 (`AGENTS.md`·`CLAUDE.md`·`PROJECT.md`·`.harness/templates/*` *실제 commit*) | [Owner] 명시 응답 + 변경 diff 사전 보고 |
| DB migration 운영 환경 실행 | backup·rollback 절차 사전 확보 + [Owner] 명시 승인 |
| 결제·통관 등 외부 시스템 프로덕션 실호출 | [Owner] 명시 승인 + 본인 확인 + log 기록 (3중 의무) |
| history rewrite (`rebase -i`·`push --force` 등) | [Owner] 명시 승인 + 영향 범위 사전 보고 |

위 행동들은 §7.1 발화 패턴으로 *암묵 승인되지 않음*. "push해줘"는 *push만*, history rewrite 포함하지 않음.

### 7.7 승인 안 받은 행동 — 절대 금지

§11.2에 체크 안 된 항목, §7.1 발화로 명시되지 않은 §7.6 안전 행동은 *실행 금지*. 마음대로 추가 행동 금지.

---

## 8. run 폴더 보관

task 종료 후 `.harness/runs/<run_id>/` 폴더는 *보존*:

- task-card.md (의도 정렬 증거 + §9 변경 이력 + §10 PROJECT.md 갱신 사항)
- handoff.md
- gate-review.md (있으면)
- final-report.md
- 보조 파일들 (codex-review.md, reviewer-raw.md 등)

**삭제 금지**. 미래의 맥락 복구 + 회고 자료 + 베타 개선 입력.

---

## 9. 종료 조건 — SUB-5를 떠나기 전 점검

- [ ] final-report §1~§13 전부 작성됨
- [ ] §2 의도↔결과 매칭표 작성됨 (Looks Like·Looks Wrong·가정 전부)
- [ ] §10 PROJECT.md 갱신 반영 확인 *실제 반영* 후 체크
- [ ] task-card §10 작성됨
- [ ] PROJECT.md §C.[N], §D, §E 갱신 완료
- [ ] §11 [Owner] 결재 안건 작성됨
- [ ] [Owner] **명시** 응답 받음
- [ ] §7 후속 승인 받은 행동만 실행 + 결과 기록
- [ ] run 폴더 보존됨

---

## 10. SUB-5 종료 시 [Foreman] 행동

[Owner] 결재 결과에 따라:

| 결재 | 다음 행동 |
|---|---|
| **승인** | task 완료. 다음 task 권고가 있으면 [Owner]와 정렬 |
| **승인 + 후속** | §7 후속 명시 승인 항목 실행. 결과 보고 |
| **보류** | 보류 상태 유지. *재진입 시점은 [Owner] 결정* |
| **거절** | SUB-4 재진입 또는 task 폐기 — [Owner] 명시 결정에 따름 |

---

## 부록 A — Tier C task의 SUB-5 직접 진입 (감리 생략 경로)

Tier C로 task-card §4에 *Gate 생략 사유*가 명시된 경우:

1. SUB-2 통과 후 *직접* SUB-5 진입
2. final-report §5 감리 결과 요약 → "해당 없음 — Tier C 감리 생략 (task-card §4 사유 인용)"
3. 나머지 절차 동일

단, Tier C 판정이 *애매했으면* — SUB-5에서 [Owner]가 *상위 Tier 감리 권고* 가능. 그 경우 SUB-3 진입으로 회귀.

---

## 부록 B — task 폐기 시 처리

[Owner] 결재 "거절" + 폐기 결정 시:

1. run 폴더는 *보존* (삭제 금지)
2. final-report §13.1에 "폐기" 명시 + 사유
3. PROJECT.md §C.[N] 다음 마일스톤은 *변경 없음*
4. PROJECT.md §D 결정 이력에 "[날짜] / [task] 폐기 / [사유]" 한 줄 추가
5. 폐기에서 *학습된 것*을 final-report §12 회고에 박음

---

**SUB-5 끝.**

본 매뉴얼 개정 제안은 task의 final-report §12에서 자기 자신을 가리킬 수 있다. 회고가 다음 r 개정의 입력.

---

**두별 워크플로우 v3.6.0 r1 (베타) SUB 매뉴얼 5개 전체 끝.**
