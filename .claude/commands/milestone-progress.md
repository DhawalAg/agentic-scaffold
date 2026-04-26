---
description: Deep dive on a specific milestone's progress
---

# Milestone Progress

$ARGUMENTS — Milestone title or number (e.g., "A1" or "1"). Blank = show all.

## Get Data

If argument provided, read from local `.issues/` (synced at `/session-start`):
```bash
# Search local issues by milestone
gh-issue-sync list --all --search "milestone:$ARGUMENTS" 2>/dev/null
```

Or parse front matter from `.issues/open/*.md` and `.issues/closed/*.md` where
`milestone:` matches the argument.

Fallback if gh-issue-sync is not installed:
```bash
gh issue list --milestone "$ARGUMENTS" --state all --json number,title,state,labels 2>/dev/null
```

If blank (show all milestones — gh-issue-sync doesn't cover milestone metadata):
```bash
gh api "repos/$REPO/milestones" --jq '.[] | {title, open: .open_issues, closed: .closed_issues}' 2>/dev/null
```

## Render

```
📋 MILESTONE A1: [Title]
═══════════════════════════════════════
Progress: ████████░░ 80%  (8/10)

✅ Completed:
  #1  description              [type:task  size:small]
  #2  description              [type:task  size:small]

⬜ Remaining:
  #12 description              [priority:high  size:medium]
  #15 description              [priority:medium size:large]

💡 Next: #12 (priority:high)
```
