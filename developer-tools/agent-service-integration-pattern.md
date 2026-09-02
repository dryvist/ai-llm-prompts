---
type: Integration Pattern
title: Agent service integration pattern
description: How an AI agent reaches an external service across every CLI harness at near-zero session cost — a shell command plus a manual-invoke skill, scoped per repository, instead of an always-on MCP server.
resource: prompt://dryvist/developer-tools/agent-service-integration-pattern
tags: [integration, mcp, skills, cross-harness, token-budget, cli]
timestamp: 2026-09-02T21:15:00-04:00
status: active
consumers: [dryvist/claude-code-plugins, dryvist/nix-ai, dryvist/nix-darwin]
render:
  engine: literal
  variables: []
  frontmatter: strip
source_history:
  - repository: dryvist/claude-code-plugins
    path: slack/skills/slack-messaging/SKILL.md
    commit: 1d9073f3d08f02212ff145d1e82fd3c25349a62f
---

# Agent service integration pattern

How to give an agent access to an external service without paying for it in
every session, and without wiring it separately for every CLI.

## The measurement that motivates this

A hosted Slack MCP connector was measured at **20,930 tokens in every session**
— roughly 18% of a typical context window — for a capability most sessions never
used. Its two canvas tools alone embed an entire markup authoring specification
inside their parameter descriptions.

It was also reachable from **one** harness. The same access as a shell command
plus a manual-invoke skill costs about **10 tokens** until invoked, and works in
every harness that can run a shell.

## Why MCP is expensive by construction

An MCP server's complete JSON Schema — every property, enum and description —
is injected at session start, for every tool, whether or not any is called.
`tools/list` returns full schemas and the protocol has no progressive
disclosure: there is no "give me names, I will ask for details" negotiation.
Servers are written to be self-describing to arbitrary clients, so authors write
exhaustively. That is correct for interoperability and ruinous for context
economics, and the cost falls on every session rather than the ones that use it.

## The pattern

1. **A shell command carries the capability.** Extend the credential helper that
   already reaches the service rather than adding a new tool. Every harness can
   run a shell, so one command serves all of them with no per-harness config.
2. **A skill carries the knowledge.** One skill documents the command, the
   credential rule and the failure modes. Skills defined in the plugin
   marketplace reach the shared agent skill tree, so a single definition serves
   every harness — verify this on the target machine rather than assuming it.
3. **Scope it per repository.** A plugin earns an always-on enable only when it
   is useful in nearly every repository. Everything else is enabled by the
   repositories where that work happens, the same way domain skill groups are.
4. **Size the surface from recorded usage.** Count real invocations in local
   agent transcripts and expose exactly those operations. Match the tool-call
   form, not the bare tool name — a name grep overcounts by around 100x, because
   every session's own schema dump contains every tool name.
5. **Mint credentials at call time.** The command obtains a short-lived token
   from the secret store per invocation and keeps it in memory. Never store one,
   never export one into a profile, never write one to disk.

## When an MCP server is still right

- The capability needs structured tool-calling the model must plan against, not
  a command whose output it reads.
- The service has no CLI or HTTP surface a shell can reach.
- It is genuinely used in nearly every session, so the schema cost is earned.

Where a server is warranted but not universal, hold it out of the always-on
profile and attach it per session instead.

## Anti-patterns

- **Blanket-installing a domain integration.** Every session in every repository
  pays for it; only some use it.
- **Wrapping a service the credential helper already reaches.** Extend the
  existing tool; a second one drifts from the first.
- **Documenting a surface nobody uses.** Exposing every endpoint an API offers
  reproduces MCP's problem in a different file.
- **Inferring a limit instead of testing it.** Verify what a credential can
  actually do — a bot token, for example, is rejected outright on some endpoints
  regardless of its scopes, and that is an API constraint rather than something
  a grant can fix.
