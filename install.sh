#!/bin/bash
# Installer for claude-tokyonight-statusline
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
HOOKS_DIR="$CLAUDE_DIR/hooks"
SETTINGS="$CLAUDE_DIR/settings.json"
DEST="$HOOKS_DIR/statusline.sh"

# Requirements
command -v jq >/dev/null || { echo "ERROR: jq required. macOS: brew install jq · Debian: apt install jq"; exit 1; }

# Install script
mkdir -p "$HOOKS_DIR"
cp "$SCRIPT_DIR/statusline.sh" "$DEST"
chmod +x "$DEST"
echo "[ok] Installed $DEST"

# Patch settings.json
[ ! -f "$SETTINGS" ] && echo '{}' > "$SETTINGS"
cp "$SETTINGS" "$SETTINGS.bak"

jq --arg cmd "$DEST" \
   '.statusLine = {type: "command", command: $cmd, refreshInterval: 30}' \
   "$SETTINGS.bak" > "$SETTINGS"

echo "[ok] Patched $SETTINGS (backup at $SETTINGS.bak)"
echo ""
echo "Restart Claude Code or run /hooks to load the status bar."
