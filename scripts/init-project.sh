#!/bin/bash
# init-project.sh
# Copy the agentic scaffold into an existing project.
# Run from inside the target project directory.
#
# Usage:
#   cd my-project
#   bash /path/to/agentic-scaffold/scripts/init-project.sh
set -e

SCAFFOLD_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TARGET_DIR="$(pwd)"

echo "🐶 Initializing agentic scaffold in: $TARGET_DIR"
echo "   Source: $SCAFFOLD_DIR"
echo ""

# Copy .claude/commands/ (don't overwrite existing settings.json)
if [ -d "$TARGET_DIR/.claude/commands" ]; then
  echo "⚠️  .claude/commands/ already exists. Merging (won't overwrite)..."
  for f in "$SCAFFOLD_DIR/.claude/commands/"*.md; do
    fname=$(basename "$f")
    if [ ! -f "$TARGET_DIR/.claude/commands/$fname" ]; then
      cp "$f" "$TARGET_DIR/.claude/commands/$fname"
      echo "   ✅ Added $fname"
    else
      echo "   ⏭️  Skipped $fname (already exists)"
    fi
  done
else
  mkdir -p "$TARGET_DIR/.claude/commands"
  cp "$SCAFFOLD_DIR/.claude/commands/"*.md "$TARGET_DIR/.claude/commands/"
  echo "✅ Copied .claude/commands/ (6 commands)"
fi

# Copy docs/project-management/ structure
if [ ! -d "$TARGET_DIR/docs/project-management" ]; then
  mkdir -p "$TARGET_DIR/docs/project-management/sessions"
  cp "$SCAFFOLD_DIR/docs/project-management/sessions/README.md" \
     "$TARGET_DIR/docs/project-management/sessions/README.md"
  cp "$SCAFFOLD_DIR/docs/project-management/01-vision.template.md" \
     "$TARGET_DIR/docs/project-management/01-vision.md"
  cp "$SCAFFOLD_DIR/docs/project-management/05-roadmap.template.md" \
     "$TARGET_DIR/docs/project-management/05-roadmap.md"
  echo "✅ Created docs/project-management/ (vision, roadmap, sessions)"
else
  echo "⏭️  docs/project-management/ already exists"
fi

# Copy scripts
mkdir -p "$TARGET_DIR/scripts"
if [ ! -f "$TARGET_DIR/scripts/setup-github-labels.sh" ]; then
  cp "$SCAFFOLD_DIR/scripts/setup-github-labels.sh" "$TARGET_DIR/scripts/"
  echo "✅ Copied scripts/setup-github-labels.sh"
else
  echo "⏭️  setup-github-labels.sh already exists"
fi

# Copy CLAUDE.md template if no CLAUDE.md exists
if [ ! -f "$TARGET_DIR/CLAUDE.md" ]; then
  cp "$SCAFFOLD_DIR/CLAUDE.md.template" "$TARGET_DIR/CLAUDE.md"
  echo "✅ Created CLAUDE.md from template (edit to customize)"
else
  echo "⏭️  CLAUDE.md already exists"
fi

echo ""
echo "🎉 Done! Next steps:"
echo "   1. Edit CLAUDE.md with your project details"
echo "   2. Edit docs/project-management/01-vision.md"
echo "   3. Edit docs/project-management/05-roadmap.md"
echo "   4. Run: bash scripts/setup-github-labels.sh"
echo "   5. Create milestones: gh milestone create 'A1: ...' --description '...'"
echo "   6. Start a session: /session-start"
