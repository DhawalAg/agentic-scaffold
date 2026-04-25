# Review: Dicklesworthstone/post_compact_reminder

**Status:** 🔍 PENDING
**Link:** https://github.com/Dicklesworthstone/post_compact_reminder
**Stars:** 43 | **Focus:** Single hook to survive context compaction

---

## What They Have

### The Problem
During long coding sessions, Claude Code compacts conversation to stay within
context limits. After compaction, Claude **forgets** your AGENTS.md / CLAUDE.md
rules — coding conventions, forbidden commands, architecture patterns, all gone.

### The Solution
One `SessionStart` hook with `matcher: "compact"` that:
1. Detects compaction events
2. Injects a reminder telling Claude to re-read AGENTS.md
3. Zero maintenance, works globally across all projects

### Install
```bash
curl -fsSL https://raw.githubusercontent.com/Dicklesworthstone/post_compact_reminder/main/install-post-compact-reminder.sh | bash
```

### Design Philosophy
- Single hook, atomic file ops, fail loudly
- 4 built-in templates: minimal, detailed, checklist, default
- Idempotent installer (safe to re-run)
- Backs up settings.json before modification

---

## What We Could Steal

1. **The hook itself** — Dead simple, solves a real problem
2. **Matcher pattern** — `"compact"` matcher for targeted hook firing
3. **Template approach** — Customizable reminder message

### Effort: ~5 minutes to add to our scaffold

---

## Dhawal's Notes

<!-- Drop your notes here after reviewing the repo — this one's a 2 min read -->

**Overall verdict:** 🔍 PENDING

**What to take:**
-

**What to skip:**
-

**How to adapt for our scaffold:**
-
