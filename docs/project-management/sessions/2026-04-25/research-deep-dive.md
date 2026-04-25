# Session: 2026-04-25 — Research Deep Dive & Inspiration Mapping

**Status:** IN PROGRESS
**Goal:** Map every existing command/skill to its inspiration source, discover new repos/patterns, and curate a shortlist for Dhawal to personally review.

---

## Executive Summary

We deployed GitHub search across 5 query vectors and analyzed **25+ repos** in the agentic coding workflow space. Below is:
1. A provenance map (what we have → where it came from)
2. A curated discovery list (new repos ranked by relevance to our scaffold)
3. Specific new commands/patterns worth stealing
4. TODOs for Dhawal's manual review

---

## 1. Provenance Map — Our Commands × Their Inspirations

### `/session-start` — Context recovery + task selection
| Inspiration | Repo | What We Took |
|-------------|------|--------------|
| INIT phase (state machine) | badlogic/claude-commands | Phase-gated workflow, WIP detection |
| `/prime` context loader | coleam00/link-in-bio-page-builder | `git ls-files`, `tree`, read docs, `git log` |
| `resume_handoff` | parcadei/Continuous-Claude-v3 | "Load last session" → resume concept |
| Session-oriented design | Original | Handoff notes as first-class citizens |

### `/session-end` — Progress logging + handoff notes
| Inspiration | Repo | What We Took |
|-------------|------|--------------|
| Session hooks | mitsuhiko/agent-stuff | Event-driven session lifecycle |
| `create_handoff` skill | parcadei/Continuous-Claude-v3 | YAML handoff concept (we use markdown) |
| `/reflect` command | robzolkos/claude-commands | Post-task learning capture |
| WIP commits > stashes | Brad Feld gist | Visible context recovery in git log |

### `/project-status` — Dashboard view
| Inspiration | Repo | What We Took |
|-------------|------|--------------|
| `gh` CLI structured output | mitsuhiko/agent-stuff | `--json` + `--jq` patterns for clean data |
| Milestone progress bars | Original | Visual % complete with Unicode bars |
| "Suggest next" logic | coleam00/link-in-bio-page-builder | Priority-based task suggestion |
| Codebase context gen | EveryInc/claude_commands | `02_generate_codebase_context.md` |

### `/create-issue` — Quick issue creation with labels
| Inspiration | Repo | What We Took |
|-------------|------|--------------|
| Tiered detail levels | EveryInc/claude_commands | MINIMAL/MORE/A LOT detail scaling |
| Label inference | Original | Auto-infer type from title keywords |
| `type:` + `priority:` + `size:` | anthropics/claude-code + EveryInc | 3-axis label system (10 labels) |
| `/gh-issue` skill | Hey-Diga/dotclaude | Research codebase before creating issue |

### `/todo` — Select → Implement → Commit workflow
| Inspiration | Repo | What We Took |
|-------------|------|--------------|
| `todo-worktree.md` 🔥🔥 | badlogic/claude-commands | INIT→SELECT→IMPLEMENT→COMMIT phases |
| STOP points (human gates) | badlogic/claude-commands | `⏸️ STOP` at every phase boundary |
| `todos.ts` TUI manager | mitsuhiko/agent-stuff | Refine/work/view/close lifecycle |
| Unforeseen work handling | badlogic/claude-commands | "Extra work? Add to plan?" pattern |
| Issue ref in commits | All repos | `feat: X (#12)` / `closes #N` |

### `/milestone-progress` — Deep dive on one milestone
| Inspiration | Repo | What We Took |
|-------------|------|--------------|
| Milestone-linked roadmaps | automazeio/ccpm | Milestones as project phases |
| Progress visualization | Original | Unicode progress bars + grouped lists |

### `setup-github-labels.sh` — Idempotent label setup
| Inspiration | Repo | What We Took |
|-------------|------|--------------|
| 7-label system | workflow-skeleton.md research | `feat, fix, chore, blocked, spike, p-high, p-low` |
| 10-label system (current) | Original refinement | Added `size:small/medium/large` axis |
| `--force` idempotency | Standard gh CLI pattern | Safe to re-run |

### `CLAUDE.md.template` — Project instruction file
| Inspiration | Repo | What We Took |
|-------------|------|--------------|
| CLAUDE-template.md | coleam00/link-in-bio-page-builder | Structure: overview, commands, structure |
| < 200 lines rule | VILA-Lab/Dive-into-Claude-Code | Empirical: instruction adherence drops beyond 200 lines |
| Project Learnings section | TheRealSeanDonahoe/agents-md | Self-correcting learnings that grow over time |
| Karpathy principles | forrestchang/andrej-karpathy-skills | Think first, simplicity, surgical changes |

---

## 2. New Repos Discovered — Curated for Dhawal Review

