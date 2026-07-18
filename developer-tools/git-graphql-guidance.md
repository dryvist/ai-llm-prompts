---
type: LLM Prompt Fragment
title: GitHub GraphQL corrective guidance
description: Model-visible corrective template for common gh api graphql failure patterns.
resource: prompt://dryvist/developer-tools/git-graphql-guidance
tags: [claude-code, hook, github, graphql]
timestamp: 2026-07-18T16:43:26-04:00
status: active
consumers: [dryvist/claude-code-plugins]
render:
  engine: application
  variables: [numbered_warnings]
  frontmatter: strip
source_history:
  - repository: dryvist/claude-code-plugins
    path: git-guards/scripts/git-permission-guard.py
    commit: 1060914b291cbc14b1d1228585e31a23142acb89
---
GRAPHQL GUIDANCE: This command has known failure patterns. Correct before retrying:

${numbered_warnings}
