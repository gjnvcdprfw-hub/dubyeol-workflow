# 마누스 task 프롬프트 — CLAUDE.md 갱신 (r6 베타 적용)

> 이 문서는 [Owner]가 마누스에게 전달하는 task 프롬프트.
> r6 매뉴얼·양식 가동 *후* 진행. PROJECT.md 채우기 *전* 또는 *병행* 가능.
> 두별 워크트리 카테고리: **4 (문서·운영)**
> Tier: **A** (운영 문서 변경 — 모든 향후 [Builder] 작업에 영향)

---

## task 개요

**목표**: 글로벌 `~/.claude/CLAUDE.md` (Language.md)와 프로젝트 `silkroadhub/CLAUDE.md`를 두별 워크플로우 v3.6.0 r1 베타에 정합하게 갱신.

**배경**: r6에서 다음 변경 사항이 [Builder] 측 지침에도 반영되어야 함:
- 두별 워크트리 5가지 카테고리·진행 트리 명시
- [Builder] 자가 보고 트리거 7가지 (SUB-2 부록 A)
- fix-loop 통합 카운트 6회 규칙 (5회 또는 5회+ 규칙 제거)
- handoff 양식 변경 (handoff-template.md 참조 — 의도 정렬 증거 블록 대조 §1, 진행 이력 §3 등)
- task-card §10 PROJECT.md 갱신 사항 작성 의무 (SUB-5 종료 시)
- "두별 워크플로우 v3.5.0"에서 "v3.6.0 r1 베타"로 버전 갱신

**범위**: 두 파일 갱신만. 다른 운영 문서·코드 변경 없음.

**제외**: AGENTS.md는 별도 task로 이미 r6 개편됨. 본 task에서 추가 변경 안 함.

---

## Step 1 — 현재 상태 확인

마누스가 직접 확인:

```bash
# 글로벌 위치
ls -la ~/.claude/CLAUDE.md
wc -l ~/.claude/CLAUDE.md

# 프로젝트 위치
ls -la /Users/twostars/ClaudeAi/silkroadhub/CLAUDE.md
wc -l /Users/twostars/ClaudeAi/silkroadhub/CLAUDE.md

# 현재 버전 표시 확인
grep -n "v3.5.0\|v3.6.0\|두별워크플로우\|두별 워크플로우" ~/.claude/CLAUDE.md
grep -n "v3.5.0\|v3.6.0\|두별워크플로우\|두별 워크플로우" /Users/twostars/ClaudeAi/silkroadhub/CLAUDE.md
```

결과를 `.harness/runs/<run_id>/claude-md-current-state.md`에 기록.

---

## Step 2 — 글로벌 `~/.claude/CLAUDE.md` 갱신

### 2.1 갱신 항목

#### (a) 버전 표시
- 모든 "두별워크플로우 v3.5.0" → "두별 워크플로우 v3.6.0 r1 베타"
- 모든 "두별워크플로우" → "두별 워크플로우" (띄어쓰기 통일)

#### (b) "두별 워크트리 — 5가지 카테고리" 절 신설

기존 §"Superpowers 워크플로우 규칙" 다음에 추가:

```markdown
# 두별 워크트리 — 5가지 카테고리 (v3.6.0 신설)

Claude Code는 마누스가 지정한 task-card.md §[두별 워크트리 카테고리]에 1~5 중 하나가 명시되어 있으면 해당 카테고리의 진행 트리를 따른다.

| # | 카테고리 | 진행 트리 |
|---|---|---|
| 1 | 표준 구현 | using-superpowers → brainstorming → writing-plans → using-git-worktrees → TDD → subagent-driven-development → requesting-code-review → verification-before-completion → finishing-a-development-branch |
| 2 | 디버깅 | using-superpowers → systematic-debugging → test-driven-development (실패 재현) → 수정 → verification-before-completion → requesting-code-review → finishing-a-development-branch |
| 3 | 간단 변경 | using-superpowers → brainstorming (축약) → 구현 → verification-before-completion → finishing-a-development-branch |
| 4 | 문서·운영 | using-superpowers → brainstorming → 작성 → 자체 review → finishing-a-development-branch |
| 5 | 기획 | using-superpowers → brainstorming → 작성 → 자체 review → finishing-a-development-branch |

표준 트리에서 변형 필요 시 task-card §6.1에 변형 사유 명시. 카테고리·트리 미명시 시 마누스에게 확인 후 진행.
```

