---
type: LLM Prompt Fragment
title: WebFetch current-year warning
description: Model-visible warning for date-sensitive searches using the current year.
resource: prompt://dryvist/developer-tools/webfetch-current-year-warning
tags: [claude-code, hook, webfetch, guard]
timestamp: 2026-07-18T16:43:26-04:00
status: active
consumers: [dryvist/claude-code-plugins]
render:
  engine: application
  variables: [current_year, date_str]
  frontmatter: strip
source_history:
  - repository: dryvist/claude-code-plugins
    path: content-guards/scripts/webfetch-guard.py
    commit: 1060914b291cbc14b1d1228585e31a23142acb89
---
WARNING: You're searching with the current year (${current_year}).

Current date: ${date_str}

Always verify the current date before running date-specific searches.
