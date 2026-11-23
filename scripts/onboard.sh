#!/bin/sh
# Point an AI tool's global instructions file at ~/.agents/RULES.md (see ONBOARDING.md).
# Usage: onboard.sh [status] | claude | codex | gemini | grok | all | link <path> | import <path>
set -eu
RULES="$HOME/.agents/RULES.md"
# Tools that edit their own global file (Claude memory, Gemini /memory add) get an import line, so their
# writes land in their file instead of in RULES.md. Read-only tools get a symlink.
CLAUDE_FILE="$HOME/.claude/CLAUDE.md"
CLAUDE_IMPORT="@~/.agents/RULES.md"
GEMINI_FILE="$HOME/.gemini/GEMINI.md"
GEMINI_IMPORT="@$RULES"   # Gemini imports take relative or absolute paths, not ~
LINKED_FILES="$HOME/.codex/AGENTS.md $HOME/.grok/rules/global-rules.md"

# Symlink $1 -> RULES. A non-empty file already there is kept as a timestamped .bak, never deleted.
link() {
  target=$1
  if [ "$(readlink "$target" 2>/dev/null)" = "$RULES" ]; then echo "ok      $target"; return; fi
  mkdir -p "$(dirname "$target")"
  if [ -s "$target" ] || [ -L "$target" ]; then
    mv "$target" "$target.bak.$(date +%Y%m%d%H%M%S)"
    echo "backup  $target"
  fi
  ln -sf "$RULES" "$target"
  echo "linked  $target"
}

# Append import line $2 to file $1, keeping the file's own content.
import() {
  if grep -qxF "$2" "$1" 2>/dev/null; then echo "ok      $1"; return; fi
  mkdir -p "$(dirname "$1")"
  printf '\n# Global rules for all agents\n%s\n' "$2" >> "$1"
  echo "linked  $1"
}

check_import() { grep -qxF "$2" "$1" 2>/dev/null && echo "ok      $1" || echo "MISSING $1"; }

status() {
  check_import "$CLAUDE_FILE" "$CLAUDE_IMPORT"
  check_import "$GEMINI_FILE" "$GEMINI_IMPORT"
  for f in $LINKED_FILES; do
    [ "$(readlink "$f" 2>/dev/null)" = "$RULES" ] && echo "ok      $f" || echo "MISSING $f"
  done
}

case "${1:-status}" in
  status) status ;;
  claude) import "$CLAUDE_FILE" "$CLAUDE_IMPORT" ;;
  gemini) import "$GEMINI_FILE" "$GEMINI_IMPORT" ;;
  codex)  link "$HOME/.codex/AGENTS.md" ;;
  grok)   link "$HOME/.grok/rules/global-rules.md" ;;
  all)    import "$CLAUDE_FILE" "$CLAUDE_IMPORT"; import "$GEMINI_FILE" "$GEMINI_IMPORT"
          for f in $LINKED_FILES; do link "$f"; done ;;
  link)   [ $# -eq 2 ] || { echo "usage: onboard.sh link <path>" >&2; exit 1; }; link "$2" ;;
  import) [ $# -eq 2 ] || { echo "usage: onboard.sh import <path>" >&2; exit 1; }; import "$2" "@$RULES" ;;
  *)      echo "usage: onboard.sh [status|claude|codex|gemini|grok|all|link <path>|import <path>]" >&2; exit 1 ;;
esac
