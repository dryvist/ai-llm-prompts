---
type: LLM Prompt Fragment
title: Commit trailer normalization guidance
description: Model-visible notice emitted after enforcing the coding-assistants trailer specification.
resource: prompt://dryvist/developer-tools/commit-trailer-guidance
tags: [claude-code, hook, git, commit]
timestamp: 2026-07-18T16:43:26-04:00
status: active
consumers: [dryvist/claude-code-plugins]
render:
  engine: application
  variables: [reason_parts]
  frontmatter: strip
source_history:
  - repository: dryvist/claude-code-plugins
    path: git-guards/scripts/commit-trailer-guard.py
    commit: 1060914b291cbc14b1d1228585e31a23142acb89
---
kernel coding-assistants spec enforced (https://docs.kernel.org/process/coding-assistants.html): ${reason_parts}
