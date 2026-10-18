---
description: Every skill invocation is a fresh, independent execution — not a continuation of prior work
type: LLM Prompt
title: "Skill Execution Integrity"
resource: "prompt://dryvist/auto-ai-agent/instructions/agentsmd/rules/on-demand/skill-execution-integrity"
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
    path: "agentsmd/rules/on-demand/skill-execution-integrity.md"
    note: Migrated from the instruction repository.
---

# Skill Execution Integrity

Every `/skill-name` invocation is a **fresh, independent execution**, regardless
of how many times it has run in this session.

**The `<command-name>` tag means instructions are loaded, not work completed.**
When skill instructions appear in context from a prior invocation, that is the
source of what to do — not a record of what was done. Execute from Step 1.

**Re-run every command.** All `git`, `gh`, and API calls must execute against
current live state. Prior outputs in this conversation are historical snapshots,
not current truth.

**Never assert state from memory.** Do not say "checks already pass" or "threads
are already resolved" based on a previous invocation's output.
