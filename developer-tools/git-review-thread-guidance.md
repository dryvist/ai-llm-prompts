---
type: LLM Prompt Fragment
title: GitHub review-thread guidance
description: Model-visible denial reason for non-resolvable top-level PR review comments.
resource: prompt://dryvist/developer-tools/git-review-thread-guidance
tags: [claude-code, hook, github, review]
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
gh pr comment creates top-level issue comments that cannot be resolved or tracked.

For code review feedback, you MUST use review threads (line-specific, resolvable comments) instead.

Use the documented thread workflows for creating review comments, replying, and resolving threads:
  - github-workflows/skills/resolve-pr-threads/graphql-queries.md
  - github-workflows/skills/resolve-pr-threads/rest-api-patterns.md

These workflows create resolvable, line-specific review threads — the only acceptable way to post review
feedback on PRs.
