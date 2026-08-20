---
type: LLM Prompt Fragment
title: "Issue Solver — Phases 5-8, Abandon, Run Output"
description: "Implement, verify, submit, and Linear-status steps for the issue-solver routine, plus its abandon workflow and run-output templates."
resource: "prompt://dryvist/automation/fragment-issue-solver-phases-5-8"
tags:
  - "automation"
  - "routine"
timestamp: "2026-07-18T16:40:00-04:00"
status: active
consumers:
  - "dryvist/claude-code-routines"
---
## Phase 5 — IMPLEMENT (no LLM, pure tool calls, ≤ 1k tokens)

1. **Pre-flight secret scan** — for each file's `after` content, write it to a `/tmp/scratch.<sha>.<ext>` file with `Write`, then run `grep -P` against the path. Abort and abandon if any pattern matches:
   - `(?i)(api[_-]?key|secret|password|token)\s*[:=]\s*['"][^'"]+['"]`
   - `AKIA[0-9A-Z]{16}` (AWS access key)
   - `ghp_[A-Za-z0-9]{36}|github_pat_[A-Za-z0-9_]{82}` (GitHub PATs)
   - `eyJ[A-Za-z0-9_-]+\.eyJ[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+` (JWT)
   - `lin_api_[A-Za-z0-9]+` (Linear API key)

2. **Get the target repo's default branch SHA**:

   ```bash
   BASE_SHA=$(gh api repos/<owner>/<repo>/git/ref/heads/main --jq '.object.sha')
   ```

3. **Create the branch.** Use Linear's pre-generated `gitBranchName` field from the
   candidate (format: `jacobpevans/jac-<NNN>-<slug>`). Do not invent your own naming.

   ```bash
   gh api repos/<owner>/<repo>/git/refs -X POST \
     -f ref="refs/heads/<branch>" \
     -f sha="$BASE_SHA"
   ```

4. **Land all files in one signed bot commit via `createCommitOnBranch`.** Build the `input` object in two steps: (1) walk every `(path, scratch-file)` row from Phase 4 and base64-encode each file body (strip line wraps with `tr -d '\n'`); (2) assemble the full request body with `jq -n` and pipe it to `gh api graphql --input -`. `additions` is the full file list; `deletions` is empty unless the diff removes files outright.

   ```bash
   ADDITIONS='[]'
   while IFS= read -r row; do
     P=$(jq -r '.path'    <<<"$row")
     S=$(jq -r '.scratch' <<<"$row")
     B64=$(base64 < "$S" | tr -d '\n')
     ADDITIONS=$(jq --arg p "$P" --arg c "$B64" '. + [{path:$p, contents:$c}]' <<<"$ADDITIONS")
   done < <(jq -c '.[]' <<<"$FILES_JSON")

   jq -n \
     --arg repo "<owner>/<repo>" \
     --arg branch "<branch>" \
     --arg base "$BASE_SHA" \
     --arg headline "<conventional-commit type>: <one-line summary> [issue-solver-$(date +%Y-%m-%d)]" \
     --argjson additions "$ADDITIONS" \
     '{
        query: "mutation($input: CreateCommitOnBranchInput!) { createCommitOnBranch(input: $input) { commit { oid url } } }",
        variables: {
          input: {
            branch: { repositoryNameWithOwner: $repo, branchName: $branch },
            expectedHeadOid: $base,
            message: { headline: $headline },
            fileChanges: { additions: $additions, deletions: [] }
          }
        }
      }' \
   | gh api graphql --input -
   ```

   `expectedHeadOid`: parent commit SHA the mutation expects the branch to currently point at. Right after branch creation that's `BASE_SHA`. If the call fails with a mismatch, refetch the branch tip via `gh api repos/<owner>/<repo>/git/ref/heads/<branch> --jq '.object.sha'` and retry once.

5. **Verify the response** by extracting `data.createCommitOnBranch.commit.oid`. If the response carries an `errors` array or `data.createCommitOnBranch` is null, abort and abandon — do NOT fall back to the Contents API.

## Phase 6 — VERIFY (best-effort, ≤ 2k tokens)

If the repo has CI workflows under `.github/workflows/`, poll briefly:

```bash
gh api repos/<owner>/<repo>/commits/<head-sha>/check-runs \
  --jq '.check_runs[] | {name, status, conclusion}'
```

Poll every 30 seconds for up to 5 minutes (max 10 polls). Capture the outcome:

