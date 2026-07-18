---
type: LLM Prompt
title: "CI Failure Issue"
description: "Dormant prompt for creating an issue from a main-branch CI failure."
resource: "prompt://dryvist/automation/ai-workflows/ci-fail-issue"
tags:
  - "automation"
  - "ai-workflows"
timestamp: "2026-07-18T16:40:00-04:00"
status: dormant
consumers:
  - "dryvist/ai-workflows"
render:
  engine: envsubst
  variables:
    - "COMMIT_SHA"
    - "FAILURE_LOGS"
    - "RUN_URL"
    - "WORKFLOW_NAME"
  frontmatter: strip
source_history:
  - repository: "dryvist/ai-workflows"
    path: ".github/prompts/ci-fail-issue.md"
    commit: "fad075ea44873c3a38f6c7060a5212880a10207c"
---
<!-- ci-fail-issue -->

# CI Failure: ${WORKFLOW_NAME}

**Commit**: `${COMMIT_SHA}`
**Run**: ${RUN_URL}

## Failure Logs

```text
${FAILURE_LOGS}
```

## Task

Please investigate and fix the CI failure on the main branch. Open a pull request with the fix.

Do not add workarounds or ignores - fix the actual root cause.
