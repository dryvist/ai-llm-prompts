---
type: LLM Prompt Fragment
title: Git command caution template
description: Model-visible confirmation guidance for risky git operations.
resource: prompt://dryvist/developer-tools/git-command-caution
tags: [claude-code, hook, git, guard]
timestamp: 2026-07-18T16:43:26-04:00
status: active
consumers: [dryvist/claude-code-plugins]
render:
  engine: application
  variables: [risk, command]
  frontmatter: strip
source_history:
  - repository: dryvist/claude-code-plugins
    path: git-guards/scripts/git-permission-guard.py
    commit: 1060914b291cbc14b1d1228585e31a23142acb89
---
CAUTION: ${risk}
Command: ${command}
