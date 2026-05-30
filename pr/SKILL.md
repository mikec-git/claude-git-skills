---
name: pr
description: Commit local changes and create or update a GitHub pull request for the current branch. Use when the user asks to open, create, submit, update, or push a PR. Formats and secret-scans changed code, commits pending changes, archives OpenSpec changes when complete, syncs with main, pushes the current branch, and creates or updates a GitHub PR with TLDR, WHAT CHANGED, and TEST PLAN sections.
---

# PR

Commit the current work, then create or update a GitHub pull request for the current branch.

## Workflow

1. Inspect:
   - `git status --short --branch`
   - `git branch --show-current`
   - `git remote -v`
   - `git log --oneline --decorate -5`
   - `git diff` and `git diff --cached` to see pending work.
2. Require:
   - Current branch is not `main` or the repo's default branch. If it is, stop and ask the user to create a feature branch first.
   - `gh` is installed and authenticated.
3. Format:
   - Run the project's configured formatter on the changed files when one exists (e.g. `prettier`, `black` / `ruff`, `gofmt`, `rustfmt`, or a repo `format` / `lint:fix` script). Skip cleanly when no formatter is configured.
4. Commit pending changes:
   - Stage intended local repo changes with `git add <paths>`; ask before staging files that look unrelated, generated, secret-like, destructive, or ambiguous. Do not stage files outside the repo.
   - Scan the staged diff for secrets, API keys, tokens, credentials, private URLs, device/machine identifiers, personal addresses, or other data that should not leave local. Unstage or redact and confirm before continuing; never commit secrets.
   - If the repo uses OpenSpec and a change is complete and validated, archive it: `openspec archive <change-name> --yes`, validate the updated specs, sanitize spec files of sensitive context, and stage the result.
   - Run focused relevant tests/checks; record PASS/FAIL/BLOCKED results.
   - Commit with the structured message below. If there is nothing new to commit, proceed with the existing commits.
5. Sync before pushing:
   - `git fetch origin main`
   - Choose the safest appropriate strategy:
     - Rebase for simple or unpublished branches.
     - Merge `origin/main` for already-pushed/shared branches when safer.
   - Pause on conflicts or unsafe rewrite risk.
6. Push:
   - Push the current branch to origin.
   - If history was rewritten by an explicit prior amend/metadata step, use `git push --force-with-lease`; otherwise use normal `git push`.
7. Create or update the PR:
   - Use `gh pr view --json number,url,title,body,headRefName,baseRefName`.
   - If a PR exists, update it with `gh pr edit`.
   - If no PR exists, create one with `gh pr create --base main --head <branch>`.
   - Report the PR URL.

## PR Body Format

Use this exact structure:

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

- Inspect: `git status`, `git branch`, `git remote`, `git log`, `git diff`
- Format: the project's configured formatter / format script
- Stage/commit: `git add`, `git commit`
- Archive specs: `openspec archive <change-name> --yes` when an OpenSpec change is complete
- Sync/push: `git fetch`, `git rebase` or `git merge`, `git push`
- GitHub: `gh auth status`, `gh pr view`, `gh pr create`, `gh pr edit`

Do not merge PRs or amend unrelated history from this skill.
