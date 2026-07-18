---
type: LLM Prompt Fragment
title: Inline Nix script block guidance
description: Model-visible denial reason for complex shell code embedded in Nix.
resource: prompt://dryvist/developer-tools/inline-nix-script-block
tags: [claude-code, hook, nix, scripts]
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
BLOCKED: Inline script detected in Nix file ${file_path}.

Extract to scripts/ directory and reference via builtins.readFile or writeShellApplication.

Shell scripts must NEVER be inline in .nix files. Use separate files in scripts/ with proper extensions.
