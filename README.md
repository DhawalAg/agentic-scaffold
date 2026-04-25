# agentic-scaffold

Portable project management scaffold for agentic coding with Claude Code.

Pull this into any project — CLI tool, web app, data pipeline, whatever — and
get a working session lifecycle, issue tracking, and commit workflow out of the box.

## What's Inside

```
.claude/commands/          # Slash commands for project management
  session-start.md         # Load context, pick task, branch off
  session-end.md           # Save progress, write handoff notes
  project-status.md        # Milestone + issue dashboard
  create-issue.md          # Quick issue creation with labels
  todo.md                  # Full workflow: select → implement → commit
  milestone-progress.md    # Deep dive on one milestone

docs/project-management/   # Project planning docs (customize these)
  01-vision.template.md    # Why the project exists
  05-roadmap.template.md   # Milestone-linked roadmap
  sessions/                # Session handoff logs (auto-generated)

scripts/
  setup-github-labels.sh   # Create labels on your GitHub repo
  init-project.sh          # Copy scaffold into an existing project

CLAUDE.md.template         # CLAUDE.md starter (customize per project)
```

## Quick Start

### Option A: New project
```bash
# Clone this scaffold, rename it, start building
cp -r agentic-scaffold my-new-project
cd my-new-project
# Rename templates
mv CLAUDE.md.template CLAUDE.md
mv docs/project-management/01-vision.template.md docs/project-management/01-vision.md
mv docs/project-management/05-roadmap.template.md docs/project-management/05-roadmap.md
# Edit CLAUDE.md, vision, roadmap for your project
```

### Option B: Existing project
```bash
# Run the init script from inside your project
bash /path/to/agentic-scaffold/scripts/init-project.sh
```

### Option C: Cherry-pick
```bash
# Just grab the commands
cp -r /path/to/agentic-scaffold/.claude/commands/ .claude/commands/
```

### Then: Set up GitHub
```bash
bash scripts/setup-github-labels.sh
gh milestone create "A1: Foundation" --description "..."
```

## The Daily Loop

```
/session-start         ← load context, pick a task
  ↓
  code, code, code...
  commit: "feat: X (#12)"
  ↓
  /create-issue        ← capture ideas inline
  /project-status      ← check progress
  ↓
/session-end           ← log progress, handoff notes
```

## Design Principles

1. **Minimal.** 6 commands, 10 labels, 3 template files. That's it.
2. **Portable.** Nothing project-specific in the commands. Works anywhere.
3. **Git-native.** GitHub Issues + Milestones. No external tools.
4. **Session-oriented.** Context is expensive. Written handoffs > memory.
5. **Inside-out.** Learn the workflow by using it, not by reading about it.

## Research

This scaffold is distilled from studying battle-tested workflows in:
- [anthropics/claude-code](https://github.com/anthropics/claude-code) — issue triage, commit-push-PR
- [badlogic/claude-commands](https://github.com/badlogic/claude-commands) — todo-worktree workflow
- [mitsuhiko/agent-stuff](https://github.com/mitsuhiko/agent-stuff) — 19 skills, librarian pattern
- [coleam00/link-in-bio-page-builder](https://github.com/coleam00/link-in-bio-page-builder) — prime, plan-feature, execute
- [EveryInc/claude_commands](https://github.com/EveryInc/claude_commands) — tiered issue detail levels

See `docs/research.md` for the full analysis.

## License

Do whatever you want with this. It's a scaffold, not a framework.
