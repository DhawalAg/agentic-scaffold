---
description: Project health dashboard — milestones, issues, recent activity
---

# Project Status

Quick overview without leaving the terminal.

## Step 1: Milestones

```bash
gh milestone list --json title,number,openIssues,closedIssues,dueOn 2>/dev/null
```

Calculate % complete for each.

## Step 2: Recent Activity

```bash
git log --oneline -10 --format="%h %s (%cr)"
```

## Step 3: Open Issues

```bash
gh issue list --state open --json number,title,labels,milestone --limit 20 2>/dev/null
```

Group by milestone.

## Step 4: Render

```
📊 PROJECT STATUS
═══════════════════════════════════════

Milestones:
  A1: Foundation        ████████░░ 80%  (8/10)
  A2: Next Phase        ░░░░░░░░░░  0%  (0/6)

🔥 Priority:
  #12 [description]     [priority:high  size:medium]
  #15 [description]     [priority:high  size:large]

📋 Open: N  |  ✅ Closed: N  |  🐛 Bugs: N

📝 Recent (7d):
  hash feat: description (Nd ago)

💡 Suggestion: Start with #N (priority:high)
```

If no milestones/issues exist:
"No issues yet. Use `/create-issue` to add tasks,
or run `scripts/setup-github-labels.sh` to set up labels first."
