---
type: LLM Prompt
title: "Remote Commit Workflow (DECOMMISSIONED)"
description: "Shared global agent instructions for Remote Commit Workflow (DECOMMISSIONED)."
resource: "prompt://dryvist/auto-ai-agent/instructions/agentsmd/docs/remote-commit-workflow"
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
    path: "agentsmd/docs/remote-commit-workflow.md"
    note: Migrated from the instruction repository.
---
# Remote Commit Workflow (DECOMMISSIONED)

> This workflow is decommissioned. Use the official commit-push-pr plugin instead:
> <https://github.com/anthropics/claude-code/blob/main/plugins/commit-commands/commands/commit-push-pr.md>
>
> The `commit-commands` plugin (`/commit-push-pr`) handles committing, pushing, and
> PR creation with proper variable support.
>
> The `cat > /tmp/` and heredoc scripting patterns from the previous version are
> explicitly prohibited. See the tool-use rule.
