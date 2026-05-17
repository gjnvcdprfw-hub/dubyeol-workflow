# G-2 스킬 검증 종합 요약

**run ID**: 20260518_g2-skills-verification-execution  
**검증 일시**: 2026-05-18  
**검증자**: [Builder] (클로드코드)  
**Tier**: A  

---

## 1. 9개 스킬 판정 테이블

| # | 스킬 ID | 판정 | 스크립트 존재 | REPO_ROOT 정합 | 참조 파일 | 핵심 로직 | 비고 |
|---:|---|---|---|---|---|---|---|
| 1 | `01-load-sub-manual` | **PARTIAL PASS** | ✅ (스킬 내) | ❌ silkroadhub | — | ✅ | 루트 scripts/ 없음 · G-1 의심 확정 |
| 2 | `02-create-task-card` | **PARTIAL PASS** | ✅ (스킬 내) | ❌ silkroadhub | 템플릿 미사용 | ✅ | §11 누락 · 템플릿 독립 관리 |
| 3 | `03-dispatch-to-builder` | **PARTIAL PASS** | ✅ (스킬 내) | ❌ silkroadhub | ❌ references/ 비어있음 | ✅ | 2단계 확정 실행 OK · 현 세션이 증거 |
| 4 | `04-invoke-plan-review` | **PARTIAL PASS** | ✅ (스킬 내) | ❌ silkroadhub | — | ✅ | GPT 호출은 Foreman 전용 |
| 5 | `05-verify-handoff` | **PARTIAL PASS** | ✅ (스킬 내) | ❌ silkroadhub | — | ✅ | 6개 항목 구현 OK · 수동 A-E PASS |
| 6 | `06-invoke-reviewer` | **PARTIAL PASS** | ✅ (스킬 내) | ❌ silkroadhub | ❌ references/ 비어있음 | ✅ | Codex 재시도·폴백 구현 OK |
| 7 | `07-invoke-judge` | **PARTIAL PASS** | ✅ (스킬 내) | ❌ silkroadhub | ❌ references/ 비어있음 | ✅ | DA 3가지 강제·세션 분리 OK |
| 8 | `08-write-final-report` | **PARTIAL PASS** | ✅ (스킬 내) | ❌ silkroadhub | 템플릿 미사용 | ✅ | §1~§13 구조 OK · 입력 매핑 OK |
| 9 | `09-update-project-md` | **PARTIAL PASS** | ✅ (스킬 내) | ❌ silkroadhub | — | ✅ | 자동 commit 금지·백업·diff 구현 OK |

---

## 2. 판정 집계

| 판정 | 수 |
|---|---|
| PASS | **0** |
| PARTIAL PASS | **9** |
| FAIL | **0** |

**전체 9개 스킬 PARTIAL PASS**

---

## 3. 공통 결함 (모든 9개 스킬)

### [COMMON-DEFECT-A] REPO_ROOT 하드코딩 (심각도: HIGH)

**영향**: 9개 스킬 전부  
**내용**: 모든 스크립트에서 `REPO_ROOT="/Users/twostars/ClaudeAi/silkroadhub"` 하드코딩.  
`dubyeol-workflow` 마스터에서 독립 실행 불가. 실 운영은 마누스가 silkroadhub에서 직접 실행하므로 기능은 하지만, `dubyeol-workflow`의 스킬 스크립트로서는 경로 오류.

**수정 방향 (r7 정비 후보)**: `REPO_ROOT` 환경변수화 또는 스크립트 실행 위치 기반 자동 감지.

### [COMMON-DEFECT-B] 스킬 내부 scripts/ (루트 scripts/ 없음) (심각도: MEDIUM)

**영향**: 01, 02, 03 (SKILL.md 호출 방식과 불일치)  
**내용**: SKILL.md에서 `bash scripts/<script>.sh`로 안내하지만, 실제 스크립트는 `<skill_dir>/scripts/`에 위치. 루트에서 실행 시 "No such file" 오류.  
**수정 방향**: SKILL.md 호출 방식에 실행 디렉토리 명시 또는 루트 scripts/ 심볼릭 링크 생성.

