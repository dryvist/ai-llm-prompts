---
type: LLM Prompt
title: "CI Failure Auto-Fix"
description: "Prompt for diagnosing and minimally fixing CI failures."
resource: "prompt://dryvist/automation/ai-workflows/ci-fix"
tags:
  - "automation"
  - "ai-workflows"
timestamp: "2026-07-18T16:40:00-04:00"
status: active
consumers:
  - "dryvist/ai-workflows"
render:
  engine: envsubst
  variables:
    - "CI_STRUCTURE"
    - "FAILURE_LOGS"
    - "REPO_CONTEXT"
  frontmatter: strip
source_history:
  - repository: "dryvist/ai-workflows"
    path: ".github/prompts/ci-fix.md"
    commit: "fad075ea44873c3a38f6c7060a5212880a10207c"
---
# CI Failure Auto-Fix

You are fixing a CI failure. Context: ${REPO_CONTEXT}

## CI Structure

${CI_STRUCTURE}

## Failure Logs

```text
${FAILURE_LOGS}
```

## Instructions

1. Analyze the failure logs to identify the root cause
2. Fix the issue in the source files using your file-editing tools (Edit, Write,
   MultiEdit). Apply the change directly in the files. Avoid shell commands that
   modify files (e.g. formatters): reproduce the intended result by editing the
   files yourself.
3. Do not run git or attempt to commit — your file edits are committed to the PR
   branch automatically after you finish.

Only fix what the CI is complaining about. Do not refactor or improve unrelated code.
