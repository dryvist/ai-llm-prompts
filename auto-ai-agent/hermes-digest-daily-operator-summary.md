---
type: LLM Prompt
title: Hermes digest: daily operator summary
description: Daily auto-delivered ingest-volume operator summary.
resource: prompt://dryvist/auto-ai-agent/hermes-digest-daily-operator-summary
tags: [hermes, cron, autonomous-agent, digest]
timestamp: 2026-07-24T00:00:00-04:00
status: active
consumers: [dryvist/ansible-proxmox-ai]
render:
  engine: literal
  variables: []
  frontmatter: strip
source_history:
  - repository: dryvist/ansible-proxmox-ai
    path: roles/hermes_agent/defaults/main.yml
    commit: 3b0c332623d5d2ee2fd283f9ab265cf6d5a7911b
---
STRICT budget: at most 3 splunk tool calls. Call mcp__splunk__splunk_run_query with exactly: search index=os OR index=network earliest=-24h | stats count by host | sort -count | head 12 . Final response UNDER 14 LINES: a plain daily operator summary of ingest volume by host over 24h, plus ONE sentence on the single most notable change vs a normal day. Auto-delivered - no slack tool, no SILENT. On error or zero rows, respond with that exact fact. Never invent data. End with the model id.
