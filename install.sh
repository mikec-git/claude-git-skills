#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
skills_dir="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"

mkdir -p "$(dirname "$skills_dir")"

if [[ -e "$skills_dir" && ! -L "$skills_dir" ]]; then
  echo "Refusing to replace non-symlink path: $skills_dir" >&2
  echo "Move it aside, then rerun ./install.sh." >&2
  exit 1
fi

ln -sfn "$repo_dir" "$skills_dir"
echo "Linked $skills_dir -> $repo_dir"
echo "Installed Claude git skills."
