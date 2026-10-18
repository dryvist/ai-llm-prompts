---
type: LLM Prompt
title: "AI Agents Configuration"
description: "Shared global agent instructions for AI Agents Configuration."
resource: "prompt://dryvist/auto-ai-agent/instructions/AGENTS"
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
    path: "AGENTS.md"
    note: Migrated from the instruction repository.
---
# AI Agents Configuration

## Coding behavior

Identity and posture: `soul.md`. Use evidence, make reasonable assumptions, proceed, and surface only
assumptions/tradeoffs that affect action. Ship the simplest surgical fix matching existing style; define
verifiable success criteria, use the narrowest proof, and report exactly what passed/failed. Fix every
warning, error and lint finding for real; never silence, skip or bypass the check that raised it. Deep
design/review/refactor work: `karpathy-guidelines` skill (`andrej-karpathy-skills`).

Tool choice — **no new custom scripts** (custom code is permanent maintenance). Before writing or extending one, stop at
the first rung that works: (1) existing flags, config, or an installed skill, command, plugin or MCP server; (2) a
native feature of the platform or tool; (3) a maintained third-party tool; (4) community content: Ansible
collections, Terraform modules, Renovate presets, pre-commit hooks, Actions; (5) prior art: `/github-code-search`
(thousands of hits means idiomatic, three means a mistake), context7, package/Terraform/Hugging Face registries; (6) a
formal gap: a standardized public repo that fits our use case. Only then write code, naming why each rung failed.
Delete or replace an existing script before editing it.

Git workflow: never edit on the default branch — `/refresh-repo`, then a new worktree. `develop` default branch →
[git-flow](agentsmd/rules/on-demand/git-flow.md): PRs target `develop` (squash-merge), `develop` → `main` by
merge commit only. Otherwise trunk flow. Always **atomic commits**, one fix/feature/section per commit. Load
the on-demand rule for the activity — `rule-tiers.md` is the index. Behavior changes to instructions are
`feat:`/`fix:`, never `docs:` (docs commits never release).

Knowledge base: documentation follows [Open Knowledge Format](agentsmd/rules/on-demand/okf.md) — search before
editing, capture new durable knowledge after a change.

## Where things get written (routing law, no exceptions)

Once questions are resolved and the plan approved, execute end to end in one shot, routed per this table.
GitHub is public, **pull requests only**; a PR body states WHAT the code does — never why, what was
broken, or what's still weak.

| Content | Destination |
| --- | --- |
| Incidents, outages, security findings, weaknesses | Zammad |
| Private documentation, especially secret management | the private docs site |
| Everything else, including side quests and follow-ups | Vikunja — **never a GitHub issue** |

Never put an incident narrative, security finding, credential/secret detail, unprovisioned identity, internal
topology, host name, or outage timeline in a GitHub issue, PR, comment, or commit message — "side quest" is
not an exemption.

Repo boundaries: `dryvist/ai-assistant-instructions` (rules, `AGENTS.md`, workflows),
`dryvist/nix-claude-code` `data/permissions` (tool permissions), `dryvist/claude-code-plugins` (commands,
skills, agents, hooks). Update the private docs site in the same session; most changes need it.

**Delegation (binding).** Session start reports `codex-quota`. While it exits 0, every delegate runs on Codex, newest
Luna, xhigh (scouting, reads, triage, review, implementation); never Haiku. Architecture, security and planning
judgment → Sonnet latest (Opus latest only when truly needed). Codex exhausted: public-repo code, implementation and
review → ZCode → Haiku; everything else → Haiku; ZCode takes nothing else. Never cap the number of delegates; run all
ready work in parallel and hold back only while machine load is above 80%. The `jpe-ai-delegation` router enforces
this; brief per `brief-delegates`; details in `model-delegation.md`.
For bounded, routine subtasks, call `~/.agents/skills/fast-subagent/scripts/fast-subagent.sh` with `LLM_ROUTER_URL` and
`FAST_SUBAGENT_MODEL`; retain consequential judgment and decisions here.
