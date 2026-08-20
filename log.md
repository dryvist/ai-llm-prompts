# Change Log

## 2026-08-07

* **Update (auto-ai-agent)**: `autonomous-base.md` gains a routing-law section —
  GitHub carries pull requests only, incidents go to Zammad, everything else to
  Vikunja, and public artifacts state what changed, never why. `hermes-repo-scorecard.md`
  routes its human-action findings to Vikunja (or Zammad if incident-shaped)
  instead of opening a GitHub issue.
* **Update (automation)**: six PR/comment-authoring `ai-workflows-*` prompts
  (`post-merge-docs-review`, `post-merge-tests`, `code-simplifier`,
  `release-notes`, `pr-review-responder`, `dep-review`) gain an explicit
  disclosure rule for the public text they draft: state what changed, never
  why or what broke; no internal hostnames/FQDNs/topology; no incident
  narrative; scrubs named by category, never as a value-to-placeholder
  mapping.

## 2026-08-06 (later)

* **Fix (automation)**: restore `issue-solver` as `automation/issue-solver.md`,
  `status: active`, and un-retire the `fragment-prerequisites` it includes. Both
  were swept up in the cloud-routine retirement, and that was wrong: issue-solver
  never ran on the cloud substrate. It runs in GitHub Actions on a GitHub App
  token, has succeeded twice daily throughout the five weeks the cloud routines
  were dead, and is the one routine still live. The removal left the body of a
  working job existing only at its consumer's pinned submodule commit and on no
  main branch anywhere, so any repin would have silently broken it. The earlier
  entry below saying the consumer renders nothing from this directory is
  corrected by this one: it renders `issue-solver`, and only `issue-solver`.

## 2026-08-06

* **Retire (automation)**: the seven cloud-routine bodies and their twelve shared
  fragments moved to `status: retired`. The Anthropic cloud-routine substrate they
  ran on has produced nothing since 2026-07-01 — every repo-scoped call returns a
  session/repo binding 403, the deploy path has been unusable since 2026-05-19, and
  no state file has been written in five weeks. The bodies stay here as history;
  each one's `source_history` note now records where its content went, so the
  catalog answers "where did this go" rather than only "this used to exist".
  `consumers` is cleared on all of them, `dryvist/claude-code-routines` no longer
  renders any prompt from this directory.

* **Add (auto-ai-agent)**: `hermes-repo-scorecard` and `hermes-secrets-policy-audit`
  salvage the two pieces of the retired routines that were neither duplicated
  elsewhere nor blocked by Hermes doctrine. The scorecard keeps the weighted 0-100
  rubric and week-over-week deltas from `estate-briefing`, with history in a Hermes
  memory key instead of the routine state repo. The secrets audit keeps the one
  `repo-audit` rule that files an issue and never a pull request — which is exactly
  what makes it Hermes-legal — and gates on the `contents:read` token so it fails
  visibly instead of reporting a clean estate it never read.

* **Promote (auto-ai-agent)**: `hermes-docs-sync` and `hermes-bot-pr-triage` move
  from `staged` to `active`. Draft-only commits to the two docs repos are the single
  code-commit carve-out Hermes has, so docs-sync transfers intact; bot-PR work
  transfers as its triage half only, because Hermes never merges and the org Renovate
  preset already merges bot PRs directly via API.

## 2026-08-05

* **Update (auto-ai-agent)**: `hermes-splunk-parsing` gained a named dedup
  baseline. It previously said only "Record findings and baselines to memory" —
  no key name — so there was nothing deterministic to recall, and a parsing
  defect that stayed unfixed was re-reported on every run. It now recalls
  `splunk-parsing-last` first, filters against it, states how many findings it
  suppressed as already-known instead of relisting them, and saves the updated
  fingerprint back. This is the same four-element pattern the other Hermes
  surfaces already use, and it is the one prompt of its family whose card is
  currently unpaused, so it was the only one repeating in a live channel.

## 2026-08-04

* **Update (auto-ai-agent)**: the `hermes` surface gained an output contract.
  Channel routing is now stated as a rule the agent can apply — real findings to
  the all channel, self-breakage to issues (one post per problem, not per
  occurrence), everything FYI or repeated to noise — because an audit of three
  days of live output found one recurring alert template filling 38% of the
  issues channel and routine sweeps repeating three to five times a day in the
  all channel. A 24-hour no-repeat rule now covers the core channels, with only
  an active unhandled P1 exempt. The format rules ask for a status emoji and one
  bold takeaway first, so a reader can triage a message at a glance. A new
  triage rule ends alert-and-stop behavior: a confirmed problem now also gets a
  deduped ticket and a bounded follow-up investigation. Model guidance gained a
  tiering line so the small fast model stays a deliberate choice for quick or
  bulk work rather than becoming the default.

* **Fix (auto-ai-agent)**: the `hermes` surface mandated routine status be
  delivered to a default home channel "every run, never suppressed", while the
  consumer's job enqueuer separately tells each job to deliver to the
  destination its own card names. Both are obeyable at once because they name
  different destinations, so routine status reports were delivered twice,
  minutes apart. The standing rule now names a single destination — the one the
  asking job names — and drops the never-suppress clause, which also
  contradicted the output-format rule directly below it ("do not re-dump
  unchanged or already-known-benign status every run").

## 2026-08-02 (later)

* **Correction (auto-ai-agent)**: The delegation text shipped earlier today
  asserted that the router enforces spend budgets. It does not, and saying so
  was worse than the advisory text it replaced — an agent that believes it is
  capped spends more freely, and nothing was capping it. Verified against the
  deployment: the LiteLLM proxy is deliberately storage-less, spend tracking
  needs a shared store it does not have, and there is one shared credential
  rather than a key per caller, so there is nothing to meter per caller.
  `autonomous-base` and `model-delegation` now split the claim — which models
  you may reach IS enforced at the router and a rejection there is a correct
  answer; how much you spend is not, so a stated budget binds only because the
  agent counts against it and stops. `hermes` gets its explicit $1.00/day
  figure and memory-key procedure back, marked plainly as self-enforced. An
  unenforced limit is still a real limit; it is just one only the agent can
  apply, and pretending otherwise removed the only control that existed.

## 2026-08-02

* **Creation (auto-ai-agent)**: Added `model-delegation`, the single shared
  statement of delegation doctrine for every agent surface — offload bounded
  subtasks to the shared model router, take the cheapest tier that can
  actually do the subtask, fetch model names from the router's published
  contract instead of hardcoding them, treat a budget or allowlist rejection
  as a correct answer, and report honestly rather than falling back silently
  when the router is unreachable. Deliberately vendor-neutral and
  topology-free so it stays publishable.
* **Update (auto-ai-agent)**: `autonomous-base` gains a delegation section
  distilled from that fragment, so every consumer of the shared base — the
  Hermes persona among them — inherits the doctrine without a second copy.
  Section placement and altitude match the surrounding rules; the
  `autonomous engineering agent` opening line consumers assert on is
  unchanged.
* **Update (auto-ai-agent)**: `hermes` stops restating the general delegation
  rules now that the base carries them, and points at the base instead. Its
  `Model fabric:` paragraph keeps only what is genuinely Hermes-specific — the
  brain value, and the fact that this router publishes no `ai-default` alias.
  Its escalation paragraph now describes the spend cap as router-enforced
  rather than naming a figure the persona cannot enforce and that would drift
  from router config. Both `Model fabric:` and `Escalation routing:` line
  anchors are unchanged, since consumers grep for them.

Entries before 2026-08-01: [log-archive.md](log-archive.md).
