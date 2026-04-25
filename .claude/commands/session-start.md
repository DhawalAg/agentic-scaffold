---
description: Begin a coding session — load context, pick a task, start working
---

# Session Start

Resume context and pick the next task.

## Step 1: Load Last Session

Find the most recent file in `docs/project-management/sessions/` (ignore README).
If found, summarize:
- What was done last time
- Any "next time" notes or blockers

If no session logs exist: "First session! Let's orient."

## Step 2: Current State

```bash
git status
git log --oneline -5
gh issue list --state open --limit 10 --json number,title,labels,milestone 2>/dev/null || echo "No issues yet — use /create-issue to add some"
```

## Step 3: Suggest Next Task

Priority order:
1. "Next time" items from last session log
2. Open issues labeled `priority:high`
3. Uncommitted work on current branch

Present a short menu:

```
🟢 SESSION START
════════════════════════

📝 Last session: [summary or "first session"]

🔥 Suggested:
  1. [Continue] #N: description (in progress)
  2. [Next up]  #N: description (priority:high)
  3. [Quick win] #N: description (size:small)

What would you like to work on?
```

## Step 4: Begin

On task selection, create a branch:

```bash
git checkout -b <issue-number>-short-description
```

Print: "🟢 Working on #N: title"

If the chosen work isn't tracked, offer: "Create an issue for this first?"
