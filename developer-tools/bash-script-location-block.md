---
type: LLM Prompt Fragment
title: Bash script location block guidance
description: Model-visible denial reason for creating executable scripts outside approved directories.
resource: prompt://dryvist/developer-tools/bash-script-location-block
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
BLOCKED: Scripts must be placed in scripts/ directory.

Use the Write tool to create scripts in the appropriate directory (scripts/, hooks/, .github/, or tests/).
