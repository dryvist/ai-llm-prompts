---
type: LLM Prompt
title: Claude post-PR finalization reminder
description: System message injected after a successful gh pr create command.
resource: prompt://dryvist/developer-tools/claude-post-pr-finalization
tags: [claude-code, hook, github, pull-request]
timestamp: 2026-07-18T16:43:26-04:00
status: active
consumers: [dryvist/claude-code-plugins]
render:
  engine: application
  variables: [pr_number]
  frontmatter: strip
source_history:
  - repository: dryvist/claude-code-plugins
    path: pr-lifecycle/scripts/post-pr-create.sh
    commit: 1060914b291cbc14b1d1228585e31a23142acb89
---
POST-PR AUTOMATION: PR #${pr_number} was just created. If no higher-level workflow (such as /ship) is already handling finalization, you MUST invoke /finalize-pr ${pr_number} before returning to the user.
