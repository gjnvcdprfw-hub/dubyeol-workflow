# Phase H run sync to dubyeol-workflow

- synced_at: 2026-05-17 11:59:53 KST
- source: /Users/twostars/ClaudeAi/silkroadhub/.harness/runs/20260517_dubyeol-workflow-master-split
- destination: /Users/twostars/ClaudeAi/dubyeol-workflow/.harness/runs/20260517_dubyeol-workflow-master-split

## 1. File counts after sync
| Location | File Count |
|---|---:|
| silkroadhub | 35 |
| dubyeol-workflow | 34 |

## 2. diff -qr after sync
```text
Only in /Users/twostars/ClaudeAi/silkroadhub/.harness/runs/20260517_dubyeol-workflow-master-split: run-location-sync.md
```

## 3. md5 after sync
```text
02a99695d9492965d53d582d9b9144da  silk ./codex-call-ops-correction.md
f3883993f12196dad2e344f4635bff1d  silk ./codex-exec-retry2.log
383f09e20b04b1038a55767c08120852  silk ./codex-exec-terminal.log
0b6e1323775f1e6e30368281f78bf9d3  silk ./codex-exec.log
d0f18f0c75fc335007b468822e9ef8f2  silk ./dubyeol-PROJECT-before-sub5.md
d41d8cd98f00b204e9800998ecf8427e  silk ./dubyeol-project-sub5-diff.patch
d2b34afe2985d9a61b5f0187174997a3  silk ./final-report.md
75c1f16ed75f6aa9d7be6d367a9f78ad  silk ./foreman-verification.md
33c2324ca09fb8039e3f0a737d9bce12  silk ./gate-review.md
5d71dbd96d56215816d8e34c9c2e403b  silk ./handoff.md
7e46de711a326d22bc1b5a7ed47201ce  silk ./judge-exec.log
84362f99d1496a541143679421dcbc59  silk ./judge-input.md
3f7678e0e87e2bd15c24be8cee5112d0  silk ./judge-payload.json
8bb781496382eb4a652f3e455c27f4ca  silk ./judge-raw.json
7c82aec040ad35d8fb71439e6d4bf1c5  silk ./judge-raw.md
cc1f929d887af00d5935d770a7b47cce  silk ./reviewer-fallback-exec.log
e85f0f301d6013145d7950f76c57afbb  silk ./reviewer-fallback-payload.json
841f9982045055c95da767f65ead75a1  silk ./reviewer-fallback-raw.json
b6ce318e579d94415d362a90d9c0a46d  silk ./reviewer-fallback-raw.md
a4e64c48e3900b210edfeb99571fb7b0  silk ./reviewer-input-short.md
22ec37825ff0d7f12ad4835bee155eb3  silk ./reviewer-input.md
d41d8cd98f00b204e9800998ecf8427e  silk ./reviewer-raw-retry2.md
d41d8cd98f00b204e9800998ecf8427e  silk ./reviewer-raw-terminal.md
d41d8cd98f00b204e9800998ecf8427e  silk ./reviewer-raw.md
2bf08f5cbb8646b9438e5bb8c19b3035  silk ./run-location-check.md
a095ca655537c8257d3d6f49a0deec9a  silk ./run-location-sync.md
eedccce326f5f37ab6060de88e829988  silk ./sub4-dangling-reference-active-docs.txt
970d19ab0b08e9741bd1ae48cae02175  silk ./sub4-dubyeol-contamination-check.md
950e01774b60498c5e01b71dabccccfc  silk ./sub4-dubyeol-secret-suspect-files.txt
e5df09a3289ef0856f853e3cdacf3785  silk ./sub4-legacy-and-phasec-plan.md
244531aacfd1004114ca40e912489f5a  silk ./sub4-modifications.md
d38178afec8e03b107bb3cb1b61df377  silk ./sub4-remote-head-check.md
a299fb3c25ad34e174a2b265a527d0b3  silk ./sub4-silkroadhub-reference-check.md
da7e90a61f751d7402ec72ec4498f187  silk ./sub5-pre-report-check.md
af69b3e340899c31524c2a68a74950af  silk ./task-card.md
---
02a99695d9492965d53d582d9b9144da  dub  ./codex-call-ops-correction.md
f3883993f12196dad2e344f4635bff1d  dub  ./codex-exec-retry2.log
383f09e20b04b1038a55767c08120852  dub  ./codex-exec-terminal.log
0b6e1323775f1e6e30368281f78bf9d3  dub  ./codex-exec.log
d0f18f0c75fc335007b468822e9ef8f2  dub  ./dubyeol-PROJECT-before-sub5.md
d41d8cd98f00b204e9800998ecf8427e  dub  ./dubyeol-project-sub5-diff.patch
d2b34afe2985d9a61b5f0187174997a3  dub  ./final-report.md
75c1f16ed75f6aa9d7be6d367a9f78ad  dub  ./foreman-verification.md
33c2324ca09fb8039e3f0a737d9bce12  dub  ./gate-review.md
5d71dbd96d56215816d8e34c9c2e403b  dub  ./handoff.md
7e46de711a326d22bc1b5a7ed47201ce  dub  ./judge-exec.log
84362f99d1496a541143679421dcbc59  dub  ./judge-input.md
3f7678e0e87e2bd15c24be8cee5112d0  dub  ./judge-payload.json
8bb781496382eb4a652f3e455c27f4ca  dub  ./judge-raw.json
7c82aec040ad35d8fb71439e6d4bf1c5  dub  ./judge-raw.md
cc1f929d887af00d5935d770a7b47cce  dub  ./reviewer-fallback-exec.log
e85f0f301d6013145d7950f76c57afbb  dub  ./reviewer-fallback-payload.json
841f9982045055c95da767f65ead75a1  dub  ./reviewer-fallback-raw.json
b6ce318e579d94415d362a90d9c0a46d  dub  ./reviewer-fallback-raw.md
a4e64c48e3900b210edfeb99571fb7b0  dub  ./reviewer-input-short.md
22ec37825ff0d7f12ad4835bee155eb3  dub  ./reviewer-input.md
d41d8cd98f00b204e9800998ecf8427e  dub  ./reviewer-raw-retry2.md
d41d8cd98f00b204e9800998ecf8427e  dub  ./reviewer-raw-terminal.md
d41d8cd98f00b204e9800998ecf8427e  dub  ./reviewer-raw.md
2bf08f5cbb8646b9438e5bb8c19b3035  dub  ./run-location-check.md
eedccce326f5f37ab6060de88e829988  dub  ./sub4-dangling-reference-active-docs.txt
970d19ab0b08e9741bd1ae48cae02175  dub  ./sub4-dubyeol-contamination-check.md
950e01774b60498c5e01b71dabccccfc  dub  ./sub4-dubyeol-secret-suspect-files.txt
e5df09a3289ef0856f853e3cdacf3785  dub  ./sub4-legacy-and-phasec-plan.md
244531aacfd1004114ca40e912489f5a  dub  ./sub4-modifications.md
d38178afec8e03b107bb3cb1b61df377  dub  ./sub4-remote-head-check.md
a299fb3c25ad34e174a2b265a527d0b3  dub  ./sub4-silkroadhub-reference-check.md
da7e90a61f751d7402ec72ec4498f187  dub  ./sub5-pre-report-check.md
af69b3e340899c31524c2a68a74950af  dub  ./task-card.md
```
