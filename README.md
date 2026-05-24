# Claude Git Skills

[![Skills](https://img.shields.io/badge/Claude-Code%20skills-111827)](https://github.com/mikec-git/claude-git-skills)
[![GitHub](https://img.shields.io/badge/GitHub-workflows-24292f?logo=github)](https://github.com/mikec-git/claude-git-skills)
[![License](https://img.shields.io/badge/license-MIT-green)](#license)

Focused Git and GitHub workflow skills for [Claude Code](https://claude.com/claude-code).

These skills keep repository automation explicit and small: inspect changes, run relevant checks, write structured messages, sync with `main` before publishing, and avoid broad hidden behavior.

## Installation

Clone this repository and run the installer:

```bash
git clone https://github.com/mikec-git/claude-git-skills.git
cd claude-git-skills
./install.sh
```

The installer symlinks this repo to `~/.claude/skills`.

## Update

Pull the latest repo changes and repair the symlink:

```bash
cd claude-git-skills
./update.sh
```

## Available Skills

| Skill | Purpose |
| --- | --- |
| `commit` | Inspect local changes, stage intended files, run focused tests, and create a structured git commit. |
| `update-commit-metadata` | Update the latest commit message metadata without changing files. |
| `amend` | Amend the latest commit with local changes and push rewritten history safely when needed. |
| `pr` | Sync with `main`, push the current branch, and create or update a GitHub pull request. |

Each skill uses structured message bodies with `TLDR`, `WHAT CHANGED`, and `TEST PLAN` sections.

## Message Format

The commit and PR workflows use this body structure:

```text
TLDR

<1-3 sentence summary>

WHAT CHANGED

- <bullet>
- <bullet>

TEST PLAN

- PASS: `<command>` - <short result>
- FAIL: `<command>` - <short reason>
- BLOCKED: `<command>` - <short reason>
```

## Safety Model

- `commit` never pushes.
- `update-commit-metadata` changes commit metadata only.
- `amend` uses `--force-with-lease` when rewritten history must be pushed.
- `pr` requires committed changes on a non-main branch.
- Publishing workflows fetch and sync with `main` before pushing.

## Requirements

- Claude Code with local skills support.
- `git`.
- GitHub CLI `gh` for `pr`.

## License

MIT
