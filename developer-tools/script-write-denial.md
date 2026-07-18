---
type: LLM Prompt Fragment
title: Script write denial guidance
description: Model-visible denial reason after the local script classifier rejects a new file.
resource: prompt://dryvist/developer-tools/script-write-denial
tags: [claude-code, hook, scripts, guard]
timestamp: 2026-07-18T16:43:26-04:00
status: active
consumers: [dryvist/claude-code-plugins]
render:
  engine: application
  variables: [file_path, reason]
  frontmatter: strip
source_history:
  - repository: dryvist/claude-code-plugins
    path: script-guards/scripts/write-script-guard.sh
    commit: 1060914b291cbc14b1d1228585e31a23142acb89
---
BLOCKED: Script creation at ${file_path} was denied.

Reason: ${reason}

Use existing tools, CLIs, or native patterns instead of creating new scripts. If this script is a legitimate committed artifact, place it in scripts/, hooks/, .github/, or tests/ directories.
