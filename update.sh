#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

git -C "$repo_dir" pull --ff-only
"$repo_dir/install.sh"

echo "Updated Claude git skills."
