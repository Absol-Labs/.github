# Codex Kickoff — Metrik (Model A)

Read this before writing code. It **supersedes** `docs/codex-kickoff.md`, `docs/r1-kickoff.md`,
and `docs/phase-2-kickoff.md` (retired — Model A is the current framing).

## What Metrik is (one paragraph)

Metrik is an **infra-agnostic verified service marketplace + payment rail for AI agents**.
A seller lists a running service endpoint + a payout wallet; an agent escrows stablecoins
and pays **only for delivery an independent verifier proves**, with auto-refund on failure
and on-chain reputation. **Single-chain (Base, USDC).** Agents also get a non-custodial
wallet + spend mandates + MCP/x402 tooling. It is **NOT** compute-rental, an Akash broker,
or DePIN-specific, and there is **no cross-chain**. Full detail:
`metrik-protocol/docs/master-plan.md`.

## Read first

1. `metrik-protocol/docs/master-plan.md` — canonical plan.
2. The `AGENTS.md` in each repo you touch — working discipline.
3. `metrik-protocol/docs/verification-model.md`.

## Scope fence

- Build **only** Model A `phase:p2`. `phase:p3` is out of scope.
- **DEPRECATED / CLOSED — do NOT touch:** cross-chain / multi-chain settlement, per-network
  deep adapters (io.net / Aethir / AEP-64), multi-network orchestration. The verifier is one
  **infra-agnostic HTTP probe** — never write per-network adapter code.
- **Single-chain (Base) only.** No bridging, no other network's lease/escrow.

## Working discipline (non-negotiable)

- `gh auth switch --user arunabha003` before any `gh`/push/PR.
- **One issue per PR.** Branch from fresh `origin/main`. **Never push to `main`.**
  Squash-merge; delete the branch.
- Run the repo formatter before commit (`pnpm format` / `forge fmt`).
- **Never fake, mock, or stub a production path.** Fail-safe + **buyer-favoring**: on any
  ambiguity, do not accrue.
- Never commit or echo secrets. End commits with the `Co-Authored-By` trailer.

## Human-intervention rule

If an issue needs a real thing you don't have (a funded account, a hosting secret, a
credential, a live deployment + public URL) or new scope — **STOP, don't fake it.** Open a
`human-intervention` issue and move on. **Never invent feature/roadmap issues yourself.**
Never deploy or broadcast value without explicit human approval.

## Build order (Model A)

1. **oracle#51** — per-serviceRef verification-target resolution (the multi-seller unblocker).
2. **oracle#49** — canary known-answer checks.
3. **oracle#50** — nonce challenge-response + randomized probe timing.
4. **oracle#52** — auto-close on failure signal.
5. **agent#24** — consumer zkTLS as first-class delivery + dispute evidence.

Then: **agent#13** (hire→stream→settle E2E), **site#13** (listings) + **site#37**
(reputation-ranked discovery), **protocol#38** (reputation index), **contracts#22** (SLA
bond), **agent#21** (caller-auth), and the **escrow redeploy** + ABI resync (**protocol#9**).

Later (`phase:p3`): **oracle#54** (decentralized staked verifier), **contracts#26**
(optimistic dispute + slashing), **oracle#53** (redundant re-execution sampling).

## Definition of done (every issue)

Real implementation (no mocks on the production path); tests for the happy **and**
adversarial/failure paths; formatter / typecheck / build / tests green; docs updated; one
issue, one PR, CI green, squash-merged.

## Honesty rule

Metrik proves **delivery**, not output **correctness** for arbitrary models. Never write
code or docs claiming to "verify correctness" of nontrivial inference — canary + sampling +
reputation give **statistical/economic** assurance, not a cryptographic guarantee. When
unsure whether the service delivered, **do not accrue** — favor the buyer.
