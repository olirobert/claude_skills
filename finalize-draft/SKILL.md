---
name: finalize-draft
description: Turns a draft file into a finalized version by resolving naming and clarifying content ambiguity with the user, one question at a time, until the result is self-sufficient for another agent to act on. Use when the user asks to finalize, complete, or clean up a draft file.
---

# Finalize Draft

Takes a draft file (given as an argument) and produces its finalized version.

## Step 1 — Determine the final filename

- If the draft filename ends in `_draft` or `-draft` (immediately before the
  extension, e.g. `notes_draft.md`, `spec-draft.txt`), strip that suffix and
  use the result as the final filename.
- Otherwise, ask the user for a name, suggesting `{name}_final` as the default
  (where `{name}` is the draft's filename without extension).
- If a file already exists at the resolved final filename, confirm with the
  user before overwriting it.
- The original draft file is left untouched — this skill only writes the new
  final file.

## Step 2 — Resolve content ambiguity

Read the draft fully before asking anything. The goal: another AI agent
should be able to pick up the final version and act on it (implement it,
summarize it, turn it into a deck, etc.) without needing to ask any
follow-up questions.

Look for:
- Explicit markers: `TODO`, `FIXME`, `[?]`, placeholders like `{...}` or `TBD`.
- Genuine gaps or contradictions found while reading — missing decisions,
  conflicting statements, unresolved options — even if not explicitly marked.

Prefer resolving what you can by inspecting the surrounding code/docs/repo
context yourself. Only ask the user about what you couldn't resolve that
way.

Ask one question at a time, and wait for the answer before asking the next.
Don't front-load a list of questions.

If the user can't answer a question ("I don't know," "doesn't matter," or
skips it), make a reasonable assumption yourself and note it explicitly
inline in the final document (e.g. "Assumption: ..."), then move on to the
next question instead of blocking.

## Step 3 — Write the final version

Once all ambiguity is either resolved or explicitly noted as an assumption,
write the finalized content to the final filename determined in Step 1. The
result should read as a complete, standalone document with no leftover
unresolved markers.
