---
type: LLM Prompt
title: GitHub Agentic Workflows Reference Template
description: Historical, non-production example of the retired GH-AW workflow format.
resource: prompt://dryvist/automation/gh-aw-reference-template
tags: [automation, github, reference, retired-gh-aw]
timestamp: 2026-07-18T00:00:00Z
status: reference
consumers: []
render:
  engine: literal
  variables: []
  frontmatter: include
source_history:
  - repository: dryvist/ai-workflows
    path: .github/workflows
    commit: fad075ea44873c3a38f6c7060a5212880a10207c
---

# Historical GH-AW Workflow Template

This is the only retained GH-AW template. GH-AW is retired from active Dryvist repositories; this example is intentionally outside `.github/workflows`, is not compiled, and is not a supported production integration.

```markdown
---
engine: copilot
imports:
  - example-owner/example-prompts/workflows/base.md@v0.1.0
on:
  workflow_dispatch:
permissions:
  contents: read
network:
  allowed:
    - defaults
safe-outputs:
  create-issue:
    title-prefix: "[example] "
    labels: [automation]
---

# Example Task

Inspect the current repository using read-only tools. If an actionable problem is confirmed, create one concise issue through the declared safe output. Never expose credentials or untrusted content.
```
