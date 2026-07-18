---
type: LLM Prompt Fragment
title: WebFetch outdated-year block guidance
description: Model-visible denial reason for searches containing an outdated year.
resource: prompt://dryvist/developer-tools/webfetch-outdated-year-block
tags: [claude-code, hook, webfetch, guard]
timestamp: 2026-07-18T16:43:26-04:00
status: active
consumers: [dryvist/claude-code-plugins]
render:
  engine: application
  variables: [blocked_year, date_str, current_year]
  frontmatter: strip
source_history:
  - repository: dryvist/claude-code-plugins
    path: content-guards/scripts/webfetch-guard.py
    commit: 1060914b291cbc14b1d1228585e31a23142acb89
---
BLOCKED: Your search contains '${blocked_year}' (outdated).

Current date: ${date_str}
Current year: ${current_year}

Please search using the current year or remove the year reference.
