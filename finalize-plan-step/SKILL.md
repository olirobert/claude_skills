---
name: finalize-plan-step
description: Commits the changes made by the in-progress plan step and marks it done in the plan file and current-plan.md. Use when the user asks to finalize, complete, or wrap up the current plan step.
---

# Finalize Plan Step

Commits the changes made by the plan step currently in progress, and marks
it done.

## Behavior

Commit the changes made by the step's implementation. Commit message:
- a one-line title
- a short description of why the change was done

Don't push the commit.

In the plan file referenced by `current-plan.md`'s `plan_file` (plan
format: see the `prepare-plan` skill):
- flip the step's `## Progress` checklist entry to `[x]`
- flip the step's `**Status:**` marker to `[x] Done`

In `current-plan.md` (see the `start-plan` skill for its location and
schema):
- clear `step_in_progress`
- set `last_step_done` to the step just finalized

Report a short summary of what was committed, and remind the user to run
`/clear` before starting the next step with `/do-next-plan-step`.
