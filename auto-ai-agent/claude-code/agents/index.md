# Claude Code subagents

Subagent definitions delivered into every Claude Code session. The router chooses the executor backend and effort
per spawn; executor definitions stay model-neutral.

## Prompts

* [executor](executor.md) - Model-neutral executor for delegated scoping, bulk reads, triage, review, shipping and implementation.
* [pr-shepherd](pr-shepherd.md) - Drives named pull requests to merged and promotes a git-flow repo afterward.
