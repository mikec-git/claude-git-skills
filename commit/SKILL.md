---
name: commit
description: Create a scoped git commit from local repository changes and push it. Use when the user asks to commit, make a commit, save changes in git, create a checkpoint commit, or invokes /commit. Inspects changes first, stages intended local repo files, runs focused tests, writes a structured commit message with TLDR, WHAT CHANGED, and TEST PLAN sections, then pushes the current branch to its remote.
---

# Commit

Create one focused commit from the current repository state, then push it.

## Workflow

1. Inspect:
   - `git status --short --branch`
   - `git diff --stat`
   - `git diff`
   - `git diff --cached`
   - For untracked files, inspect names and contents enough to classify them.
2. Format:
   - Run the project's configured formatter on the changed files when one exists (e.g. `prettier`, `black` / `ruff`, `gofmt`, `rustfmt`, or a repo `format` / `lint:fix` script). Skip cleanly when no formatter is configured.
   - Re-check the diff after formatting so the commit reflects the formatted result.
3. Decide staging:
   - Stage intended local repo changes by default with `git add <paths>`.
   - Ask before staging files that appear unrelated, generated, secret-like, destructive, or ambiguous.
   - Do not stage files outside the repo.
4. Scan for sensitive content:
   - Review the staged diff for secrets, API keys, tokens, credentials, private URLs, device/machine identifiers, personal addresses, or other data that should not be committed.
   - If any is found, unstage or redact it and confirm before continuing; never commit secrets. Verify env files holding secrets are gitignored.
5. Archive specs if needed:
   - If the repo uses OpenSpec and a change is complete and validated, archive it before committing: `openspec archive <change-name> --yes`, then validate the updated specs and stage the archived change plus canonical spec updates.
   - Sanitize spec files of sensitive context before staging.
6. Verify:
   - Run focused relevant tests/checks for changed code.
   - If repo instructions require a full suite before commits, run it.
   - Record exact commands and PASS/FAIL/BLOCKED results.
7. Commit:
   - Use `git commit` only after staging and verification.
8. Push:
   - Push the current branch to its remote with `git push`.
   - If the branch has no upstream, set it: `git push -u origin <branch>`.
   - If the push is rejected as non-fast-forward, stop and report; do not force-push from this skill.
   - Report commit hash, the pushed branch and remote, staged files summary, and test results.

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
- Format: the project's configured formatter / format script
- Stage: `git add`
- Commit: `git commit`
- Push: `git push` (set upstream with `-u` when missing)
- Archive specs: `openspec archive <change-name> --yes` when an OpenSpec change is complete
- Verify: repo-specific test/build commands required by the change

Do not merge, rebase, amend, force-push, or create PRs from this skill.
