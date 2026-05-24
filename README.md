# Claude Skills

A collection of custom skills for [Claude Code](https://claude.com/claude-code).

## Installation

Clone this repository and symlink it to your Claude Code skills directory:

```bash
git clone https://github.com/mikec-git/claude-skills.git
ln -s /path/to/claude-skills ~/.claude/skills
```

## Available Skills

### skill-creator

A meta-skill for creating well-structured Claude Code skills. Supports guided and quick modes.

**Triggers:** "create a skill", "make a new skill", "how do I make a skill"

### blog-writer

A conversational blog writing assistant that gathers context before drafting, produces outlines for approval, and writes section by section.

**Triggers:** "help me write about...", "review my blog", "make this better", "revise my post"

### commit

Inspects Git changes, stages intended local repo files, runs focused tests, and creates a structured commit.

**Triggers:** "commit", "commit my changes", "/commit"

### update-commit-metadata

Updates the latest commit message metadata without changing files.

**Triggers:** "update commit metadata", "rewrite commit message", "retitle commit"

### amend

Amends the latest commit with local changes and pushes rewritten history safely when needed.

**Triggers:** "amend", "amend this", "fold this into the last commit"

### pr

Syncs with main, pushes the current branch, and creates or updates a GitHub pull request.

**Triggers:** "open a PR", "submit a PR", "push a PR", "/pr"

## Creating New Skills

Use the `skill-creator` skill to create new skills:

```
/skill-creator
```

## License

MIT
