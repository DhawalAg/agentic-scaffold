#!/bin/bash
# setup-github-labels.sh
# Idempotent label setup for project management. Safe to re-run.
# Copy into any repo and run.
set -e

echo "🏷️  Setting up project management labels..."

# Type — what kind of work
gh label create "type:task"    --color "0053e2" --description "Feature or planned work"     --force
gh label create "type:bug"     --color "ea1100" --description "Something broken"            --force
gh label create "type:idea"    --color "ffc220" --description "Future consideration"        --force
gh label create "type:chore"   --color "6B7280" --description "Maintenance, refactor, docs" --force

# Priority — when to do it
gh label create "priority:high"   --color "ea1100" --description "Do this first"   --force
gh label create "priority:medium" --color "ffc220" --description "Normal priority" --force
gh label create "priority:low"    --color "2a8703" --description "Nice to have"    --force

# Size — how long (helps pick tasks for available time)
gh label create "size:small"   --color "D1FAE5" --description "< 1 hour"  --force
gh label create "size:medium"  --color "FEF3C7" --description "1-4 hours" --force
gh label create "size:large"   --color "FEE2E2" --description "4+ hours"  --force

echo ""
echo "✅ 10 labels created (4 type + 3 priority + 3 size)"
