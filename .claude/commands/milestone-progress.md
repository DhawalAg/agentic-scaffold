---
description: Deep dive on a specific milestone's progress
---

# Milestone Progress

$ARGUMENTS — Milestone title or number (e.g., "A1" or "1"). Blank = show all.

## Get Data

If argument provided:
```bash
gh issue list --milestone "$ARGUMENTS" --state all --json number,title,state,labels 2>/dev/null
```

If blank:
```bash
gh milestone list --json title,number,openIssues,closedIssues 2>/dev/null
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
