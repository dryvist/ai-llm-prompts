# Change Log

## 2026-07-20

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
