---
name: claude-workstream
description: Use when Claude is acting as an implementation worker or parent/orchestrator in a manual git worktree workflow and needs clear startup, UI preview, verification, handoff, branch-commit, reviewer-subagent, and completed-worktree cleanup rules.
---

# Claude Workstream

<purpose>
Use this skill for Claude implementation sessions that are working in their own git worktree.
</purpose>

<startup>
1. Assume this session is already running in the intended worktree. Do not launch another Claude session.
2. Read applicable project instructions:
   - `CLAUDE.md`
   - `AGENTS.md` when present
   - shared project status or coordination docs named by those files
3. Confirm branch and worktree:
   - `git branch --show-current`
   - `git status --short --branch`
4. Implementation workers should be on a task branch such as `claude/<task>`, not `main`.
5. Update the shared Agent Board or equivalent status row before editing.
</startup>

<implementation>
- Keep edits scoped to the assigned task and owned files.
- Match the repo's existing patterns, components, utilities, and test style.
- Avoid redesigns, broad refactors, and unrelated cleanup unless the task requires them.
- Remove dead code and unused imports instead of leaving placeholders.
- Do not overwrite or revert changes made by other active agents.
- Commit only task-related files to the Claude task branch.
</implementation>

<ui_work>
For UI-visible work:

1. Start or reuse a dev server from the Claude worktree.
2. Use `$AGENT_DEV_PORT` if set; otherwise choose the first free port from `3001` upward. Reserve `3000` for `main`.
3. Open or report the local URL so the user can inspect before merge.
4. Include changed routes, visible states, and any known UI caveats in the handoff.
5. Verify key interactions after navigation, modals/drawers, collapsed states, and responsive layout when relevant.
</ui_work>

<verification>
Run the repository's relevant verification before handoff:

- typecheck for TypeScript/interface changes
- focused tests for behavior changes
- build for Next.js route or server/client changes
- browser smoke for UI interactions

If verification is skipped or blocked, state exactly why.
</verification>

<handoff>
Before finishing:

1. Inspect `git status --short`.
2. Update the shared handoff with:
   - branch/worktree
   - files changed
   - public interfaces changed
   - assumptions
   - verification
   - blockers
   - preview URL for UI work
3. Commit completed task changes to the Claude branch when the workflow expects worker commits.
4. Do not merge to `main`. Hand off to the parent/orchestrator so it can launch a fresh-context reviewer subagent.
</handoff>

<review_before_merge>
Do not merge a workstream directly after implementation. A fresh reviewer should inspect the branch first.

Fresh-context review means a separate reviewer subagent call from the parent/orchestrating session, not asking the user to start a manually cleared chat. If this session is the parent/orchestrator and subagents are available, launch the reviewer subagent after the worker handoff and before declaring the branch merge-ready. If this session is only the implementation worker, do not self-review; make the handoff explicit enough for the parent/orchestrator to launch the reviewer.

Use this reviewer prompt shape:

```text
You are reviewing branch `<branch>` for merge into `<base>` in `<worktree>`.

Review stance: read-only code review. Do not modify files, commit, merge, push, clean up worktrees, or edit coordination docs. Prioritize correctness bugs, regressions, missing or weak tests, scope creep, generated junk/secrets, and UI behavior that would block merge.

Task goal:
<goal>

Acceptance criteria:
<criteria>

Important user decisions / non-goals:
<decisions>

Expected scope / owned files:
<files or modules>

Please inspect the diff against `<base>` and run appropriate verification:
- git status --short --branch
- git diff --check <base>...HEAD
- <repo typecheck command>
- <repo test command>
- <repo build command when relevant>
- Browser/UI smoke when relevant, using a non-main port.

Review checklist:
1. Confirm the implementation satisfies every acceptance criterion.
2. Look for behavior regressions, edge cases, data loss, stale state, race conditions, and incorrect assumptions.
3. Check that tests cover meaningful behavior, not incidental implementation details.
4. Confirm verification commands pass, or explain exactly what could not be run.
5. Confirm changed files are within expected scope and no unrelated/generated/secrets files are included.
6. For UI work, verify relevant routes render, interactive states work, layout does not overlap, and the preview port/URL is documented.
7. For data/model/parser work, verify old and new data shapes are handled intentionally.
8. Check docs/status handoff when the project requires coordination updates.
9. Flag unnecessary complexity, dead code, duplicate logic, or fragile hardcoding if it creates real maintenance risk.
10. State whether the branch is safe to squash-merge.

Output format:
- Start with `VERDICT: approve` or `VERDICT: needs_changes`.
- List findings first, ordered by severity with file/line references.
- Include verification results.
- Include residual risks or test gaps, if any.
- If no blocking findings, say so clearly and say whether it is safe to squash-merge.
```

If the reviewer returns `needs_changes`, fix the blockers on the task branch and repeat review. If the reviewer returns `approve`, merge to `main` as one squash commit and do not include unrelated dirty files.
</review_before_merge>

<post_merge_cleanup>
After the squash merge is complete and verified on `main`, clean up completed task worktrees that are no longer needed for inspection.

1. Confirm the merged task branch and worktree are the ones being cleaned up.
2. Stop any dev server or agent session attached to that task worktree.
3. Check the task worktree is clean with `git -C <worktree> status --short --branch`.
4. Remove the completed task worktree with `git worktree remove <worktree>`.
5. Delete the completed task branch after the worktree is removed, for example `git branch -D <branch>`.
6. Update the shared Agent Board or handoff status to show the worktree/branch cleanup.

Do not remove dirty worktrees, `main`, unrelated branches, or worktrees owned by active agents. If cleanup safety is ambiguous, leave the worktree in place and call out the blocker.
</post_merge_cleanup>

<finish_response>
Final response should state:

- task status
- commit hash if committed
- verification run
- preview URL when relevant
- merged worktree/branch cleanup when performed
- blockers or unresolved risks
</finish_response>
