#!/bin/bash
# Stop hook: commit and push memory/ and evaluation/ so every lesson is shared at once. Never fails the session.
# Set LEARNLOOP_PUSH=0 to commit locally only.
DIR="${LEARNLOOP_DIR:-$HOME/.claude/skills/learnloop}"
cd "$DIR" 2>/dev/null && git rev-parse --git-dir >/dev/null 2>&1 || exit 0
git add -- memory evaluation 2>/dev/null
git diff --cached --quiet -- memory evaluation && exit 0
git commit -q -m "learnloop: memory $(date -Iseconds)" -- memory evaluation >/dev/null 2>&1
[ "${LEARNLOOP_PUSH:-1}" != 0 ] && (timeout 60 git push -q >/dev/null 2>&1 &)
exit 0
