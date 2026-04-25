---
description: Bootstrap the agentic scaffold into any project
---

# Setup Scaffold

Initialize the full agentic coding scaffold in the current project.
Run this once when migrating the scaffold into a new repo.

## Step 1: Confirm Location

```bash
pwd
git remote -v 2>/dev/null || echo "No git remote"
```

Print: "Setting up scaffold in: <directory>. Continue? (y/n)"

⏸️ STOP — get confirmation before proceeding.

## Step 2: Git Init

If not already a git repo:
```bash
git init
```

## Step 3: .gitignore

Append standard ignores if not already present. Check before appending
to avoid duplicates:

```
# Dependencies
node_modules/
venv/
.venv/

# Environment
.env
.env.local

# Build artifacts
dist/
build/
__pycache__/

# OS
.DS_Store
Thumbs.db
```

## Step 4: Create Directory Structure

```bash
# Commands
mkdir -p .claude/commands

# Project management
mkdir -p docs/project-management/sessions

# Scripts
mkdir -p scripts
```

## Step 5: Copy Commands

Copy all finalized commands into `.claude/commands/`.
If a command already exists, skip it (don't overwrite customizations).

Commands to install:
- `session-start.md` — Begin session, create daily hub
- `session-end.md` — End session, write handoff
- `project-status.md` — Dashboard view
- `create-issue.md` — Quick issue creation
- `todo.md` — Select → implement → commit workflow
- `milestone-progress.md` — Milestone deep dive
- `setup-scaffold.md` — This command (self-referential, skip if exists)

For each command, print: "✅ Added <command>" or "⏭️ Skipped <command> (exists)"

## Step 6: Copy Templates

Install project management templates if they don't exist:

- `docs/project-management/sessions/README.md` — Session format guide
- `docs/project-management/01-vision.md` — From vision template
- `docs/project-management/05-roadmap.md` — From roadmap template

## Step 7: Copy Scripts

Install helper scripts if they don't exist:

- `scripts/setup-github-labels.sh` — Label setup script

## Step 8: CLAUDE.md

⏸️ STOP — Ask the user:

```
CLAUDE.md options:
  1. Create new — generate from template (no existing CLAUDE.md found)
  2. Append — add scaffold sections to existing CLAUDE.md
  3. Skip — don't touch CLAUDE.md

Choice?
```

**If Create:**
Generate CLAUDE.md from the template. Ask for:
- Project name
- One-line description
- Primary language/framework

Fill in the template with these values. Include the PM Commands section
referencing the installed commands.

**If Append:**
Read existing CLAUDE.md. Append only the sections that are missing:
- Project Management section with command references
- Commit Convention section
- Branch Convention section

**If Skip:**
Print "⏭️ Skipping CLAUDE.md"

## Step 9: GitHub Labels

If `gh` is available and authenticated:

```bash
gh auth status 2>/dev/null
```

If authenticated, ask: "Set up GitHub labels? (y/n)"

If yes:
```bash
bash scripts/setup-github-labels.sh
```

If `gh` not available: "⏭️ Skipping labels (gh CLI not found). Run later: bash scripts/setup-github-labels.sh"

## Step 10: First Day Folder

Create today's session folder and next-up.md:

```bash
mkdir -p docs/project-management/sessions/$(date +%Y-%m-%d)
```

Create `next-up.md`:

```markdown
# Next Up — YYYY-MM-DD

## Focus
Scaffold setup complete. Ready to start building.

## Active Issues
<!-- Run /session-start to populate from GitHub -->

## Sessions
<!-- Links to workstream sessions today -->

## Scratch Pad
- Scaffold installed — customize CLAUDE.md, vision, roadmap
```

## Step 11: Initial Commit

```bash
git add -A
git status
```

⏸️ STOP — Show what will be committed. Ask: "Commit scaffold? (y/n)"

If yes:
```bash
git commit -m "chore: initialize agentic scaffold"
```

## Step 12: Summary

```
🎉 SCAFFOLD INSTALLED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📁 Commands:     .claude/commands/ (N commands)
📁 PM docs:      docs/project-management/
📁 Sessions:     docs/project-management/sessions/YYYY-MM-DD/
📁 Scripts:      scripts/
📄 CLAUDE.md:    [created | appended | skipped]
🏷️  Labels:      [10 created | skipped]

Next steps:
  1. Edit docs/project-management/01-vision.md
  2. Edit docs/project-management/05-roadmap.md
  3. Customize CLAUDE.md for your project
  4. Create milestones: use /create-issue or gh CLI
  5. Start working: /session-start
```
