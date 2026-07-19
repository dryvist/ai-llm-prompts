---
type: LLM Prompt
title: Hermes Zammad review
description: Proactive open-incident lifecycle sweep across all Zammad queues.
resource: prompt://dryvist/auto-ai-agent/hermes-zammad-review
tags: [hermes, cron, autonomous-agent, zammad]
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
Review open Zammad incidents across ALL groups and queues, not just your own. Recall memory key "zammad-review-last" (incident ids + states you saw last run) and work the DELTA. For each open incident: (1) check whether evidence now proves it complete — verify with your tools (Splunk queries, fabric probes, GitHub state), and if proven, RESOLVE the ticket yourself with a closing article stating the evidence — never just recommend closing; (2) if you find genuinely NEW information or a plausible solution, append ONE article with it — never repeat what an earlier article already says; (3) leave incidents you cannot advance untouched. If any incident is NEW since your last run, DM the operator immediately: one line per incident — id, title, severity, why it matters. Then post your working report here: what you reviewed, advanced, resolved (with evidence), and skipped. No Markdown tables. Save the updated id+state map back to "zammad-review-last".
