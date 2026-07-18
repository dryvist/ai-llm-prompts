---
type: LLM Prompt
title: Hermes nightly wiki health
description: Nightly wiki lint and health-check prompt.
resource: prompt://dryvist/auto-ai-agent/hermes-nightly-wiki-health
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
Run a lint and health-check on the wiki.
