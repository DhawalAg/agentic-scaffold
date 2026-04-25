# Review: coleam00/link-in-bio-page-builder

**Status:** 🔍 PENDING
**Links:**
- [`/prime` command](https://github.com/coleam00/link-in-bio-page-builder/blob/main/.claude/commands/prime.md)
- [`/plan-feature` command](https://github.com/coleam00/link-in-bio-page-builder/blob/main/.claude/commands/plan-feature.md)
- [Full repo](https://github.com/coleam00/link-in-bio-page-builder)
**Stars:** 7 commands, 2 skills, `.agents/plans/` directory

---

## What They Have

### `/prime` — Load full project context
- Runs `git ls-files`, `tree -L 3`, reads docs/schemas/configs, `git log -10`
- Outputs structured report: purpose, architecture, tech stack, principles, current state
- Think of it as `/session-start` Step 2 but way more thorough

### `/plan-feature` — Research-first planning
- Multi-phase: context refs → codebase research → implementation plan → tasks → testing → validation
- Output goes to `.agents/plans/` directory (not inline)
- Every task has: ACTION target_file + IMPLEMENT/PATTERN/IMPORTS/GOTCHA/VALIDATE
- Key principle: "We do NOT write code in this phase"

### `/execute` — Reads plan and implements step by step
- Clean separation: planning agent writes, execution agent reads
- This is the handoff mechanism

### Other commands
- `/commit` — Smart conventional commits
- `/create-prd` — PRD generation
- `/create-rules` — Rule file generation
- `/init-project` — Project bootstrapping

---

## What We Could Steal

1. **Merge `/prime` into `/session-start`** — richer context loading
2. **`/plan-feature` → `.agents/plans/`** — plan/execute separation
3. **Plan file format** — ACTION + IMPLEMENT + GOTCHA + VALIDATE per task

---

## Dhawal's Notes

<!-- Drop your notes here after reviewing the links above -->

**Overall verdict:** 🔍 PENDING
<!-- Change to: ✅ ADOPT | 🔀 ADAPT | ⏸️ DEFER | ❌ REJECT -->

**What to take:**
-

**What to skip:**
-

**How to adapt for our scaffold:**
-
