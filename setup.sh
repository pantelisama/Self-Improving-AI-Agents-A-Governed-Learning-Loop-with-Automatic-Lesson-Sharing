#!/bin/bash
# Install Learnloop as a Claude Code skill and enable its hooks.
# Usage: bash setup.sh [git-remote-url]
#   With a remote URL, memory is committed and pushed automatically after every turn.
#   Without one, it is committed locally only until you add a remote.
set -euo pipefail
SRC="$(cd "$(dirname "$0")" && pwd)"
DEST="${LEARNLOOP_DIR:-$HOME/.claude/skills/learnloop}"
SETTINGS="$HOME/.claude/settings.json"
REMOTE="${1:-}"

# 1. Install the skill folder.
if [ "$SRC" != "$DEST" ]; then
  mkdir -p "$DEST"
  cp -r "$SRC/." "$DEST/"
fi
chmod +x "$DEST/hooks/"*.sh
echo "Installed skill: $DEST"

# 2. Make it a git repository, so every lesson is versioned.
cd "$DEST"
if ! git rev-parse --git-dir >/dev/null 2>&1; then
  git init -q && git add -A
  git config user.name >/dev/null || git config user.name "learnloop"
  git config user.email >/dev/null || git config user.email "learnloop@localhost"
  git commit -q -m "learnloop: install"
  echo "Initialised git repository"
fi
if [ -n "$REMOTE" ]; then
  git remote remove origin 2>/dev/null || true
  git remote add origin "$REMOTE"
  git push -q -u origin HEAD && echo "Remote set and pushed: $REMOTE"
fi
git remote get-url origin >/dev/null 2>&1 || echo "No remote yet: lessons commit locally. Add one with: bash setup.sh <git-remote-url>"

# 3. Register the hooks in ~/.claude/settings.json (merged, existing hooks kept).
mkdir -p "$(dirname "$SETTINGS")"
[ -f "$SETTINGS" ] || echo '{}' > "$SETTINGS"
cp "$SETTINGS" "$SETTINGS.bak.learnloop"
python3 - "$SETTINGS" "$DEST" <<'PY'
import json, sys
path, dest = sys.argv[1], sys.argv[2]
cfg = json.load(open(path))
hooks = cfg.setdefault("hooks", {})
want = {
    "UserPromptSubmit": {"type": "command", "command": f"LEARNLOOP_DIR={dest} bash {dest}/hooks/correction-reminder.sh", "timeout": 10},
    "Stop": {"type": "command", "command": f"LEARNLOOP_DIR={dest} bash {dest}/hooks/memory-commit.sh", "timeout": 30, "async": True},
}
for event, hook in want.items():
    groups = hooks.setdefault(event, [])
    if any("learnloop" in h.get("command", "") for g in groups for h in g.get("hooks", [])):
        continue
    groups.append({"hooks": [hook]})
json.dump(cfg, open(path, "w"), indent=2)
PY
echo "Hooks registered in $SETTINGS (backup: $SETTINGS.bak.learnloop)"
echo "Done. Restart Claude Code, then correct the agent twice on the same thing to see: 📚 LESSON LEARNT"
