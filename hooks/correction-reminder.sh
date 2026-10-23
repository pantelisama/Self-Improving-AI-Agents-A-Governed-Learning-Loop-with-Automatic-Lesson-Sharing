#!/bin/bash
# UserPromptSubmit hook: remind the agent to record a correction when the prompt looks like one.
# Set LEARNLOOP_DIR to the installed skill folder. Extend the keyword list for your languages.
DIR="${LEARNLOOP_DIR:-$HOME/.claude/skills/learnloop}"
prompt=$(python3 -c 'import json,sys; print(json.load(sys.stdin).get("prompt",""))' 2>/dev/null)
grep -qiE "wrong|mistake|not what|again|still|review|comment|reject|stop|should|must|why did" <<<"$prompt" || exit 0
cat <<JSON
{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"If this message corrects you, rejects your work, or carries review comments (each counts), record it generalised in $DIR/memory/corrections.md. If it repeats an earlier correction, promote it to memory/lessons.md and log it in evaluation/versions.md. Show the user one bold line: 📚 **LESSON LEARNT ::** <one sentence>."}}
JSON
