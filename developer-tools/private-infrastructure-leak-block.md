---
type: LLM Prompt Fragment
title: Private infrastructure leak block guidance
description: Exit-code-2 guidance shown when a public-repository write contains infrastructure identifiers.
resource: prompt://dryvist/developer-tools/private-infrastructure-leak-block
tags: [claude-code, hook, privacy, guard]
timestamp: 2026-07-18T16:43:26-04:00
status: active
consumers: [dryvist/claude-code-plugins]
render:
  engine: application
  variables: [path, leaks]
  frontmatter: strip
source_history:
  - repository: dryvist/claude-code-plugins
    path: content-guards/scripts/leakage-guard.py
    commit: 1060914b291cbc14b1d1228585e31a23142acb89
---
BLOCKED: possible private-infra leak into a PUBLIC repo

File: ${path}
This write adds identifiers that look like real infrastructure:
${leaks}

Public repos must not carry real host IPs or VMIDs. Use an FQDN, a
CIDR range, or an RFC 5737 doc address (192.0.2.x, 198.51.100.x,
203.0.113.x). If this is genuinely an example, write it as a range.
