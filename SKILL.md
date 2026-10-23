---
name: learnloop
description: Self-learning memory for an AI agent or agent team. Records every human correction, generalises it into a principle, promotes it to a lesson when it recurs, and keeps per-job playbooks. Use at the start of any task (load lessons and the job's playbook), whenever the user corrects you or a reviewer leaves a comment (record it), and after a repeatable job (update its playbook). Works standalone or as the memory module of a larger agent team.
---

# Learnloop

Learn from use. A correction given once stays given.

This skill is a module. It owns one thing: what the agent learned from working, kept
separate from what is true of the project. It does not route tasks, review code or run
tests; the host skill or agent team does that and calls Learnloop at four points.

## The four hook points

| When | Do |
|---|---|
| **Task start** | Read `memory/lessons.md`. If the task is a repeatable job, read `memory/playbooks/<job>.md`. Load only what applies. |
| **Human correction** (the user says you were wrong, rejects work, or a reviewer comments; each comment counts) | Record it, generalised, in `memory/corrections.md` (see "Record"). |
| **Recurrence** (a correction matches an earlier one) | Promote it to `memory/lessons.md` as a general principle, log it in `evaluation/versions.md`. |
| **Job end** (a repeatable job finished) | Update its playbook with what was learned: a better order, a command, a trap. Create the file if it is missing. |

Show the user exactly one bold line per recorded lesson or playbook change, nothing more:

- `📚 **LESSON LEARNT ::** <one sentence>`
- `🔁 **PLAYBOOK UPDATED ::** <job> — <one sentence>`

## Record

1. **Generalise, don't transcribe.** Store the principle under the correction, stated in
   two sentences or fewer. "Grep the HTML" helps once; "count what the reviewer reads"
   helps every time. Rules: `references/learning.md`.
2. **Name the root cause** from the table in `references/reflection.md`. "Missed X" is
   not a cause.
3. **Count recurrence.** A duplicate raises the count on the existing entry; it does not
   add a new one.
4. **Curate on write.** Merge duplicates, supersede contradicted entries, deprecate ones
   whose subject is gone. States: `references/experience-memory.md`.

## Governance

Observing and recording are free. Changing how the agent or team works is not: new
rules, agent definitions, references and this file change only after a human approves a
recommendation (`references/governance.md`). The exceptions are lessons and playbooks,
which update automatically, are logged, and are shown to the user.

## Plugging it in

- **Standalone skill:** install this folder as a skill. The host agent follows the table
  above.
- **Inside an agent team:** the team's lead (orchestrator) owns the hook points. It loads
  lessons and the playbook into each specialist's brief, and it alone writes to `memory/`.
  Specialists report corrections to the lead rather than writing memory themselves.
- **Hooks (recommended):** `hooks/` has a prompt hook that reminds the agent to record a
  correction, and a stop hook that **commits and pushes every lesson automatically**, so
  every agent and teammate sharing the repository has it on their next session. See
  `README.md`.

## Setup

Run `bash setup.sh <git-remote-url>` once (see `README.md`). Without it the skill still
learns, but lessons are not pushed automatically and the correction reminder is off.

## Keep it small

Load lessons and one playbook, never the whole memory. A lessons file nobody can read is a
lessons file nobody loads.
