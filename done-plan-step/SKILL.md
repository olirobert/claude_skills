---
name: done-plan-step
description: Marks the in-progress plan step done in the plan file and current-plan.md, without committing any changes. Use when the user asks to mark the current plan step done without committing.
---

# Done Plan Step

Marks the plan step currently in progress as done, without committing any
changes, even if there are changes to commit.

## Behavior

Do not commit or stage any changes, regardless of whether the step's
implementation produced any.

In the plan file referenced by `current-plan.md`'s `plan_file` (plan
format: see the `prepare-plan` skill):
- flip the step's `## Progress` checklist entry to `[x]`
- flip the step's `**Status:**` marker to `[x] Done`

In `current-plan.md` (see the `start-plan` skill for its location and
schema):
- clear `step_in_progress`
- set `last_step_done` to the step just marked done

Report a short summary of what was marked done, and remind the user that
no changes were committed.
