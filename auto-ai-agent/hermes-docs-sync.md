---
type: LLM Prompt
title: Hermes docs sync
description: Bounded docs-sync pass that routes doc-worthy changes to public or private docs via signed draft PRs.
resource: prompt://dryvist/auto-ai-agent/hermes-docs-sync
tags: [hermes, cron, autonomous-agent, docs]
timestamp: 2026-07-21T00:00:00-04:00
status: active
consumers: [dryvist/ansible-proxmox-ai]
render:
  engine: literal
  variables: []
  frontmatter: strip
source_history:
  - repository: dryvist/ai-llm-prompts
    path: automation/fragment-docs-sync-pr-authoring.md
    note: "Distilled from the retired docs-sync authoring step for a scheduled Hermes job. Privacy routing, signed commits, redaction, and attribution are deferred to the docs-pr skill rather than restated here."
---
Run a docs-sync pass right now using your `docs-pr` skill. That skill owns the hard guarantees — absolute public/private privacy routing, signed commits through the GitHub App, secret redaction, the no-emoji rule, the `[routine:hermes]` attribution triad, and the fact that you open draft PRs only and never merge. Defer to it; do not re-implement any of that here.

## Discover (bounded, delta-only)

- Recall the last run from memory key `docs-sync-last` (the timestamp plus the concepts you already routed).
- Scan the doc-source set your skill and config define for doc-worthy changes since that timestamp — new or changed behavior, config, or runbooks. Bound the pass: if there is nothing new, save the timestamp and reply with exactly [SILENT].

## Route and author

- Route each new concept with your skill's privacy rule: public-safe and general goes to the public docs site; anything internal, sensitive, secret, or private-repo in origin goes to the private docs site only. When unsure, treat it as sensitive.
- Open at most one draft PR per target site — batch the run's concepts into that site's PR — through the skill's signed-commit path. Use one branch per site, reused if it already exists.
- In each PR body, list the concepts documented and, for each, which site it went to and why (public-safe, sensitive, or private-origin).

## Verify

- After the public PR exists, poll its secret-scan check for about two minutes. If it fails, a sensitive value slipped through: rename the PR title to flag that a human is needed, and surface it in Slack.
- Save the run (timestamp plus routed concepts) to memory key `docs-sync-last`.

If both sites got zero concepts, reply with exactly [SILENT]. Otherwise post a one-line Slack summary (PRs opened, per site) to the home channel. End every delivered message with one line naming the model id(s) you used.
