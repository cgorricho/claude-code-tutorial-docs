# Claude Code Docs — Knowledge Base

A version-controlled mirror of the [Claude Code documentation](https://code.claude.com/docs/en/) built as the reference corpus for the **Claude Code CLI Tutorial** Claude.ai Project.

## Purpose

- **Evergreen reference**: Each doc page is a Markdown file, versioned in git
- **Update signal**: `URL_MANIFEST.md` tracks when each page was last fetched
- **Tutorial substrate**: The Claude.ai Project uses these files as its knowledge base

## How to Refresh

```bash
bash refresh.sh
git add -A
git commit -m "docs: refresh $(date +%Y-%m-%d)"
git push
```

Or delegate to Claude Code CLI:
```bash
claude "run refresh.sh, commit and push the updated docs with today's date"
```

## Update Signal Convention

Each file has YAML frontmatter:
```yaml
---
source_url: https://code.claude.com/docs/en/overview
fetched: 2026-04-06
---
```

`URL_MANIFEST.md` status values:
- `✅ YYYY-MM-DD` — fetched on that date
- `⚠️ STALE` — older than 30 days
- `❌ FAILED` — last fetch failed
- `PENDING` — not yet fetched (stub placeholder)

## Linking to Claude.ai Project

After refreshing, upload updated `.md` files to the Claude.ai Project under Project Files. Eventually automate with an n8n workflow or GitHub Action.
