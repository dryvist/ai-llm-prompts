---
type: LLM Prompt
title: Hermes Splunk deep dive
description: Quiet Splunk index or sourcetype characterization prompt.
resource: prompt://dryvist/auto-ai-agent/hermes-splunk-deepdive
tags: [hermes, cron, autonomous-agent]
timestamp: 2026-07-18T16:43:26-04:00
status: active
consumers: [dryvist/ansible-proxmox-ai]
render:
  engine: literal
  variables: []
  frontmatter: strip
source_history:
  - repository: dryvist/ansible-proxmox-ai
    path: roles/hermes_agent/defaults/main.yml
    commit: 5fe2eb8f6df8203ea5dd17f1e49053f0a195b490
---
Pick ONE index or sourcetype you have not yet characterized well (check your wiki/memory for gaps). Using only bounded queries, learn its normal shape, volume and purpose, then write or update a page in the `splunk` area of your wiki plus a memory baseline. This is a quiet research run — no alert needed.
