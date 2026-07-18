---
type: LLM Prompt Fragment
title: "Issue Analysis"
description: "Reusable issue categorization and duplicate-detection rules."
resource: "prompt://dryvist/automation/ai-workflows/issue-analysis-fragment"
tags:
  - "automation"
  - "ai-workflows"
  - "fragment"
timestamp: "2026-07-18T16:40:00-04:00"
status: dormant
consumers:
  - "dryvist/ai-workflows"
render:
  engine: literal
  variables:
    []
  frontmatter: strip
source_history:
  - repository: "dryvist/ai-workflows"
    path: "shared/prompts/issue-analysis.md"
    commit: "fad075ea44873c3a38f6c7060a5212880a10207c"
---

# Issue Analysis Rules

Guidelines for analyzing, categorizing, and deduplicating GitHub issues.

## Categorization

Map issues to `type:*` labels based on content, not just keywords:

| Signal | Type |
| -------- | ------ |
| Error messages, stack traces, "doesn't work", regression | `type:bug` |
| "Add", "implement", "support for", "would be nice" | `type:feature` |
| API changes, removal of existing behavior, version bump | `type:breaking` |
| Typos, missing docs, README updates, examples | `type:docs` |
| Dependencies, tooling, build config, cleanup | `type:chore` |
| Pipeline, workflow, CI/CD, GitHub Actions | `type:ci` |
| Test coverage, test fixes, test infrastructure | `type:test` |
| Restructure, rename, extract, reorganize (no behavior change) | `type:refactor` |
| Slow, latency, memory, optimization, benchmark | `type:perf` |

When signals conflict, prefer the primary intent of the issue.

## Duplicate Detection

An issue is a likely duplicate when:

1. **Title similarity**: >70% word overlap with an existing open issue title.
2. **Description overlap**: Same error messages, same file references, or same
   requested feature described differently.
3. **Linked resources**: References the same PR, commit, or external issue.

When a duplicate is detected:

- Apply the `duplicate` label to the newer issue.
- Comment with a reference: `Possible duplicate of #<number>`.
- Do not close the issue; let a human confirm.

## Completeness Assessment

An issue is potentially resolved when:

- A merged PR references the issue number in its title, body, or commits.
- A branch named after the issue has been merged to main.
- The specific code change requested in the issue exists in the current codebase.

An issue is in progress when:

- An open (unmerged) PR references the issue.
- A branch exists but has not been merged.
- Recent commits reference the issue number.
