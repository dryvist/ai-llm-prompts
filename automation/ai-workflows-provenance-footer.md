---
type: LLM Prompt Fragment
title: "AI Provenance Footer"
description: "Canonical provenance footer fragment for AI-created pull requests."
resource: "prompt://dryvist/automation/ai-workflows/provenance-footer"
tags:
  - "automation"
  - "ai-workflows"
  - "fragment"
timestamp: "2026-07-18T16:40:00-04:00"
status: reference
consumers:
  - "dryvist/ai-workflows"
render:
  engine: envsubst
  variables:
    - "EVENT_NAME"
    - "RUN_ID"
    - "RUN_URL"
    - "TRIGGER_ACTOR"
    - "WORKFLOW_NAME"
  frontmatter: strip
source_history:
  - repository: "dryvist/ai-workflows"
    path: ".github/prompts/_provenance-footer.md"
    commit: "fad075ea44873c3a38f6c7060a5212880a10207c"
---
---
> **AI Provenance** | Workflow: `${WORKFLOW_NAME}` | [Run ${RUN_ID}](${RUN_URL}) | Event: `${EVENT_NAME}` | Actor: `${TRIGGER_ACTOR}`
