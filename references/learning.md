# Learning from use

## Signals, in order of value

1. **A human correction.** Someone said the agent was wrong. The strongest signal and the
   cheapest to miss.
2. **A finding that came back.** Reported fixed; a reviewer found it again. The fix hit the
   symptom, not the cause.
3. **Repeated manual work.** The same deterministic step done by hand several times is a
   missing tool.
4. **A wrong route.** A specialist used for a problem the task did not contain, or one
   missed that it did.

A task that went well teaches nothing that needs recording.

## Generalise, do not transcribe

> Correction: "No. It doesn't verify the failure branch."
> Bad: "Check failure branch."
> Good: "A test must demonstrate the intended failure branch, not merely execute the
> surrounding happy path."

Worked example: an agent counted a defect pattern in the source files, got zero, and
reported the issue closed. A reviewer found 68 instances in the generated reports.
Verbatim lesson: "grep the reports". Generalised: **count what the reviewer reads; a
generated document can contain rows the source does not.**

## Where a lesson lands

| Kind | Where |
|---|---|
| one-off accident | nowhere |
| true of this project | `memory/lessons.md`, scoped to the project |
| true of any project | `memory/lessons.md`, unscoped |
| enforceable by a script | a check in the host's tooling, plus the lesson that motivated it |

## Promotion needs recurrence

One occurrence is a candidate in `memory/corrections.md`. A second occurrence promotes it
to `memory/lessons.md` as a principle that applies to any task, logged in
`evaluation/versions.md`, and the user is told in one line.

## Do not store

- whole conversations or transcripts
- anything already in the repository (code structure, history, its docs)
- anything true only of one conversation
- a lesson you cannot state in two sentences
