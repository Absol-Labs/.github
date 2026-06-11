# R1 Kickoff — the real, local-first testnet prototype

This is the **R1 build sequence**: a real (no-mocks) end-to-end where a user opens a
real USDC stream on Base Sepolia against a **real rentable service**, the oracle verifies
it by **probing the service's public endpoint** (this resolves the Akash 401 — see
`streamproof-protocol/docs/verification-model.md`), accrual happens on-chain, real
downtime pauses it, and the buyer reclaims. Local-first; host on Render/Railway only
after it's verified locally via the frontend.

> Onboard Codex with **`codex-kickoff.md`** first (product overview + working
> discipline + per-issue Task prompt). This file is the **order** and the **R1-specific
> required reading**. Everything in `AGENTS.md` "Working discipline" is binding: read the
> whole issue, finish it, **never mock/fake to go green**, fail-safe, one PR per issue,
> ask the human when a real dependency is missing.

## Required reading for every R1 issue
- `streamproof-protocol/docs/verification-model.md` — the 4-layer model. **R1 uses L1
  only (public-endpoint probe).** Do NOT poll the provider admin API (that's the 401).
  Any uncertainty → `Failed`, never `Delivered`.
- The issue's own `Implementation Detail` + `Security Pass`.

## Build order (do strictly in sequence; respect `Depends on:`)

| # | Repo | Issue | Why this order |
|---|------|-------|----------------|
| 1 | `streamproof-protocol` | **#19** verification-mode/result types | Foundational — the adapter reports `mode`/`evidence` using these types. Publish a `@absol-labs/shared` minor after. |
| 2 | `streamproof-oracle` | **#29** adapter v2 — output-side probe (primary) | The core R1 change: verify by probing the public URL. Depends on #19. |
| 3 | `streamproof-oracle` | **#30** real rentable service + local e2e | Real service + run the verifier loop against the real escrow, locally. Depends on #29. |
| 4 | `streamproof-site` | **#1** wallet connect + Base Sepolia | Frontend foundation. No deps — can run in parallel with #2/#3 of oracle. |
| 5 | `streamproof-site` | **#2** test-USDC faucet | Depends on #1 (site). |
| 6 | `streamproof-site` | **#3** interactive testnet demo (Section 3) | The payoff — real open/accrue/pause/reclaim in the UI. Depends on site #1/#2 + oracle #29/#30. |

**Parallelism:** the two oracle issues (#29 → #30) and the two foundation site issues
(#1 → #2) are independent tracks; only site **#3** needs both tracks done.

**NOT in R1** (do not start): oracle #31 (delegated credential, R3), agent #4/#5/#12
(x402 / MCP / zkTLS, R2). If a task seems to need one of these, STOP — it's out of scope
for R1.

## Human-intervention rule
If an R1 issue needs a real thing you don't have (a funded account, an Akash testnet
deployment + its public URL, a hosting secret, an open-mint mock-USDC), **STOP, open a
separate `human-intervention` issue describing exactly what's needed, and move to the
next independent issue.** Never fake it to proceed. Hosting (Render/Railway, Akash
deploy) is explicitly a human/ops step — build and verify locally; do not deploy.

## Per-issue prompt
Use the **Task prompt in `codex-kickoff.md` PART C**, and add this line to step 1:
> Also read `streamproof-protocol/docs/verification-model.md`; R1 uses **L1 only**
> (probe the public endpoint, never the provider admin API).

**Start with `streamproof-protocol` #19.** When it's merged and `@absol-labs/shared` is
re-published, proceed to oracle #29.
