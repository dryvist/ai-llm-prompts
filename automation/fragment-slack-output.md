---
type: LLM Prompt Fragment
title: "Slack Output"
description: "Shared Slack output and sanitization rules for cloud routines."
resource: "prompt://dryvist/automation/slack-output"
tags:
  - "automation"
  - "routine"
  - "fragment"
timestamp: "2026-07-18T16:40:00-04:00"
status: active
consumers:
  - "dryvist/claude-code-routines"
render:
  engine: literal
  variables: []
  frontmatter: strip
source_history:
  - repository: "dryvist/claude-code-routines"
    path: "routines/_common/slack-output.md"
    commit: "11a75537a6ec52bdf60f37b06c8a5ebd51562a4d"
---
Slack output is mandatory: emit exactly one of this routine's templates per run, even on a no-op. Never exit silently. If `state_fallback=true` was set (state-file read degraded to in-memory), prepend a one-line warning to the message. This is distinct from a `🔴 FATAL` preflight exit (blocked/unreachable GitHub API) — a state-file miss is a soft memory-degradation banner, never a substitute for the FATAL path.

Sanitize before posting. Slack's `<!channel>`, `<!here>`, `<@USERID>`, `<#CHANNEL>`, `<URL|text>` tokens can be smuggled through PR titles, issue bodies, and alert names. Every field derived from repo content MUST pass the redaction set (Hard Rules) and then have `<` / `>` escaped — literal control tokens this routine's own templates emit deliberately are exempt:

```bash
safe() { jq -Rr 'gsub("<"; "‹") | gsub(">"; "›")'; }
echo "${untrusted_title}" | safe
```
