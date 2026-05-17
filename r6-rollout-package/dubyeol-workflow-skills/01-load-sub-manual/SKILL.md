---
name: 01-load-sub-manual
description: 마누스가 [Owner] 발화에서 SUB 매뉴얼 호출 신호를 인지하고 해당 SUB-N 매뉴얼을 자동 로드하는 스킬. "기획 매뉴얼 봐"/"워크플로우 매뉴얼 봐"/"감리 매뉴얼 봐"/"수정 매뉴얼 봐"/"종료 매뉴얼 봐"와 같은 자연 발화를 SUB-1~5로 라우팅. 마누스가 발화 컨버터로 동작. silkroadhub 두별 워크플로우 v3.6.0 r1 베타에서 마누스 프로젝트 지침 §7 발화 컨버터의 스킬화.
---

# 01-load-sub-manual

[Owner] 자연 발화를 SUB-N 매뉴얼 로드로 자동 라우팅.

## 언제 호출하는가

[Owner]가 다음 발화 또는 유사 발화 시:

| 발화 패턴 | 매핑 |
|---|---|
| "기획 매뉴얼 봐" / "의도 매뉴얼" / "SUB-1" | SUB-1 로드 |
| "워크플로우 매뉴얼 봐" / "구현 매뉴얼" / "SUB-2" | SUB-2 로드 |
| "감리 매뉴얼 봐" / "외부 검토 매뉴얼" / "SUB-3" | SUB-3 로드 |
| "수정 매뉴얼 봐" / "fix 매뉴얼" / "SUB-4" | SUB-4 로드 |
| "종료 매뉴얼 봐" / "마무리 매뉴얼" / "SUB-5" | SUB-5 로드 |
| "PROJECT.md 봐" | PROJECT.md 진입 점검 |

## 동작 순서

1. `scripts/load_sub.sh <sub_num>` 실행 (또는 PROJECT.md)
2. 해당 SUB-N 매뉴얼 파일 경로 출력
3. 마누스가 *전체 파일 읽음* (cat·view)
4. 매뉴얼 §0 강제력 + §1 진입 첫 행동 인지
5. 인지 완료 응답으로 [Owner]에 "SUB-N 진입 완료, 첫 행동 …" 보고

## 호출

```bash
# SUB-N 로드
bash scripts/load_sub.sh 1   # SUB-1
bash scripts/load_sub.sh 2   # SUB-2
# ... 3, 4, 5

# PROJECT.md 진입 점검
bash scripts/load_project_md.sh
```

## 핵심 원칙

- 매뉴얼은 *전체 로드* — 부분만 읽으면 §0 강제력 손실
- *진입 첫 행동*을 인지한 후에만 다음 행동
- 매뉴얼 충돌 시 [Owner] 최신 발화 우선, 그 다음 매뉴얼

## 산출물

- 마누스 컨텍스트에 SUB-N 매뉴얼 로드된 상태
- 진입 완료 응답 (예: "SUB-1 로드. 첫 행동은 §2 의도 정렬 5단계 SOP입니다.")

## 참조

- silkroadhub `마누스-프로젝트-지침-r6.md` §7 발화 컨버터
- silkroadhub `SUB-1`~`SUB-5` 매뉴얼
