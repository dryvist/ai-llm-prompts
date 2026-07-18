---
type: LLM Prompt
title: Claude research-first reminder
description: System message injected for implementation-oriented user prompts.
resource: prompt://dryvist/developer-tools/claude-research-reminder
tags: [claude-code, hook, research, scripts]
timestamp: 2026-07-18T16:43:26-04:00
status: active
consumers: [dryvist/claude-code-plugins]
render:
  engine: literal
  variables: []
  frontmatter: strip
source_history:
  - repository: dryvist/claude-code-plugins
    path: script-guards/scripts/research-reminder.sh
    commit: 1060914b291cbc14b1d1228585e31a23142acb89
---
Before implementing: check if a native tool, CLI, module, or existing function handles this. Use Context7 MCP for library docs. Check the direct-execution alternatives table. Script files are blocked by hooks unless placed in scripts/, hooks/, .github/, or tests/ directories.
