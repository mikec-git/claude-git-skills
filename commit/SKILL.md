---
name: commit
description: Create a scoped git commit from local repository changes. Use when the user asks to commit, make a commit, save changes in git, create a checkpoint commit, or invokes /commit. Inspects changes first, stages intended local repo files, runs focused tests, and writes a structured commit message with TLDR, WHAT CHANGED, and TEST PLAN sections. Does not push.
---

# Commit

Create one focused commit from the current repository state.

## Workflow

1. Inspect:
   - `git status --short --branch`
   - `git diff --stat`
   - `git diff`
   - `git diff --cached`
   - For untracked files, inspect names and contents enough to classify them.
2. Decide staging:
   - Stage intended local repo changes by default with `git add <paths>`.
   - Ask before staging files that appear unrelated, generated, secret-like, destructive, or ambiguous.
   - Do not stage files outside the repo.
3. Verify:
   - Run focused relevant tests/checks for changed code.
   - If repo instructions require a full suite before commits, run it.
   - Record exact commands and PASS/FAIL/BLOCKED results.
4. Commit:
   - Use `git commit` only after staging and verification.
   - Do not push.
   - Report commit hash, staged files summary, and test results.

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
- Trim long external paths with an ellipsis while preserving useful tail context, for example `…/Resources/Claude/skills/commit/SKILL.md`.
- Do not paste long command logs.

## Command Scope

Use only the minimal needed commands:
- Inspect: `git status`, `git diff`, `git log`
- Stage: `git add`
- Commit: `git commit`
- Verify: repo-specific test/build commands required by the change

Do not push, merge, rebase, amend, or create PRs from this skill.
