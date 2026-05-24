---
name: amend
description: Amend the latest git commit with local repository changes. Use when the user asks to amend, fold changes into the previous commit, update the last commit, or amend and push. Inspects and stages intended local changes, runs focused tests, preserves or updates the structured commit message with TLDR, WHAT CHANGED, and TEST PLAN sections, syncs with main before pushing, and pushes rewritten history with force-with-lease when needed.
---

# Amend

Fold current local changes into the latest commit.

## Workflow

1. Inspect:
   - `git status --short --branch`
   - `git diff --stat`
   - `git diff`
   - `git diff --cached`
   - `git log -1 --format=fuller`
2. Decide staging:
   - Stage intended local repo changes by default with `git add <paths>`.
   - Ask before staging files that appear unrelated, generated, secret-like, destructive, or ambiguous.
3. Verify:
   - Run focused relevant tests/checks for changed code.
   - If repo instructions require a full suite before amend, run it.
   - Record exact commands and PASS/FAIL/BLOCKED results.
4. Amend:
   - Use `git commit --amend`.
   - Preserve the subject unless the user asks for a new one.
   - Ensure the body uses the required message format and updates `WHAT CHANGED` and `TEST PLAN`.
5. If the branch has an upstream or the user asks to push:
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
- Inspect: `git status`, `git diff`, `git log`, `git branch`
- Stage: `git add`
- Amend: `git commit --amend`
- Sync/push when needed: `git fetch`, `git rebase` or `git merge`, `git push --force-with-lease`
- Verify: repo-specific test/build commands required by the change

Do not create PRs from this skill.
