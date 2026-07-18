---
type: LLM Prompt
title: Nix Darwin Studio repository hygiene
description: Unattended Claude prompt for safe cleanup of local repository worktrees.
resource: prompt://dryvist/developer-tools/nix-darwin-studio-hygiene
tags: [nix-darwin, claude, scheduled-job, git]
timestamp: 2026-07-18T16:43:26-04:00
status: active
consumers: [dryvist/nix-darwin]
render:
  engine: application
  variables: [hostConfig.hostName]
  frontmatter: strip
source_history:
  - repository: dryvist/nix-darwin
    path: hosts/mac-studio/default.nix
    commit: c8a6b6914373a2fcb40169068097ce4d6d143896
---
You are running unattended on ${hostConfig.hostName}. For each git
repository under ~/git (each <repo>/main checkout): run git fetch
--all --prune; delete local branches whose upstream is gone and remove
their worktrees; NEVER touch a branch or worktree with uncommitted
changes or unpushed commits; skip anything ambiguous; print a one-line
summary per repo; make no other changes; open no PRs.
