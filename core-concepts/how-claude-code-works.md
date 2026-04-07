---
source_url: https://code.claude.com/docs/en/how-claude-code-works
fetched: 2026-04-06
---

# How Claude Code Works

Claude Code is an agentic assistant running in your terminal. It excels at coding but can help with anything from the command line: writing docs, running builds, searching files, researching topics, and more.

## The Agentic Loop

When you give Claude a task, it works through three phases:
1. **Gather context** — reads files, searches codebase, understands structure
2. **Take action** — edits files, runs commands, calls tools
3. **Verify results** — runs tests, checks output, course-corrects

These phases blend together and repeat. You can interrupt at any point to steer, provide context, or try a different approach.

**Two components power the loop:**
- **Models** — reason about the task. Sonnet for most tasks; Opus for complex architectural decisions. Switch with `/model` or `claude --model <n>`.
- **Tools** — act on the world

## Built-in Tools

| Category | What Claude can do |
|---|---|
| File operations | Read, edit, create, rename files |
| Search | Find files by pattern, search content with regex |
| Execution | Run shell commands, tests, git operations |
| Web | Search the web, fetch documentation |
| Code intelligence | Type errors, warnings, jump-to-definition (requires plugins) |

## What Claude Can Access

When you run `claude` in a directory:
- **Your project** — all files in directory and subdirectories
- **Your terminal** — any CLI command: build tools, git, package managers, scripts
- **Your git state** — current branch, uncommitted changes, recent history
- **Your CLAUDE.md** — project-specific instructions and conventions
- **Auto memory** — learnings saved automatically across sessions
- **Your extensions** — MCP servers, skills, subagents, Claude in Chrome

Because Claude sees your whole project, it can work across files — searching, reading, editing multiple files, running tests, and committing — all in one task.

## Execution Environments

| Environment | Where code runs | Use case |
|---|---|---|
| Local | Your machine | Default. Full access to files, tools |
| Cloud | Anthropic-managed VMs | Offload tasks, work on remote repos |
| Remote Control | Your machine, browser-controlled | Web UI + local environment |

## Sessions

- Saved locally with full conversation history
- **Independent** — each new session starts fresh
- **Resume**: `claude --continue` or `claude --resume`
- **Fork**: `claude --continue --fork-session` — branch without affecting original
- **Parallel**: use git worktrees for concurrent sessions in separate directories

## The Context Window

Holds: conversation history, file contents, command outputs, CLAUDE.md, auto memory, skills, system instructions.

**When it fills up:**
- Auto-compacts — clears older tool outputs, summarizes if needed
- Put persistent rules in CLAUDE.md, not conversation history
- `/compact focus on <topic>` — control what's preserved
- `/context` — see what's using space

**Context management:**
- **Skills** load on demand — descriptions load at start, full content only when used
- **Subagents** get isolated fresh context; results return as summaries

## Safety Mechanisms

**Checkpoints:** Every file edit snapshots the file first. Press `Esc` twice to rewind, or ask Claude to undo.

**Permissions:** Control what Claude can do without asking. Configure via `/permissions` or permission modes.

## Working Effectively

- **Be specific upfront** — "fix the login bug where users see blank screen" not "fix the bug"
- **Give something to verify against** — share tests, expected outputs, acceptance criteria
- **Explore before implementing** — ask Claude to analyze first
- **Delegate the goal, not the steps** — describe what you want, not how to do it
- **Interrupt and steer** — the loop is interactive; redirect anytime