### 🔴 Tier 1: MUST READ (high-value, directly relevant patterns)

#### A. marcusgoll/Spec-Flow — 83⭐
- **URL:** https://github.com/marcusgoll/Spec-Flow
- **What:** Spec-driven development toolkit. `/feature`, `/epic`, `/plan`, `/ship` pipeline
- **Key idea:** Right-size workflow to task complexity:
  - Quick fix (<30 min) → minimal process
  - Feature (<16 hours) → full spec→plan→implement→ship
  - Epic (>16 hours) → parallel sprints with locked API contracts
- **Why care:** Our `/todo` is one-size-fits-all. Spec-Flow's tiering is smarter — a one-line fix shouldn't go through the same pipeline as a new feature.
- **Steal for scaffold:** Tiered task sizing that adjusts workflow weight

#### B. agenticnotetaking/eidos — 49⭐
- **URL:** https://github.com/agenticnotetaking/eidos
- **What:** Spec-driven development plugin. 55+ skills. Three-folder architecture.
- **Key idea:** `eidos/` (what it SHOULD be) + `memory/` (how we got here) + `src/` (what it IS). Specs capture intent. Code is downstream manifestation. `/eidos:drift` detects when code has drifted from spec.
- **Why care:** The `push`/`pull` bidirectionality is genius — extract spec from existing code, or push spec into new code. Plus: `/eidos:research`, `/eidos:decision`, `/eidos:observe`, `/eidos:reflect`.
- **Steal for scaffold:** `drift` detection, `decision` recording, `research` skill

#### C. badlogic/pi-skills — 1374⭐
- **URL:** https://github.com/badlogic/pi-skills
- **What:** Cross-agent compatible skills from libGDX creator (same person as `claude-commands`)
- **Key idea:** Skills work across Pi, Claude Code, Codex CLI, Amp, and Droid. Brave search, browser tools, Google Calendar/Drive/Mail CLIs, transcription, VS Code integration.
- **Why care:** This is the portable skill layer we'd want. Especially `brave-search` and `browser-tools` for our second-brain project.
- **Steal for scaffold:** Skill format standard, brave-search skill

