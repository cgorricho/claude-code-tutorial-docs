---
source_url: https://code.claude.com/docs/en/quickstart
fetched: 2026-04-06
---

# Quickstart

## Before You Begin

- Terminal or command prompt open
- A code project to work with
- Claude subscription (Pro, Max, Team, Enterprise), Console account, or supported cloud provider

## Step 1: Install

```bash
# macOS/Linux/WSL
curl -fsSL https://claude.ai/install.sh | bash

# Windows PowerShell
irm https://claude.ai/install.ps1 | iex

# Homebrew
brew install --cask claude-code

# WinGet
winget install Anthropic.ClaudeCode
```

Native installs auto-update. Homebrew/WinGet require manual upgrades.

## Step 2: Log In

```bash
claude   # prompted to log in on first use
```

Login options: Claude Pro/Max/Team/Enterprise, Claude Console, or Amazon Bedrock/Google Vertex AI/Microsoft Foundry.

## Step 3: Start a Session

```bash
cd /path/to/your/project
claude
```

## Step 4: Ask Your First Question

```
what does this project do?
explain the folder structure
where is the main entry point?
```

Claude reads project files as needed — no manual context required.

## Step 5: Make a Code Change

```
add a hello world function to the main file
```

Claude shows proposed changes and asks for approval before editing anything.

## Step 6: Use Git

```
what files have I changed?
commit my changes with a descriptive message
create a new branch called feature/my-feature
```

## Essential Commands

| Command | What it does |
|---|---|
| `claude` | Start interactive mode |
| `claude "task"` | Run a one-time task |
| `claude -p "query"` | One-off query, then exit |
| `claude -c` | Continue most recent conversation |
| `claude -r` | Resume a previous conversation |
| `/clear` | Clear conversation history |
| `/help` | Show available commands |
| `exit` or `Ctrl+D` | Exit |

## Pro Tips

- **Be specific**: "fix the login bug where users see blank screen" not "fix the bug"
- **Break complex tasks into numbered steps**
- **Let Claude explore first**: ask it to analyze before making changes
- Press `?` for keyboard shortcuts, `/` to see all commands
