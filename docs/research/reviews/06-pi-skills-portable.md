# Review: badlogic/pi-skills

**Status:** 🔍 PENDING
**Link:** https://github.com/badlogic/pi-skills
**Stars:** 1374 | **Author:** Mario Zechner (libGDX creator)
**Focus:** Cross-agent portable skills

---

## What They Have

### Skills (all agent-agnostic, markdown-based)
| Skill | What It Does |
|-------|-------------|
| `brave-search` | Web search + content extraction via Brave |
| `browser-tools` | Browser automation via Chrome DevTools Protocol |
| `gccli` | Google Calendar CLI (events, availability) |
| `gdcli` | Google Drive CLI (file management, sharing) |
| `gmcli` | Gmail CLI (email, drafts, labels) |
| `transcribe` | Speech-to-text via Groq Whisper API |
| `vscode` | VS Code integration (diffs, file comparison) |
| `youtube-transcript` | Fetch YouTube video transcripts |

### Cross-Agent Compatibility
Works with: **Pi**, **Claude Code**, **Codex CLI**, **Amp**, **Droid**

Claude Code install method (symlinks because CC only looks 1 level deep):
```bash
git clone https://github.com/badlogic/pi-skills ~/pi-skills
mkdir -p ~/.claude/skills
ln -s ~/pi-skills/brave-search ~/.claude/skills/brave-search
```

### Skill Format
```markdown
---
name: skill-name
description: Short description shown to agent
---
# Instructions
Detailed instructions here...
Helper files available at: {baseDir}/
```

---

## What We Could Steal

1. **Skill format standard** — Simple frontmatter + instructions. Our scaffold could adopt this.
2. **`brave-search` skill** — Directly relevant for second-brain project
3. **Cross-agent mindset** — Skills should be portable, not locked to one tool
4. **Symlink install pattern** — Clever workaround for Claude Code's 1-level-deep limitation

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
