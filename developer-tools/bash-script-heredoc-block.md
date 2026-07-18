---
type: LLM Prompt Fragment
title: Bash script heredoc block guidance
description: Model-visible denial reason for creating script files with heredocs.
resource: prompt://dryvist/developer-tools/bash-script-heredoc-block
tags: [claude-code, hook, bash, scripts]
timestamp: 2026-07-18T16:43:26-04:00
status: active
consumers: [dryvist/claude-code-plugins]
render:
  engine: literal
  variables: []
  frontmatter: strip
source_history:
  - repository: dryvist/claude-code-plugins
    path: script-guards/scripts/bash-script-guard.sh
    commit: 1060914b291cbc14b1d1228585e31a23142acb89
---
BLOCKED: Use the Write tool for file creation, not heredocs.

The Write tool provides proper file creation with atomic writes. Heredoc-based file creation via Bash is not allowed.
