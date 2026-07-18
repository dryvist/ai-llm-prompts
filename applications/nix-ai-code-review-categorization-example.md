---
type: LLM Prompt
title: Nix AI review categorization workflow example
description: Second LLM-call prompt in the executable code-review workflow example.
resource: prompt://dryvist/applications/nix-ai-code-review-categorization-example
tags: [nix-ai, example, workflow, code-review]
timestamp: 2026-07-18T16:43:26-04:00
status: staged
consumers: [dryvist/nix-ai]
render:
  engine: literal
  variables: []
  frontmatter: strip
source_history:
  - repository: dryvist/nix-ai
    path: orchestrator/examples/workflows/code-review-pipeline.yaml
    commit: ad0de9fa3170eb92823ce17518c3efde886231f7
---
Categorize the identified issues by severity: critical, warning, info.
