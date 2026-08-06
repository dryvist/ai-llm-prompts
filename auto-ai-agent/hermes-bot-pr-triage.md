---
type: LLM Prompt
title: Hermes bot PR triage
description: Delta-aware bot-PR security triage that labels and escalates dependency PRs but never merges.
resource: prompt://dryvist/auto-ai-agent/hermes-bot-pr-triage
tags: [hermes, cron, autonomous-agent, security]
timestamp: 2026-07-21T00:00:00-04:00
status: active
consumers: [dryvist/ansible-proxmox-ai]
render:
  engine: literal
  variables: []
  frontmatter: strip
source_history:
  - repository: dryvist/ai-llm-prompts
    path: automation/fragment-bot-pr-security-triage.md
    note: "Distilled from the retired bot-pr-merge Phase A for a scheduled Hermes job. State-file references adapted to Hermes memory keys; the merge phase removed because Hermes labels and escalates only."
---
Run a bot-PR security triage sweep across the dryvist GitHub org right now. You **label and escalate only — you never merge or push.** Merging a labeled PR is owned by deterministic CI, not by you.

Use your `github-issues` skill plus a security-alert read token (`security_events:read` + `contents:read` + `pull_requests:read`/`write`). If that token is absent you cannot read alerts — reply with exactly [SILENT].

## Enumerate

- List non-archived repos in the org. Apply your operator skip-list.
- For each repo, fetch open CodeQL alerts (`code-scanning/alerts?state=open`) and open Dependabot alerts (`dependabot/alerts?state=open`). A 404 means the feature is disabled — skip that repo silently.
- Fetch open bot PRs (authors `dependabot[bot]`, `renovate[bot]`, `github-actions[bot]`, `jacobpevans-github-actions[bot]`). Cross-reference each Dependabot alert to its PR by package name. Renovate manifest bumps are candidates even with no backing alert.

## Auto-label gate (apply mechanically — do NOT reason around a failed gate)

Label a candidate PR `auto-merge-deps` only if it clears every gate. These are deterministic pass/fail checks, not judgment calls.

1. **Severity** — a backing alert is `open` and `high`. Missing or null severity, or no backing alert, fails closed (Slack only). Critical severity is never labeled — always Slack with `<!here>`.
2. **Age** — the alert is older than 7 days. Filters transient findings.
3. **Ignore list** — the alert `rule.id` is not in your operator CodeQL ignore list (memory key `bot-pr-triage-codeql-ignore`).
4. **File allowlist** — every changed file is a dependency manifest or lockfile (flake.lock, uv.lock, pyproject.toml, package.json, package-lock.json, Cargo.toml/lock, requirements*.txt, go.mod/sum, Gemfile/lock, poetry.lock, Pipfile/lock). Subset match, so a manifest plus its lockfile passes.
5. **Diff content** — every added or removed line is a dependency-declaration line for its file type (a `key = value`, a quoted JSON pair, a version-pinned requirement, a `go.mod` require). Any executable code, import, or free-form text rejects the PR. This closes the one-byte source-edit bypass. If a changed line is genuinely ambiguous, escalate that single judgment to Codex rather than guessing.
6. **Signed commits** — every commit in the PR is verified.
7. **Label provisioned** — the `auto-merge-deps` label exists in the repo. If it does not, skip the label and Slack `[label missing]`.
8. **Cap** — the PR is not already labeled, and you have added fewer than 5 labels this run.

## Act

- On a full pass, add `auto-merge-deps`. That is the whole action — CI merges from there. You never call merge.
- Escalate every high (failed the gate for any reason except age) and every critical alert to Slack: `@here` for high, `<!here>` for critical, with CVE/GHSA, severity, repo, and link. Dedupe with memory key `bot-pr-triage-cooldown` — skip an alert already escalated in the last 3 days. Collect escalations into one combined message.
- Cap labels at 5 per run; escalations are uncapped.

If nothing cleared a gate and nothing needs escalation, reply with exactly [SILENT]. Otherwise post the combined Slack message (labels added plus escalations) to the home channel and save updated cooldowns to memory. End every delivered message with one line naming the model id(s) you used.
