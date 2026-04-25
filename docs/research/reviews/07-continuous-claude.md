# Review: parcadei/Continuous-Claude-v3

**Status:** 🔍 PENDING
**Link:** https://github.com/parcadei/Continuous-Claude-v3
**Stars:** 3731 | **Skills:** 109 | **Agents:** 32 | **Hooks:** 30

---

## What They Have

### Core Philosophy
> **"Compound, don't compact."** Extract learnings automatically,
> then start fresh with full context.

### Key Innovations

**1. YAML Handoffs (more token-efficient than markdown)**
- Session handoffs in YAML instead of markdown
- Structured fields reduce token waste on formatting

**2. Natural Language Skill Activation**
- Hook injects skill suggestions based on message intent
- No need to memorize slash commands
- Priority levels: ⚠️ CRITICAL → 📚 RECOMMENDED → 💡 SUGGESTED → 📌 OPTIONAL

**3. 5-Layer TLDR Code Analysis**
- Avoids reading entire files (token-expensive)
- Semantic index for targeted code understanding

**4. Memory Daemon**
- Auto-extracts learnings from sessions
- Surfaces relevant memories when context matches

**5. Skill vs Workflow vs Agent Distinction**
| Type | Purpose | Example |
|------|---------|---------|
| Skill | Single-purpose tool | `commit`, `qlty-check` |
| Workflow | Multi-step process | `/fix` (sleuth→premortem→kraken→commit) |
| Agent | Specialized role | `debug-agent`, `scout` |

### Warning Signs 🚩
- 109 skills is A LOT — exact opposite of our minimalist philosophy
- Complex hook system may have emergent behavior
- Their own README warns against "plugin sprawl"

---

## What We Could Steal

1. **YAML handoff format** — More efficient than our markdown session logs?
2. **"Compound don't compact" mantra** — Philosophy, not a tool
3. **Skill/Workflow/Agent distinction** — Useful taxonomy
4. **TLDR code analysis concept** — Read summaries, not full files
5. **Natural language activation idea** — (but we'd implement it much simpler)

### What to AVOID from this repo
- 109 skills (framework-itis)
- Complex hook chains (emergent behavior risk)
- Over-engineering the memory system

---

## Dhawal's Notes

<!-- Drop your notes here after reviewing the repo — focus on the README philosophy section -->

**Overall verdict:** 🔍 PENDING

**What to take:**
-

**What to skip:**
-

**How to adapt for our scaffold:**
-
