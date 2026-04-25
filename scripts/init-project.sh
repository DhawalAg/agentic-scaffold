#!/bin/bash
# init-project.sh
# Copy the agentic scaffold into an existing project.
# Run from inside the target project directory.
#
# Usage:
#   cd my-project
#   bash /path/to/agentic-scaffold/scripts/init-project.sh
#
# For the interactive version, use /setup-scaffold command instead.
set -e

SCAFFOLD_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TARGET_DIR="$(pwd)"
TODAY=$(date +%Y-%m-%d)

echo "🐶 Initializing agentic scaffold in: $TARGET_DIR"
echo "   Source: $SCAFFOLD_DIR"
echo ""

# --- Commands ---
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
  echo "✅ Copied .claude/commands/ ($(ls "$SCAFFOLD_DIR/.claude/commands/"*.md | wc -l | tr -d ' ') commands)"
fi

# --- Project management docs ---
mkdir -p "$TARGET_DIR/docs/project-management/sessions/$TODAY"

if [ ! -f "$TARGET_DIR/docs/project-management/sessions/README.md" ]; then
  cp "$SCAFFOLD_DIR/docs/project-management/sessions/README.md" \
     "$TARGET_DIR/docs/project-management/sessions/README.md"
  echo "✅ Copied sessions/README.md"
fi

# Create today's next-up.md if it doesn't exist
if [ ! -f "$TARGET_DIR/docs/project-management/sessions/$TODAY/next-up.md" ]; then
  cat > "$TARGET_DIR/docs/project-management/sessions/$TODAY/next-up.md" << EOF
# Next Up — $TODAY

## Focus
Scaffold setup complete. Ready to start building.

## Active Issues
<!-- Run /session-start to populate from GitHub -->

## Sessions
<!-- Links to workstream sessions today -->

## Scratch Pad
- Scaffold installed — customize CLAUDE.md, vision, roadmap
EOF
  echo "✅ Created sessions/$TODAY/next-up.md"
fi

# Copy templates (without .template suffix)
for template in 01-vision 05-roadmap; do
  if [ ! -f "$TARGET_DIR/docs/project-management/$template.md" ]; then
    cp "$SCAFFOLD_DIR/docs/project-management/$template.template.md" \
       "$TARGET_DIR/docs/project-management/$template.md"
    echo "✅ Created docs/project-management/$template.md"
  else
    echo "⏭️  docs/project-management/$template.md already exists"
  fi
done

# --- Scripts ---
mkdir -p "$TARGET_DIR/scripts"
if [ ! -f "$TARGET_DIR/scripts/setup-github-labels.sh" ]; then
  cp "$SCAFFOLD_DIR/scripts/setup-github-labels.sh" "$TARGET_DIR/scripts/"
  echo "✅ Copied scripts/setup-github-labels.sh"
else
  echo "⏭️  setup-github-labels.sh already exists"
fi

# --- CLAUDE.md ---
if [ ! -f "$TARGET_DIR/CLAUDE.md" ]; then
  cp "$SCAFFOLD_DIR/CLAUDE.md.template" "$TARGET_DIR/CLAUDE.md"
  echo "✅ Created CLAUDE.md from template (edit to customize)"
else
  echo "⏭️  CLAUDE.md already exists (use /setup-scaffold for interactive append)"
fi

# --- .gitignore ---
GITIGNORE_ENTRIES="node_modules/
venv/
.venv/
.env
.env.local
dist/
build/
__pycache__/
.DS_Store
Thumbs.db"

if [ ! -f "$TARGET_DIR/.gitignore" ]; then
  echo "$GITIGNORE_ENTRIES" > "$TARGET_DIR/.gitignore"
  echo "✅ Created .gitignore"
else
  # Append missing entries
  ADDED=0
  while IFS= read -r entry; do
    if ! grep -qxF "$entry" "$TARGET_DIR/.gitignore" 2>/dev/null; then
      echo "$entry" >> "$TARGET_DIR/.gitignore"
      ADDED=$((ADDED + 1))
    fi
  done <<< "$GITIGNORE_ENTRIES"
  if [ "$ADDED" -gt 0 ]; then
    echo "✅ Appended $ADDED entries to .gitignore"
  else
    echo "⏭️  .gitignore already has all standard entries"
  fi
fi

echo ""
echo "🎉 Done! Next steps:"
echo "   1. Edit CLAUDE.md with your project details"
echo "   2. Edit docs/project-management/01-vision.md"
echo "   3. Edit docs/project-management/05-roadmap.md"
echo "   4. Run: bash scripts/setup-github-labels.sh"
echo "   5. Start a session: /session-start"
