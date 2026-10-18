---
name: technical-writing
description: Prose style for docs, comments, commits, PRs, and messages — Google technical-writing style at an 8th-grade reading level.
paths: ["**/*.md", "**/*.mdx", "**/*.rst", "docs/**"]
type: LLM Prompt
title: "Technical writing"
resource: "prompt://dryvist/auto-ai-agent/instructions/agentsmd/rules/technical-writing"
tags:
  - shared-instructions
  - agent-instructions
timestamp: "2026-10-18T08:44:13-04:00"
status: active
consumers:
  - dryvist/nix-ai
  - dryvist/nix-claude-code
render: { engine: literal, variables: [], frontmatter: strip }
source_history:
  - repository: dryvist/ai-assistant-instructions
    path: "agentsmd/rules/technical-writing.md"
    note: Migrated from the instruction repository.
---

# Technical writing

Write prose — docs, code comments, commit bodies, PR text, chat — in
[Google technical-writing style](https://developers.google.com/tech-writing/one)
at an 8th-grade reading level.

- **Short sentences.** One idea each. Split a sentence that runs past one clause.
- **Plain words.** Prefer the short word to the long Latinate one: `use` not
  `utilize`, `help` not `facilitate`, `about` not `regarding`, `to` not `in
  order to`.
- **Active voice.** Name the actor: "the hook blocks the commit", not "the
  commit is blocked".
- **Terms of art stay.** Keep the precise technical word, but define it the
  first time it appears.

When your runtime has Claude Code skill support, invoke the `elements-of-style`
plugin's `writing-clearly-and-concisely` skill before writing prose (enabled via
nix-ai).
