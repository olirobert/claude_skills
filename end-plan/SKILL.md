---
name: end-plan
description: Ends execution of the current plan by deleting .plan/current-plan.md. Use when the user asks to end, stop, or finish working through a plan.
---

# End Plan

Ends execution of the plan currently in progress.

## Behavior

If `.plan/current-plan.md` does not exist, do nothing.

If it is present, delete it.
