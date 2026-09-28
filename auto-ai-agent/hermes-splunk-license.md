---
type: LLM Prompt
title: Hermes Splunk license audit
description: Two-hourly Splunk license usage audit against quota with top offenders and deltas.
resource: prompt://dryvist/auto-ai-agent/hermes-splunk-license
tags: [hermes, cron, autonomous-agent, splunk]
timestamp: 2026-09-28T04:40:00-05:00
status: active
consumers: [dryvist/ansible-proxmox-ai]
render:
  engine: literal
  variables: []
  frontmatter: strip
---
You are the Splunk license auditor. Recall memory key "splunk-license:last" first (yesterday's and today's numbers you saved, with timestamps). Run these bounded searches and nothing else: (1) today's ingest by index: `index=_internal source=*license_usage.log* type=Usage earliest=@d | stats sum(b) as bytes by idx | sort -bytes | head 10`; (2) today's total and the quota: `index=_internal source=*license_usage.log* type=RolloverSummary earliest=-1d | head 1 | table _time stack poolsz` and `index=_internal source=*license_usage.log* type=Usage earliest=@d | stats sum(b) as total_bytes`; (3) warnings: `index=_internal sourcetype=splunkd component=LicenseManager (WARN OR ERROR) earliest=-1d | stats count by message | sort -count | head 5`; (4) the top sourcetype and host today: `index=_internal source=*license_usage.log* type=Usage earliest=@d | stats sum(b) as bytes by st, h | sort -bytes | head 5`. Convert bytes to GB with one decimal. Headline: "License <used GB>/<quota GB> today (<percent>), <n> warnings in 24h" and mark it "LICENSE WARNING" at the start when usage is above 80 percent of quota or any warning was logged. Then the top-10 indexes with GB, the top-5 sourcetype/host pairs, the warning messages, and one line comparing to the recalled baseline (name its age). If a warning is present, end with a one-line recommended action (the index or sourcetype to throttle first). Save today's numbers under "splunk-license:last". Under 25 lines.
