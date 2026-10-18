---
type: LLM Prompt
title: "Default: Implement and Verify"
description: "Shared global agent instructions for Default: Implement and Verify."
resource: "prompt://dryvist/auto-ai-agent/instructions/agentsmd/workflows/4-implement-and-verify"
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
    path: "agentsmd/workflows/4-implement-and-verify.md"
    note: Migrated from the instruction repository.
---
# Default: Implement and Verify

**Goal:** Make the smallest correct change and prove it.

## Rules

- Keep edits surgical and consistent with local style.
- Use structured parsers or project APIs when available.
- If the plan is wrong, revise it in place and continue.
- Delegate isolated implementation only when the result can be reviewed with a
  compact diff and evidence; follow `model-delegation.md` for routing.

## Tasks

1. Implement the smallest viable change.
2. Run the selected verification.
3. If verification fails, diagnose and fix when the fix is in scope.
4. If blocked, report the concrete blocker, evidence, and next required input.
