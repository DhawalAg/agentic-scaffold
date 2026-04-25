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
**What they have:** 19 skills + 16 TypeScript extensions for [Pi Coding Agent](https://buildwithpi.ai/)

**Skills (markdown-based, agent-agnostic):**
- `commit/SKILL.md` — Conventional commits. Smart about file selection:
  "if unclear, ask the user which files to commit." Checks recent log for
  common scopes.
- `github/SKILL.md` — Clean `gh` CLI patterns. Always `--repo owner/repo`.
  Uses `--json` + `--jq` for structured output.
- `librarian/SKILL.md` — 🔥 Caches remote repos in `~/.cache/checkouts/`.
  Partial clone (`--filter=blob:none`), throttled refresh (5min),
  fast-forward when clean. Genius for reference work.
- Also: tmux, uv, web-browser, mermaid, Google Workspace, Sentry, OpenSCAD,
  apple-mail, native-web-search, summarize (via `uvx markitdown`)

**Extensions (TypeScript, Pi-specific — the REAL gold):**

Pi Coding Agent (`@mariozechner/pi-coding-agent`) has a programmatic extension
API with hooks: `before_agent_start`, `tool_call`, `tool_result`, `agent_end`,
`session_start`, `session_switch`, `session_before_compact`. Extensions can:
- Register commands (`pi.registerCommand()`)
- Register tools the LLM can call (`pi.registerTool()`)
- Block tool calls with a reason
- Inject messages into conversation (`pi.sendMessage()`)
- Render custom TUI components (`ctx.ui.custom()`)
- Branch/fork sessions (`ctx.navigateTree()`)
- Persist state across turns (`pi.appendEntry()`)

Key extensions:

- **`loop.ts`** — 🔥🔥 Autonomous coding loop with breakout conditions.
  Three modes: `tests` (keep going until tests pass), `self` (agent decides
  when done), `custom` (user-defined breakout). Registers a `signal_loop_success`
  tool the LLM can call to break out. Persists state across sessions.
  Handles context compaction. Detects aborted turns and asks to break.

- **`review.ts`** — 🔥🔥 Code review in a session branch:
  - Branches conversation to do isolated review
  - Structured handoff with P0-P3 priority findings
  - Three end modes: return only, return+summarize, return+fix
  - Review summary prompt is incredibly thorough:
    - Scope, Verdict, Findings (with file:line), Fix Queue, Constraints
    - Non-blocking human callouts: "adds DB migration", "new dependency",
      "changes auth/permissions", "backwards-incompatible", "irreversible ops"
  - Auto-generates fix queue and can auto-apply fixes in priority order

- **`todos.ts`** — Full TUI todo manager with file-backed storage.
  Actions: refine, work, view, copy path/text, release, delete, close, reopen.
  Uses overlays and interactive selection. Can trigger agent to "work on"
  or "refine" a todo by injecting it as the next prompt.

- **`context.ts`** — Shows loaded context: AGENTS.md files, extensions,
  skills (highlighted green if actually loaded this session), token usage
  bar (system|tools|convo|remaining), session cost. Tracks skill loading
  by watching `read` tool calls — if a file inside a skill dir is read,
  that skill is marked as "loaded".

- **`session-breakdown.ts`** — 7/30/90-day usage analytics TUI.
  Shows sessions/messages/tokens by model, by directory, by day-of-week,
  by time-of-day. Unicode bar charts. Tabbed views with keyboard navigation.

- **`split-fork.ts`** — Fork current session into a new terminal split
  (Ghostty-specific via AppleScript). Forked session carries full conversation
  history. Enables parallel work on related tasks.

- **`go-to-bed.ts`** — 😂 After midnight (00:00-05:59), blocks tool execution
  and tells you to go to sleep. Agent pushes back with "caring firmness".
  User must explicitly confirm via `echo confirm-that-we-continue-after-midnight`.
  Confirmation lasts for the night only.

- **`multi-edit.ts`** — Replaces built-in edit with batch edits + Codex-style
  patch support. Includes preflight validation.

- **`notify.ts`** — Desktop notifications when agent finishes.

- **`prompt-editor.ts`** — Mode selector: switch between model/thinking configs.
  Persists selection. History support.

**Architecture insights:**
- **Event-driven hooks** — Pre/post agent start, tool call/result interception
- **Tool blocking** — Extensions can block any tool call with a reason string
- **Session branching** — Navigate tree, do isolated work, return with summary
- **Distributions** — `mitsupi-common` (default set) and `mitsupi-loaded` (extras)
  Published on npm for Pi's package loader.
- **Intercepted commands** — Wraps python/pip/poetry for safety/customization

**Key pattern:** Skills are agent-agnostic markdown. Extensions are Pi-specific
TypeScript. The split is intentional — skills port anywhere, extensions need
the framework.

**Extracted into scaffold:** Commit convention, gh CLI patterns, skill architecture.
**Future:** Loop concept (simplified), review workflow, context visibility,
librarian for cross-project reference.

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
| Loop (run until tests pass) | mitsuhiko | Powerful but needs guardrails |
| Review branch workflow | mitsuhiko | Needs session branching support |
| Context visibility command | mitsuhiko | Shows token budget + loaded skills |

### Tier 3 — Future
| Pattern | Source | Why wait |
|---------|--------|----------|
| Librarian (repo caching) | mitsuhiko | Cross-project concern |
| Git worktrees for isolation | badlogic | Advanced, learn branches first |
| Orphan task detection | badlogic | Needs worktrees |
| Issue dedup (parallel agents) | anthropic | Needs volume of issues |
| Issue triage automation | anthropic | Needs CI/GitHub Actions |
| Session forking (parallel) | mitsuhiko | Needs Pi or equivalent runtime |
| Usage analytics dashboard | mitsuhiko | Needs session data format |
| Tool call blocking (safety) | mitsuhiko | Needs extension API support |
| Go-to-bed guard | mitsuhiko | Fun, needs extension hooks |

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
