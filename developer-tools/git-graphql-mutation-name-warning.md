---
type: LLM Prompt Fragment
title: GitHub GraphQL mutation-name warning
description: Corrective warning for known invalid GitHub GraphQL mutation names.
resource: prompt://dryvist/developer-tools/git-graphql-mutation-name-warning
tags: [claude-code, hook, github, graphql]
timestamp: 2026-07-18T16:43:26-04:00
status: active
consumers: [dryvist/claude-code-plugins]
render:
  engine: application
  variables: [wrong_name, correct_name, example]
  frontmatter: strip
source_history:
  - repository: dryvist/claude-code-plugins
    path: git-guards/scripts/git-permission-guard.py
    commit: 1060914b291cbc14b1d1228585e31a23142acb89
---
WRONG MUTATION NAME: '${wrong_name}' does not exist in the GitHub GraphQL API.
Use '${correct_name}' instead.

  Example: ${example}
