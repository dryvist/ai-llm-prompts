---
name: shell-conventions
description: Shell variable naming and bracing conventions — bare $VAR, name intermediates after source or destination only.
paths: ["**/*.sh", "**/*.bash", "**/*.zsh", "**/.zshrc", "**/.envrc"]
type: LLM Prompt
title: "Shell Conventions"
resource: "prompt://dryvist/auto-ai-agent/instructions/agentsmd/rules/shell-conventions"
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
    path: "agentsmd/rules/shell-conventions.md"
    note: Migrated from the instruction repository.
---

# Shell Conventions

## Bracing

`$VAR` is the simplest expression and is preferred. Use `${VAR}` only when
the next character would otherwise extend the variable name (a letter,
digit, or underscore) — e.g. `${VAR}suffix`, `${VAR}_backup`. Never brace
reflexively: `$HOME/anything` is correct, `${HOME}/anything` is noise.

## Naming intermediates

When a shell variable is just a pass-through — read from one name, fed to
another — name it after **either** the source or the destination. Never
invent a third name.

```bash
# Bad — CF_ACCT is neither the source name nor the destination name
CF_ACCT=$(security find-generic-password -s CF_ACCOUNT_ID -w …)
export CLOUDFLARE_ACCOUNT_ID=$CF_ACCT

# Good — destination-named, no intermediate
export CLOUDFLARE_ACCOUNT_ID=$(security find-generic-password -s CF_ACCOUNT_ID -w …)

# Also good — source-named, used directly downstream
CF_ACCOUNT_ID=$(security find-generic-password -s CF_ACCOUNT_ID -w …)
some-tool -var "cloudflare_account_id=$CF_ACCOUNT_ID"
```

Triple-naming forces the reader to trace three layers (source name →
intermediate → consumer name) instead of one.
