# Change Log

## 2026-07-26

* **Fix (auto-ai-agent)**: `hermes-digest-daily-operator-summary` was caught
  live posting "All hosts reporting; no gaps" from a query that could only see
  its own `head 12` truncation — a live cross-check against Splunk for the
  exact same window found 61 real hosts, not 12. Dropped the dead
  `index=network` (stale since 2026-06-12) in favor of `index=firewall`
  (Hermes' other expected-continuous index), added an `index` grouping
  dimension so a whole index going silent is explicit rather than folded away,
  added a memory-recalled baseline for a real delta, and forbade the model
  from asserting completeness it cannot support — it must now state "top N of
  M hosts shown" instead. No `head` truncation left in the SPL itself.

## 2026-07-21

* **Creation (auto-ai-agent)**: Added two Hermes jobs distilled from the retired
  automation fragments. `hermes-bot-pr-triage` reads CodeQL/Dependabot alerts,
  runs the 8 deterministic gates, labels `auto-merge-deps`, and Slack/Codex-
  escalates — it never merges, so CI still owns the merge. `hermes-docs-sync`
  runs a bounded delta discovery and defers privacy routing and signed draft
  PRs to the `docs-pr` skill. Both staged pending the `ansible-proxmox-ai` card
  wiring. Index updated.

## 2026-07-20

* **Rename (automation)**: Dropped the `routine` naming across the catalog —
  every `automation/routine-*.md` becomes `automation/*.md`, resource ids move
  from `prompt://dryvist/automation/routine/*` to `prompt://dryvist/automation/*`,
  and all `include` refs and index links follow. Bodies unchanged. No live
  consumer moves (`claude-code-routines` main does not consume the catalog yet).
* **Creation (auto-ai-agent)**: Added the `maintenance-windows` fragment —
  shared homelab hands-off state tracked as Vikunja tasks, checked before
  touching live infrastructure. Staged; hand-consumed by the workstation agent
  config, intended repo consumer `dryvist/nix-hermes`. Index updated.
* **Release**: Wired release-please (`release-type: simple`, `VERSION`-tracked)
  for automated releases on every push to `main`, seeded at the existing
  `v0.1.0`.
* **Removal (automation)**: Retired `routine-issue-solver` — a Linear-JAC
  GitHub-Actions task driver that duplicated the `ai-workflows` GitHub
  issue→PR path and never went live. Its goal is a candidate for a future
  Hermes job.
* **Refactor (automation)**: Split `routine-bot-pr-merge` (Phase A →
  `routine-fragment-bot-pr-security-triage`, Phase B →
  `routine-fragment-bot-pr-merge-gates`) and `routine-docs-sync` (Step 8 →
  `routine-fragment-docs-sync-pr-authoring`) via `include`, verbatim and
  lossless, so every catalog file clears the 12KB file-size limit. Index
  updated.

## 2026-07-19

* **Addition (auto-ai-agent)**: Two new cron prompts closing the catalog gap
  flagged by the ansible consumption work — `hermes-daily-summary` (once-daily
  delta-only operator rollup, home channel) and `hermes-zammad-review`
  (proactive open-incident lifecycle sweep across all Zammad queues, resolve
  with evidence, DM new incidents). Bodies verbatim from
  ansible-proxmox-ai roles/hermes_agent defaults (#51); index updated.
* **Capability (hermes surface)**: Added the OpenRouter escalation contract —
  discover current models/prices via the keyless public catalog (the
  `dryvist/openrouter-models` skill), escalate deliberately for complicated
  reasoning or advanced coding through the router only, hard $1.00/day budget
  tracked in memory, `:free`-variant preference with a confidentiality rule.
  Added the attribution rule: every delivered message ends with one line naming
  the exact model id(s) actually used.

## 2026-07-18

* **Correction (hermes surface)**: Dropped the generic `ai-default` alias — the
  default is the resident local brain, a real model id from the OpenBao brain
  value, re-pointable with no rebuild. Marked Zammad tracking live with the full
  open/update/resolve lifecycle (do the close, not just a recommendation). Added
  the Slack output rule: no Markdown tables — use fenced code blocks or
  `key: value` lists, lead with the delta, be direct.
* **Migration**: Cataloged 108 active, staged, dormant, and reference prompt assets from the Dryvist organization.
* **Canonicalization**: Unified the shared autonomous base, Hermes surface, and repository health audit without duplicate prompt bodies.
* **Preservation**: Retained authored routine and GH-AW prompt bodies while keeping exactly one non-production GH-AW format reference.
* **Creation**: Established the public Dryvist LLM prompt catalog and OKF governance for the `v0.1.0` bootstrap.
