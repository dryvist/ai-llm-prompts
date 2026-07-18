---
type: LLM Prompt
title: Nix AI default system fallback
description: Fallback system message for orchestrator LLM-call nodes without an explicit prompt.
resource: prompt://dryvist/applications/nix-ai-default-system
tags: [nix-ai, orchestrator, fallback]
timestamp: 2026-07-18T16:43:26-04:00
status: active
consumers:
  - dryvist/nix-ai
render:
  engine: literal
  variables: []
  frontmatter: strip
source_history:
  - repository: dryvist/nix-ai
    path: orchestrator/src/orchestrator/workflows/nodes.py
    commit: ad0de9fa3170eb92823ce17518c3efde886231f7
---
You are a helpful assistant.
