# Research: Battle-Tested Agentic Coding Workflows

Analysis of 6 repos with proven `.claude/`, skills, and command patterns.
Conducted 2026-04-25. Used to design this scaffold.

---

## Repos Analyzed

### 1. anthropics/claude-code
**What they have:** `.claude/commands/` with 3 commands
- `commit-push-pr.md` — Branch → commit → push → PR in one shot.
  Uses `allowed-tools` frontmatter to restrict scope.
- `triage-issue.md` — Automated label assignment with lifecycle labels
  (`needs-repro`, `needs-info`). Reads issue, reads comments, applies labels.
  NEVER posts comments — labels only.
- `dedupe.md` — Launches 5 parallel sub-agents with diverse search strategies
  to find duplicate issues. Filters false positives with a separate agent.

**Key pattern:** `allowed-tools` frontmatter scopes what a command can do.
Prevents accidental side effects.

**Extracted into scaffold:** Issue creation, label system design.

### 2. mitsuhiko/agent-stuff (Armin Ronacher)
**What they have:** 19 skills in `skills/`, minimal AGENTS.md
- `commit/SKILL.md` — Conventional commits. Smart about file selection:
  "if unclear, ask the user which files to commit." Checks recent log for
  common scopes.
- `github/SKILL.md` — Clean `gh` CLI patterns. Always `--repo owner/repo`.
  Uses `--json` + `--jq` for structured output.
- `librarian/SKILL.md` — 🔥 Caches remote repos in `~/.cache/checkouts/`.
  Partial clone (`--filter=blob:none`), throttled refresh (5min),
  fast-forward when clean. Genius for reference work.
- Also: tmux, uv, web-browser, mermaid, Google Workspace, OpenSCAD, Sentry

**Key pattern:** Skills are standalone markdown files with a shell helper script
when needed (`checkout.sh`). AGENTS.md is tiny — just release workflow.
Proves that less is more for project-level instructions.

**Extracted into scaffold:** Commit convention, gh CLI patterns.
**Future:** Librarian pattern for cross-project reference.

### 3. coleam00/link-in-bio-page-builder
**What they have:** 7 commands, 2 skills, `.agents/plans/`
- `prime.md` — 🔥 Loads full project context: `git ls-files`, `tree -L 3`,
  reads docs/schemas/configs, checks `git log -10`. Outputs structured
  overview (purpose, architecture, tech stack, principles, current state).
- `plan-feature.md` — Research-first planning that outputs to `.agents/plans/`.
  Multi-phase: context refs → codebase research → implementation plan → step-by-step
  tasks → testing strategy → validation commands → acceptance criteria.
  Every task has format: ACTION target_file with IMPLEMENT/PATTERN/IMPORTS/GOTCHA/VALIDATE.
- `execute.md` — Reads a plan from `.agents/plans/` and implements it step by step.
- `commit.md` — Smart commit with conventional format.
- `CLAUDE-template.md` — Reusable CLAUDE.md template.

**Key pattern:** Plan → Execute separation. Planning agent writes to `.agents/plans/`,
execution agent reads from it. Clean handoff.

**Extracted into scaffold:** CLAUDE.md template, session log concept (similar to plans).
**Future:** Plan-then-execute pipeline.

### 4. badlogic/claude-commands (Mario Zechner — libGDX creator)
**What they have:** 3 commands, deeply sophisticated
- `todo-worktree.md` — 🔥🔥 THE most thorough workflow found:
  - **Phases:** INIT → SELECT → REFINE → IMPLEMENT → COMMIT
  - **Git worktrees** for task isolation (parallel work possible)
  - **Orphan detection**: Checks PID liveness to find interrupted tasks
  - `todos/todos.md` → `todos/work/` → `todos/done/` lifecycle
  - Each task gets `task.md` (plan) + `analysis.md` (codebase research)
  - Status machine: Refining → InProgress → AwaitingCommit → Done
  - **STOP points**: Human approval at every phase boundary
  - Auto-generates `todos/project-description.md` on first run
  - Discovers unforeseen work during IMPLEMENT → proposes new checkboxes
  - Validation after implementation, user testing before commit
  - Updates project description if implementation changed structure
