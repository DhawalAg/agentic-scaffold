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

Create the issue locally with gh-issue-sync (stays local until next `gh-issue-sync push`):

```bash
gh-issue-sync new "<title>" \
  --label "type:<type>" --label "priority:<priority>" --label "size:<size>"
```

Then edit the created file (in `.issues/open/T*-<slug>.md`) to:
- Add the body content below the front matter
- Set `milestone: <milestone>` in the front matter

Print: "✅ Created local issue: <filename>"
Print: "💡 This issue is local-only. It will be pushed to GitHub at `/session-end` or via `gh-issue-sync push`."

Fallback if gh-issue-sync is not installed:
```bash
gh issue create \
  --title "<title>" \
  --body "<body>" \
  --label "type:<type>,priority:<priority>,size:<size>" \
  --milestone "<milestone>"
```

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
