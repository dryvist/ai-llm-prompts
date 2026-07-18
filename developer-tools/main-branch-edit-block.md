---
type: LLM Prompt Fragment
title: Main-branch edit block guidance
description: Model-visible reason returned when an edit targets the main branch.
resource: prompt://dryvist/developer-tools/main-branch-edit-block
tags: [claude-code, hook, git, guard]
timestamp: 2026-07-18T16:43:26-04:00
status: active
consumers: [dryvist/claude-code-plugins]
render:
  engine: application
  variables: [file_path]
  frontmatter: strip
source_history:
  - repository: dryvist/claude-code-plugins
    path: git-guards/scripts/main-branch-guard.py
    commit: 1060914b291cbc14b1d1228585e31a23142acb89
---
BLOCKED: File '${file_path}' is on the main branch. Editing files on the main branch is not allowed.

Create or switch to a worktree before editing.
