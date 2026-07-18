# Dryvist AI LLM Prompts

Canonical, versioned prompt assets used by Dryvist automation, applications, developer tooling, and continuously running local AI agents.

Prompts are published as Open Knowledge Format Markdown. Consumers pin a release commit and select only the catalog directory they need:

- `auto-ai-agent/` — continuous local-agent behavior and jobs
- `automation/` — repository and cloud automation prompts
- `applications/` — application-facing system and user prompts
- `developer-tools/` — development workflow and hook prompts

The initial catalog release is `v0.1.0`. Release tags are immutable; consumers should pin the release commit rather than a mutable branch.

Repository directives, schemas, release rules, and public-safety requirements are in [AGENTS.md](AGENTS.md). Browse the catalog through [index.md](index.md).
