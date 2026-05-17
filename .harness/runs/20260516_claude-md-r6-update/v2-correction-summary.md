# v2 정정 검증 요약

run_id: 20260516_claude-md-r6-update
작성일: 2026-05-16
작성자: Claude Code (Builder)

---

## 1. 글로벌 v2 정정 사항

| 구분 | 내용 |
|---|---|
| 대상 파일 | `claude-md-global-draft.md` → `claude-md-global-draft-v2.md` |
| 정정 위치 | §1 역할 경계 표, ChatGPT 직접 호출 행 |

| 변경 전 | 변경 후 |
|---|---|
| `금지. ChatGPT는 마누스가 Gate Judge + Devil's Advocate로 호출한다.` | `금지. ChatGPT는 마누스가 [Judge] — Devil's Advocate로 호출한다. 코덱스 [Reviewer] 불가 시 [Reviewer] 폴백도 마누스가 호출.` |

정정 근거: r6 AGENTS.md §1·§7.5에서 코덱스 = [Reviewer], 지피티 = [Judge] 역할 분리 명확화. 코덱스 [Reviewer] 불가 시 지피티 [Reviewer] 폴백 절차 명시 요건.

---

## 2. 프로젝트 v2 점검 결과

| 구분 | 내용 |
|---|---|
| 대상 파일 | `claude-md-project-draft.md` → `claude-md-project-draft-v2.md` |

### r5 표현 발견 및 정정 현황

| 점검 항목 | 발견 여부 | 정정 여부 |
|---|---|---|
| `Gate Judge + Devil's Advocate` | **발견** (§2 역할 표 ChatGPT 행) | **정정** |
| `Gate Judge` 단독 표현 | 미발견 | 해당 없음 |
| Codex `[Reviewer]` 태그 누락 | **발견** (`Auditor / 코드 감리자` 표기) | **정정** |
| 코덱스 [Reviewer] 불가 시 폴백 절차 누락 | **발견** (ChatGPT 행에 폴백 미기재) | **정정** |
| 한 ChatGPT 세션 [Reviewer]+[Judge] 동시 수행 위반 | 미발견 | 해당 없음 |

### 정정 내용 (§2 역할 표)

**Codex 행**

| 변경 전 | 변경 후 |
|---|---|
| `Auditor / 코드 감리자. 마누스가 제공한 diff·실행 증거 기반 검토` | `[Reviewer] — 코드 감리자. 마누스가 제공한 diff·실행 증거 기반 검토` |

**ChatGPT 행**

| 변경 전 | 변경 후 |
|---|---|
| `Gate Judge + Devil's Advocate. 마누스가 호출하며 진행·수정·보류·중단 판정과 반대 논리 제시` | `[Judge] — Devil's Advocate. 마누스가 호출하며 진행·수정·보류·중단 판정과 반대 논리 제시. 코덱스 [Reviewer] 불가 시 [Reviewer] 폴백도 마누스가 별도 세션으로 호출.` |

---

## 3. grep 검증 결과

| 검증 항목 | 파일 | 결과 |
|---|---|---|
| `"Gate Judge + Devil's Advocate"` 잔여 건수 | 글로벌 v2 | **0건** ✅ |
| `"Gate Judge + Devil's Advocate"` 또는 `"Gate Judge"` 잔여 건수 | 프로젝트 v2 | **0건** ✅ |
| `"v3.5.0"` 또는 `"두별워크플로우"` (붙여쓰기) 잔여 건수 | 프로젝트 v2 | **0건** ✅ |
| `"OpenAI"`, `"주민등록번호"`, `"카드 번호"` 확인 건수 | 프로젝트 v2 | **3건** ✅ (마스킹 정책 표에 정상 포함) |
| `"운송장"`, `"BL"`, `"개인통관고유부호"` 확인 건수 | 프로젝트 v2 | **7건** ✅ (Tier A 키워드 및 마스킹 표에 정상 포함) |

> OpenAI·주민등록번호·카드 번호 3건, 운송장·BL·개인통관고유부호 7건은 모두 §5 Tier 기준 및 §6 마스킹 정책 표 내 정상 항목. 노출 또는 오용 없음.

---

## 4. 실제 파일 미반영 확인

| 확인 항목 | 결과 |
|---|---|
| `~/.claude/CLAUDE.md` 덮어쓰기 | **없음** ✅ |
| `/Users/twostars/ClaudeAi/silkroadhub/CLAUDE.md` 덮어쓰기 | **없음** ✅ |
| `claude-md-global-draft.md` (v1) 덮어쓰기 | **없음** ✅ |
| `claude-md-project-draft.md` (v1) 덮어쓰기 | **없음** ✅ |
| `AGENTS.md`, `.harness/templates`, `PROJECT.md` 변경 | **없음** ✅ |
| git status | `.harness/runs/20260516_claude-md-r6-update/` untracked만 존재 ✅ |

---

## 5. 생성된 파일 목록

| 파일 | 설명 |
|---|---|
| `claude-md-global-draft-v2.md` | 글로벌 초안 v2 (ChatGPT 행 1건 정정) |
| `claude-md-project-draft-v2.md` | 프로젝트 초안 v2 (Codex·ChatGPT 역할 표 2건 정정) |
| `v2-correction-summary.md` | 본 파일 — 정정 내용 및 grep 검증 결과 요약 |

---

## 6. 다음 단계

Owner 최종 결재 후 실제 반영.

- 글로벌 반영: `claude-md-global-draft-v2.md` → `~/.claude/CLAUDE.md`
- 프로젝트 반영: `claude-md-project-draft-v2.md` → `/Users/twostars/ClaudeAi/silkroadhub/CLAUDE.md`
- 반영 및 commit/push는 대표님 또는 마누스 명시 승인 후 수행.
