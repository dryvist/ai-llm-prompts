---
type: LLM Prompt
title: Raycast Smart Issue user template
description: Dynamic context, output contract, and example used to generate a GitHub issue.
resource: prompt://dryvist/applications/raycast-smart-issue-user
tags: [raycast, github, issue-writing, template]
timestamp: 2026-07-18T16:43:26-04:00
status: active
consumers:
  - dryvist/raycast-smart-issue
render:
  engine: application
  variables: [ctx.repo.name, ctx.repo.description, openText, similarText, labelsBlock, prefsBlock, labelInstructions, ctx.idea]
  frontmatter: strip
source_history:
  - repository: dryvist/raycast-smart-issue
    path: src/lib/prompt.ts
    commit: a7dd6561f50bd3da2e16140e4016657a89c2b3d3
---
<context>
<repository>${ctx.repo.name}: ${ctx.repo.description}</repository>
<open_issues>
${openText}
</open_issues>
<similar_issues>
${similarText}
</similar_issues>
</context>

${labelsBlock}${prefsBlock}<format>
If a similar issue fully covers this idea, respond ONLY: DUPLICATE:#<number>
Otherwise output EXACTLY:
---TITLE---
<concise title, max 80 chars>
---BODY---
## Summary
<1-2 sentence description>

## Details
<expanded context and implementation notes>

## Acceptance Criteria
- [ ] <criterion 1>
- [ ] <criterion 2>
- [ ] <criterion 3>
---END---${labelInstructions}
</format>

<example>
---TITLE---
Add retry logic for failed webhook deliveries
---BODY---
## Summary
Webhook deliveries currently fail silently with no retry, causing missed events when downstream services are temporarily unavailable.

## Details
Implement exponential backoff retry with configurable max attempts. Failed deliveries should be logged and eventually dead-lettered for manual inspection.

## Acceptance Criteria
- [ ] Failed webhooks retry up to 3 times with exponential backoff (1s, 2s, 4s)
- [ ] All retry attempts are logged with attempt number and error
- [ ] Permanently failed deliveries are written to a dead letter queue
---END---
---LABELS---
type:feature
priority:medium
size:m
---LABELS-END---
</example>

<idea_parsing>
Map conventional commit prefixes to types: feat: → type:feature, fix: → type:bug, docs: → type:docs, chore: → type:chore, refactor: → type:refactor, test: → type:test, perf: → type:perf, ci: → type:ci
Extract inline hints like "size:s", "priority:high" from the idea text.
Strip these prefixes from the title — they are metadata only.
</idea_parsing>

IDEA: ${ctx.idea}
