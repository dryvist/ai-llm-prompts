---
name: model-delegation
description: Routing rules for delegated work across Codex, Claude, and the model router
type: LLM Prompt
title: "Model delegation"
resource: "prompt://dryvist/auto-ai-agent/instructions/agentsmd/rules/on-demand/model-delegation"
tags:
  - shared-instructions
  - agent-instructions
timestamp: "2026-10-24T08:56:24-04:00"
status: active
consumers:
  - dryvist/nix-ai
  - dryvist/nix-claude-code
render: { engine: literal, variables: [], frontmatter: strip }
source_history:
  - repository: dryvist/ai-assistant-instructions
    path: "agentsmd/rules/on-demand/model-delegation.md"
    note: Migrated from the instruction repository.
---

# Model delegation

Canonical doctrine and routing: `prompt://dryvist/auto-ai-agent/model-delegation`.

Session start reports `codex-quota`. Delegate through the harness Agent tool; while `codex-quota` exits 0,
the delegation hook sends the task to Codex. Confirm in the delegate log that it ran on a Codex model,
never Haiku. The agent hook denies `codex exec` from a tool shell unless stdin comes from a prompt file.

Architecture, security and planning judgment route to latest Sonnet (latest Opus only when truly needed). When Codex
is exhausted, public-repo code, implementation and review route to ZCode, then Haiku; everything else routes to Haiku.

When a runtime must call the Codex CLI directly (sandbox entrypoints or the router itself), pass the prompt as `-`
with finite stdin, or as a positional argument with stdin closed (`</dev/null`); always set `-o <file>`. Treat a
non-zero exit or empty final message as failure and surface it.

A delegate returns its result in the final message: one line (`STATUS|ITEM|REASON`) or a schema. Read-only delegates
never get a report-file contract. Background work is complete only after its result is retrieved and checked; a job ID
is not a result.

## When a Codex worker is blocked

Routed workers run `workspace-write` (`read-only` for Explore, Plan and advisory work), with no credential
store and no keychain. That is the default; keep it. A worker that hits a wall stops with
`BLOCKED|NEED <kind>|<detail>` and never works around it. The lead re-runs that step as a direct Codex run, widened
only for the named blocker:

```sh
( export GH_TOKEN="$(<mint a 1 h token for one repo; print only the token>)" GITHUB_TOKEN="$GH_TOKEN"
  codex exec -s workspace-write -C <worktree> --add-dir <path> \
    -c shell_environment_policy.ignore_default_excludes=true -o <out> - < <brief.md> )
```

| Blocker | Lead adds |
| --- | --- |
| Write outside the working directory (another repo, a worktree's `.git`, the scratchpad) | `-C <worktree>` and one `--add-dir` per directory |
| GitHub fetch, push or API | `GH_TOKEN` and `GITHUB_TOKEN` minted for that one repo in the subshell, plus `ignore_default_excludes=true`, because Codex strips `*TOKEN*` variables by default |
| Another internal service | One short-lived, narrowly scoped credential in one variable, minted the same way. Writes to trackers and incidents stay with the lead's own tools |
| A blocked network domain | The proxy allowlist in nix config, not a per-run flag |
| Everything else | `-s danger-full-access` only after the operator approves it for this step |

Mint outside the worker: the subshell holds only the minted value, never the secret-zero environment. Never put a
token on the command line or in the brief, which `ps` and transcripts show. The worker never runs the credential
store CLI.

## Parallelism

Codex delegates have no fixed limit. Before a large fan-out, read CPU and memory; hold back only while machine load
is above 80%. Batch many small, related tasks into one Agent brief when practical.

## Fable is a main-session planning model only

No Fable subagents.

## Skills

Procedures ship as skills in the `ai-delegation` and `jpe-ai-delegation` plugins of the
[`claude-code-plugins`](https://github.com/JacobPEvans/claude-code-plugins) marketplace, not here:

- `delegate-to-ai` — classify the task, keep sensitive content from third parties, verify the exact result.
- `delegation-ladder` (`jpe-ai-delegation`) — routing eligibility and trusted draft-PR verification.
- `local-subagents` — when a handoff is worth it, the live model menu, and where to place the call.
- `openrouter-models` — the spend budget, the free-tier logging caveat, and requesting a model the router lacks.

None depends on Claude Code. The plugin copy is the only authored one; a harness adopting a skill deletes its local copy in the same change.

For bounded, routine subtasks, call `~/.agents/skills/fast-subagent/scripts/fast-subagent.sh` with `LLM_ROUTER_URL` and
`FAST_SUBAGENT_MODEL`; the lead keeps consequential judgment.
