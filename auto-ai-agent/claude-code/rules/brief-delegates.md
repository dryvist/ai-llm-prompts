---
type: LLM Prompt Fragment
title: "Brief Delegates Completely"
description: "Always-loaded rule: the parent owns every subagent brief and states goal, scope, constraints, success check, output contract, stop conditions and difficulty in it."
resource: "prompt://dryvist/auto-ai-agent/claude-code/rules/brief-delegates"
tags:
  - "claude-code"
  - "delegation"
  - "briefing"
timestamp: "2026-10-10T12:00:00-04:00"
status: active
consumers:
  - "dryvist/nix-ai"
render:
  engine: literal
  variables: []
  frontmatter: include
source_history:
  - repository: "dryvist/ai-llm-prompts"
    path: "auto-ai-agent/claude-code/rules/brief-delegates.md"
    note: "Authored net-new. Delivered as an always-loaded Claude Code rule; no hook checks briefs."
---

**Brief delegates completely.** A subagent knows only its prompt: nothing of this conversation, the files you read,
the user's preferences or what already failed. What the brief leaves out, the delegate guesses or skips, and the
parent owns that outcome. A vague brief is the parent's failure, never the delegate's. Every brief states:

1. the goal and the intent behind it;
2. the exact scope (repo, absolute paths, branch or worktree) and what must not be touched;
3. constraints, patterns to follow (`file:line`) and decisions already made, pasted rather than referred to;
4. the success criterion: the exact check to run and the result that means done;
5. the output contract: report file path, line cap, evidence required;
6. where to stop and report instead of guessing: a gate, a refusal, an ambiguity, a second failure;
7. difficulty and risk in plain words, never a model name. Routing picks the cheapest tier the brief justifies, so
   a thin brief buys the weakest executor.

Test: could a capable contractor with no access to this conversation finish from the brief alone? If not, rewrite
it. Never write "as discussed", "the bug we found", "look into X" or "based on your findings, implement it": handing
off understanding is not handing off work. Worked example: `prompt://dryvist/auto-ai-agent/model-delegation`.