#### (c) "[Builder] 자가 보고 트리거" 절 신설

기존 §"7. 금지 사항" 앞에 추가:

```markdown
# [Builder] 자가 보고 트리거 (v3.6.0 신설)

다음 상황에서 Claude Code는 즉시 작업을 중단하고 마누스에게 자가 보고한다. 자가 진행 절대 금지.

| 케이스 | 행동 |
|---|---|
| systematic-debugging Phase 4.5 발동 (3회 fix 실패 → architecture 의심) | 작업 중단, 마누스에 architecture 의심 보고 |
| spec과 실제 구현 어긋남을 구현 중 발견 | 작업 중단, 마누스에 spec 재검토 요청 |
| task-card §3.3 Looks Wrong 항목이 발생 | 작업 중단, 마누스에 보고 |
| 권한 천장 위반이 불가피해 보임 | 자체 실행 금지, 마누스 보고 후 [Owner] 승인 절차 |
| 마스킹 위반이 git history에 진입 | 즉시 마누스 보고, history rewrite는 [Owner] 명시 승인 후 |
| Context7·Code Simplifier 사용 사유가 불명확 | 사용 보류, 마누스에 확인 후 |
| handoff 작성 중 권한 천장 점검 항목 위반 발견 | handoff 작성 중단, 마누스 보고 |
```

#### (d) "fix-loop 한계" 절 명시

기존 §"5. Tier 및 위험 보고"의 "테스트 실패·실행 증거 부족" 항목 뒤에 추가:

```markdown
| 같은 문제에 대한 fix 시도 누적 한계 | systematic-debugging Phase 4.5 내부 fix와 마누스 지휘 fix를 통합 카운트. 6회까지 진행 가능, 7회째 절대 금지. 6회 후에도 재발 시 마누스에 보고. |
```

#### (e) handoff 양식 변경 참조

기존 §"4. handoff 작성 의무"의 필수 항목 표 *전체를 교체*하지 않고, *맨 끝에 추가*:

```markdown
v3.6.0 r1 베타부터 handoff 양식이 변경되었다. 상세는 마누스가 task-card에서 지정하는 `.harness/templates/handoff-template.md` 참조. 주요 변경:
- §1 의도 정렬 증거 블록 대조 (task-card §3과 항목별 1:1 매칭) 추가
- §3 두별 워크트리 진행 이력 (카테고리 트리 따른 단계별 결과) 추가
- §6 권한 천장 점검 체크박스 명시
- §7 마스킹 점검 체크박스 명시
- §8 scope 밖 발견 사항 (제안만, 실행 금지) 추가
```

#### (f) "[Builder] 자동 제안 자제 의무" 절 신설 ★ (검증 발견 2026-05-16)

기존 §"7. 금지 사항" 또는 §"5. Tier 및 위험 보고" 적절한 위치에 추가:

```markdown
# [Builder] 자동 제안 자제 의무 (v3.6.0 검증 발견)

task 완료 후 Claude Code가 *task-card 범위 밖 행동*을 *자동 제안*하지 않는다. 다음 예시는 모두 금지:

- task 완료 직후 `git add ... && git commit` 명령을 입력 필드에 자동 채움
- "다음으로 result-X.md도 확인해봐" 같은 추가 확인 제안
- task-card 미명시 cleanup·refactor·정리 제안
- "push해도 되는지" 같은 자율 판단 제안

이유: 마누스는 이런 제안을 *명령으로 해석하지 않는다*. 자동 제안은 *마누스를 헷갈리게* 하고 *권한 천장을 위협*한다.

원칙:
- task 완료 후 handoff.md만 작성하고 *정지*
- task-card §5.2 제외 범위에 해당하는 행동은 *handoff §8 scope 밖 발견 사항*에 *기록만*
- 명시 지시·승인 없이 *다음 행동을 사전 준비하지 않음*
```

