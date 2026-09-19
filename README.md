# Claude Skills

A collection of public [Claude Skills](https://docs.claude.com/en/docs/claude-code/skills) —
each one lives in its own top-level folder with a `SKILL.md` describing when
and how Claude should use it.

## Skills in this repo

| Skill | Description |
|---|---|
| [`do-next-plan-step`](./do-next-plan-step) | Implements the next step (or the one already in progress) of the current plan, without committing. |
| [`done-plan-step`](./done-plan-step) | Marks the in-progress plan step done in the plan file and `current-plan.md`, without committing any changes. |
| [`end-plan`](./end-plan) | Ends execution of the current plan by deleting `.plan/current-plan.md`. |
| [`finalize-draft`](./finalize-draft) | Turns a draft file into a finalized version by resolving naming and clarifying content ambiguity with the user. |
| [`finalize-plan-step`](./finalize-plan-step) | Commits the changes made by the in-progress plan step and marks it done in the plan file and `current-plan.md`. |
| [`prepare-plan`](./prepare-plan) | Prepares a plan to implement a project or task described in a markdown file, saving the plan alongside the source file. |
| [`restart-plan`](./restart-plan) | Resets progress tracking on the current plan without changing which plan file is active. |
| [`start-plan`](./start-plan) | Starts execution of a plan file by creating `.plan/current-plan.md` to track progress across skill calls. |

## Install

Clone this repo, then run the install script for your platform. With no
arguments it installs every skill; pass one or more names to install just
those.

### macOS / Linux / Git Bash on Windows

```sh
git clone <this-repo-url> claude-skills
cd claude-skills
./install.sh                # install every skill into ~/.claude/skills
./install.sh finalize-draft  # install a single skill
```

### Windows PowerShell

```powershell
git clone <this-repo-url> claude-skills
cd claude-skills
.\install.ps1
.\install.ps1 finalize-draft
```

### Install into a project instead of your user directory

By default skills are installed to `~/.claude/skills` (or `%USERPROFILE%\.claude\skills`
on Windows), which makes them available across all your projects. To scope a
skill to a single project instead, point the installer at that project's
`.claude/skills` directory:

```sh
./install.sh -t ./.claude/skills finalize-draft
```

```powershell
.\install.ps1 -Target .\.claude\skills finalize-draft
```

### Keep skills up to date

Pass `-l` / `-Link` to symlink instead of copy. Then `git pull` in this repo
updates every installed skill in place, no reinstall needed.

```sh
./install.sh -l
```

### Manual install

A skill is just a folder containing a `SKILL.md`. You can also install one by
hand: copy (or symlink) the folder into `~/.claude/skills/<skill-name>` for a
personal install, or `<project>/.claude/skills/<skill-name>` to scope it to one
project.
