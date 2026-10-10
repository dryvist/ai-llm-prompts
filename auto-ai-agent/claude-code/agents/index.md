# Claude Code subagents

Subagent definitions delivered into every Claude Code session. Each file carries Claude Code's own frontmatter
(`name`, `model`, `effort`) next to the OKF fields, and models are always the family alias, never a version.

## Prompts

* [haiku-xhigh](haiku-xhigh.md) - Default executor for scoping, bulk reads, triage and implementation chunks.
* [opus-medium](opus-medium.md) - Strong-reasoning executor for architecture and security judgment.
