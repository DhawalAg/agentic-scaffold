# Review: marcusgoll/Spec-Flow

**Status:** 🔍 PENDING
**Links:**
- [README](https://github.com/marcusgoll/Spec-Flow)
- [QUICKSTART](https://github.com/marcusgoll/Spec-Flow/blob/main/QUICKSTART.md)
**Stars:** 83 | **Focus:** Spec-driven dev toolkit with tiered task sizing

---

## What They Have

### Core Pipeline
```
spec → plan → tasks → implement → optimize → ship
```

### Tiered Task Sizing (the key innovation)
| Tier | Duration | Workflow |
|------|----------|---------|
| Quick fix | < 30 min | Minimal process, just fix it |
| Feature | < 16 hours | Full spec→plan→implement→ship |
| Epic | > 16 hours | Multi-sprint, parallel with locked API contracts |

### Commands
| Command | What It Does |
|---------|-------------|
| `/feature "desc"` | Start feature workflow |
| `/feature continue` | Resume after break |
| `/epic "desc"` | Multi-sprint orchestration |
| `/epic continue` | Resume epic work |
| `/plan` | Create implementation plan |
| `/ship` | Deploy + document |

### Key Features
- Every decision tracked in NOTES.md
- TDD enforced, quality gates block bad code
- Auto-compaction keeps context efficient
- Reusable patterns across features
- Auditable artifacts for every phase
- Install via `npx spec-flow init` (copies files into `.claude/`, `.spec-flow/`, `CLAUDE.md`)

---

## What We Could Steal

1. **Tiered task sizing** — Our `/todo` treats everything the same. A one-liner shouldn't go through 4 phases.
2. **Quick fix path** — Skip the ceremony for trivial changes
3. **Continue/resume** — `/feature continue` to pick up where you left off
4. **Quality gates** — Block shipping if tests don't pass

---

## Dhawal's Notes

<!-- Drop your notes here after reviewing the links above -->

**Overall verdict:** 🔍 PENDING

**What to take:**
-

**What to skip:**
-

**How to adapt for our scaffold:**
-
