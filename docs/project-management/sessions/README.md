# Session Logs

Daily folder structure with a hub file and individual workstream sessions.

```
sessions/
  YYYY-MM-DD/
    next-up.md              ← Daily hub: focus, active issues, scratch pad
    research-deep-dive.md   ← Individual workstream session
    refactor-auth.md        ← Another session same day
  YYYY-MM-DD/
    next-up.md
    ...
```

## How It Works

### next-up.md — The Daily Cockpit

Created by `/session-start` on the first session of each day.
Agent reads it for context and appends status updates. Never rewrites your content.

Two key sections:
- **Active Issues** — auto-populated from `gh issue list`. GitHub is the source of truth.
- **Scratch Pad** — temporary notes, ideas, quick thoughts. If something survives 2+ days, promote it to a GitHub issue.

Cross-day handoff: Active Issues refresh from GitHub (always current). Scratch Pad
items carry over from yesterday's next-up.md.

### Session Files — Workstream Logs

One per workstream/exploration. Named by descriptor only (date is in the folder).
Created by `/session-start` when you begin a specific piece of work.

## next-up.md Template

```markdown
# Next Up — YYYY-MM-DD

## Focus
<!-- What's on your mind today. Free text. -->

## Active Issues
<!-- Auto-populated by /session-start from GitHub -->
- [ ] #N title [labels]

## Sessions
<!-- Links to individual session files -->
- [descriptor](descriptor.md) — STATUS

## Scratch Pad
<!-- Temporary notes. If it survives 2+ days, promote to issue. -->
```

## Session File Template

```markdown
# Session: Short Description

**Status:** IN PROGRESS | COMPLETE
**Goal:** What we set out to do

## Accomplished
- What got done

## Issues Touched
- #N: title (opened | closed | progressed)

## Commits
- hash type: description

## Blockers / Notes
- Anything to remember

## Next Time
- [ ] What to pick up next
```

## Why This Structure?

- **Context is expensive.** Reloading takes tokens and time.
- **Handoff > memory.** Written notes beat hoping the LLM remembers.
- **next-up.md is your cockpit.** One glance tells you where you are.
- **Session files are workstream journals.** Dig in when you need detail.
- **GitHub Issues are truth.** next-up.md references them, never duplicates.
