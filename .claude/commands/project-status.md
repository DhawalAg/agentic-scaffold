---
description: Project health dashboard — milestones, issues, recent activity
---

# Project Status

Quick overview without leaving the terminal.

## Step 1: Detect Repo

```bash
REPO=$(gh repo view --json nameWithOwner --jq '.nameWithOwner' 2>/dev/null)
```

If `gh` is unavailable or unauthenticated, skip GitHub sections and show
git-only status (Step 3 only).

## Step 2: Milestones

NOTE: `gh milestone list` does not exist. Use the API:

```bash
gh api "repos/$REPO/milestones" --jq '.[] | {title, open: .open_issues, closed: .closed_issues, due: .due_on}' 2>/dev/null
```

For each milestone, calculate:
- total = open + closed
- pct = (closed / total * 100), or 0 if total is 0
- bar = render █ and ░ proportionally (10 chars wide)

## Step 3: Recent Commits

```bash
git log --oneline -10 --format="%h %s (%cr)"
```

## Step 4: Open Issues

Read from local `.issues/` directory (synced at `/session-start`):

```bash
gh-issue-sync list 2>/dev/null
```

Or parse `.issues/open/*.md` front matter directly for richer grouping.

Fallback if gh-issue-sync is not installed:
```bash
gh issue list --state open --json number,title,labels,milestone --jq '
  sort_by(.number) | .[] | {
    number,
    title,
    labels: [.labels[].name],
    milestone: (.milestone.title // "unassigned")
  }' 2>/dev/null
```

Group issues by milestone. Within each group, sort priority:high first.

## Step 5: Summary Counts

Count from local `.issues/` directory:
- **Open:** count files in `.issues/open/`
- **Closed:** count files in `.issues/closed/` (if synced with `--all`)
- **Bugs:** grep for `type:bug` in front matter of `.issues/open/*.md`

```bash
# Quick local counts
OPEN=$(ls .issues/open/*.md 2>/dev/null | wc -l | tr -d ' ')
CLOSED=$(ls .issues/closed/*.md 2>/dev/null | wc -l | tr -d ' ')
BUGS=$(grep -l 'type:bug' .issues/open/*.md 2>/dev/null | wc -l | tr -d ' ')
```

Fallback if `.issues/` doesn't exist:
```bash
gh issue list --state all --json state,labels --jq '{
  open: [.[] | select(.state == "OPEN")] | length,
  closed: [.[] | select(.state == "CLOSED")] | length,
  bugs: [.[] | select(.labels[].name == "type:bug")] | length
}' 2>/dev/null
```

## Step 6: Today's Context

Check for today's next-up.md:

```bash
TODAY=$(date +%Y-%m-%d)
NEXTUP="docs/project-management/sessions/$TODAY/next-up.md"
test -f "$NEXTUP" && echo "exists"
```

If it exists, read the **Focus** section (first few lines after `## Focus`).

## Step 7: Render

```
📊 PROJECT STATUS
═══════════════════════════════════════════════

📅 Today: YYYY-MM-DD
🎯 Focus: [from next-up.md Focus section, or "No focus set — run /session-start"]

━━━ Milestones ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  S1: Review & Finalize  ████████░░  80%  (8/10)
  S2: New Commands        ░░░░░░░░░░   0%  (0/3)
  S3: Hooks & Infra       ██░░░░░░░░  20%  (1/5)

━━━ Priority ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  🔥 #6  Finalize /todo workflow  [priority:high, size:large]  (S1)
  🔥 #4  Finalize /session-start  [priority:high, size:medium] (S1)
     #9  Finalize /milestone-progress  [priority:medium]       (S1)

  🔥 #10 Implement /work command  [priority:high]  (S2)
  🔥 #11 Implement /ship command  [priority:high]  (S2)
     #12 Implement /reflect       [priority:medium] (S2)

━━━ Totals ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  📋 Open: N  |  ✅ Closed: N  |  🐛 Bugs: N

━━━ Recent ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  3137a1c docs: update next-up.md (3 min ago)
  02711f9 feat: daily session folders (3 min ago)
  f42fdff docs: add workflow-skeleton (28 min ago)

💡 Suggested next: #N — [title] (priority:high, size:small)
```

## Suggestion Logic

Pick the next task by this priority:
1. priority:high + size:small in the earliest milestone (quick win)
2. priority:high in the earliest milestone
3. Any open issue in the earliest milestone

## Empty State

If no milestones or issues exist:

```
📊 PROJECT STATUS
═══════════════════════════════════════════════

No milestones or issues yet.

Get started:
  1. bash scripts/setup-github-labels.sh
  2. /create-issue to add your first task
  3. Create milestones via GitHub or gh CLI
```
