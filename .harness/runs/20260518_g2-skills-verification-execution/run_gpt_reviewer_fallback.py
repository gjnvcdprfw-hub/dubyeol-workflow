#!/usr/bin/env python3
import json
import os
import sys
import urllib.request
import urllib.error
from pathlib import Path

ROOT = Path('/Users/twostars/ClaudeAi/dubyeol-workflow')
RUN = ROOT / '.harness/runs/20260518_g2-skills-verification-execution'
OUTPUT = RUN / 'reviewer-raw.md'
LOG = RUN / 'gpt-reviewer-fallback-exec.log'
INPUT_COPY = RUN / 'reviewer-fallback-packaged-input.md'
MODEL = 'gpt-5.5'

SKILLS = [
    '01-load-sub-manual',
    '02-create-task-card',
    '03-dispatch-to-builder',
    '04-invoke-plan-review',
    '05-verify-handoff',
    '06-invoke-reviewer',
    '07-invoke-judge',
    '08-write-final-report',
    '09-update-project-md',
]


def read_text(path: Path, max_chars: int = 20000) -> str:
    try:
        text = path.read_text(encoding='utf-8', errors='replace')
    except FileNotFoundError:
        return f'[MISSING] {path}\n'
    if len(text) > max_chars:
        return text[:max_chars] + f'\n\n[TRUNCATED at {max_chars} chars from {path}]\n'
    return text


def collect() -> str:
    parts = []
    parts.append('# Packaged Reviewer Input — GPT Fallback\n')
    parts.append('This package is for [Reviewer] technical audit only. It intentionally excludes Owner intent and PROJECT.md. Do not perform Judge/business role.\n')
    parts.append('## Original reviewer-input.md\n')
    parts.append(read_text(RUN / 'reviewer-input.md', 30000))
    parts.append('\n## skill-verification-summary.md\n')
    parts.append(read_text(RUN / 'skill-verification-summary.md', 30000))
    parts.append('\n## handoff-verification.md\n')
    parts.append(read_text(RUN / 'handoff-verification.md', 20000))
    parts.append('\n## Evidence files\n')
    for ev in sorted(RUN.glob('g2-*.md')):
        parts.append(f'\n### {ev.relative_to(ROOT)}\n')
        parts.append(read_text(ev, 12000))
    parts.append('\n## Skill definitions and scripts\n')
    for skill in SKILLS:
        skill_dir = ROOT / skill
        parts.append(f'\n### {skill}/SKILL.md\n')
        parts.append(read_text(skill_dir / 'SKILL.md', 12000))
        scripts = sorted((skill_dir / 'scripts').glob('*')) if (skill_dir / 'scripts').exists() else []
        for script in scripts:
            if script.is_file():
                parts.append(f'\n### {script.relative_to(ROOT)}\n')
                parts.append(read_text(script, 16000))
        refs = sorted((skill_dir / 'references').glob('*')) if (skill_dir / 'references').exists() else []
        ref_names = [str(p.relative_to(ROOT)) for p in refs if p.is_file()]
        parts.append(f'\n### {skill}/references file list\n')
        parts.append('\n'.join(ref_names) if ref_names else '[empty]\n')
    return '\n'.join(parts)


def call_openai(prompt: str) -> str:
    api_key = os.environ.get('OPENAI_API_KEY')
    if not api_key:
        raise RuntimeError('OPENAI_API_KEY is not set')
    system = (
        'You are [Reviewer], a technical/code auditor for the dubyeol-workflow skills. '
        'Review only technical correctness, scripts, file paths, output locations, input isolation mechanics, and evidence sufficiency. '
        'Do not evaluate business intent, Owner intent, roadmap, priority, or Tier. Do not act as Judge. '
        'Do not suggest direct file edits; list required fixes only.'
    )
    user = prompt + '''\n\nReturn exactly this Markdown structure:\n\n# Reviewer Raw Result — G-2 Skills Verification\n\n## 1. Overall Technical Verdict\nVerdict: PASS / CONDITIONAL PASS / HOLD / BLOCK\n\n## 2. Confirmed Technical Findings\n| Finding | Severity | Evidence |\n|---|---|---|\n\n## 3. Disputed or Unproven Findings\n| Finding | Reason |\n|---|---|\n\n## 4. Missed Technical Risks\n| Risk | Severity | Evidence |\n|---|---|---|\n\n## 5. Required Fixes Before Closure\n| Fix | Priority | Scope |\n|---|---|---|\n\n## 6. Reviewer Boundary Check\n- Code/technical scope only: yes/no\n- Business/Judge role avoided: yes/no\n- Direct code modification performed: no\n'''
    payload = {
        'model': MODEL,
        'messages': [
            {'role': 'system', 'content': system},
            {'role': 'user', 'content': user},
        ],
        'max_completion_tokens': 6000,
    }
    data = json.dumps(payload).encode('utf-8')
    req = urllib.request.Request(
        'https://api.openai.com/v1/chat/completions',
        data=data,
        headers={'Authorization': f'Bearer {api_key}', 'Content-Type': 'application/json'},
        method='POST',
    )
    try:
        with urllib.request.urlopen(req, timeout=240) as resp:
            body = json.loads(resp.read().decode('utf-8'))
            return body['choices'][0]['message']['content']
    except urllib.error.HTTPError as e:
        err = e.read().decode('utf-8', errors='replace')
        raise RuntimeError(f'HTTPError {e.code}: {err}')


def main() -> int:
    LOG.write_text('=== GPT Reviewer Fallback Start ===\n', encoding='utf-8')
    prompt = collect()
    INPUT_COPY.write_text(prompt, encoding='utf-8')
    with LOG.open('a', encoding='utf-8') as f:
        f.write(f'Model: {MODEL}\n')
        f.write(f'Packaged input chars: {len(prompt)}\n')
        f.write(f'Packaged input path: {INPUT_COPY}\n')
    try:
        result = call_openai(prompt)
        OUTPUT.write_text('# [Reviewer] 폴백 (지피티) — Codex 불가로 대체\n\n' + result.strip() + '\n', encoding='utf-8')
        with LOG.open('a', encoding='utf-8') as f:
            f.write(f'SUCCESS chars={len(result)}\n')
        return 0
    except Exception as e:
        with LOG.open('a', encoding='utf-8') as f:
            f.write(f'FAIL: {e}\n')
        print(f'FAIL: {e}', file=sys.stderr)
        return 3

if __name__ == '__main__':
    raise SystemExit(main())
