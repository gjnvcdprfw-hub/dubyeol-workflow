# manus-import-verification: dubyeol-workflow-skills GitHub import 검증

**run ID**: 20260516_skills-github-register  
**작성일시**: 2026-05-17 01:12 KST  
**작성자**: [Foreman]  
**검증 대상 URL**: `https://github.com/gjnvcdprfw-hub/dubyeol-workflow-skills`  
**검증 위치**: Manus 앱 설정 → 스킬 → 추가 → GitHub에서 가져오기

---

## 1. 결론

Manus Skills 공식 문서는 Skills 페이지의 `+ Add` 메뉴에서 `Import from GitHub`를 선택하고 repository link를 제공해 GitHub 저장소의 Skill을 가져올 수 있다고 설명한다. 실제 UI에서도 `설정 → 스킬 → 추가 → GitHub에서 가져오기` 경로와 URL 입력 폼은 확인되었다.

그러나 `https://github.com/gjnvcdprfw-hub/dubyeol-workflow-skills`를 입력하고 `가져오기`를 실행한 뒤, Skills 목록에서 `01-load-sub-manual`과 `dubyeol`을 검색했을 때 모두 `결과를 찾을 수 없음`이 표시되었다. 따라서 본 검증의 판정은 **(다) Import 실패 또는 인식 결과 없음**이다. 명시적 오류 메시지는 캡처하지 못했으나, visible installed skill 목록에 9개 스킬이 나타나지 않았고 부분 인식도 확인되지 않았다.

| 가능 결과 | 판정 | 근거 |
|---|---|---|
| (가) 9개 모두 인식 | 아님 | `01-load-sub-manual` 검색 결과 없음 |
| (나) 일부만 인식 | 현재 증거상 아님 | `dubyeol` 검색 결과 없음. 부분 인식 목록도 표시되지 않음 |
| (다) Import 실패 | 해당 | import 제출 후 Skills 목록으로 복귀했으나 신규 skill 검색 결과 없음 |

---

## 2. 공식 문서 및 UI 확인

브라우저로 확인한 `https://manus.im/docs/features/skills` 문서에는 Skills 관리가 왼쪽 메인 메뉴의 Skills tab에서 이루어지고, Skills page의 `+ Add` 메뉴에 `Import from GitHub`가 있으며 repository link를 제공해 GitHub 저장소에서 Skill을 가져올 수 있다고 설명되어 있었다.

실제 앱 UI에서는 직접 URL `https://manus.im/settings/skills`는 404였지만, 앱 좌하단 설정 아이콘을 통해 `https://manus.im/app/library#settings` 설정 모달을 열 수 있었다. 이후 `스킬` 메뉴를 클릭하자 `https://manus.im/app/library#settings/skills`가 열렸고, `추가` 버튼에서 `GitHub에서 가져오기` 옵션을 확인했다.

| 단계 | 결과 |
|---|---|
| 공식 문서 확인 | `Import from GitHub`는 repository link 입력 방식으로 설명됨 |
| 직접 `/settings/skills` 경로 | 404 |
| 앱 설정 경로 | `#settings/skills`에서 Skills 관리 화면 확인 |
| 추가 메뉴 | `Manus으로 빌드`, `스킬 업로드`, `공식에서 추가하기`, `GitHub에서 가져오기` 확인 |
| GitHub import 폼 | URL 입력 placeholder `https://github.com/username/repo`, `가져오기` 버튼 확인 |

---

## 3. 실행 증거

| 시점 | 관찰 내용 | 저장된 브라우저 기록 |
|---|---|---|
| 문서 확인 | 공식 문서에서 GitHub import 설명 확인 | `/home/ubuntu/browser_findings_phase_d_import_2.md` |
| 앱 설정 진입 | `#settings/skills` 화면과 Skills 목록 확인 | `/home/ubuntu/browser_findings_phase_d_import_4.md` |
| URL 입력 | `https://github.com/gjnvcdprfw-hub/dubyeol-workflow-skills` 입력 | 브라우저 입력 로그 |
| import 실행 | `가져오기` 클릭 후 spinner 표시 | `/home/ubuntu/browser_findings_phase_d_import_5.md` |
| 결과 확인 | browser extension 504 이후 Skills 목록으로 복귀 | `/home/ubuntu/browser_findings_phase_d_import_6.md` |
| 검색 검증 | `01-load-sub-manual`, `dubyeol` 검색 모두 결과 없음 | `/home/ubuntu/browser_findings_phase_d_import_7.md` |

---

## 4. 해석

가장 가능성이 높은 원인은 **multi-skill 단일 저장소 구조가 현재 Manus GitHub import에서 자동 탐색되지 않는 것**이다. 본 저장소 루트에는 `SKILL.md`가 없고, 9개 하위 폴더 각각에 `SKILL.md`가 있다. 공식 문서에는 repository link를 제공한다고만 설명되어 있으며, 하위 폴더 9개를 자동 탐색해 9개 스킬로 가져오는지 여부는 본 UI 검증에서 확인되지 않았다.

다만 명시적 오류 메시지를 캡처하지 못했으므로 “multi-skill 미지원”을 확정 사실로 단정하지 않는다. 현재 확인된 사실은 “해당 단일 저장소 URL import 후 Skills 목록에서 9개 또는 일부 skill이 보이지 않았다”이다.

---

## 5. 정정안

| 옵션 | 내용 | 장점 | 리스크 |
|---|---|---|---|
| A | 각 스킬 하위 폴더 URL을 개별 import 시도 | 단일 repo를 유지하면서 9회 import 가능성 검증 | Manus가 subdirectory URL을 지원하는지 [미확인] |
| B | 루트 `SKILL.md`를 추가해 단일 meta-skill로 구성 | GitHub import가 루트 `SKILL.md`만 기대한다면 인식 가능성 높음 | 9개 독립 slash command가 아니라 meta-skill 1개가 될 수 있음 |
| C | 9개 개별 저장소로 분리 | GitHub import가 repo당 1 skill만 지원하는 경우 가장 명확 | 저장소 9개 생성·관리 부담, [Owner] 명시 승인 필요 |
| D | zip/folder upload 방식으로 우회 | 즉시 설치 가능성 | GitHub import 검증 목적과 다름, 버전 업데이트 흐름 약함 |

본 task에서는 구조 변경·저장소 추가 생성이 out of scope이므로, 위 정정안은 final-report 후속 제안으로 넘긴다.

---

## 6. 최종 판정

`dubyeol-workflow-skills` 단일 GitHub 저장소 import는 **현재 검증에서 실패 또는 인식 결과 없음**으로 판정한다. 32개 파일 push와 공개 저장소 반영은 성공했지만, Manus Skills import는 9개 모두 인식되지 않았고 부분 인식도 확인되지 않았다. 따라서 PROJECT.md §C.1 상태는 “운영중”이 아니라 **검증중**으로 두어야 한다.

---

**manus-import-verification 끝.**
