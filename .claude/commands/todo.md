---
description: Structured todo workflow — select task, implement, commit
---

# Todo

Turn issues into shipped code. Phases run in order.
Get user confirmation at each ⏸️ STOP.

## INIT

1. Read project context (CLAUDE.md, roadmap if exists)
2. Check for in-progress work:

```bash
git branch --list | head -20
git status
```

3. If on a feature branch with uncommitted work:
   - "You have WIP on `<branch>`. Continue here, or pick something new?"

4. Show open issues:

```bash
gh-issue-sync list 2>/dev/null
```

Fallback if gh-issue-sync is not installed:
```bash
gh issue list --state open --json number,title,labels,milestone --limit 15 2>/dev/null
```

If no issues: "No issues found. Use `/create-issue` to add tasks first."

## SELECT

1. Present numbered list grouped by milestone
2. ⏸️ STOP → "Which issue? (number)"
3. Read the full issue from local files:

```bash
# Read from .issues/open/<number>-*.md
cat .issues/open/<number>-*.md 2>/dev/null
```

Fallback if file not found:
```bash
gh issue view <number>
```

4. Branch off:

```bash
git checkout -b <number>-short-description
```

## IMPLEMENT

1. Break the issue into implementation steps (checkboxes)
2. ⏸️ STOP → "Plan looks good?"
3. For each step:
   - Make changes
   - Commit with issue ref:
     ```bash
     git add -A
     git commit -m "feat: <change> (#<number>)"
     ```
4. If unexpected work surfaces:
   - ⏸️ STOP → "Extra work needed: <desc>. Add to plan?"
5. Run validation (lint, test, build — whatever the project has)

## COMMIT

1. Summarize what was done
2. ⏸️ STOP → "Ready to finalize?"
   - Show commits on this branch
   - Ask if issue should be closed

3. Close if done:
   ```bash
   gh-issue-sync close <number>
   ```
   The close is staged locally and pushed at `/session-end`.

   Fallback if gh-issue-sync is not installed:
   ```bash
   gh issue close <number> --comment "Completed in branch <branch>"
   ```

4. Wrap up:
   ```
   ✅ DONE
   Issue: #N title → CLOSED
   Branch: <branch>
   Commits: <count>
   ```

5. "Merge to main?"
   ```bash
   git checkout main
   git merge <branch> --no-ff -m "feat: title (closes #<number>)"
   git branch -d <branch>
   ```

## Rules

- One logical change per commit
- Reference issues: `#N` in messages, `closes #N` to auto-close
- Commit after each step, not in one big batch
- ⏸️ STOP = ask the human. Don't skip these.
