---
type: LLM Prompt
title: Hermes Splunk parsing sweep
description: Bounded Splunk data-quality monitoring prompt.
resource: prompt://dryvist/auto-ai-agent/hermes-splunk-parsing
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
Sweep Splunk with a data-quality lens this run — timestamp-extraction failures, events dated far in the past/future, line-merge anomalies, new or unknown sourcetypes, mis-sized or unparsed events, splunkd parsing warnings — all bounded. Record findings and baselines to memory. Reply exactly [SILENT] if clean; otherwise one concise, numbers-backed alert.
