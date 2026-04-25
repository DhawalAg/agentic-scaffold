# Review: agenticnotetaking/eidos

**Status:** 🔍 PENDING
**Link:** https://github.com/agenticnotetaking/eidos
**Stars:** 49 | **Skills:** 55+ | **Focus:** Spec-driven development plugin

---

## What They Have

### Core Philosophy
> Markdown specs capture intent. Code is a downstream manifestation of spec intent.
> The relationship is bidirectional: specs shape code, code can update specs,
> and conflicts become human decisions.

### Three-Folder Architecture
```
project/
  eidos/     # what it SHOULD be (specs, claims)
  memory/    # how we got here (plans, decisions, sessions)
  src/       # what it IS (code)
```

### Key Skills (55+ total, highlights below)
| Skill | What It Does |
|-------|-------------|
| `/eidos:push` | Push spec intent into code |
| `/eidos:pull` | Extract spec from existing code |
| `/eidos:drift` | Detect when code has drifted from spec |
| `/eidos:plan` | Multi-step work gets a plan in `memory/` |
| `/eidos:plan-continue` | Resume plan across sessions |
| `/eidos:research` | Investigate topics, document findings with sources |
| `/eidos:observe` | Capture testing issues mid-plan, update specs |
| `/eidos:decision` | Record architectural choices with options + rationale |
| `/eidos:reflect` | Post-task reflection |
| `/eidos:sync` | Sync spec and code state |
| `/eidos:status` | Show current spec/plan/drift status |
| `/eidos:worktree` | Git worktree management |
| `/eidos:compact` | Manage context compaction |
| `/eidos:brainstorm` | Structured brainstorming |
| `/eidos:challenge` | Challenge assumptions |
| `/eidos:spiral` | Iterative deepening on a topic |

### The Interesting Bit
- "AI learning on the job is just capturing ephemeral knowledge into files"
- Knowledge can be anywhere — chat history, coworker's head, legacy code
- Eidos gives it all a place to land and a way to get loaded when it matters

---

## What We Could Steal

1. **`drift` detection** — Check if code matches intent (even without full spec system)
2. **`decision` recording** — Log architectural choices with options + rationale
3. **`research` skill** — Investigate external topics, document with sources
4. **`memory/` directory concept** — Plans + decisions + sessions in one place
5. **Push/Pull philosophy** — Extract spec from existing code, push spec into new code

---

## Dhawal's Notes

<!-- Drop your notes here after reviewing the repo -->

**Overall verdict:** 🔍 PENDING

**What to take:**
-

**What to skip:**
-

**How to adapt for our scaffold:**
-
