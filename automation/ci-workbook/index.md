# CI Workbook

Known CI failure signatures and how to handle them. Each entry's `ci_workbook` frontmatter field is a JSON
object with the entry `id`, its `class` (`aggregate`, `transient`, `never_retry`, `deterministic`,
`recipe` or `human`), a `match.log` regular expression applied to the normalized failure text, and
optional `fix.command` and `reproduce` commands. The body is the recipe given to the fixing agent.

## Entries

* [Aggregate result job](aggregate-rollup.md) - `aggregate`: A roll-up job failed only because another job in the same run failed.
* [Runner lost](infra-runner-lost.md) - `transient`: The runner disappeared mid-job.
* [Action archive download failed](action-download-failed.md) - `transient`: Downloading an action archive failed during job setup.
* [Upstream service unavailable](upstream-unavailable.md) - `transient`: A dependency answered with a gateway or availability error.
* [Molecule instance cleanup](molecule-instance-cleanup.md) - `transient`: Molecule could not reach or delete its test instance.
* [Model budget or key scope](model-budget-or-scope.md) - `human`: The model router refused the request on budget or key scope.
* [AI agent refused a bot actor](ai-agent-bot-actor.md) - `human`: An AI workflow refused to run for a bot-triggered event.
* [AI agent execution failed](ai-agent-exec-failed.md) - `human`: An AI agent step exited without a usable result.
* [App token installation not found](app-token-not-found.md) - `human`: The GitHub App is not installed on the repository, or the App id secret is wrong.
* [App private key invalid](app-token-jwt.md) - `human`: The GitHub App private key secret is malformed or belongs to a different App.
* [Required secret missing](missing-secret.md) - `human`: A workflow secret did not reach the job.
* [Disclosure denylist hit](disclosure-denylist.md) - `human`: The disclosure scan matched restricted text in the diff, title or body.
* [Privileged VPN download test](never-retry-download-vpn.md) - `never_retry`: This test knocks shared runners offline.
* [Markdownlint](markdownlint.md) - `deterministic`: Fix only Markdown files this branch added or modified.
* [File size limit](file-size-limit.md) - `recipe`: A file exceeds the repository's size limit.
* [Token limit](token-limit.md) - `recipe`: An always-loaded instruction file exceeds its token budget.
* [Nix flake check](nix-flake-check.md) - `recipe`: Reproduce with the command above and read the first error, not the last.
* [Flake input behind its branch head](flake-input-not-at-head.md) - `recipe`: A pinned flake input lags its branch head.
* [Home Manager conflicting definition](hm-conflicting-definition.md) - `recipe`: Two modules set the same option.
* [Ansible-lint](ansible-lint.md) - `recipe`: Reproduce, then fix only the reported rules on the reported lines.
* [Zizmor workflow audit](zizmor.md) - `recipe`: Zizmor flagged a workflow.
* [Link check](link-check.md) - `recipe`: A 429 or 5xx from a large site is transient: rerun once.
* [Workflow script path missing](script-path-missing.md) - `human`: A reusable workflow could not find one of its own scripts, so its checkout ref is wrong.
* [Back-merge conflict](backmerge-conflict.md) - `human`: A release back-merge has conflicts.
* [Dependency review found a vulnerability](dependency-review-vulnerable.md) - `human`: A dependency update introduces a known vulnerability.
* [Nix install needs privilege](install-nix-privilege.md) - `human`: Installing Nix on the runner needs privileges the runner lacks.
