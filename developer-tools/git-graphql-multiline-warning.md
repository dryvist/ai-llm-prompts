---
type: LLM Prompt Fragment
title: GitHub GraphQL multiline warning
description: Corrective warning for multiline gh GraphQL query forms.
resource: prompt://dryvist/developer-tools/git-graphql-multiline-warning
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
MULTI-LINE QUERY: GraphQL queries must be on a single line.
Trailing backslashes and \n sequences break gh api graphql.

  WRONG:  gh api graphql --raw-field query=' \
            mutation { ... }'
  CORRECT: gh api graphql --raw-field query='mutation { ... }'
