---
name: update-commit-metadata
description: Update the latest git commit metadata without changing files. Use when the user asks to rewrite, clean up, retitle, restructure, or update the latest commit message/body/trailers. Produces commit metadata with TLDR, WHAT CHANGED, and TEST PLAN sections, preserves accurate test results, syncs with main before pushing rewritten history, and pushes with force-with-lease when needed.
---

# Update Commit Metadata

Rewrite only the latest commit's message metadata. Do not change repo files.

## Workflow

1. Inspect:
   - `git status --short --branch`
   - `git log -1 --format=fuller`
   - `git show --stat --no-ext-diff --format=fuller HEAD`
2. Require a clean worktree before metadata-only changes.
   - If files are dirty, pause and ask whether to switch to `$amend` or leave them untouched.
3. Rewrite latest commit metadata:
   - Update title/body/trailers only.
   - Use `git commit --amend` with the revised message.
   - Do not invent tests; preserve known test results or mark unknown commands as not run only when accurate.
4. If the branch has an upstream or the user asks to push:
   - `git fetch origin main`
   - Sync with main using the safest appropriate rebase/merge path.
   - Push rewritten history with `git push --force-with-lease`.
   - Pause on conflicts, lease failures, or unsafe rewrite risk.

## Message Format

Use a concise subject line, then this exact body structure:

```text
TLDR

<1-3 sentence summary>

WHAT CHANGED

- <bullet>
- <bullet>

TEST PLAN

- PASS: `<command>` — <short result>
- FAIL: `<command>` — <short reason>
- BLOCKED: `<command>` — <short reason>
```

Rules:
- Use uppercase headers exactly: `TLDR`, `WHAT CHANGED`, `TEST PLAN`.
- Include test commands and results in `TEST PLAN`.
- Prefer repo-relative paths.
- Trim long external paths with an ellipsis while preserving useful tail context.
- Do not paste long command logs.

## Command Scope

Use only the minimal needed commands:
- Inspect: `git status`, `git log`, `git show`, `git branch`
- Rewrite metadata: `git commit --amend`
- Sync/push when needed: `git fetch`, `git rebase` or `git merge`, `git push --force-with-lease`

Do not stage files, edit files, or create PRs from this skill.
