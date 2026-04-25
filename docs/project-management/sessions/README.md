# Session Logs

One file per coding session. Format: `YYYY-MM-DD-descriptor.md`.

Async handoff notes between sessions. `/session-start` reads the latest.

## Format

```markdown
# Session: YYYY-MM-DD — Short Description

**Status:** COMPLETE | IN PROGRESS
**Goal:** What we set out to do

## Accomplished
- What got done

## Issues Touched
- #N: title (opened | closed | progressed)

## Commits
- hash type: description

## Blockers / Notes
- Anything to remember

## Next Time
- [ ] What to pick up next
```

## Why Session Logs?

- **Context is expensive.** Reloading takes tokens and time.
- **Handoff > memory.** Written notes beat hoping the LLM remembers.
- **Progress is visible.** Session logs are a commit-by-commit journal.

---

## Session 001 — 2025-04-25 — Bootstrap

**Status:** COMPLETE
**Goal:** Create the agentic-scaffold project from research.

### Accomplished
- Researched 6 repos (anthropic, badlogic, mitsuhiko, coleam00, EveryInc, yzyydev)
- Deep dive into mitsuhiko/agent-stuff Pi extensions (16 TypeScript extensions)
  - Pi Coding Agent = full programmatic framework (not just markdown commands)
  - Key patterns: loop (run-until-pass), review (branch→review→fix),
    context visibility, session forking, go-to-bed guard, TUI todos
- Created 6 slash commands, templates, label setup, init script
- Committed initial scaffold (15 files, 917 lines)

### Key Decision
Skills (markdown) are portable across agents. Extensions (TypeScript) are
framework-specific. Our scaffold uses markdown commands (Claude Code / Code Puppy
compatible) but documents the programmatic patterns for future growth.

### Next Time
- [ ] Apply scaffold to second-brain or finance-hub as first real test
- [ ] Try the loop concept as a simplified slash command
- [ ] Build review summary prompt into a /review command
