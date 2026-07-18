---
type: LLM Prompt
title: Hermes inbound webhook relay
description: Prompt template for relaying the raw inbound webhook payload.
resource: prompt://dryvist/auto-ai-agent/hermes-inbound-webhook
tags: [hermes, webhook, autonomous-agent]
timestamp: 2026-07-18T16:43:26-04:00
status: active
consumers: [dryvist/ansible-proxmox-ai]
render:
  engine: application
  variables: [__raw__]
  frontmatter: strip
source_history:
  - repository: dryvist/ansible-proxmox-ai
    path: roles/hermes_agent/templates/config.yaml.j2
    commit: 5fe2eb8f6df8203ea5dd17f1e49053f0a195b490
---
Inbound webhook ping: {__raw__}
