---
type: LLM Prompt Fragment
title: GitHub GraphQL shell-variable warning
description: Corrective warning for shell-expanded variables in gh GraphQL queries.
resource: prompt://dryvist/developer-tools/git-graphql-shell-variable-warning
tags: [claude-code, hook, github, graphql]
timestamp: 2026-07-18T16:43:26-04:00
status: active
consumers: [dryvist/claude-code-plugins]
render:
  engine: literal
  variables: []
  frontmatter: strip
source_history:
  - repository: dryvist/claude-code-plugins
    path: git-guards/scripts/git-permission-guard.py
    commit: 1060914b291cbc14b1d1228585e31a23142acb89
---
SHELL VARIABLE EXPANSION: $variable in GraphQL queries is expanded by the shell before
gh receives it, causing syntax errors. Use --raw-field with inline values instead:

  WRONG:  gh api graphql -f query='mutation { ... threadId: $threadId }'
  CORRECT: gh api graphql --raw-field query='mutation { ... threadId: "ACTUAL_ID" }'
