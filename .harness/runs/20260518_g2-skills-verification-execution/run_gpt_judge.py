#!/usr/bin/env python3
import json
import os
import sys
import urllib.request
import urllib.error
from pathlib import Path

ROOT = Path('/Users/twostars/ClaudeAi/dubyeol-workflow')
RUN = ROOT / '.harness/runs/20260518_g2-skills-verification-execution'
INPUT = RUN / 'judge-input.md'
OUTPUT = RUN / 'judge-raw.md'
LOG = RUN / 'judge-exec.log'
MODEL = 'gpt-5.5'


def call_openai(prompt: str) -> str:
    api_key = os.environ.get('OPENAI_API_KEY')
    if not api_key:
        raise RuntimeError('OPENAI_API_KEY is not set')
    system = (
        'You are [Judge], a Devil\'s Advocate for business, planning, and logical fit only. '
        'Do not inspect code details or make file-level technical judgments. '
        'Use the Reviewer summary only as technical evidence, and decide the workflow gate from Owner intent and operational risk. '
        'You are a separate role/session from Reviewer.'
    )
    payload = {
        'model': MODEL,
        'messages': [
            {'role': 'system', 'content': system},
            {'role': 'user', 'content': prompt},
        ],
        'max_completion_tokens': 5000,
    }
    req = urllib.request.Request(
        'https://api.openai.com/v1/chat/completions',
        data=json.dumps(payload).encode('utf-8'),
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
    LOG.write_text('=== GPT Judge Start ===\n', encoding='utf-8')
    prompt = INPUT.read_text(encoding='utf-8', errors='replace')
    with LOG.open('a', encoding='utf-8') as f:
        f.write(f'Model: {MODEL}\n')
        f.write(f'Input chars: {len(prompt)}\n')
        f.write(f'Input path: {INPUT}\n')
        f.write('Session separation: Judge input excludes code details and is separate from Reviewer fallback.\n')
    try:
        result = call_openai(prompt)
        OUTPUT.write_text('# [Judge] 응답 — 지피티 별도 세션\n\n' + result.strip() + '\n', encoding='utf-8')
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
