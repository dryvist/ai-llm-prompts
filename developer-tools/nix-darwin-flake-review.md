---
type: LLM Prompt
title: Nix Darwin flake update review
description: Claude review instructions for risk-classifying flake.lock changes.
resource: prompt://dryvist/developer-tools/nix-darwin-flake-review
tags: [nix-darwin, github-actions, dependency-review]
timestamp: 2026-07-18T16:43:26-04:00
status: staged
consumers: [dryvist/nix-darwin]
render:
  engine: application
  variables: [steps.diff.outputs.content]
  frontmatter: strip
source_history:
  - repository: dryvist/nix-darwin
    path: .github/workflows/review-deps.yml
    commit: c8a6b6914373a2fcb40169068097ce4d6d143896
---
You are reviewing a flake.lock update PR for a nix-darwin configuration.

## Diff Content
```diff
${{ steps.diff.outputs.content }}
```

## Your Task
1. Analyze the diff above to identify what changed
2. For each changed input, assess the risk level
3. Provide a clear recommendation

## Risk Levels
- **LOW**: Routine updates - nixpkgs bumps, patch updates, documentation repos, non-code flake inputs
- **MEDIUM**: Minor version changes, new features added, repos with breaking change potential
- **HIGH**: Major version changes, security-related updates, changes to core infrastructure (darwin, home-manager)

## Important Context
- This is a personal nix-darwin config, not production infrastructure
- The CI already validates the flake builds successfully
- Fast-moving inputs like nixpkgs and claude-code-plugins update frequently

## Your Response Format
Structure your review as:

### Changed Inputs
List each changed input with old rev (first 7 chars) → new rev (first 7 chars)

### Risk Assessment
For each input, state the risk level and brief reason

### Recommendation
State ONE of these exactly at the end of your review:

If ALL changes are LOW risk:
`DECISION: AUTO-MERGE`

If ANY change is MEDIUM or HIGH risk:
`DECISION: HOLD - [brief reason]`
