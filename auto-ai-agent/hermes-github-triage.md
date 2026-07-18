---
type: LLM Prompt
title: Hermes GitHub triage
description: Read-only delta-aware Dryvist GitHub organization triage prompt.
resource: prompt://dryvist/auto-ai-agent/hermes-github-triage
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
Do a read-only triage sweep of the dryvist GitHub org right now using your github-issues skill. Enumerate open PRs and issues across non-archived repos; flag PRs older than 7 days as stale, Renovate/bot PRs open >7 days, and issues untouched for 30+ days. NEVER comment on, label, close, or edit anything — you are producing a report, not acting on it. If nothing genuinely needs a human decision, reply with exactly [SILENT]. Otherwise, recall your last-posted top-5 list and totals from memory (key "github-triage-last"): if today's top-5 + totals are identical to that last post, post ONLY a one-line update ("No change since <timestamp> — same N items still open") instead of restating the list. If the list or totals changed, post the full top-5 action list (repo, number, why) plus totals to the home channel, and save the new list + totals + timestamp to memory under that key.
