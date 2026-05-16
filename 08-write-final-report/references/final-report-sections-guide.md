# final-report.md 자동 추출 vs 수동 영역

본 문서는 `write_final_report.sh`가 *자동 채우는 영역*과 *마누스 수동 영역*을 명확히 분리.

## §1 task 요약 (자동 + 수동 검토)

**자동 추출**:
- run_id, 기간, Tier, 카테고리 — task-card에서
- 한 문장 목표 — task-card §3.1

**수동 검토 의무**:
- 한 문장 목표가 *task 실제 결과*와 정렬되는지 — 어긋나면 §11 후속 task 후보

## §2 진행 결과 (자동)

handoff §2·§3에서 추출:
- 완료 항목
- 남은 항목 (있으면)
- block 사유 (있으면)

**검토**: handoff 작성 시 [Builder]의 *과장 가능성*. 마누스가 *실제 git·로그*로 교차 확인 (스킬 05 verify-handoff 결과 인용).

## §3 산출물 (자동)

handoff §2.2 변경 파일 목록을 task-card §5.1 산출 파일 목록과 *대조*:
- task-card 명시 + handoff 실제 = ✅
- task-card 명시 + handoff 없음 = ❌ 미완료
- task-card 명시 없음 + handoff 있음 = ⚠️ scope 확장 의심

## §4 검증 결과 (자동)

handoff §4·§5에서 추출:
- 테스트 결과 (PASS/FAIL 카운트)
- verification-before-completion 통과 여부
- fresh evidence 확인

## §5 외부 감리 결과 (자동, gate-review.md 있을 때)

- §5.1 [Reviewer] 판정 — gate-review §1 인용
  - 폴백 사용 시 *폴백 사실 명시*
- §5.2 [Judge] 판정 — gate-review §2 인용

## §6 plan-review 결과 (자동, plan-review.md 있을 때)

- plan-review.md 존재 시: §6에 인용
- 없을 시: §6 자체 생략 또는 *"plan-review 생략 — 사유"*

## §7 변경 파일 (자동, git 직접)

```bash
git diff <task_start_commit>..HEAD --name-status
git log <task_start_commit>..HEAD --oneline
```

PROJECT.md·AGENTS.md·CLAUDE.md 등 운영 문서가 *task scope에 없는데 변경*됐다면 *경고 표시*.

## §8 fix-loop 기록 (자동, 있을 때)

handoff 또는 `fix-log.md`에서 추출:
- 발동 횟수 (3회·5회 보고 권고 시점 통과 여부)
- 각 시도 가설·결과
- 6회 한계 도달 여부

## §9 권한 천장 점검 (자동, verify-handoff 인용)

스킬 05 `handoff-verification.md` 결과 그대로 인용:
- 6개 항목 PASS/WARN/FAIL 표

## §10 PROJECT.md 갱신 사항 ★ (수동)

**자동 생성 불가** — *task 의미를 PROJECT.md 모듈 진행에 어떻게 반영할지* 마누스 판단.

작성 가이드:
- §10.1 §C.[N] 모듈 진행 갱신
  - "어떤 모듈의 어떤 항목이 어떻게 변경됐는가"
  - 예: "§C.3 manifest 등록 — 'BL 자동 매칭' 항목 베타 가동 시작"
- §10.2 §D 결정 이력 (큰 결정 발생 시만)
  - "task 진행 중 인지된 큰 결정"
  - 예: "manifest_no 형식을 14자리 고정으로 결정. 이유: ..."

**§10이 비어있으면 PROJECT.md 갱신 안 됨**. 마누스 의무.

## §11 후속 task 후보 ★ (수동)

자동 추출 *어려운 영역*. 마누스가 task 진행 중 발견한:
- scope 밖이라 미수행한 작업
- handoff §8에 [Builder]가 *제안만* 남긴 항목
- gate-review에서 발견된 *별도 task로 처리해야 할 리스크*
- plan-review에서 *수정 권고*받았으나 *현 task에서 처리 안 한* 항목

각 후보에 *추정 Tier·카테고리·우선순위* 박음.

## §12 회고 — r6 베타 어색함 ★ (수동)

베타의 *진짜 자산*. 마누스가 task 진행 중 *어색하다고 느낀 모든 것*:
- 매뉴얼이 *현실과 안 맞는* 부분
- *진짜 안 쓰이는* 절·항목
- *너무 자주 쓰이는데 매뉴얼에서 약하게 박힌* 절
- 발화 컨버터에 *추가하면 좋을 새 패턴*
- 스킬화하면 좋을 *새로운 반복 작업*

→ 다음 r 개정의 *직접 입력*. *형식 안 갖춰도 됨*, 솔직히 누적.

## §13 마누스 짚을 점 ★ (수동)

[Owner]께 *솔직히 짚어야 할* 한두 가지:
- 본 task에서 의문이 남는 부분
- 리스크가 누적되고 있는 신호
- [Owner]가 알아야 할 *예상치 못한 발견*
- *진짜 짚어줘서 고맙다*는 부분도 포함

## 자동 생성 후 마누스 의무

- [ ] §1 한 문장 목표 ↔ 실제 결과 정렬 확인
- [ ] §2~§9 자동 추출 결과 한 번 *훑어 보기* — 기계적 인용 오류 점검
- [ ] §10 PROJECT.md 갱신 사항 *반드시 작성*
- [ ] §11 후속 task 후보 *반드시 검토*
- [ ] §12 회고 *솔직히* 작성
- [ ] §13 짚을 점 *작성*

6개 통과 후에만 [Owner] 제출.
