---
type: LLM Prompt Fragment
title: "Issue Solver — Phases 1-4"
description: "Discover, triage, claim, and investigate steps for the issue-solver routine."
resource: "prompt://dryvist/automation/fragment-issue-solver-phases-1-4"
tags:
  - "automation"
  - "routine"
timestamp: "2026-07-18T16:40:00-04:00"
status: active
consumers:
  - "dryvist/claude-code-routines"
---
## Phase 1 — DISCOVER Linear (the only queue)

If `$LINEAR_API_KEY` is empty: emit Path E and exit.

Query the JAC team's Backlog + Todo issues, ordered by priority ascending (highest first), then createdAt ascending (oldest first):

```bash
jq -n '{
  query: "query { issues(filter: { state: { type: { in: [\"backlog\", \"unstarted\"] } }, team: { key: { eq: \"JAC\" } } }, orderBy: priority, first: 10) { nodes { identifier title description priority url gitBranchName createdAt updatedAt state { name type } labels { nodes { name } } assignee { id } } } }"
}' | curl -sS -X POST https://api.linear.app/graphql \
       -H "Authorization: Bearer $LINEAR_API_KEY" \
       -H "Content-Type: application/json" \
       --data @- \
   | jq '.data.issues.nodes' > /tmp/linear-candidates.json
```

If the response carries an `errors` array, abort Phase 1 and emit Path F (Linear API failure) with the error message, then exit.

Sort the 10 candidates by `(priority asc, createdAt asc)` and take the top 5. Filter out any candidate that already has a linked open PR (check via Linear's `attachments` field if needed, or scan PR titles in the candidate's referenced repo for the Linear identifier).

If zero candidates remain after filtering → exit with Path C (no eligible work today).

## Phase 2 — TRIAGE (Sonnet, ≤ 2k tokens, 4-axis)

For each of the top 5 Linear candidates, classify on these axes:

1. **Repo identifiability** — Does the description name a specific GitHub repo? Scan for `\b(dryvist)/[\w.-]+\b`. issue-solver operates only within `$GH_OWNER` — treat any repo whose owner resolves outside `$GH_OWNER`/`dryvist` (e.g. a personal-account repo) as repo_identifiable = NO. If exactly one in-scope repo is named with clear context → YES. If zero or ambiguously multiple → NO.

2. **Sandbox-feasibility** — Does the task require ONLY repo edits + `gh` API + Linear API? NO if the description mentions: hardware (BIOS, PXE, firmware, drives), physical access (rack, plug, console), SSH to a host, `tofu apply`, Terrakube, `ansible-playbook`, OpenBao credentials, DNS records, certificate issuance, Proxmox/PVE/iDRAC operations, network device config (UniFi, switch), live infra apply.

3. **Complexity** — `trivial` = ≤1 file ≤20 lines. `small` = 1–3 files ≤100 lines. `medium` = 4+ files OR architecture change. `large` = needs design. issue-solver accepts only trivial/small.

4. **Acceptance criteria** — Does the task description state concrete success conditions (e.g. "after this, X file should contain Y", "CI passes", "step Z completes without error")? If the criteria are vague ("clean this up", "make it better") → NO.

Output JSON per candidate:

```json
{
  "task": "JAC-123",
  "repo_identifiable": true,
  "sandbox_feasible": true,
  "complexity": "small",
  "has_acceptance_criteria": true,
  "approach": "single-line guard in src/foo.ts:42",
  "abandon_reason": ""
}
```

### Triage Gate (strict — no opt-in label exists at this layer, the gate IS the safety bar)

Pick the first candidate (in priority order) where ALL of: `repo_identifiable && sandbox_feasible && complexity ∈ {trivial, small} && has_acceptance_criteria`.

For each candidate that fails the gate: post a one-line skip comment to its Linear task explaining the first failed axis. Skip-comment format:

```text
issue-solver — 2026-05-30: skipped — <axis> fail (<one-line specific reason>). Will re-evaluate when the task is updated.
```

Cooldown via the state file: if a (taskId, "skipped") entry exists in `runs` with `date >= today − 7`, skip silently (no new comment) — the prior comment already explains.

If no candidate passes the gate → exit with Path B (triage rejected all candidates).

## Phase 3 — CLAIM

Update the chosen task's status to "In Progress" via `IssueUpdate` mutation, then post a comment marking the claim.

```bash
# Look up the "In Progress" stateId for the JAC team (cache for this run)
IN_PROGRESS_STATE_ID=$(jq -n '{query: "query { workflowStates(filter: { team: { key: { eq: \"JAC\" } }, name: { eq: \"In Progress\" } }) { nodes { id } } }"}' \
  | curl -sS -X POST https://api.linear.app/graphql \
         -H "Authorization: Bearer $LINEAR_API_KEY" \
         -H "Content-Type: application/json" \
         --data @- \
  | jq -r '.data.workflowStates.nodes[0].id')

# Save the original stateId for revert-on-abort
ORIGINAL_STATE_ID=<from candidate.state.id>

# Set status to In Progress
jq -n --arg id "$TASK_ID" --arg sid "$IN_PROGRESS_STATE_ID" '{
  query: "mutation($id: String!, $sid: String!) { issueUpdate(id: $id, input: { stateId: $sid }) { success } }",
  variables: { id: $id, sid: $sid }
}' | curl -sS -X POST https://api.linear.app/graphql \
       -H "Authorization: Bearer $LINEAR_API_KEY" \
       -H "Content-Type: application/json" \
       --data @-

# Post the claim comment
jq -n --arg id "$TASK_ID" --arg body "issue-solver — 2026-05-30: claimed. Workflow run: $GITHUB_SERVER_URL/$GITHUB_REPOSITORY/actions/runs/$GITHUB_RUN_ID" '{
  query: "mutation($id: String!, $body: String!) { commentCreate(input: { issueId: $id, body: $body }) { success } }",
  variables: { id: $id, body: $body }
}' | curl -sS -X POST https://api.linear.app/graphql \
       -H "Authorization: Bearer $LINEAR_API_KEY" \
       -H "Content-Type: application/json" \
       --data @-
```

Record `ORIGINAL_STATE_ID` in `/tmp/claim.json` so the abandon workflow can revert.

## Phase 4 — INVESTIGATE (Sonnet subagent, ≤ 5k tokens, read-only)

Dispatch a focused subagent (Task tool, `subagent_type: Explore`) with the chosen task + triage output. Subagent's job:

1. Read relevant files via `gh api repos/<owner>/<repo>/contents/<path>` (Contents API only — no clone, no local write).
2. Locate the exact line(s) that need changing.
3. Draft a unified diff with `before` and `after` snippets per file.
4. Return JSON:

   ```json
   {
     "files": [
       {"path": "src/foo.ts", "before": "...", "after": "...", "summary": "add null guard"}
     ],
     "diff": "<full unified diff>",
     "test_plan": "describe how to verify"
   }
   ```

If the subagent reports the task is actually unsolvable, out of scope, or would touch more than 3 files: ABANDON via the abandon workflow.

