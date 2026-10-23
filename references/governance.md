# Governance

**The agent never changes how it works without a human.** Reflection produces a
recommendation; a person approves it; only then does anything change.

```
observation -> learning -> recommendation -> HUMAN REVIEW -> change -> evaluation -> version
```

| Change | Approval |
|---|---|
| record a correction (candidate) | no |
| promote a recurring correction to a lesson | no; automatic, logged, user told in one line |
| update a playbook after a job | no; logged, user told in one line |
| new or changed rule, check, agent definition, reference, SKILL.md | yes |
| installing anything | yes |

## A recommendation states

- what to change, and the observed problem it fixes
- recurrence (how many times) and the evidence
- how improvement will be measured, before and after
- how to roll it back

## Never

- weaken a check or a test to make something pass
- turn missing evidence into success
- invent facts, links or traceability
- alter the agent's own rules without approval
