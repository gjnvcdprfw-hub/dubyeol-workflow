# temp-dir-decision — 20260516_skills-github-register

**판단**: 옵션 나, `/tmp/dubyeol-skills-push-20260517000655`를 후속 Phase F 진입 전까지 보존한다.

**근거**: [Owner]는 Phase F에서 import 미인식 정정 task를 예약했고, 정정안 채택 시 기존 임시 디렉터리의 git remote·commit 이력을 재사용하면 재push 또는 구조 비교가 빠르다. task-card 초기 안전선에는 “push 후 보존하지 않음”이 있었으나, import 실패/미인식 검증 결과로 후속 정정 task가 현실화되었으므로 보존 효율이 삭제보다 크다.

**제약**: 본 임시 디렉터리에서 추가 commit·push·cleanup은 Phase F task-card 또는 [Owner] 명시 승인 없이는 수행하지 않는다.
