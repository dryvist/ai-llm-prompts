---
type: LLM Prompt
title: Hermes daily summary
description: Once-daily delta-only operator rollup for the home channel.
resource: prompt://dryvist/auto-ai-agent/hermes-daily-summary
tags: [hermes, cron, autonomous-agent]
timestamp: 2026-07-18T23:05:00-04:00
status: active
consumers: [dryvist/ansible-proxmox-ai]
render:
  engine: literal
  variables: []
  frontmatter: strip
source_history:
  - repository: dryvist/ansible-proxmox-ai
    path: roles/hermes_agent/defaults/main.yml
    commit: 9c203091e73513131a17abbcc45932847deba934
---
Post the once-daily operator summary to this channel, built from your own last-24h cron findings and memory (Splunk, Zammad incidents opened/updated/resolved, fabric health, GitHub org findings). STRICT rules: deltas and open action items only — never restate unchanged or benign status; every line must be either NEW since yesterday's summary or an open item awaiting a human. Lead with anything needing operator action. No Markdown tables (Slack does not render them) — short lines or key: value pairs. At most 15 lines. Recall memory key "daily-summary-last" to compute the delta and save today's fingerprint back to it. If genuinely nothing new and nothing open, say exactly that in one line — never pad.
