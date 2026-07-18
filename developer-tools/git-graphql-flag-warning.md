---
type: LLM Prompt Fragment
title: GitHub GraphQL flag warning
description: Corrective warning for template-processing flags in gh GraphQL queries.
resource: prompt://dryvist/developer-tools/git-graphql-flag-warning
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
WRONG FLAG: -f/-F applies Go template processing which causes variable expansion.
Use --raw-field for GraphQL queries:

  WRONG:  gh api graphql -f query='...'
  CORRECT: gh api graphql --raw-field query='...'
