---
name: model-delegation
description: Routing rules for delegated work across Codex, Claude, and the model router
type: LLM Prompt
title: "Model delegation"
resource: "prompt://dryvist/auto-ai-agent/instructions/agentsmd/rules/on-demand/model-delegation"
tags:
  - shared-instructions
  - agent-instructions
timestamp: "2026-10-18T08:44:13-04:00"
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

Manual Codex run (the router covers `Agent` spawns only): `codex exec -m <slug> -c 'model_reasoning_effort="xhigh"'
-s <read-only|workspace-write> -o <out> - < brief.md`, in the background. `<slug>` is the listed `-luna` entry with the
lowest `priority` in `~/.codex/models_cache.json`; never write a version from memory.

## Parallelism

Codex jobs have no fixed limit. Before a large fan-out, read CPU and memory load. Send many small, related tasks to
one Codex session as a task list instead of separate `codex exec` calls.

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
