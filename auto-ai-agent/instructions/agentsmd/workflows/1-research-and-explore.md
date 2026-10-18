---
type: LLM Prompt
title: "Default: Research and Explore"
description: "Shared global agent instructions for Default: Research and Explore."
resource: "prompt://dryvist/auto-ai-agent/instructions/agentsmd/workflows/1-research-and-explore"
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
    path: "agentsmd/workflows/1-research-and-explore.md"
    note: Migrated from the instruction repository.
---
# Default: Research and Explore

**Goal**: Gather enough context to act correctly without filling the main context
window.

## Rules

- Use the smallest useful exploration pass.
- For delegated read-only sweeps, follow `model-delegation.md`.
- Ask only when the missing answer would materially change the outcome, safety,
  ownership, or reversibility.

## Key Activities

- Analyze the request and identify goals
- Explore relevant codebase areas
- Identify risks, dependencies, and unknowns
- State low-risk assumptions and proceed