### 2.2 갱신 시 보존 사항

- §"Safety Rules" (rm -rf 금지 등) 그대로 유지
- §"6. Git·보안 경계" 권한 천장 절대 유지 — 어떤 r6 변경도 권한 천장 약화 금지
- 기존 코드 작성 원칙·테스트 명령·언어 규칙 보존

---

## Step 3 — 프로젝트 `silkroadhub/CLAUDE.md` 갱신

### 3.1 갱신 항목

#### (a) 버전 표시
- "두별워크플로우 v3.5.0" → "두별 워크플로우 v3.6.0 r1 베타"

#### (b) §"3. Claude Code 읽기·쓰기 기준" 갱신

표에 한 행 추가:

| 구분 | 기준 문서 | 설명 |
|---|---|---|
| 기획 맥락 참조 | `PROJECT.md` | Claude Code는 자동 로드하지 않음. task-card §2 "상위 맥락 연결"에 인용된 §C.N 모듈 정보 참조 |

#### (c) §"4. Superpowers 및 실행 흐름" 표 변경

기존 표에 *카테고리 매핑 행*을 추가하거나, 표 위에 다음 문구 삽입:

```markdown
**카테고리 매핑**: 본 표의 단계는 두별 워크트리 *카테고리 1 (표준 구현)*의 진행 트리다. 마누스가 task-card §[두별 워크트리 카테고리]에 다른 카테고리를 지정하면 글로벌 §[두별 워크트리] 표에 따른 트리 적용. 카테고리 2 디버깅은 systematic-debugging 우선, 카테고리 5 기획·4 문서·운영은 TDD·git-worktrees 생략 가능.
```

#### (d) 마스킹 §"6"에 OpenAI 키 마스킹 추가

기존 마스킹 표에 다음 행 추가:

| OpenAI / 외부 API 키 | 출력 자체 금지 (디버그 시 첫 7자만 노출 가능) |
| 주민등록번호, 카드 번호 | 출력 자체 금지 |

### 3.2 갱신 시 보존 사항

- §5 Tier 키워드 (silkroadhub 도메인 특화) 보존
- §6 마스킹 도메인 (운송장·BL·HBL·MBL·CLP 등) 보존
- §8 Git·commit·배포 경계 절대 유지
- §10 금지 사항 절대 유지

---

## Step 4 — 검증

각 파일 갱신 후:

```bash
# 글로벌
grep -c "v3.6.0\|두별 워크트리\|자가 보고 트리거\|fix-loop\|handoff-template" ~/.claude/CLAUDE.md

# 프로젝트
grep -c "v3.6.0\|PROJECT.md\|카테고리 매핑\|OpenAI" /Users/twostars/ClaudeAi/silkroadhub/CLAUDE.md
```

결과가 *0이 아닌지* 확인. 0이면 갱신 누락.

기존 핵심 항목 보존 확인:

```bash
# 글로벌
grep -c "rm -rf\|git push --force\|.env" ~/.claude/CLAUDE.md

# 프로젝트
grep -c "운송장\|BL\|개인통관고유부호" /Users/twostars/ClaudeAi/silkroadhub/CLAUDE.md
```

결과가 *기존과 동일하거나 더 많은지* 확인. 더 적으면 보존 사항 손실.

---

## Step 5 — handoff 작성

`.harness/runs/<run_id>/handoff.md`에 다음 기록:

- 변경 파일: `~/.claude/CLAUDE.md`, `silkroadhub/CLAUDE.md`
- diff 요약 (각 파일별)
- §2.2·§3.2 보존 사항 점검 결과
- 검증 결과 (grep 카운트)
- 마누스 확인 필요점: AGENTS.md와의 정합성 한 번 더 확인 요청

---

## 권한·금지

- 본 task는 *운영 문서 변경*. 변경 *실제 commit*은 SUB-5 §7.6 안전 행동 — [Owner] 명시 승인 후만
- AGENTS.md 변경 금지 (별도 task)
- 다른 운영 문서·코드 변경 금지

---

**프롬프트 끝.**

본 프롬프트의 의문점·환경 차이 발견 시 마누스가 [Owner]에 확인 후 진행.
