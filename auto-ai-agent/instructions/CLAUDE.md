---
type: LLM Prompt
title: "AI Agents Configuration"
description: "Shared global agent instructions for AI Agents Configuration."
resource: "prompt://dryvist/auto-ai-agent/instructions/CLAUDE"
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
    path: "CLAUDE.md"
    note: Migrated from the instruction repository.
---
# AI Agents Configuration

Canonical agent instructions live in [AGENTS.md](AGENTS.md) and `agentsmd/rules/`.
Nix-managed machines auto-load both globally via
[nix-ai](https://github.com/dryvist/nix-ai), so this file deliberately does not
re-import them — doing so would load every byte twice in each session.
Non-Nix contributors: read `AGENTS.md` once before making changes.