#### D. robzolkos/claude-commands — 39⭐
- **URL:** https://github.com/robzolkos/claude-commands
- **What:** Clean solo-dev workflow. 12 focused commands.
- **Key idea:** Beyond code: `/reflect` (capture learnings), `/quiz` (reinforce knowledge), `/reverse` (Socratic questioning to avoid over-engineering), `/lw` (last week summary for stakeholders), `/today` (today's summary).
- **Why care:** The learning/reflection commands are unique. Nobody else does `/quiz` or `/reverse`. And `/lw` + `/today` solve the "what did I do?" problem for non-technical communication.
- **Steal for scaffold:** `/reflect`, `/reverse`, `/today` concepts

#### E. Dicklesworthstone/post_compact_reminder — 43⭐
- **URL:** https://github.com/Dicklesworthstone/post_compact_reminder
- **What:** Hook that detects context compaction and re-injects project rules
- **Key idea:** After Claude compacts context, it forgets AGENTS.md rules. This hook detects compaction events and tells Claude to re-read its instructions.
- **Why care:** Directly solves our "context is expensive" problem. Simple, one hook, zero maintenance.
- **Steal for scaffold:** Post-compact hook pattern

### 🟡 Tier 2: WORTH SKIMMING (good ideas, may be overkill now)

#### F. parcadei/Continuous-Claude-v3 — 3731⭐
- **URL:** https://github.com/parcadei/Continuous-Claude-v3
- **What:** 109 skills, 32 agents, 30 hooks. "Compound, don't compact."
- **Key ideas:**
  - YAML handoffs (more token-efficient than markdown)
  - Natural language skill activation (infer from message intent)
  - 5-layer TLDR code analysis (avoid reading entire files)
  - Memory daemon that auto-extracts learnings
- **Why care:** The "compound, don't compact" philosophy is powerful. But 109 skills is exactly the over-engineering we said we'd avoid. Cherry-pick the handoff format and TLDR concept.
- **Steal for scaffold:** YAML handoff format, TLDR code analysis idea

#### G. OneRedOak/claude-code-workflows — 3788⭐
- **URL:** https://github.com/OneRedOak/claude-code-workflows
- **What:** Code review, security review, design review workflows
- **Key ideas:**
  - Dual-loop architecture (slash commands + GitHub Actions)
  - Design review uses Playwright MCP for visual testing
  - Security review based on OWASP Top 10
- **Why care:** When we're ready for review workflows, this is the reference. Too early for solo dev phase.
- **Steal for scaffold (later):** Review workflow templates

#### H. dgalarza/claude-code-workflows — 50⭐
- **URL:** https://github.com/dgalarza/claude-code-workflows
- **What:** Codebase readiness scoring, TDD workflow, parallel code review
- **Key ideas:**
  - `/codebase-readiness` scores repo on 8 dimensions (0-100)
  - `agent-ready` plugin fixes documentation gaps automatically
  - Worktree tips for parallel agents
- **Why care:** The "codebase readiness" concept is fascinating — score how AI-ready your repo is. Good future addition.
- **Steal for scaffold (later):** Readiness scoring concept

#### I. Hey-Diga/dotclaude — 12⭐
- **URL:** https://github.com/Hey-Diga/dotclaude
- **What:** Define → Implement → Review three-phase flow
- **Key ideas:**
  - `/gh-issue` researches codebase BEFORE creating issue
  - `/start-working-on-issue N` does branch→code→test→PR in one shot
  - `/review-pr-comments` addresses feedback and updates PR
  - `/fix-ci` diagnoses and fixes CI/CD failures
- **Why care:** Very similar to our `/work` + `/ship` from workflow-skeleton.md. Their `/fix-ci` and `/review-pr-comments` are nice additions we don't have.
- **Steal for scaffold:** `/fix-ci` concept, `/review-pr-comments`

#### J. disler/claude-code-hooks-mastery — 3571⭐
- **URL:** https://github.com/disler/claude-code-hooks-mastery
- **What:** Master class on Claude Code hooks
- **Key ideas:**
  - `ai_docs/` directory for LLM-specific guidance
  - `specs/` for feature specifications
  - Output styles (configurable agent output formatting)
  - Status lines (custom status bar content)
- **Why care:** The `ai_docs/` vs `docs/` separation is smart. Similar to yzyydev's pattern. Hooks mastery content is educational.
- **Steal for scaffold:** `ai_docs/` directory concept

### 🟢 Tier 3: NICHE / FUTURE (interesting but not now)

#### K. sbtobb/my-claude-code-workflow — 46⭐
- **URL:** https://github.com/sbtobb/my-claude-code-workflow
- **What:** PRD-driven development with multi-model collaboration (O3 + Gemini review)
- **Steal for scaffold (future):** Multi-model review pattern

#### L. nicobailon/pi-messenger — 519⭐
- **URL:** https://github.com/nicobailon/pi-messenger
- **What:** Multi-agent communication for Pi coding agent
- **Steal for scaffold (future):** Agent-to-agent messaging

#### M. HazAT/pi-config — 310⭐
- **URL:** https://github.com/HazAT/pi-config
- **What:** Personal Pi config with skills + extensions + agents + MCP
- **Steal for scaffold (future):** Config organization pattern

---

## 3. New Commands/Patterns — Ranked for Our Scaffold

### Immediately Actionable (add to scaffold now or next iteration)

| # | Command/Pattern | Source Repo | What It Does | Effort |
|---|----------------|-------------|--------------|--------|
| 1 | `/prime` | coleam00 | Full project context load | Small — already similar to our `/session-start` step 2, but more thorough |
| 2 | `/reflect` | robzolkos | Post-task learning capture → append to CLAUDE.md Project Learnings | Small — 20-line command |
| 3 | `/plan-feature` → `.agents/plans/` | coleam00 | Research-first planning separated from execution | Medium — needs plans directory |
| 4 | Post-compact hook | Dicklesworthstone | Re-inject rules after context compaction | Small — one hook script |
| 5 | Tiered task sizing | Spec-Flow | Quick-fix / Feature / Epic workflow selection | Medium — refactor `/todo` |
| 6 | `/today` + `/lw` | robzolkos | Generate summaries for stakeholders | Small — simple git log + LLM formatting |
| 7 | `/work` + `/ship` | workflow-skeleton.md (already designed!) | Pick issue → branch → implement → PR → merge | Medium — already spec'd, just needs files |

### Next Iteration (add when friction demands)

| # | Command/Pattern | Source Repo | What It Does |
|---|----------------|-------------|--------------|
| 8 | `/review` branch workflow | mitsuhiko/agent-stuff | Branch conversation, do isolated review, return findings |
| 9 | `/reverse` Socratic questioning | robzolkos | Challenge over-engineering via questioning |
| 10 | `drift` detection | eidos | Detect when code has drifted from spec |
| 11 | `/fix-ci` | Hey-Diga/dotclaude | Diagnose and fix CI/CD failures |
| 12 | `/review-pr-comments` | Hey-Diga/dotclaude | Address PR feedback and update |
| 13 | Codebase readiness score | dgalarza | Score how AI-ready your repo is |
| 14 | `ai_docs/` separation | disler, yzyydev | LLM-specific docs separate from human docs |

### Future (cool but premature)

| # | Command/Pattern | Source Repo |
|---|----------------|-------------|
| 15 | Loop (run until tests pass) | mitsuhiko |
| 16 | Git worktree isolation | badlogic, dgalarza |
| 17 | YAML handoffs | parcadei |
| 18 | Natural language skill activation | parcadei |
| 19 | Multi-model review (O3 + Gemini) | sbtobb |
| 20 | Agent-to-agent messaging | nicobailon |
| 21 | Session forking (parallel work) | mitsuhiko |
| 22 | TLDR code analysis (5-layer) | parcadei |
| 23 | `/quiz` knowledge reinforcement | robzolkos |
| 24 | `/decision` recording | eidos |

---

## 4. Key Observations for Dhawal

### Things that jumped out from this research sweep:

1. **The space EXPLODED since our initial research.** When we first analyzed 6 repos on 2025-04-25, the top repos had ~500⭐. Now there are repos with 3000-56000⭐. The patterns have matured significantly.

2. **Three philosophical camps emerged:**
   - **Minimalists** (robzolkos, Hey-Diga, our scaffold) — 5-12 focused commands, lean on gh CLI
   - **Framework builders** (Spec-Flow, Continuous-Claude) — 50-109 skills, npm packages, plugin systems
   - **Spec-driven** (eidos, antirez) — Specs as source of truth, code as downstream artifact

3. **We're solidly in the minimalist camp, which is correct for now.** But the eidos `push/pull` philosophy and Spec-Flow's tiered sizing are patterns that transcend camp boundaries.

4. **The post-compact hook is a no-brainer.** Every repo with hooks has some version of this. We should add it.

5. **`/reflect` is the missing link** in our session-end. We log what happened but don't capture *learnings* that persist across sessions into CLAUDE.md.

6. **`/work` and `/ship` are already designed** in `workflow-skeleton.md` but never implemented as actual command files. Low-hanging fruit.

7. **Pi coding agent (buildwithpi.ai)** is emerging as a serious Claude Code alternative. Badlogic (Mario Zechner) is the most prolific contributor — his `pi-skills` repo has cross-agent compatible skills that work with Claude Code too.

---

## 5. TODOs

### For Dhawal to review personally:
- [ ] **READ** [coleam00 `/prime`](https://github.com/coleam00/link-in-bio-page-builder/blob/main/.claude/commands/prime.md) — 2 min read, this is our `/session-start` on steroids
- [ ] **READ** [coleam00 `/plan-feature`](https://github.com/coleam00/link-in-bio-page-builder/blob/main/.claude/commands/plan-feature.md) — 5 min read, research-first planning
- [ ] **SKIM** [robzolkos/claude-commands](https://github.com/robzolkos/claude-commands) — 10 min skim, especially `/reflect`, `/reverse`, `/quiz`, `/today`, `/lw`
- [ ] **SKIM** [agenticnotetaking/eidos](https://github.com/agenticnotetaking/eidos) — 10 min, focus on the push/pull/drift philosophy
- [ ] **SKIM** [marcusgoll/Spec-Flow QUICKSTART](https://github.com/marcusgoll/Spec-Flow/blob/main/QUICKSTART.md) — 5 min, tiered task sizing
- [ ] **GLANCE** [Dicklesworthstone/post_compact_reminder](https://github.com/Dicklesworthstone/post_compact_reminder) — 2 min, should we add this hook?
- [ ] **GLANCE** [badlogic/pi-skills](https://github.com/badlogic/pi-skills) — 3 min, cross-agent skill format
- [ ] **DECIDE** which patterns to adopt / reject / defer

### For Code Puppy (next session):
- [ ] **Collate Dhawal's review notes** from `docs/research/reviews/01-07` into implementation specs for each adopted pattern
- [ ] Finalize each existing command (session-start, session-end, project-status, create-issue, todo, milestone-progress) — one by one, commit each
- [ ] Implement `/work` and `/ship` commands (already designed in workflow-skeleton.md)
- [ ] Implement `/reflect` command (post-task learning capture)
- [ ] Add post-compact reminder hook (if Dhawal approves)
- [ ] Consider merging `/prime` logic into `/session-start` (richer context loading)
- [ ] Update research.md with new repo findings
- [ ] Create GitHub issues for each skill to finalize (eat our own dog food!)

---

## Issues Touched
- None yet — setting up GitHub remote + issues next

## Commits
- `docs: add research deep-dive session doc`

## Blockers / Notes
- Code Puppy doesn't have a web browsing subagent to view full README renders — relied on `gh api` for all repo exploration
- Some newer repos (56k⭐ awesome lists) are star-inflated — many are just curated link lists, not original work
- Pi coding agent ecosystem is growing fast but requires Pi runtime for TypeScript extensions (skills in markdown are portable)

## Next Time
- [ ] Dhawal reviews the 7 links above and decides what to adopt/reject
- [ ] Implement the approved additions to the scaffold
- [ ] Consider creating a `CHANGELOG.md` to track scaffold evolution
