#!/usr/bin/env bash
# refresh.sh — Re-fetch all Claude Code doc pages and save as Markdown
# Run from repo root: bash refresh.sh
# Requires: curl, python3

set -euo pipefail

FETCH_DATE=$(date +%Y-%m-%d)
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
FAILED=0
SUCCESS=0

echo "🔄 Claude Code Docs Refresh — $FETCH_DATE"
echo "================================================"

fetch_page() {
  local url="$1"
  local rel_path="$2"
  local full_path="$BASE_DIR/$rel_path"
  mkdir -p "$(dirname "$full_path")"
  local html
  if html=$(curl -sf -A "Mozilla/5.0" --max-time 20 "$url"); then
    local content
    content=$(python3 - << 'PYEOF'
import sys, re
html = sys.stdin.read()
html = re.sub(r'<(script|style|nav|footer)[^>]*>.*?</\1>', '', html, flags=re.DOTALL|re.IGNORECASE)
for i in range(6, 0, -1):
    html = re.sub(rf'<h{i}[^>]*>(.*?)</h{i}>', lambda m, n=i: '\n' + '#'*n + ' ' + re.sub('<[^>]+>','',m.group(1)).strip() + '\n', html, flags=re.DOTALL|re.IGNORECASE)
html = re.sub(r'<pre[^>]*><code[^>]*>(.*?)</code></pre>', lambda m: '\n```\n' + m.group(1) + '\n```\n', html, flags=re.DOTALL|re.IGNORECASE)
html = re.sub(r'<code[^>]*>(.*?)</code>', lambda m: '`' + m.group(1) + '`', html, flags=re.DOTALL|re.IGNORECASE)
html = re.sub(r'<li[^>]*>(.*?)</li>', lambda m: '- ' + re.sub('<[^>]+>','',m.group(1)).strip() + '\n', html, flags=re.DOTALL|re.IGNORECASE)
html = re.sub(r'<(p|div|br|tr)[^>]*>', '\n', html, flags=re.IGNORECASE)
text = re.sub(r'<[^>]+>', '', html)
text = text.replace('&amp;','&').replace('&lt;','<').replace('&gt;','>').replace('&quot;','"').replace('&#39;',"'").replace('&nbsp;',' ')
text = re.sub(r'\n{4,}', '\n\n\n', text)
print(text.strip())
PYEOF
<<< "$html")
    printf -- '---\nsource_url: %s\nfetched: %s\n---\n\n%s\n' "$url" "$FETCH_DATE" "$content" > "$full_path"
    echo "✅ $rel_path"
    ((SUCCESS++)) || true
  else
    echo "❌ $rel_path (fetch failed)"
    ((FAILED++)) || true
  fi
  sleep 0.3
}

fetch_page 'https://code.claude.com/docs/en/overview'                  'getting-started/overview.md'
fetch_page 'https://code.claude.com/docs/en/quickstart'                'getting-started/quickstart.md'
fetch_page 'https://code.claude.com/docs/en/changelog'                 'getting-started/changelog.md'
fetch_page 'https://code.claude.com/docs/en/how-claude-code-works'     'core-concepts/how-claude-code-works.md'
fetch_page 'https://code.claude.com/docs/en/features-overview'         'core-concepts/features-overview.md'
fetch_page 'https://code.claude.com/docs/en/claude-directory'          'core-concepts/claude-directory.md'
fetch_page 'https://code.claude.com/docs/en/context-window'            'core-concepts/context-window.md'
fetch_page 'https://code.claude.com/docs/en/memory'                    'use-claude-code/memory.md'
fetch_page 'https://code.claude.com/docs/en/permission-modes'          'use-claude-code/permission-modes.md'
fetch_page 'https://code.claude.com/docs/en/common-workflows'          'use-claude-code/common-workflows.md'
fetch_page 'https://code.claude.com/docs/en/best-practices'            'use-claude-code/best-practices.md'
fetch_page 'https://code.claude.com/docs/en/platforms'                 'platforms-integrations/platforms.md'
fetch_page 'https://code.claude.com/docs/en/remote-control'            'platforms-integrations/remote-control.md'
fetch_page 'https://code.claude.com/docs/en/claude-code-on-the-web'    'platforms-integrations/web.md'
fetch_page 'https://code.claude.com/docs/en/desktop-quickstart'        'platforms-integrations/desktop-quickstart.md'
fetch_page 'https://code.claude.com/docs/en/desktop'                   'platforms-integrations/desktop.md'
fetch_page 'https://code.claude.com/docs/en/chrome'                    'platforms-integrations/chrome.md'
fetch_page 'https://code.claude.com/docs/en/computer-use'              'platforms-integrations/computer-use.md'
fetch_page 'https://code.claude.com/docs/en/vs-code'                   'platforms-integrations/vs-code.md'
fetch_page 'https://code.claude.com/docs/en/jetbrains'                 'platforms-integrations/jetbrains.md'
fetch_page 'https://code.claude.com/docs/en/slack'                     'platforms-integrations/slack.md'
fetch_page 'https://code.claude.com/docs/en/sub-agents'                'build/sub-agents.md'
fetch_page 'https://code.claude.com/docs/en/mcp'                       'build/mcp.md'
fetch_page 'https://code.claude.com/docs/en/skills'                    'build/skills.md'
fetch_page 'https://code.claude.com/docs/en/hooks'                     'build/hooks.md'
fetch_page 'https://code.claude.com/docs/en/github-actions'            'build/github-actions.md'
fetch_page 'https://code.claude.com/docs/en/gitlab-ci-cd'              'build/gitlab-ci-cd.md'
fetch_page 'https://code.claude.com/docs/en/code-review'               'build/code-review.md'
fetch_page 'https://code.claude.com/docs/en/channels'                  'build/channels.md'
fetch_page 'https://code.claude.com/docs/en/scheduled-tasks'           'build/scheduled-tasks.md'
fetch_page 'https://code.claude.com/docs/en/web-scheduled-tasks'       'build/web-scheduled-tasks.md'
fetch_page 'https://code.claude.com/docs/en/third-party-integrations'  'deployment/third-party-integrations.md'
fetch_page 'https://code.claude.com/docs/en/bedrock'                   'deployment/bedrock.md'
fetch_page 'https://code.claude.com/docs/en/vertex'                    'deployment/vertex.md'
fetch_page 'https://code.claude.com/docs/en/setup'                     'administration/setup.md'
fetch_page 'https://code.claude.com/docs/en/troubleshooting'           'administration/troubleshooting.md'
fetch_page 'https://code.claude.com/docs/en/security'                  'administration/security.md'
fetch_page 'https://code.claude.com/docs/en/privacy-and-data'          'administration/privacy-and-data.md'
fetch_page 'https://code.claude.com/docs/en/enterprise-managed-policy' 'administration/enterprise-managed-policy.md'
fetch_page 'https://code.claude.com/docs/en/settings'                  'configuration/settings.md'
fetch_page 'https://code.claude.com/docs/en/cli-reference'             'reference/cli-reference.md'
fetch_page 'https://code.claude.com/docs/en/whats-new'                 'whats-new/whats-new.md'
fetch_page 'https://code.claude.com/docs/en/legal-and-compliance'      'whats-new/legal-and-compliance.md'

echo ""
echo "================================================"
echo "✅ $SUCCESS fetched | ❌ $FAILED failed"
echo "Run: git add -A && git commit -m \"docs: refresh $FETCH_DATE\" && git push"
