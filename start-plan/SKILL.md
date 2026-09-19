---
name: start-plan
description: Starts execution of a plan file by creating .plan/current-plan.md to track progress across skill calls. Use when the user asks to start, begin, or kick off working through a plan file.
---

# Start Plan

Begins execution of a plan file, given as an argument, by setting up the
`.plan/current-plan.md` exchange file used to track progress across the
`start-plan`, `restart-plan`, `end-plan`, `do-next-plan-step`, and
`finalize-plan-step` skills.

## Argument

One argument: the path to the plan file to execute.

## The exchange file

`.plan/current-plan.md` stores state shared between skill calls. It is a
markdown file with a YAML frontmatter block holding the state; the body is
left empty.

```yaml
---
plan_file: <path of current plan file>
step_in_progress: <step number, or empty>
last_step_done: <step number, or empty>
---
```

- `plan_file`: path of the plan file currently being executed.
- `step_in_progress`: number of the step currently being worked on; empty if
  none.
- `last_step_done`: number of the last step that was completed; empty if
  none.

The referenced plan file follows the format produced by the `prepare-plan`
skill: a `## Progress` checklist (`- [ ] N. <title>`) plus one `## N. <title>`
section per step, each with a `**Status:** [ ] Done` marker that flips to
`[x] Done` when finished.

## Behavior

If `.plan/current-plan.md` already exists, a plan is already in progress —
ask the user to confirm they want to start a new plan.
- If confirmed: overwrite `current-plan.md` — set `plan_file` to the new
  argument, and clear both `step_in_progress` and `last_step_done`.
- If not confirmed: cancel the skill and leave the existing state untouched.

Otherwise (no plan currently in progress):
- create the `.plan` folder if it doesn't exist
- create `.plan/current-plan.md` with `plan_file` set to the given argument
  and both `step_in_progress` and `last_step_done` left empty
