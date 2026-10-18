---
type: LLM Prompt
title: "Permissions moved to nix-claude-code"
description: "Shared global agent instructions for Permissions moved to nix-claude-code."
resource: "prompt://dryvist/auto-ai-agent/instructions/agentsmd/permissions/MOVED"
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
    path: "agentsmd/permissions/MOVED.md"
    note: Migrated from the instruction repository.
---
# Permissions moved to nix-claude-code

The tool-agnostic permission data that used to live here (`allow/`, `ask/`,
`deny/`, `domains/`, plus `STRATEGY.md` and `valid-tools.json`) has been
**retired**. The single source of truth is now
[`dryvist/nix-claude-code` → `data/permissions/`](https://github.com/dryvist/nix-claude-code/tree/main/data/permissions)
(`allow.nix`, `ask.nix`, `deny.nix`, `domains.nix`, `tool-specific.nix`).

`nix-ai` reads that data via `nix-claude-code.lib.permissions` and the per-tool
formatters render it into Claude / Codex / Gemini / Copilot settings. Nothing in
this repo consumes permissions anymore.

**To change a permission**, edit the `.nix` data in
`nix-claude-code/data/permissions/` and open a PR there. The project is also
moving to an auto-mode classifier, where novel commands are governed by intent at
runtime rather than by a static allow-list. See
`dryvist/ai-assistant-instructions#680` for the full migration.

> Tombstone marker kept only so the old path resolves to a pointer. Safe to
> delete once no references remain.
