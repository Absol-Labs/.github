# Contributing to StreamProof (cross-repo guide)

How we develop across the five repos. Each repo also has its own **`AGENTS.md`** —
that is binding for *how* to build in that repo; this file is the *cross-repo* glue.

## Repos & ownership

- **streamproof-protocol** — hub (spec + `@streamproof/shared` + docs). Shared.
- **streamproof-contracts** — escrow (Track A, @arunabha003).
- **streamproof-oracle** — verifier + adapters (Track B, @siddhantcookie).
- **streamproof-sdk** — developer SDK (Track B).
- **streamproof-agent** — x402/MCP/mandates (Track B).

## The one rule that matters: the seam

The **EIP-712 attestation + the contract ABI** are the contract between repos. They
live canonically in **streamproof-protocol** (`@streamproof/shared`). Never fork
those shapes in a consumer repo. A change to the attestation/ABI is a **breaking
protocol change** — bump the shared package and coordinate contracts + oracle + sdk
+ agent together.

## Picking work

1. Read the repo's `AGENTS.md` and the issue.
2. Respect the issue's **`Depends on:`** line and its **milestone** (P0–P3). Only
   start an issue whose deps are closed.
3. Honor the **prototype cut-line** in [ROADMAP.md](./ROADMAP.md): if it's not on the
   "DO for prototype" list, it's not part of the prototype.
4. **Cross-repo dependencies are real.** Many issues say "requires X in another repo
   first" (e.g. consuming `@streamproof/shared` needs the hub to publish it). If you
   hit one, stop and do the upstream issue (or flag it), don't fake it.

## Per-change workflow (every repo)

1. **Branch off `main`** — never commit to `main`. Name it `<type>/<issue>-<slug>`
   (e.g. `feat/issue-4-hire-compute`). Conventional-commit type matches the issue.
2. **Tests first** for anything touching funds, signatures, telemetry, or spend.
3. Implement the smallest change that closes the issue.
4. **Run the repo's full check set green** before opening a PR:
   - TypeScript repos: `pnpm typecheck && pnpm test && pnpm build`
   - contracts: from `evm/` — `forge fmt --check && forge build && forge test`
5. **Open a PR** with `Closes #N`, a short before/after, and the **Security Pass**
   checklist when the change touches funds/keys/attestations.
6. **Review → squash-merge → delete branch.** Update the repo's status/docs if state
   changed. Keep PRs small: one issue per PR.

## Non-negotiables

- **No fake green paths.** Never mock/stub/bypass a real integration to make tests
  or code *appear* to work. If a real dependency needs a key, RPC, funded account, or
  manual setup, **ask for it** — don't pretend.
- **No secrets in git/logs/PRs** — `.env.example` is variable names only. Private
  keys, RPC URLs with tokens, API keys never get committed, logged, or pasted.
- **Buyer-favoring + fail-safe defaults** — missing/stale/failed/unverifiable state
  never creates accrual; adapters return `Failed` on any uncertainty.
- **Testnet only** until the external review package is complete.

## Toolchain

- Node 20, pnpm 9.15.0 (Corepack), TypeScript repos are ESM.
- Foundry (solc 0.8.24); `streamproof-contracts` vendors forge-std + OpenZeppelin as
  submodules under `evm/lib` — clone with `--recursive`.

## Project board

Cross-repo work is tracked on the **StreamProof Roadmap** project (org-level). New
issues should be added to it and tagged with their phase.
