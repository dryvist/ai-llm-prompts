---
type: LLM Prompt Fragment
title: Duplicate issue block guidance
description: Exit-code-2 guidance shown when a proposed issue or PR duplicates an open item.
resource: prompt://dryvist/developer-tools/duplicate-issue-block
tags: [claude-code, hook, github, guard]
timestamp: 2026-07-18T16:43:26-04:00
status: active
consumers: [dryvist/claude-code-plugins]
render:
  engine: application
  variables: [label, number, existing_title]
  frontmatter: strip
source_history:
  - repository: dryvist/claude-code-plugins
    path: content-guards/scripts/enforce-issue-limits.py
    commit: 1060914b291cbc14b1d1228585e31a23142acb89
---
BLOCKED: Duplicate ${label} detected

Your title matches existing #${number}: ${existing_title}

Ask the user before creating a duplicate ${label}.
