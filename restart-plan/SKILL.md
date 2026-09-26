---
name: restart-plan
description: Resets progress tracking on the current plan without changing which plan file is active. Use when the user asks to restart, reset, or redo progress on the current plan.
---

# Restart Plan

Resets progress tracking on the plan currently in progress, without
changing which plan file is active.

## Behavior

Fail if `.plan/current-plan.md` does not exist (see the `start-plan` skill
for its location and schema).

Otherwise, update `.plan/current-plan.md` to clear both `step_in_progress`
and `last_step_done` (i.e. no step in progress, no last step done).
`plan_file` is left unchanged.

In the plan file referenced by `current-plan.md`'s `plan_file` (plan
format: see the `prepare-plan` skill):
- flip all `## Progress` checklist entries to `[ ]`
- flip all steps' `**Status:**` markers to `[ ] Done`
