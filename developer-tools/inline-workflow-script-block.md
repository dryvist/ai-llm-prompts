---
type: LLM Prompt Fragment
title: Inline workflow script block guidance
description: Model-visible denial reason for complex shell code embedded in workflow YAML.
resource: prompt://dryvist/developer-tools/inline-workflow-script-block
tags: [claude-code, hook, github-actions, scripts]
timestamp: 2026-07-18T16:43:26-04:00
status: active
consumers: [dryvist/claude-code-plugins]
render:
  engine: application
  variables: [file_path]
  frontmatter: strip
source_history:
  - repository: dryvist/claude-code-plugins
    path: script-guards/scripts/inline-script-guard.sh
    commit: 1060914b291cbc14b1d1228585e31a23142acb89
---
BLOCKED: Complex inline bash in workflow YAML ${file_path}.

Extract to .github/scripts/ or scripts/ and call from the workflow step.

Never embed complex bash logic inline in GitHub Actions workflow YAML.
