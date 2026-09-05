# .github — Metrik org meta

Org-level community-health files and cross-repo documentation for **Absol-Labs / Metrik**, the
verified-delivery layer for the agent economy. These files apply org-wide through GitHub's
community-health-file defaults, so any repo under the org that does not define its own inherits
them.

| File | Purpose |
|------|---------|
| [`profile/README.md`](./profile/README.md) | The org profile page rendered at [github.com/Absol-Labs](https://github.com/Absol-Labs) — the public front door |
| [`ROADMAP.md`](./ROADMAP.md) | Cross-repo roadmap: the dependency spine, and what is built now vs. next vs. parked |
| [`SECURITY.md`](./SECURITY.md) | Security policy — reporting channel and the standing rules every repo follows |
| [`CONTRIBUTING.md`](./CONTRIBUTING.md) | How to develop across the repos |
| [`docs/CODEX-KICKOFF-MODEL-A.md`](./docs/CODEX-KICKOFF-MODEL-A.md) | AI-agent (Codex) kickoff for the Model A build |
| [`docs/codex-playbook.md`](./docs/codex-playbook.md) | The cross-repo working playbook |
| [`.github/ISSUE_TEMPLATE/`](./.github/ISSUE_TEMPLATE/) | Default issue template for org repos without their own |

The canonical product docs live in
[metrik-protocol/docs](https://github.com/Absol-Labs/metrik-protocol/tree/main/docs); start
from [master-plan.md](https://github.com/Absol-Labs/metrik-protocol/blob/main/docs/master-plan.md).

> **Naming:** the product is **Metrik** and the repositories are `metrik-*`. The deployed EIP-712
> domain is immutable and still reads `StreamProof`; local working directories are likewise still
> `streamproof-*`. Those two are compatibility artifacts, not stale branding.
