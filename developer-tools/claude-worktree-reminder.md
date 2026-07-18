---
type: LLM Prompt
title: Claude main-branch worktree reminder
description: System message injected when a Claude session starts work on the main branch.
resource: prompt://dryvist/developer-tools/claude-worktree-reminder
tags: [claude-code, hook, git, worktree]
timestamp: 2026-07-18T16:43:26-04:00
status: active
consumers: [dryvist/claude-code-plugins]
render:
  engine: literal
  variables: []
  frontmatter: strip
source_history:
  - repository: dryvist/claude-code-plugins
    path: git-guards/scripts/worktree-reminder.sh
    commit: 1060914b291cbc14b1d1228585e31a23142acb89
---
WARNING: You are on the main branch. You MUST create or switch to a separate worktree on its own branch BEFORE making any changes — how and where you create it is up to you. Do not read-for-editing, edit, write, or create files for the task until you are in a non-main worktree. This applies to ALL work — code, docs, and config.