- `todo-branch.md` — Same workflow, no worktrees, single commit at end
- `publish.md` — npm publish: check git, build, bump version, tag, push, publish

**Key pattern:** The todo workflow is a state machine with human gates.
Every phase has clear entry/exit criteria. Unforeseen work is explicitly handled.
The "project description" concept is smart — auto-discovered context.

**Extracted into scaffold:** Todo command phases (simplified), STOP points,
issue-reference-in-commits convention.
**Future:** Worktree-based task isolation, orphan detection.

### 5. EveryInc/claude_commands (502⭐)
**What they have:** 7 files including agents/
- `04_create_github_issue.md` — Tiered detail: MINIMAL / MORE / A LOT.
  MINIMAL for quick tasks, A LOT for architectural changes with phased
  implementation plans, alternative approaches, risk analysis.
  Great formatting: collapsible `<details>`, emojis for scanning, code permalinks.
  AI-era notes: document which prompts worked, note AI-generated code.
- `03_analyze_github_issue.md` — Deep analysis of existing issues.
- `01_experiment_driven_development.md` — EDD: hypothesis → experiment → learn.
- `02_generate_codebase_context.md` — Context generation for onboarding.

**Key pattern:** Tiered detail levels based on complexity. Don't write a
comprehensive spec for a one-line fix.

**Extracted into scaffold:** Issue creation with appropriate detail level.

### 6. yzyydev/agentic-coding-structure (35⭐)
**What they have:** `.claude/` with CLAUDE.md + agents/ + commands/,
plus `ai_docs/` and `specs/`
- Separates AI-specific docs (`ai_docs/claude_thinking.md`) from specs.
- `.claude/agents/` for multi-agent setups.

**Key pattern:** Dedicated `ai_docs/` directory for LLM-specific guidance
(distinct from human docs).

---

## Pattern Rankings

### Tier 1 — Built into this scaffold
| Pattern | Source | Why |
|---------|--------|-----|
| Session lifecycle | Original + coleam00 | Context is expensive |
| Todo phases with STOP points | badlogic | Human gates prevent runaway agents |
| Conventional commits + issue refs | mitsuhiko, all | Links code to intent |
| Label system (type/priority/size) | anthropic, EveryInc | Just enough categorization |
| Project status dashboard | Original | Know where you stand in 5 seconds |

### Tier 2 — Next iteration
| Pattern | Source | Why wait |
|---------|--------|----------|
| `prime` context loader | coleam00 | Useful but project-specific |
| `plan-feature` → `.agents/plans/` | coleam00 | Needs a real feature to test |
| `allowed-tools` frontmatter | anthropic | Needs Claude Code support |
| Tiered issue detail | EveryInc | Currently overkill for solo dev |

### Tier 3 — Future
| Pattern | Source | Why wait |
|---------|--------|----------|
| Librarian (repo caching) | mitsuhiko | Cross-project concern |
| Git worktrees for isolation | badlogic | Advanced, learn branches first |
| Orphan task detection | badlogic | Needs worktrees |
| Issue dedup (parallel agents) | anthropic | Needs volume of issues |
| Issue triage automation | anthropic | Needs CI/GitHub Actions |

---

## Anti-Patterns Observed

1. **Over-documentation.** Some repos have more docs about how to code than
   actual code. The scaffold should be ~20% docs, 80% working commands.

2. **Framework-itis.** Templates with 15+ placeholder sections that nobody fills in.
   Our templates have 5-6 sections max.

3. **No STOP points.** Commands that run to completion without human checkpoints.
   badlogic got this right — every phase transition needs approval.

4. **Mixing concerns.** Project-specific commands (like `/stock`) in the same
   directory as project-management commands. Keep them separate.
