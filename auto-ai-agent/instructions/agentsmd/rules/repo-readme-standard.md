---
name: repo-readme-standard
description: Every repo README is standalone (no cross-repo narrative); one footer link to the docs hub, routed by visibility. Canonical spec on the docs site.
paths: ["**/README*.md", "**/README*.mdx"]
type: LLM Prompt
title: "Repo README standard"
resource: "prompt://dryvist/auto-ai-agent/instructions/agentsmd/rules/repo-readme-standard"
tags:
  - shared-instructions
  - agent-instructions
timestamp: "2026-10-18T08:44:13-04:00"
status: active
consumers:
  - dryvist/nix-ai
  - dryvist/nix-claude-code
render: { engine: literal, variables: [], frontmatter: strip }
source_history:
  - repository: dryvist/ai-assistant-instructions
    path: "agentsmd/rules/repo-readme-standard.md"
    note: Migrated from the instruction repository.
---

# Repo README standard

Every repo ships **one standalone README**: it describes only that repo, and the
cross-repo story lives on the docs site, not duplicated across READMEs.

Canonical spec (sections, order, examples):
[docs.jacobpevans.com/conventions/readme-conventions](https://docs.jacobpevans.com/conventions/readme-conventions).

When writing or editing a README, enforce:

- **Standalone.** No "Related Repos" table, no sibling descriptions, no
  repo-relationship diagram. That map lives on the docs hub.
- **Dependencies are contracts, not names.** Describe the shape this repo
  consumes ("an inventory matching `<schema>`", "`NETWORK_CIDR_*` in env"), not
  "run `<other-repo>` first."
- **One footer link, by visibility.** Public repo → `https://docs.jacobpevans.com`;
  private repo → `https://docs.dryvist.com`. That single line is the only
  cross-cutting reference a README carries.
- **Required shape, in order:** title + one-liner · badges (CI, license) ·
  installation · usage · repo-specific sections · contributing · license ·
  footer link.
