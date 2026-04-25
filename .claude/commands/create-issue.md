---
description: Create a GitHub Issue with labels and milestone
---

# Create Issue

$ARGUMENTS — Free-form description of the task, bug, or idea.

## Step 1: Parse Intent

From the description, infer:
- **Type:** task (default) | bug | idea | chore
- **Priority:** high | medium (default) | low
- **Size:** small (<1hr) | medium (1-4hr, default) | large (4hr+)
- **Milestone:** infer from context or ask

## Step 2: Draft

Write a concise title and body. Body includes:
- What needs to happen (acceptance criteria as checkboxes)
- Relevant file paths or references
- Context the implementer needs

Keep it lean. A clear minimal issue > a confusing comprehensive one.

## Step 3: Confirm

```
📝 New Issue:
  Title: [concise title]
  Type: task | Priority: high | Size: medium
  Milestone: [name]

  Body:
  [description with checkboxes]

Create? (y/n)
```

## Step 4: Create

```bash
gh issue create \
  --title "<title>" \
  --body "<body>" \
  --label "type:<type>,priority:<priority>,size:<size>" \
  --milestone "<milestone>"
```

Print: "✅ Created #N: title"

## Labels

| Label | Meaning |
|-------|---------|
| `type:task` | Feature or planned work |
| `type:bug` | Something broken |
| `type:idea` | Future consideration |
| `type:chore` | Maintenance, refactor, docs |
| `priority:high` | Do this first |
| `priority:medium` | Normal |
| `priority:low` | Nice to have |
| `size:small` | < 1 hour |
| `size:medium` | 1-4 hours |
| `size:large` | 4+ hours |
