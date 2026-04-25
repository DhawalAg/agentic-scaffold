# Workflow Skeleton — Second Brain Project Infrastructure

> Session doc for building out project management infra, git workflows, and custom commands.
> Living document — update as decisions are made, feedback incorporated, direction changes.

**Created:** 2026-04-25
**Status:** Draft — awaiting review
**Context:** Career strategy build-in-public project. Solo PM-turned-builder. Need minimal but effective workflows, not over-engineered frameworks.

---

## Table of Contents

1. [Philosophy](#1-philosophy)
2. [Research Findings](#2-research-findings)
3. [Infrastructure Skeleton](#3-infrastructure-skeleton)
4. [Custom Commands](#4-custom-commands)
5. [CLAUDE.md / AGENTS.md Redesign](#5-claudemd--agentsmd-redesign)
6. [Implementation Plan](#6-implementation-plan)
7. [Decision Log](#7-decision-log)
8. [Open Questions](#8-open-questions)

---

## 1. Philosophy

### What we're NOT doing
- Not buying a Ferrari before learning stick (no superpowers/, no compound-engineering/ for now)
- Not adopting frameworks we don't understand inside-out
- Not adding process for process's sake
- Not creating 50 labels, elaborate templates, Kanban boards

### What we ARE doing
- Building knowledge from the inside out — understand each layer before adding the next
- GitHub Issues + Milestones as the single source of truth (the "sweet spot" for solo devs)
- Custom commands we actually use daily, not a showcase
- Commit discipline that creates traceability without friction
- Session rituals that solve the #1 solo dev problem: "what was I doing?"

### The litmus test
Before adding ANY workflow artifact, ask:
1. Will I use this every session? → Add it
2. Will I use this weekly? → Maybe add it
3. Will I use this "someday"? → Don't add it

---

## 2. Research Findings

### Battle-Tested Repos Surveyed

| Repo | Builder | Key Insight |
|------|---------|-------------|
| [antirez/iris.c](https://github.com/antirez) | Salvatore Sanfilippo | Spec-first, code-second. `IMPLEMENTATION_NOTES.md` as persistent memory between sessions. Zero code written by human. |
| [automazeio/ccpm](https://github.com/automazeio/ccpm) | Automaze | 5-phase PM workflow: Plan → Structure → Sync → Execute → Track. PRDs decompose into GitHub issues. |
| [alirezarezvani/claude-code-github-workflow](https://github.com/alirezarezvani/claude-code-github-workflow) | Alireza Rezvani | `/plan-to-issues` converts plans into GitHub issues. Full lifecycle automation. |
| [bradfeld gist](https://gist.github.com/bradfeld/1deb0c385d12289947ff83f145b7e4d2) | Brad Feld | 12 repos, 68 commands, circuit breaker blocking commits until user verifies. `/start TICKET` → implement → `/commit` → auto-update. |
| [forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills) | Forrest Chang / Karpathy | 4 principles: Think before coding, simplicity first, surgical changes, goal-driven. 65% → 94% accuracy. |
| [TheRealSeanDonahoe/agents-md](https://github.com/TheRealSeanDonahoe/agents-md) | Sean Donahoe | ~200-line universal AGENTS.md. "Project Learnings" section that self-corrects over time. |
| [EveryInc/claude_commands](https://github.com/EveryInc/claude_commands) | Every Inc | 6 commands. "Create GitHub Issue" with 3 detail levels. Research → Plan → Execute → Review. |
| [mitsuhiko/agent-stuff](https://github.com/mitsuhiko/agent-stuff) | Armin Ronacher | *(research pending — agent still running)* |
| [coleam00/link-in-bio-page-builder](https://github.com/coleam00/link-in-bio-page-builder) | Cole Medin | *(research pending — agent still running)* |

### Cross-Cutting Patterns (What Actually Works)

1. **Spec-first, code-second.** Every mature setup converges on: write the plan, then hand to agent.
2. **CLAUDE.md < 200 lines.** Beyond that, instruction adherence drops measurably.
3. **Self-correcting learnings.** Start empty, add one line per mistake. The file improves itself.
4. **GitHub Issues as single source of truth.** No external PM tools for solo devs.
5. **Circuit breakers.** Block agent from shipping untested work.
6. **Research → Plan → Execute → Review → Ship.** Every good command follows this arc.
7. **WIP commits > stashes.** Visible in `git log`, squash-merged away. Context recovery is instant.

### Minimal Git Workflow for Solo Dev

```
Labels:       feat, fix, chore, blocked, spike, p-high, p-low (7 total)
Milestones:   1 per project phase (A1, A2, A3, A4, A5, then B-phases)
Branch:       <type>/<issue-number>-<short-desc>  (e.g. feat/12-brave-caching)
Commits:      feat(scope): description\n\nCloses #N
PR strategy:  Always use PRs. Squash-merge. Auto-delete branch.
Issue template: What / Why / Acceptance criteria (one template, not ten)
```

---

## 3. Infrastructure Skeleton

### 3a. GitHub Labels

```bash
# Run once to set up labels
gh label create feat --color 0E8A16 --description "New feature"
gh label create fix --color D93F0B --description "Bug fix"
gh label create chore --color E4E669 --description "Maintenance / refactor"
gh label create blocked --color B60205 --description "Cannot proceed"
gh label create spike --color D4C5F9 --description "Research / exploration"
gh label create p-high --color FF6600 --description "Must do this milestone"
gh label create p-low --color C2E0C6 --description "Nice to have"
```

### 3b. GitHub Milestones

Map directly to existing A-chunks from 04-mvp-scope.md:

```bash
gh api repos/DhawalAg/second-brain/milestones --method POST \
  -f title="A1 — Single-source search" \
  -f description="CLI scaffold + Brave Search API. brain search <query> returns results." \
  -f due_on="2026-05-10T00:00:00Z"

gh api repos/DhawalAg/second-brain/milestones --method POST \
  -f title="A2 — Multi-source fan-out" \
  -f description="GitHub + Twitter/X sources. Query decomposition via OpenRouter." \
  -f due_on="2026-05-24T00:00:00Z"

gh api repos/DhawalAg/second-brain/milestones --method POST \
  -f title="A3 — LLM scoring columns" \
  -f description="Relevance, recency, depth columns scored by LLM with rubric prompts." \
  -f due_on="2026-06-07T00:00:00Z"

gh api repos/DhawalAg/second-brain/milestones --method POST \
  -f title="A4 — Vault cross-reference" \
  -f description="Novelty column: NEW / IN VAULT / PARTIAL. BM25 over local vault." \
  -f due_on="2026-06-21T00:00:00Z"

gh api repos/DhawalAg/second-brain/milestones --method POST \
  -f title="A5 — Interactive REPL" \
  -f description="Session mode: compare, skim, queue, refine commands." \
  -f due_on="2026-07-05T00:00:00Z"
```

### 3c. A1 Issues (Ready to Create)

These are the immediate work items for milestone A1:

```bash
# Core scaffold
gh issue create --title "Set up Commander.js CLI with brain search <query>" \
  --label feat --milestone "A1 — Single-source search" \
  --body "## What\nCLI entry point that accepts a search query and dispatches to search handler.\n\n## Why\nFoundation for all future commands.\n\n## Acceptance criteria\n- [ ] \`bun run brain search \"test\"\` executes without error\n- [ ] Commander.js parses query argument\n- [ ] Help text displays with \`--help\`"

# Brave integration
gh issue create --title "Implement Brave Search API client" \
  --label feat --milestone "A1 — Single-source search" \
  --body "## What\nBrave Search API integration implementing SearchSource interface.\n\n## Why\nFirst external data source. Proves the source abstraction.\n\n## Acceptance criteria\n- [ ] BraveSource implements SearchSource interface\n- [ ] Returns typed SearchResult[]\n- [ ] Handles API errors gracefully\n- [ ] Rate limiting respected"

# Results display
gh issue create --title "Format search results as terminal table" \
  --label feat --milestone "A1 — Single-source search" \
  --body "## What\nRanked results table in terminal using chalk.\n\n## Why\nUsable output from day one.\n\n## Acceptance criteria\n- [ ] Results display as formatted table\n- [ ] Title, URL, snippet visible\n- [ ] Spinner shows during search (ora)"

# Provider abstraction
gh issue create --title "Create SearchSource interface and types" \
  --label feat --milestone "A1 — Single-source search" \
  --body "## What\nSearchSource interface + SearchResult type in src/sources/types.ts.\n\n## Why\nAbstraction for A2 multi-source. Design it right once.\n\n## Acceptance criteria\n- [ ] Interface defined with name + search()\n- [ ] SearchResult type covers title, url, snippet, score"

# Error handling
gh issue create --title "Env validation and error handling for missing API key" \
  --label fix --milestone "A1 — Single-source search" \
  --body "## What\nGraceful error when BRAVE_API_KEY is missing or invalid.\n\n## Why\nFirst-run experience. Don't let users hit cryptic API errors.\n\n## Acceptance criteria\n- [ ] Missing key → clear error message with setup instructions\n- [ ] Invalid key → meaningful error (not raw 401)"

# Tests
gh issue create --title "Add tests for Brave search client" \
  --label chore --milestone "A1 — Single-source search" \
  --body "## What\nUnit tests for BraveSource.\n\n## Why\nEval-first principle from roadmap.\n\n## Acceptance criteria\n- [ ] Tests pass with \`bun test\`\n- [ ] Mock API responses (don't hit real API in tests)\n- [ ] Test error cases (missing key, API failure, empty results)"
```

### 3d. Issue Template

`.github/ISSUE_TEMPLATE/task.md`:

```markdown
---
name: Task
about: A unit of work
labels: ''
---

## What
<!-- One sentence: what needs to happen -->

## Why
<!-- One sentence: why this matters -->

## Acceptance criteria
- [ ] ...

## Notes
<!-- Context, links, constraints. Delete if empty. -->
```

### 3e. Hierarchy Mapping

```
Obsidian Design Docs          →  GitHub Infrastructure
─────────────────────         →  ──────────────────────
01-vision.md                  →  Repo description + README
05-roadmap.md (Phase S)       →  Milestones (A1-A5)
04-mvp-scope.md (chunks)      →  Issues per milestone
Individual tasks              →  Issues with acceptance criteria
Code                          →  Commits referencing issues (Closes #N)
```

---

## 4. Custom Commands

### Philosophy
- Commands we'll use every session go in `~/.wibey/commands/` (global)
- Commands specific to second-brain go in `.claude/commands/` (project-level)
- Start with 3-4 commands. Add more only when we feel friction.

### 4a. `/project-status` — Where am I?

**Location:** `~/.wibey/commands/project-status.md`
**Purpose:** Context recovery. Run at session start.

```markdown
   ---
   description: Show project status — milestones, open issues, recent work
   ---

   Run the following commands and present a clean summary:

   1. Show milestone progress:
      ```bash
      gh api repos/:owner/:repo/milestones --jq '.[] | select(.state=="open") | "\(.title): \(.closed_issues)/\(.open_issues + .closed_issues) done"'
      ```

   2. Show open issues for the current milestone (lowest number = current):
      ```bash
      gh issue list --state open --json number,title,labels,milestone --template '{{range .}}#{{.number}} {{.title}} {{range .labels}}[{{.name}}]{{end}} {{if .milestone}}({{.milestone.title}}){{end}}{{"\\n"}}{{end}}'
      ```

   3. Show recent commits (last 5):
      ```bash
      git log --oneline -5
      ```

   4. Show uncommitted work:
      ```bash
      git status --short
      ```

   5. Show open PRs:
      ```bash
      gh pr list
      ```

   Present as a concise dashboard. Format:
   - Current milestone + progress bar
   - Open issues (numbered, labeled)
   - Last 5 commits
   - Any uncommitted changes
   - Any open PRs

   If there's an obvious "next thing to work on" based on priority labels and milestone, suggest it.
```


### 4b. `/work` — Start a task

**Location:** `.claude/commands/work.md`
**Purpose:** Pick up an issue and start working.

```markdown
   ---
   description: Start working on an issue — creates branch, shows context
   ---

   Usage: /work <issue-number>

   Steps:
   1. Fetch the issue details:
      ```bash
      gh issue view $ARGUMENTS
      ```

   2. Create a branch from the issue:
      ```bash
      gh issue develop $ARGUMENTS --checkout
      ```
      If that fails (older gh), create manually:
      ```bash
      git checkout -b feat/$ARGUMENTS-$(gh issue view $ARGUMENTS --json title --jq '.title' | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | cut -c1-40)
      ```

   3. Display the issue's acceptance criteria so they're visible during the session.

   4. Remind: "When done, run /ship to create PR and close this issue."
```

### 4c. `/ship` — Ship current work

**Location:** `.claude/commands/ship.md`
**Purpose:** Create PR, link to issue, prepare for merge.

```markdown
   ---
   description: Ship current branch — create PR linking to issue, ready for merge
   ---

   Steps:
   1. Detect current branch and extract issue number from branch name:
      ```bash
      git branch --show-current
      ```

   2. Check for uncommitted changes and commit if needed.

   3. Push the branch:
      ```bash
      git push -u origin $(git branch --show-current)
      ```

   4. Create PR that auto-closes the issue:
      ```bash
      gh pr create --fill --body "Closes #<issue-number>"
      ```

   5. Show the PR URL.

   6. Ask: "Ready to merge? (squash-merge + delete branch)"
      If yes:
      ```bash
      gh pr merge --squash --delete-branch
      ```
```

### 4d. `/quick-issue` — Create an issue fast

**Location:** `.claude/commands/quick-issue.md`
**Purpose:** Capture work items without friction.

```markdown
   ---
   description: Create a GitHub issue quickly from a one-liner
   ---

   Usage: /quick-issue <title>

   Steps:
   1. Parse the title from $ARGUMENTS.

   2. Infer the label from the title:
      - Contains "fix", "bug", "crash", "error" → label: fix
      - Contains "add", "implement", "create", "build" → label: feat
      - Contains "refactor", "clean", "update", "migrate" → label: chore
      - Contains "explore", "investigate", "research" → label: spike
      - Default → feat

   3. Detect the current milestone (lowest open milestone number):
      ```bash
      gh api repos/:owner/:repo/milestones --jq '[.[] | select(.state=="open")] | sort_by(.number) | .[0].title'
      ```

   4. Create the issue:
      ```bash
      gh issue create --title "<title>" --label <inferred-label> --milestone "<current-milestone>" --assignee @me
      ```

   5. Confirm with issue number and URL.
```

### Future Commands (Add when friction demands it)

| Command | When to add | What it does |
|---------|-------------|--------------|
| `/plan-to-issues` | When starting A2+ milestones | Parse a plan doc into multiple issues |
| `/session-end` | When context loss between sessions hurts | WIP commit + summary of what was done |
| `/review` | When PRs need structured review | Run through acceptance criteria checklist |
| `/retro` | At milestone completion | What went well, what didn't, what to change |

---

## 5. CLAUDE.md / AGENTS.md Redesign

### Current state
- `AGENTS.md` exists (comprehensive but long)
- `skills/` directory has 9 coding skills (from Simon Willison patterns)
- No `.claude/commands/` directory yet
- No project-level learnings

### Proposed changes

**Keep AGENTS.md < 200 lines.** Move overflow to scoped files.

**Add "Project Learnings" section** (from agents-md pattern):
```markdown
## Project Learnings
<!-- Add one line per mistake. This section self-corrects over time. -->
- (empty — will grow as we build)
```

**Add `.claude/commands/`** with the 3 project-specific commands above.

**Simplify skills/**: The existing skills/ directory is good reference material, but for daily work we need the patterns internalized in AGENTS.md, not loaded on-demand. Keep skills/ as reference, but the working instructions live in AGENTS.md.

### Proposed AGENTS.md structure (< 200 lines)

```
1. Project Overview (what, tech stack, current phase) — 15 lines
2. Repo Structure — 15 lines
3. Coding Conventions — 20 lines
4. Architecture Patterns — 15 lines
5. Git Workflow — 20 lines (branch naming, commit format, PR strategy)
6. Build/Test/Run — 10 lines
7. Current Milestone — 10 lines (what we're building NOW)
8. Key Decisions — 15 lines (choices made and why)
9. Project Learnings — grows over time
10. Design References — 10 lines (links to Obsidian docs)
```

Total: ~130 lines base, growing with learnings.

---

## 6. Implementation Plan

### Phase 1: Infrastructure (Do Now)
- [ ] Create GitHub labels (7 labels)
- [ ] Create GitHub milestones (A1-A5)
- [ ] Create A1 issues (6 issues)
- [ ] Add issue template (`.github/ISSUE_TEMPLATE/task.md`)
- [ ] Create `.claude/commands/` with work.md, ship.md, quick-issue.md
- [ ] Create `~/.wibey/commands/project-status.md`

### Phase 2: AGENTS.md Refresh (Do Next Session)
- [ ] Slim AGENTS.md to < 200 lines
- [ ] Add Project Learnings section
- [ ] Add Git Workflow section with conventions
- [ ] Add Current Milestone section

### Phase 3: Validate (Do Over Next Week)
- [ ] Use `/project-status` at start of every session — is it useful?
- [ ] Use `/work <N>` to pick up issues — does it flow?
- [ ] Use `/ship` to close work — does it reduce friction?
- [ ] Add learnings to AGENTS.md as they come up
- [ ] After 5-7 sessions: retro on what's working and what's not

### Phase 4: Expand (Only When Friction Demands)
- [ ] Add `/plan-to-issues` when starting A2
- [ ] Add `/session-end` if context loss is a problem
- [ ] Consider gh aliases for frequent operations
- [ ] Evaluate if skills/ waterfall pattern adds value or just adds indirection

---

## 7. Decision Log

| Date | Decision | Rationale |
|------|----------|-----------|
| 2026-04-25 | Start with 4 commands, not 20 | YAGNI. Add when friction demands. |
| 2026-04-25 | GitHub Issues over Projects/Linear | Solo dev sweet spot. No Kanban overhead. |
| 2026-04-25 | 7 labels, not 20 | Covers type + priority + status. Everything else is noise. |
| 2026-04-25 | Squash-merge PRs always | Clean main history. WIP commits never pollute. |
| 2026-04-25 | Skip superpowers/ and compound-engineering/ | Over-engineered for current needs. Build knowledge inside-out. |
| 2026-04-25 | AGENTS.md < 200 lines | Research shows instruction adherence drops beyond this. |

---

## 8. Open Questions

- [ ] **First URL in user's message was blank** — what was the other repo to research?
- [ ] **Should we keep skills/ as-is or trim?** Current skills are good reference but may be dead weight if never loaded.
- [ ] **gh issue develop** — does this work with our gh version? Need to test.
- [ ] **Project-level vs global commands** — should `/project-status` be global (works across projects) or project-specific?
- [ ] **How to handle Obsidian ↔ GitHub sync?** Vision/roadmap live in Obsidian, issues live in GitHub. Should milestone descriptions link to Obsidian docs?
- [ ] **finance-hub workflows** — same infra pattern? Or different needs?

---

## Appendix: Research Sources

### Repos with strong workflow patterns
- [automazeio/ccpm](https://github.com/automazeio/ccpm) — Claude Code Project Manager
- [alirezarezvani/claude-code-github-workflow](https://github.com/alirezarezvani/claude-code-github-workflow) — Full lifecycle automation
- [forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills) — Behavioral CLAUDE.md
- [TheRealSeanDonahoe/agents-md](https://github.com/TheRealSeanDonahoe/agents-md) — Universal AGENTS.md template
- [EveryInc/claude_commands](https://github.com/EveryInc/claude_commands) — Battle-tested command templates
- [josix/awesome-claude-md](https://github.com/josix/awesome-claude-md) — 242+ CLAUDE.md examples
- [VILA-Lab/Dive-into-Claude-Code](https://github.com/VILA-Lab/Dive-into-Claude-Code) — Empirical study of 328 configs
- [Brad Feld's Advanced Config](https://gist.github.com/bradfeld/1deb0c385d12289947ff83f145b7e4d2) — 12-repo, 68-command setup
- antirez (Salvatore Sanfilippo) — Spec-first "vibe-speccing" with IMPLEMENTATION_NOTES.md

### Key principles extracted
1. Spec-first, code-second (antirez, ccpm, bradfeld)
2. CLAUDE.md < 200 lines (empirical research from VILA-Lab)
3. Self-correcting project learnings (agents-md)
4. GitHub Issues as single source of truth (ccpm, github-workflow)
5. Circuit breakers to prevent untested shipping (bradfeld)
6. Research → Plan → Execute → Review → Ship (every good command)
7. WIP commits > stashes for context recovery
