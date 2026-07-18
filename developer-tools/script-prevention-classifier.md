---
type: LLM Prompt
title: Script prevention classifier
description: Local-model classification prompt used to distinguish legitimate artifacts from unnecessary scripts.
resource: prompt://dryvist/developer-tools/script-prevention-classifier
tags: [claude-code, hook, local-llm, scripts]
timestamp: 2026-07-18T16:43:26-04:00
status: active
consumers: [dryvist/claude-code-plugins]
render:
  engine: application
  variables: [file_path]
  frontmatter: strip
source_history:
  - repository: dryvist/claude-code-plugins
    path: script-guards/scripts/write-script-guard.sh
    commit: 1060914b291cbc14b1d1228585e31a23142acb89
---
You are a script-prevention guardrail. A file is being created at: ${file_path}

Is this a legitimate committed artifact (CI workflow, plugin hook, test fixture, build tool) or an unnecessary custom script?

Respond with ONLY 'allow' or 'deny' followed by a brief reason.
