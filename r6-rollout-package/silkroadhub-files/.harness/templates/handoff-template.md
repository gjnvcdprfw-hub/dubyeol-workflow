# handoff 양식

> **두별 워크플로우 v3.6.0 r1 (베타) 표준 양식**
> 작성자: [Builder] (SUB-2 단계 종료 시)
> 저장 위치: `.harness/runs/<run_id>/handoff.md`
> [Foreman]은 본 handoff 수신 후 §6 권한 천장 점검 *직접 검증* 의무.

---

```markdown
# handoff: [task 한 줄 제목]

**run ID**: [YYYYMMDD]_[task-slug]
**작성일시**: YYYY-MM-DD HH:MM
**작성자**: [Builder] (클로드코드)
**대응 task-card**: `.harness/runs/<run_id>/task-card.md`
**두별 워크트리 카테고리**: 1 / 2 / 3 / 4 / 5
**Tier**: A / B / C
**branch**: feature/xxx 또는 fix/xxx
**worktree 상태**: keep / 정리 대기 ([Owner] 승인 후)
**최종 상태**: ready_for_review / blocked
**다음 단계 권고**: SUB-3 (감리, Tier A/B) / SUB-5 (종료, Tier C) / SUB-4 (수정 필요)

---

## 1. 의도 정렬 증거 블록 대조 (task-card §3과 매칭)

### 1.1 Looks Like 항목 점검 결과 (task-card §3.2 대조)

| Looks Like 항목 | 검증 방법 | 결과 |
|---|---|---|
| [task-card §3.2 항목 1] | [테스트 / 수동 / 빌드 / 로그 등] | ✅ / ⚠️ / ❌ |
| [task-card §3.2 항목 2] | [...] | ✅ / ⚠️ / ❌ |
| ... | ... | ... |

⚠️ 또는 ❌가 있으면 §5에 상세 사유 기록.

### 1.2 Looks Wrong 항목 방어 결과 (task-card §3.3 대조)

| Looks Wrong 항목 | 방어 방법 | 발생 여부 |
|---|---|---|
| [task-card §3.3 항목 1] | [방어 테스트 / 검증 절차] | 미발생 ✅ / 발생 ❌ |
| [task-card §3.3 항목 2] | [...] | 미발생 ✅ / 발생 ❌ |
| ... | ... | ... |

발생 ❌가 있으면 §5에 상세 사유 기록.

### 1.3 마누스 가정 사후 검증 (task-card §3.5 대조)

| 가정 (task-card §3.5) | 사후 검증 결과 |
|---|---|
| 가정 1 | 맞았음 ✅ / 틀렸음 ❌ / 부분 ⚠️ — [근거] |
| 가정 2 | ... |
| 가정 3 | ... |

---

## 2. 사전·사후 상태

### 2.1 사전 (worktree 진입 시점)

- **baseline test 결과**: [통과/실패 — 실패면 어느 테스트]
- **branch 진입점 commit hash**: [hash]
- **진입 시점 추가 컨텍스트**: [있으면]

### 2.2 사후 (verification 종료 시점)

- **전체 test 결과**: [통과/실패/일부 미실행 — 상세]
- **빌드 결과**: [통과/실패]
- **변경 파일 목록**: [`git diff --stat` 출력 또는 명시 목록]
- **commit 수**: [N개]
- **commit hash 범위**: [first..last]
- **push 상태**: 로컬만 (push 미실행)

---

## 3. 두별 워크트리 진행 이력

task-card §6에서 명시한 카테고리·트리에 따른 실행 결과.

| 단계 | skill / 행동 | 산출물·증거 | 상태 |
|---|---|---|---|
| using-superpowers | 진입점 | — | ✅ |
| [카테고리별 단계 1] | [skill 또는 행동] | [파일 경로·로그] | ✅ / ⚠️ / N/A |
| [카테고리별 단계 2] | [...] | [...] | ✅ / ⚠️ / N/A |
| ... | ... | ... | ... |
| finishing-a-development-branch | merge/PR/keep/discard 선택지 제시 | [본 handoff §7] | ✅ |

**변형 사유** (task-card §6.2에 명시했거나, 실행 중 변형 발생 시): [내용]

---

## 4. 보조 도구 호출 이력

### 4.1 Context7

- [호출 없음] 또는 다음 기록:

| 호출 시점 | library ID | version | query/topic | decision affected | 증거 위치 |
|---|---|---|---|---|---|
| ... | ... | ... | ... | ... | ... |

### 4.2 Code Simplifier

- [호출 없음] 또는 다음 기록:

| 호출 시점 (A/B/C) | 대상 파일·함수 | 사용 전 green 증거 | 사용 후 green 증거 |
|---|---|---|---|
| ... | ... | ... | ... |

호출 시점 분류:
- A: verification 1차 green 직후 자체 인지
- B: code-review에서 maintainability concern 제기
- C: Gate에서 maintainability 권고 받은 후

---

## 5. systematic-debugging 이력 (해당 시)

[발동 없음] 또는:

### 5.1 발동 경위

- **트리거**: [무엇이 실패했나]
- **발견 일시**: [...]

### 5.2 Phase 진행

- **Phase 1 (Root Cause Investigation)**: [발견된 root cause]
- **Phase 2 (Pattern Analysis)**: [...]
- **Phase 3 (Hypothesis Testing)**: [...]
- **Phase 4 (Implementation)**: [...]
- **(Phase 4.5 발동 시) Architecture 의심**: [내용 + [Owner] 보고 결과]

---

## 6. 권한 천장 점검 ★ [Foreman] 수신 후 직접 검증

다음 *전부* 미위반 확인. 위반 발생 시 즉시 [Foreman]·[Owner] 보고.

- [ ] git push 미실행
- [ ] merge / deploy 미실행
- [ ] 운영 문서 무단 변경 없음 (AGENTS.md, CLAUDE.md, templates 등)
- [ ] 파괴적 git 명령 미실행 (reset --hard, force push, history rewrite)
- [ ] task scope 확장 없음 (task-card §5.2 제외 범위 미침범)
- [ ] 외부 시스템 프로덕션 실호출 없음
- [ ] task-card §8의 추가 금지 사항 미위반

**위반 발생 시**: [상세 + [Foreman] 보고 일시]

---

## 7. 마스킹 점검

CLAUDE.md §6 마스킹 규칙 (운송장·BL·HBL·MBL·CLP·개인통관고유부호·이름 등) 준수 확인.

- [ ] 로그 출력 마스킹 적용
- [ ] commit 메시지에 실제 식별자 없음
- [ ] design.md / plan.md 마스킹 적용
- [ ] 보조 도구 (Context7·Code Simplifier) 입출력 마스킹 적용
- [ ] handoff 자체에 평문 민감정보 없음

**위반 발견 및 처리**: [있으면 기록. git history 진입 시 [Foreman] 즉시 보고]

---

## 8. scope 밖 발견 사항 (제안만, 실행 안 함)

작업 중 발견한 *task-card §5 범위 밖* 작업. **실행하지 않고 *제안*만** 기록.

- [발견 1]: [내용] / 권고 Tier: [A/B/C 추정] / 권고 카테고리: [1~5]
- [발견 2]: ...

(없으면 "해당 없음")

[Foreman]은 위 제안을 *별도 task-card*로 처리할지 결정.

---

## 9. finishing-a-development-branch 선택지

[Builder]는 *실행하지 않고* 선택지만 제시한다. 실제 merge/PR/discard는 [Owner] 명시 승인 후 [Foreman] 지시.

| 선택지 | 권고 여부 | 사유 |
|---|---|---|
| merge to main | 권고 / 비권고 / 미해당 | [사유] |
| Pull Request 생성 | 권고 / 비권고 / 미해당 | [사유] |
| keep (worktree 유지) | 권고 / 비권고 / 미해당 | [사유] |
| discard | 비권고 (기본값) | [Owner] 명시 승인 필수 |

---

## 10. 의문·미해소 사항 ([Foreman] 확인 필요)

작업 중 발생한 의문, 가정에 대한 불확실성, [Owner] 의도 재확인이 필요한 부분.

- [의문 1]: [내용]
- [의문 2]: [내용]

(없으면 "없음")

---

## 11. [Foreman] 수신 후 다음 행동

1. 본 handoff 통독
2. §6 권한 천장 점검 항목 **[Foreman] 직접 검증** (git log, diff, 운영 파일 변경 여부 등)
3. §1 의도 정렬 증거 블록 대조를 task-card §3과 *교차 확인*
4. §7 마스킹 점검 통과 확인
5. Tier 따라 다음 SUB 호출:
   - Tier A/B → SUB-3 (감리)
   - Tier C → SUB-5 (종료) — 단, task-card §4에 Gate 생략 사유 명시 시
6. ❌ 또는 ⚠️ 다수 발견 시 → SUB-4 (수정) 진입 또는 [Builder] 재호출

---

**handoff 끝.**
```

---

## 작성·검증 책임 요약

| 시점 | 절 | 책임 |
|---|---|---|
| SUB-2 종료 시 | §1~§10 전부 | [Builder] |
| [Foreman] 수신 직후 | §6 권한 천장 *직접 검증* | [Foreman] |
| [Foreman] 수신 직후 | §1 의도 정렬 대조 *교차 확인* | [Foreman] |
| §11 | 다음 SUB 호출 판단 | [Foreman] |

---

**본 양식은 두별 워크플로우 v3.6.0 r1 베타.**
[Builder]의 handoff는 *증거*이지 *판정*이 아니다. [Foreman]은 §6을 *반드시 직접 검증*한다.
