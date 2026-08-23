#!/usr/bin/env bash
# Installs skills from this repo into a Claude skills directory.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
LINK=false
SKILLS=()

usage() {
  cat <<EOF
Usage: ./install.sh [options] [skill-name ...]

Installs skills from this repo into your Claude skills directory.
With no skill names, installs every skill found in this repo.

Options:
  -t, --target <dir>   Install target directory (default: \$HOME/.claude/skills,
                        or \$CLAUDE_SKILLS_DIR if set)
  -l, --link            Symlink skills instead of copying (lets 'git pull'
                        update every installed skill at once)
  -h, --help            Show this help

Examples:
  ./install.sh                                   # install every skill
  ./install.sh hello-skill                        # install just one skill
  ./install.sh -l                                 # symlink all skills
  ./install.sh -t ./.claude/skills hello-skill    # install into a project
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -t|--target) TARGET_DIR="$2"; shift 2 ;;
    -l|--link) LINK=true; shift ;;
    -h|--help) usage; exit 0 ;;
    *) SKILLS+=("$1"); shift ;;
  esac
done

mkdir -p "$TARGET_DIR"

is_skill_dir() {
  [[ -f "$1/SKILL.md" ]]
}

if [[ ${#SKILLS[@]} -eq 0 ]]; then
  for d in "$REPO_ROOT"/*/; do
    name="$(basename "$d")"
    is_skill_dir "$d" && SKILLS+=("$name")
  done
fi

if [[ ${#SKILLS[@]} -eq 0 ]]; then
  echo "No skills found in $REPO_ROOT" >&2
  exit 1
fi

for name in "${SKILLS[@]}"; do
  src="$REPO_ROOT/$name"
  if ! is_skill_dir "$src"; then
    echo "Skipping '$name': no SKILL.md found at $src" >&2
    continue
  fi
  dest="$TARGET_DIR/$name"
  rm -rf "$dest"
  if $LINK; then
    ln -s "$src" "$dest"
    echo "Linked    $name -> $dest"
  else
    cp -r "$src" "$dest"
    echo "Installed $name -> $dest"
  fi
done