- All checks `success` or no checks defined → `ci_status=passed` (or `ci_status=none`).
- Any check `failure` or `cancelled` → `ci_status=failed`. Flip the PR title to `<type>: <summary> [CI failing — needs human]`. Continue to Phase 7 (still open the PR so it's discoverable) with a CI-failure note in the body. Also post a Linear comment flagging the failure.
- Still pending after 5 minutes → `ci_status=pending`. Continue to Phase 7 with a "CI pending — re-check later" note.

## Phase 7 — SUBMIT (≤ 1k tokens)

Open the PR ready-for-review (NOT draft):

```bash
gh pr create --repo <owner>/<repo> \
  --head <branch> \
  --base main \
  --title "<conventional-commit type>: <one-line summary> [routine:issue-solver]" \
  --body-file pr-body.md \
  --label cloud-routine
```

Also add label `linear-driven` (create with `gh label create` first if missing).

PR body template (`pr-body.md`):

```markdown
Closes <linear-url>

## Problem

<quoted from task description, trimmed to first 200 words>

## Approach

<from Phase 2 triage `approach` field>

## Files changed

- `<path>` — <one-line summary>

## CI status

[passed | failed | pending | none] — <link to checks if available>

## Self-review

This PR was drafted by issue-solver running in GitHub Actions. The commit is made via the GraphQL `createCommitOnBranch` mutation with a `dryvist-claude` App installation token — GitHub auto-signs the commit and attributes it to `dryvist-claude[bot]`. The prompt's Hard Rules forbid dependency changes, infra/workflow edits without the matching label, and secret-pattern matches in any payload.

issue-solver scoped to a single task this run. If CI is green, this PR is ready for human approval — no further AI work needed.

---

Generated by issue-solver — prompt source: `$PROMPT_SOURCE_URL`
```

## Phase 8 — UPDATE Linear status

After PR is open and `pr_url` captured:

```bash
# Look up the "In Review" stateId for the JAC team
IN_REVIEW_STATE_ID=$(jq -n '{query: "query { workflowStates(filter: { team: { key: { eq: \"JAC\" } }, name: { eq: \"In Review\" } }) { nodes { id } } }"}' \
  | curl -sS -X POST https://api.linear.app/graphql \
         -H "Authorization: Bearer $LINEAR_API_KEY" \
         -H "Content-Type: application/json" \
         --data @- \
  | jq -r '.data.workflowStates.nodes[0].id')

# Update status
jq -n --arg id "$TASK_ID" --arg sid "$IN_REVIEW_STATE_ID" '{
  query: "mutation($id: String!, $sid: String!) { issueUpdate(id: $id, input: { stateId: $sid }) { success } }",
  variables: { id: $id, sid: $sid }
}' | curl -sS -X POST https://api.linear.app/graphql \
       -H "Authorization: Bearer $LINEAR_API_KEY" \
       -H "Content-Type: application/json" \
       --data @-

# Post the PR-link comment
jq -n --arg id "$TASK_ID" --arg body "issue-solver — 2026-05-30: PR opened — $PR_URL (CI: $CI_STATUS)" '{
  query: "mutation($id: String!, $body: String!) { commentCreate(input: { issueId: $id, body: $body }) { success } }",
  variables: { id: $id, body: $body }
}' | curl -sS -X POST https://api.linear.app/graphql \
       -H "Authorization: Bearer $LINEAR_API_KEY" \
       -H "Content-Type: application/json" \
       --data @-
```

Append `{"source": "linear", "task": "<id>", "date": "<today>", "outcome": "drafted_pr", "pr_url": "<url>"}` to the state file's `runs` array (optimistic-lock PUT per the State file section).

## Abandon Workflow (when any phase decides to stop)

1. **Revert Linear status.** If Phase 3 (CLAIM) ran successfully, revert the task's status to `ORIGINAL_STATE_ID` (saved in `/tmp/claim.json`). This is non-negotiable — never leave a task stuck "In Progress." If the revert API call fails, retry once; if it still fails, emit a Slack alert (or stdout warning) with the task identifier and exit with non-zero status.

2. **Comment on the Linear task** (one-shot — check for an existing Solver comment in the last 7 days; do not duplicate):

   ```text
   issue-solver — 2026-05-30: stopped at <phase>.

   Reason: <one-line reason>

   Human review needed. issue-solver will not retry this task for 7 days.
   ```

3. **Update the state file** with the matching `abandoned_*` outcome and a `reason` field.

4. **Print abandon message** (Path D below) to stdout.

## Run Output

Print exactly one of the templates below to stdout per run. Never exit silently.

### Path A: PR drafted (happy path)

```text
issue-solver — [date]

Source: linear
Task: [JAC-NNN — title]
Triage: [complexity], [estimated_files] file(s)

Actions:
- PR: [PR URL]
- CI: [passed | failed | pending | none]
- Files: [comma-separated paths]
- Linear status: [In Progress → In Review]
```

### Path B: Abandoned at triage (no candidate passed gate)

```text
issue-solver — [date]

Status: triage rejected all candidates
Queue: linear ([N] candidates, JAC team)
Top rejections:
- [JAC-NNN] — [failed axis]
- [JAC-MMM] — [failed axis]
```

### Path C: No-op (no candidates surfaced from discovery)

```text
issue-solver — [date]

Status: no eligible work today
Linear queue: [N] Backlog/Todo tasks (JAC team), [M] qualifying after PR-link filter
```

### Path D: Abandoned mid-flight (investigate / implement / verify failed)

```text
issue-solver — [date]

Source: linear
Task: [JAC-NNN] — [title]
Phase reached: [investigate | implement | verify]
Reason: [one-line reason]

Task commented; Linear status reverted to [original]. Will not retry for 7 days.
```

### Path E: Linear unconfigured

```text
issue-solver — [date]

Status: Linear API key not provided — no queue to work
(GitHub issues are handled by ai-workflows' cc-issue-resolver, not issue-solver.)

Action: configure `LINEAR_API_KEY` in workflow secrets to enable the Linear queue.
```

### Path F: Linear API failure

```text
issue-solver — [date]

Status: Linear API call failed (Phase 1 discovery) — no work this run
Error: [first 200 chars of error message]

Action: verify `LINEAR_API_KEY` is valid and has read access to JAC team.
```
