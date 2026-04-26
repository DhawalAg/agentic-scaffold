---
description: Begin a coding session — create daily hub, load context, pick a task
---

# Session Start

Set up today's workspace and resume context.

## Step 1: Set Up Today's Folder

Create today's date folder if it doesn't exist:

```bash
mkdir -p docs/project-management/sessions/$(date +%Y-%m-%d)
```

## Step 2: Create or Read next-up.md

Check if `docs/project-management/sessions/YYYY-MM-DD/next-up.md` exists.

**If it does NOT exist (first session of the day):**

1. Check if yesterday's next-up.md exists. If so, read its **Scratch Pad** section
   to carry over unfinished items.

2. Sync and fetch active issues (local-first):
   ```bash
   # Sync once at session start — this is the single network call
   gh-issue-sync pull 2>/dev/null
   # Read from local .issues/ directory
   gh-issue-sync list 2>/dev/null
   ```
   Fallback if gh-issue-sync is not installed:
   ```bash
   gh issue list --state open --limit 15 --json number,title,labels,milestone 2>/dev/null
   ```

3. Create `next-up.md` with this structure:

   ```markdown
   # Next Up — YYYY-MM-DD

   ## Focus
   <!-- What's on your mind today? -->

   ## Active Issues
   <!-- From GitHub — refreshed each /session-start -->
   - [ ] #N title [labels] (milestone)
   ...

   ## Sessions
   <!-- Links to workstream sessions today -->

   ## Scratch Pad
   <!-- Temporary notes. Promote to issue if it survives 2+ days. -->
   [carry over yesterday's scratch pad items if any]
   ```

**If it DOES exist (returning same day):**

1. Read it for context — summarize Focus + Scratch Pad
2. Do NOT rewrite it. Only append to it in later steps.

## Step 3: Load Last Session

Find the most recent session file (across all day folders, not next-up.md).
If found, summarize:
- What was done last time
- Any "next time" notes or blockers

If no session files exist: "First session! Let's orient."

## Step 4: Current State

```bash
git status --short
git log --oneline -5
```

## Step 5: Suggest Next Task

Priority order:
1. "Next time" items from last session file
2. Open issues labeled `priority:high`
3. Uncommitted work on current branch

Present a short menu:

```
🟢 SESSION START — YYYY-MM-DD
════════════════════════════════════════

📝 Last session: [summary or "first session"]

🔥 Suggested:
  1. [Continue] #N: description (in progress)
  2. [Next up]  #N: description (priority:high)
  3. [Quick win] #N: description (size:small)

What would you like to work on?
```

## Step 6: Begin Workstream

On task selection:

1. Ask for a short descriptor (e.g. "refactor-auth", "spike-caching")

2. Create the session file:
   ```
   docs/project-management/sessions/YYYY-MM-DD/<descriptor>.md
   ```

   With header:
   ```markdown
   # Session: <Descriptor (title case)>

   **Status:** IN PROGRESS
   **Goal:** <inferred from selected task>

   ## Accomplished
   -

   ## Issues Touched
   -

   ## Commits
   -

   ## Blockers / Notes
   -

   ## Next Time
   - [ ]
   ```

3. Append a link to next-up.md's Sessions section:
   ```markdown
   - [descriptor](descriptor.md) — IN PROGRESS
   ```

4. Create a branch if working on a tracked issue:
   ```bash
   git checkout -b <issue-number>-<descriptor>
   ```

5. Print: "🟢 Working on: <descriptor>"

If the chosen work isn't tracked, offer: "Create an issue for this first?"
