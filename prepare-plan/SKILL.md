---
name: prepare-plan
description: Prepares a plan to implement a project or task described in a markdown file, saving the plan alongside the source file. Use when the user asks to plan, scope, or break down a project/task file into steps.
---

# Prepare Plan

Takes a markdown file describing a project or task (given as an argument) and produces a plan to implement it.

## Argument

The skill takes one argument: the path to a markdown file describing the
project or task to implement. This file is required — the skill has nothing
to act on without it.

## Output

The plan is saved alongside the provided project file, in the same
directory. Its filename is the project file's basename (without extension)
plus `-plan.md`. For example, an argument of `foo/bar-project.md` produces
`foo/bar-project-plan.md`.

If a file already exists at the resolved plan filename, confirm with the
user before overwriting it, matching the convention used by the
`finalize-draft` skill in this repo.

## Plan content

The plan consists of a numbered list of steps (`1.`, `2.`, `3.`, ...) to
implement the project, to be executed one at a time, in order — never in
parallel. Step numbers are integers only — no sub-numbering like `3.2`.

The plan must reference the source project file so a reader always knows
what it was generated from. This reference appears in an intro paragraph
before the progress checklist, e.g.:

```
Implements `<project file>` (design doc, read it first — this plan does not
repeat rationale, only concrete steps, file locations, and verification).
```

If the project describes a way to verify the work as a whole (a build, a
test command, etc.), name it in the intro so it's clear it should be re-run
after each step.

### Progress checklist

Immediately after the intro, include a flat `## Progress` checklist with one
line per step, so progress can be tracked at a glance:

```
## Progress

- [ ] 1. <short step title>
- [ ] 2. <short step title>
...
```

The first unchecked box is always the next step to work on. Flip a box to
`[x]` only when that step is fully done.

### Per-step sections

Each step gets its own `##`-level section titled `## <number>. <short step
title>` (matching the checklist entry), immediately followed by a status
marker:

```
## <number>. <short step title>

**Status:** [ ] Done
```

Flip the step's `**Status:**` marker to `[x] Done` in lockstep with its
checklist entry — both change together.

After the status marker, give the concrete detail needed to execute the
step: file path(s), the change itself (code block, description, or
sub-checklist), and any decisions or edge cases carried over from the
project file.

Where possible, close the step with a `**Verify:**` line or short list
describing how to confirm the step succeeded (a command to run, a behavior
to check, what should compile or pass). Not every step will have a
meaningful verification — omit it rather than inventing one.
