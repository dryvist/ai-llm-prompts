---
type: LLM Prompt Fragment
title: Bash script redirect block guidance
description: Model-visible denial reason for creating script files with Bash redirects.
resource: prompt://dryvist/developer-tools/bash-script-redirect-block
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
BLOCKED: Use the Write tool for file creation, not Bash redirects.

The Write tool provides proper file creation with atomic writes. Bash redirects to script files are not allowed.
