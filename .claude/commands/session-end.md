---
description: End a coding session — log progress, update daily hub, handoff
---

# Session End

Save progress and write handoff notes.

## Step 1: Gather Data

```bash
git log --oneline --since="6 hours ago" 2>/dev/null || git log --oneline -5
git diff --stat HEAD 2>/dev/null
```

Check for issues closed today (local-first):
```bash
# Check local closed issues
ls .issues/closed/ 2>/dev/null | head -20
gh-issue-sync status 2>/dev/null
```

Fallback if gh-issue-sync is not installed:
```bash
gh issue list --state closed --json number,title,closedAt --jq '.[] | select(.closedAt > "'"$(date -u +%Y-%m-%dT00:00:00Z)"'")' 2>/dev/null || true
```

## Step 2: Quick Prompts (3 max)

1. **What did you accomplish?** (auto-suggest from commits)
2. **Any blockers?**
3. **What should you do next time?**

## Step 3: Update Session File

Find the current session file in `docs/project-management/sessions/YYYY-MM-DD/`.
(The most recently created file that isn't `next-up.md`.)

Update it:
- **Status:** → COMPLETE
- **Accomplished:** from commits + user input
- **Issues Touched:** from gh issue activity
- **Commits:** from git log
- **Blockers / Notes:** from user input
- **Next Time:** from user input

## Step 4: Append to next-up.md

Append a summary block to today's `next-up.md`. Never rewrite existing content.

```markdown

---
### Session Wrap: <descriptor> (HH:MM)
- **Done:** [1-2 line summary]
- **Issues:** #N closed, #M progressed
- **Next:** [first "next time" item]
```

Update the Sessions section link status:
```
- [descriptor](descriptor.md) — COMPLETE
```

## Step 5: Commit Check

```bash
git status
```

If uncommitted changes: "Commit remaining changes before ending?"

Commit session files:
```bash
git add docs/project-management/sessions/
git commit -m "docs: session log — <descriptor>"
```

## Step 5.5: Sync Issues to GitHub

Batch-push all local changes (new issues, closes, edits) back to GitHub:

```bash
gh-issue-sync push 2>/dev/null
```

Print sync results. If gh-issue-sync is not installed, skip this step
(issues were already managed via `gh` CLI directly).

## Step 6: Sign Off

```
🔴 SESSION ENDED
━━━━━━━━━━━━━━━━━━━━━━━━━
Session: <descriptor>
Log: docs/project-management/sessions/YYYY-MM-DD/<descriptor>.md
Hub: docs/project-management/sessions/YYYY-MM-DD/next-up.md
Next: [first "next time" item]
```
