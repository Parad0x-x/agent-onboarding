#!/bin/sh
# Install into ~/.agents and register the skill with Claude Code. Never overwrites existing files.
set -eu
SRC=$(cd "$(dirname "$0")" && pwd)
DEST="$HOME/.agents"
mkdir -p "$DEST" "$HOME/.claude/skills/onboard-agent"

put() { if [ -e "$2" ]; then echo "kept    $2"; else cp "$1" "$2"; echo "added   $2"; fi; }

put "$SRC/scripts/onboard.sh" "$DEST/onboard.sh"
put "$SRC/scripts/ask" "$DEST/ask"
put "$SRC/templates/RULES.md" "$DEST/RULES.md"
put "$SRC/templates/AGENTS.template.md" "$DEST/AGENTS.template.md"
put "$SRC/SKILL.md" "$HOME/.claude/skills/onboard-agent/SKILL.md"
chmod +x "$DEST/onboard.sh" "$DEST/ask"
echo "Next: edit $DEST/RULES.md, then run: $DEST/onboard.sh status"
