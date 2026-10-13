---
type: LLM Prompt
title: Hermes promotion drift
description: Daily org sweep that opens one draft promotion PR for each git-flow repo whose develop branch is ahead of main and has none open; never labels, readies, updates or merges.
resource: prompt://dryvist/auto-ai-agent/hermes-promotion-drift
tags: [hermes, cron, autonomous-agent, git-flow]
timestamp: 2026-10-12T12:00:00-04:00
status: active
consumers: [dryvist/ansible-proxmox-ai]
render:
  engine: literal
  variables: []
  frontmatter: strip
source_history:
  - repository: dryvist/ai-llm-prompts
    path: auto-ai-agent/hermes-bot-pr-triage.md
    note: "Same enumerate-then-act shape and delivery rules; the action is opening a draft promotion PR."
---
Run a promotion-drift sweep across the dryvist GitHub org right now. You **open draft promotion PRs only — you never label, mark ready, update, push, or merge anything.** A person or agent finishes a promotion later; your job is to make the drift visible.

Use your `github-issues` skill with your per-repo write token. If a repo's token is missing, skip that repo and name it in the report.

## Enumerate

- List non-archived repos in the org whose default branch is `develop`. Apply your operator skip-list.
- For each, read `gh api repos/<owner>/<repo>/compare/main...develop` and take `ahead_by`. A 404 or `ahead_by` of 0 means in sync: skip silently.
- List open PRs with base `main` and head `develop`. If one exists, skip the repo; if it has been open more than 7 days, record its URL and age for the report.

## Act

- For each drifting repo with no open promotion PR, open one **draft** PR from `develop` to `main` titled `chore: promote develop to main`. The body is exactly: `Promotes <N> commits from develop to main.`, a blank line, up to 5 of the first lines of the unpromoted commit messages as a bullet list, and `Oldest unpromoted commit: <UTC date>.`
- Add no label. A draft promotion PR neither freezes `develop` nor can it merge until it is marked ready.
- Open at most 10 PRs per run; report the repos left over.

## Report

If nothing was opened and no promotion PR is older than 7 days, reply with exactly [SILENT]. Otherwise post one message to the home channel listing each PR opened (full URL), each stale promotion PR (full URL, days open), and each skipped repo with its reason. End the message with one line naming the model id(s) you used.
