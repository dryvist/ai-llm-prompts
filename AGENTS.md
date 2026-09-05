---
skill-groups: [core, ai]
---
# AI Agents Configuration

## Repository purpose

This public repository is the canonical source for Dryvist-authored LLM prompts. Keep runtime prompt text here and keep consumer-specific
schedules, credentials, deployment IDs, and application logic in their owning repositories.

## Open Knowledge Format

All prompt changes MUST comply with Open Knowledge Format (OKF) 0.1.

- Put prompts only under `auto-ai-agent/`, `automation/`, `applications/`, or `developer-tools/`. Never put a prompt in the repository root.
- Every prompt or fragment Markdown file, except reserved `index.md` and `log.md` files, must have parseable YAML frontmatter.
- Required fields are `type`, `title`, `description`, `resource`, `tags`, `timestamp`, `status`, `consumers`, `render`, and `source_history`.
- Use `type: LLM Prompt` or `type: LLM Prompt Fragment` and a stable `prompt://dryvist/...` resource identifier.
- Preserve unknown frontmatter fields. Update `timestamp` after meaningful content changes.
- Update the affected directory `index.md` whenever a prompt is added, removed, or renamed.
- Update root `log.md` newest-first for every meaningful catalog change.
- Consumers must tolerate unknown OKF fields and must follow the prompt's declared rendering and frontmatter policy.

## Prompt contracts

Prompt resource identifiers, repository paths, required variables, frontmatter delivery, and rendering behavior are public consumer contracts.
Coordinate consumer updates before changing or removing them. Do not duplicate a canonical prompt body; use fragments or consumer-side
composition where needed.

Do not commit secrets, private infrastructure values, personal data, live tokens, or sensitive host context. Public prompt text must remain safe to publish.

## Release policy

The bootstrap release is `v0.1.0`.

AI agents MUST NOT create, push, or publish a major or major-equivalent breaking release. This prohibition includes `v1.0.0`, every later
major-version increment, and breaking changes during 0.x development. Major and breaking releases are human-only decisions. Agents may
prepare compatible patch or minor changes, but must halt before any human-only release boundary.

Release tags are immutable. Consumers pin the full commit represented by a release and receive updates through Renovate PRs.

## Change behavior

- Search before adding tooling; do not add repository scripts when an existing native tool or configuration can perform the check.
- Make atomic commits and surgical changes.
- Validate OKF metadata, Markdown, links, Nix outputs, and affected consumer contracts with the narrowest available proof.
- Documentation is descriptive. Directives belong in this file.
