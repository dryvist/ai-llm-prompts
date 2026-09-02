# Developer Tools

Prompts injected by development workflows, scheduled jobs, guards, and hooks.

## Prompts

* [Agent service integration pattern](agent-service-integration-pattern.md) - How an agent reaches an external service across every CLI harness at near-zero session cost.
* [Bash script heredoc block guidance](bash-script-heredoc-block.md) - Model-visible denial reason for creating script files with heredocs.
* [Bash script location block guidance](bash-script-location-block.md) - Denial reason for scripts outside approved directories.
* [Bash script redirect block guidance](bash-script-redirect-block.md) - Model-visible denial reason for creating script files with Bash redirects.
* [Claude post-PR finalization reminder](claude-post-pr-finalization.md) - System message injected after a successful gh pr create command.
* [Claude research-first reminder](claude-research-reminder.md) - System message injected for implementation-oriented user prompts.
* [Claude main-branch worktree reminder](claude-worktree-reminder.md) - System message injected when a Claude session starts work on the main branch.
* [Commit trailer normalization guidance](commit-trailer-guidance.md) - Notice emitted after enforcing the coding-assistants trailer.
* [Duplicate issue block guidance](duplicate-issue-block.md) - Exit-code-2 guidance shown when a proposed issue or PR duplicates an open item.
* [Git command block template](git-command-block.md) - Shared model-visible wrapper for blocked git and GitHub command reasons.
* [Git command caution template](git-command-caution.md) - Model-visible confirmation guidance for risky git operations.
* [GitHub GraphQL flag warning](git-graphql-flag-warning.md) - Corrective warning for template-processing flags in gh GraphQL queries.
* [GitHub GraphQL corrective guidance](git-graphql-guidance.md) - Model-visible corrective template for common gh api graphql failure patterns.
* [GitHub GraphQL multiline warning](git-graphql-multiline-warning.md) - Corrective warning for multiline gh GraphQL query forms.
* [GitHub GraphQL mutation-name warning](git-graphql-mutation-name-warning.md) - Corrective warning for known invalid GitHub GraphQL mutation names.
* [GitHub GraphQL shell-variable warning](git-graphql-shell-variable-warning.md) - Corrective warning for shell-expanded variables in gh GraphQL queries.
* [GitHub review-thread guidance](git-review-thread-guidance.md) - Model-visible denial reason for non-resolvable top-level PR review comments.
* [Inline Nix script block guidance](inline-nix-script-block.md) - Model-visible denial reason for complex shell code embedded in Nix.
* [Inline workflow script block guidance](inline-workflow-script-block.md) - Model-visible denial reason for complex shell code embedded in workflow YAML.
* [Main-branch edit block guidance](main-branch-edit-block.md) - Model-visible reason returned when an edit targets the main branch.
* [Nix Darwin flake update review](nix-darwin-flake-review.md) - Claude review instructions for risk-classifying flake.lock changes.
* [Private infrastructure leak block guidance](private-infrastructure-leak-block.md) - Denial guidance for leaked infrastructure identifiers.
* [Script prevention classifier](script-prevention-classifier.md) - Local classification prompt for legitimate artifacts versus unnecessary scripts.
* [Script write denial guidance](script-write-denial.md) - Model-visible denial reason after the local script classifier rejects a new file.
* [WebFetch current-year warning](webfetch-current-year-warning.md) - Model-visible warning for date-sensitive searches using the current year.
* [WebFetch outdated-year block guidance](webfetch-outdated-year-block.md) - Model-visible denial reason for searches containing an outdated year.
