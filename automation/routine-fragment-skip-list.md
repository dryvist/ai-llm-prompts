---
type: LLM Prompt Fragment
title: "Routine Skip List"
description: "Shared repository exclusions for cloud routines."
resource: "prompt://dryvist/automation/routine/skip-list"
tags:
  - "automation"
  - "routine"
  - "fragment"
timestamp: "2026-07-18T16:40:00-04:00"
status: active
consumers:
  - "dryvist/claude-code-routines"
render:
  engine: literal
  variables: []
  frontmatter: strip
source_history:
  - repository: "dryvist/claude-code-routines"
    path: "routines/_common/skip-list.md"
    commit: "11a75537a6ec52bdf60f37b06c8a5ebd51562a4d"
---
- Archived repos.
- `agentics`, `agent-os` (upstream mirrors).
- `tf-static-website` (abandoned).
- `dryvist`, `dryvist.github.io`, `.github` (profile/meta).
- Splunk-app legacy repos.
- `docs` itself (the docs site is a target, not a subject).
