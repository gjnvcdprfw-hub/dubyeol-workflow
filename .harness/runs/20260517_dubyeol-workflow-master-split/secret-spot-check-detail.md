# Phase H secret spot-check detail (value redacted)

- checked_at: 2026-05-17 12:05:33 KST
- file: `./.harness/runs/20260517_skills-direct-register/task-card-reissue-diff-summary.md`
- policy: 실제 값과 원문 라인은 출력하지 않는다.

| Pattern Class | Count | Interpretation |
|---|---:|---|
| OpenAI-style sk token | 1 | actual secret-like token/assignment pattern present — stop required |
| GitHub classic ghp token | 0 | not present |
| GitHub fine-grained token | 0 | not present |
| private key header | 0 | not present |
| assignment keyword | 0 | not present |

## Decision

Commit remains stopped until Owner decides whether to redact/remove this file from import scope or inspect manually.
