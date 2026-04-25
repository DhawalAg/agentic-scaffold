---
description: End a coding session — log progress, create handoff notes
---

# Session End

Save progress and write a handoff note for next time.

## Step 1: Gather Data

```bash
git log --oneline --since="6 hours ago" 2>/dev/null || git log --oneline -5
git diff --stat HEAD 2>/dev/null
gh issue list --state closed --json number,title,closedAt --jq '.[] | select(.closedAt > "'"$(date -u +%Y-%m-%dT00:00:00Z)"'")' 2>/dev/null || true
```

## Step 2: Quick Prompts (3 max)

1. **What did you accomplish?** (auto-suggest from commits)
2. **Any blockers?**
3. **What should you do next time?**

## Step 3: Write Session Log

Create `docs/project-management/sessions/YYYY-MM-DD-descriptor.md`:

```markdown
# Session: YYYY-MM-DD — [Descriptor]

**Status:** COMPLETE
**Goal:** [inferred from work]

## Accomplished
- [from commits + user input]

## Issues Touched
- #N: title (opened | closed | progressed)

## Commits
- hash type: description

## Blockers / Notes
- [user input or "None"]

## Next Time
- [ ] [user input]
```

## Step 4: Commit Check

```bash
git status
```

If uncommitted changes: "Commit remaining changes before ending?"

Commit the session log itself:
```bash
git add docs/project-management/sessions/
git commit -m "docs: session log for YYYY-MM-DD"
```

## Step 5: Sign Off

```
🔴 SESSION ENDED
Log: docs/project-management/sessions/YYYY-MM-DD-descriptor.md
Next: [first "next time" item]
```