---

## 4. 스킬별 추가 결함

| 스킬 | 결함 ID | 내용 |
|---|---|---|
| 01 | DEFECT-01-C | 전체 로드 미수행 (head -30 미리보기만) |
| 02 | DEFECT-02-B | task-card-template.md 미사용 (heredoc 독립 생성) |
| 02 | DEFECT-02-C | §11 섹션 누락 |
| 03 | DEFECT-03-B | references/ 비어있음 (standard-entry-prompt.md 등) |
| 06 | DEFECT-06-B | references/ 비어있음 (codex-prompt-pattern.md 등) |
| 06 | DEFECT-06-C | PATH 하드코딩 |
| 07 | DEFECT-07-B | references/ 비어있음 (judge-prompt-pattern.md) |
| 08 | DEFECT-08-B | final-report-template.md 미사용 |
| 08 | DEFECT-08-C | extract_section 패턴 정확도 우려 |
| 09 | DEFECT-09-B | §C·§D 자동 배치 미구현 (끝에 추가 후 수동 이동) |

---

## 5. G-1 의심 신호 최종 결론

G-1에서 기록한 "scripts/load_sub.sh 미발견 의심":

**결론**: 부분 확인 (수정된 해석)
- 루트 `scripts/load_sub.sh` → **없음** (루트 scripts/ 디렉토리 자체 없음) ✅ G-1 의심 확인
- `01-load-sub-manual/scripts/load_sub.sh` → **존재** (G-1이 예상한 결함 방향과 다름)
- 실제 결함: 스크립트 존재하지만 `REPO_ROOT` silkroadhub 하드코딩으로 dubyeol-workflow에서 독립 실행 불가

G-1이 "스크립트 없음"으로 의심했으나 실제는 "위치 다름 + 경로 하드코딩"이 문제.

---

## 6. 양호한 점

- 9개 스크립트 모두 존재하고 핵심 로직 구현됨
- 정보 격리 원칙(Reviewer/Judge 입력 분리) 스크립트에 반영됨
- 권한 천장 원칙(자동 commit 금지, push 미포함) 스크립트에 반영됨
- 마누스 수동 보강 영역 명시(수동 판단 영역을 스크립트가 대체하지 않음)
- GPT 폴백 구현 (06-invoke-reviewer)
- 4단 판정 형식 시스템 프롬프트 구현 (04, 06, 07)
- `verify_handoff.sh` 6개 항목 자동화 수준 양호

---

## 7. 의존성 영향 요약

| 의존 그룹 | 영향 |
|---|---|
| 그룹 0: 01-load-sub-manual | PARTIAL PASS → 이후 그룹에 영향 없음 (수동 대체 가능) |
| 그룹 1: 02-create-task-card | PARTIAL PASS → 실 운영 마누스 수동 작성 중 |
| 그룹 2: 03·04 | PARTIAL PASS → 03 현 세션으로 검증. 04 GPT 호출 Foreman 담당 |
| 그룹 3: 05 | PARTIAL PASS → 수동 동등 명령으로 A-E 검증 완료 |
| 그룹 4: 06·07 | PARTIAL PASS → 입력 격리 설계 OK. 실 호출은 Foreman |
| 그룹 5: 08·09 | PARTIAL PASS → 구조·승인 경계 설계 OK. Builder 직접 실행 금지 |

---

## 8. 다음 단계 권고

1. **SUB-3 외부 감리** (Tier A 의무): Codex [Reviewer] + GPT [Judge] 1회씩 → gate-review.md 작성
2. **r7 정비 후보**: 
   - [COMMON-DEFECT-A] REPO_ROOT 환경변수화 (9개 스킬 일괄)
   - [COMMON-DEFECT-B] SKILL.md 호출 방식 명확화 또는 루트 scripts/ 생성
   - references/ 파일 작성 (03, 06, 07)
   - 02·08 템플릿 연동 구현
3. **SUB-3 이후**: [Owner] 결재 후 수정 범위 결정 (SUB-4)
