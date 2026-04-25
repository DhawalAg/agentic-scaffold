# agentic-scaffold

Portable project management scaffold for agentic coding with Claude Code.

Pull this into any project — CLI tool, web app, data pipeline, whatever — and
get a working session lifecycle, issue tracking, and commit workflow out of the box.

## What's Inside

```
.claude/commands/              # Slash commands for project management
  session-start.md             # Create daily hub, load context, pick task
  session-end.md               # Log progress, update hub, handoff notes
  project-status.md            # Milestone + issue dashboard
  create-issue.md              # Quick issue creation with labels
  todo.md                      # Full workflow: select → implement → commit
  milestone-progress.md        # Deep dive on one milestone
  setup-scaffold.md            # Bootstrap scaffold into any project

docs/project-management/       # Project planning docs (customize these)
  01-vision.template.md        # Why the project exists
  05-roadmap.template.md       # Milestone-linked roadmap
  sessions/                    # Daily session folders
    YYYY-MM-DD/
      next-up.md               # Daily hub: focus, issues, scratch pad
      <descriptor>.md           # Individual workstream sessions

scripts/
  setup-github-labels.sh       # Create labels on your GitHub repo
  init-project.sh              # Copy scaffold into an existing project

CLAUDE.md.template             # CLAUDE.md starter (customize per project)
```

## Quick Start

### Option A: New project
```bash
cp -r agentic-scaffold my-new-project
cd my-new-project
mv CLAUDE.md.template CLAUDE.md
# Edit CLAUDE.md, vision, roadmap for your project
```

### Option B: Existing project (script)
```bash
cd my-project
bash /path/to/agentic-scaffold/scripts/init-project.sh
```

### Option C: Existing project (interactive command)
```bash
# Inside Claude Code / Code Puppy:
/setup-scaffold
```

### Option D: Cherry-pick
```bash
cp -r /path/to/agentic-scaffold/.claude/commands/ .claude/commands/
```

### Then: Set up GitHub
```bash
bash scripts/setup-github-labels.sh
```

## The Daily Loop

```
/session-start             ← create daily hub, pick a task
  ↓
  code, code, code...
  commit: "feat: X (#12)"
  ↓
  /create-issue            ← capture ideas inline
  /project-status          ← check progress
  ↓
/session-end               ← log progress, update hub
```

## Session Structure

Each day gets a folder. `next-up.md` is your cockpit.

```
sessions/
  2026-04-25/
    next-up.md               ← Daily hub (focus, active issues, scratch pad)
    research-deep-dive.md    ← Workstream session
    refactor-auth.md         ← Another workstream same day
  2026-04-26/
    next-up.md
    implement-caching.md
```

- **next-up.md** — Agent reads it + appends updates. You own the content.
- **Active Issues** section auto-refreshes from GitHub each `/session-start`.
- **Scratch Pad** carries over across days. Promote to issues when they mature.
- **Session files** are workstream journals. One per thread of work.

## Design Principles

1. **Minimal.** 7 commands, 10 labels, 3 template files. That's it.
2. **Portable.** Nothing project-specific in the commands. Works anywhere.
3. **Git-native.** GitHub Issues + Milestones. No external tools.
4. **Session-oriented.** Context is expensive. Written handoffs > memory.
5. **Inside-out.** Learn the workflow by using it, not by reading about it.
6. **Your cockpit.** next-up.md is yours. The agent helps, never hijacks.

## Research

This scaffold is distilled from studying battle-tested workflows in:
- [anthropics/claude-code](https://github.com/anthropics/claude-code) — issue triage, commit-push-PR
- [badlogic/claude-commands](https://github.com/badlogic/claude-commands) — todo-worktree workflow
- [mitsuhiko/agent-stuff](https://github.com/mitsuhiko/agent-stuff) — 19 skills, librarian pattern
- [coleam00/link-in-bio-page-builder](https://github.com/coleam00/link-in-bio-page-builder) — prime, plan-feature, execute
- [EveryInc/claude_commands](https://github.com/EveryInc/claude_commands) — tiered issue detail levels
- [robzolkos/claude-commands](https://github.com/robzolkos/claude-commands) — reflect, reverse, solo-dev flow
- [marcusgoll/Spec-Flow](https://github.com/marcusgoll/Spec-Flow) — spec-driven, tiered task sizing
- [agenticnotetaking/eidos](https://github.com/agenticnotetaking/eidos) — spec↔code push/pull/drift

See `docs/research.md` for the full analysis.

## License

Do whatever you want with this. It's a scaffold, not a framework.
