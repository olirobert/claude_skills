---
name: do-next-plan-step
description: Implements the next step (or the one already in progress) of the current plan, without committing. Use when the user asks to do, work on, or implement the next plan step.
---

# Do Plan Step

Implements one step of the plan currently in progress.

## Behavior

Fail if `.plan/current-plan.md` does not exist (see the `start-plan` skill
for its location and schema).

If `step_in_progress` is already set, stop and tell the user a step is
already in progress. Don't finalize it and don't invoke the
`finalize-plan-step` skill — the user must run that themselves first.

Otherwise, determine the step to work on:
- if `step_in_progress` and `last_step_done` are both empty: use the first
  step of the plan
- if `step_in_progress` is empty but `last_step_done` is set: use the step
  following it
- if `last_step_done` is the plan's final step (there is no next step):
  report to the user that the plan is already fully completed, and stop —
  do not touch `current-plan.md`

Update `current-plan.md`'s `step_in_progress` to the step determined above,
and tell the user what the new step in progress is.

Then implement that step, per its section in the plan file referenced by
`plan_file` (plan format: see the `prepare-plan` skill).

Don't commit the changes made by the implementation. Do one step at a time.
Once the implementation is done, stop — don't finalize the step and don't
invoke the `finalize-plan-step` skill. The user must run that themselves.
