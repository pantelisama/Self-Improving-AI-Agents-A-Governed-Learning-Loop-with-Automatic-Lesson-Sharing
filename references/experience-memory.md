# Experience memory

Two memories, never mixed:

| | Answers | Lives in |
|---|---|---|
| Project knowledge | what is true of the project | the repository and its docs |
| Experience | what the agent learned working on it | `memory/` |

## An entry carries

```yaml
id:          # C12 (candidate) or L4 (lesson)
title:
source:      # the human's words, if a human said them
observation: # what happened
root_cause:  # from reflection.md's cause table
principle:   # generalised, two sentences at most
action:      # what to do differently
evidence:    # file:line, a count, a link
recurrence:  # counted, not estimated
status:      # candidate | validated | active | superseded | deprecated | rejected
```

Entries stay readable prose with a heading; this is the set of facts, not a file format.

## States

```
candidate --recurs--> validated --used--> active
    |                                       |-- restated better --> superseded
    +-- contradicted --> rejected           +-- no longer applies --> deprecated
```

Rejected and deprecated entries are kept with a reason, so the same idea is not relearned
or re-proposed.

## Curate on write

- deduplicate: same observation twice is one entry with recurrence 2
- resolve contradictions instead of filing both
- deprecate an entry whose evidence no longer exists
