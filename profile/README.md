# Metrik

**The verified-delivery layer for the agent economy.**

> _"x402 proves the payment, Metrik proves the delivery."_

Metrik is an infra-agnostic verified-service marketplace and payment rail for AI agents on
[Base](https://base.org/). Agents discover, pay for, and verify third-party services;
escrowed USDC is released **only for delivery that an independent verifier has proven**, and
auto-refunds on failure. A seller runs its endpoint on any backend it likes — Akash, io.net,
AWS, bare metal — and Metrik only ever sees a URL and a payout wallet. Settlement is
single-chain (Base, USDC). Metrik is complementary to [x402](https://www.x402.org/): x402
settles the payment, Metrik proves the work was delivered before that payment is earned.


## How it works

An agent opens a stream: it escrows USDC and sets a per-second rate and budget under a signed
spend mandate. The verifier probes the seller's endpoint each interval; value accrues to the
seller only for verified, delivered time, following
`accrued += ratePerSecond × (checkedAt − lastVerifiedAt)`. Per-second is the accounting math,
not the transaction cadence — settlement is batched into roughly one transaction per stream per
poll interval (~15s), keeping gas bounded, and `checkedAt ≤ block.timestamp` is enforced
on-chain (`InvalidTimestamp`). Two consecutive failed checks auto-pause the stream, after which
the buyer reclaims all unspent funds.

## Verification stack

Defense-in-depth from cheap to expensive. Each layer narrows what a dishonest seller can get
away with; the lower layers run continuously, the upper layers are the trust-minimization moat.

| Layer | What it proves | Status |
|-------|----------------|--------|
| **L1 — hardened probe** | Liveness, latency, and schema, plus canary known-answer checks, nonce challenge-response, and randomized timing | **Live**, every interval |
| **L2 — consumer zkTLS** | The buyer proves what *they* received (via [Reclaim](https://reclaimprotocol.org/)), closing vantage-spoofing and MITM and providing dispute evidence | **Live**, in-app, buyer-side |
| **L3 — redundant re-execution sampling** | A sampled fraction of requests is re-run and compared for a statistical correctness signal | **Live**, deterministic, single-vantage today |
| **L4 — M-of-N staked multi-vantage verifier** | Independent, multi-region operators sign a threshold attestation into the on-chain verifier | **Live but federated** — 2-of-3, single operator today; independent staked operators are roadmap |
| **L5 — optimistic dispute + slashing** | A challenge window with bonds ([UMA Optimistic Oracle V3](https://uma.xyz/)) gives recourse against a bad attestation | **Deployed / armed** |


## Status

Live end-to-end on **Base Sepolia** (chainId 84532). Testnet only — no mainnet value moves.

| Contract | Address | Notes |
|----------|---------|-------|
| Metered escrow (per-tick) | `0x21948a5E6AE8d9A3D1050791AB6138657Fb54286` | Production build, Basescan-verified; powers the live flow |
| `StreamEscrowV2` (checkpoint) | `0x0f09f36Ccc05A7c9882F438721C08De314dFd46C` | Deployed + verified; **not yet wired** to the live flow |
| Settlement token (USDC) | `0x036CbD53842c5426634e7929541eC2318f3dCF7e` | Circle Base Sepolia test USDC |

Packages are published on npm: `@absol-labs/shared` 0.8.0, `@absol-labs/sdk` 0.5.1, and
`@absol-labs/agent` 0.3.2 (ESM-only).

## Surfaces

| Surface | URL |
|---------|-----|
| App | [app.metrik.live](https://app.metrik.live) |
| Marketing + docs | [metrik.live](https://metrik.live) |
| Oracle (verifier) | [oracle.metrik.live](https://oracle.metrik.live) |

## Repositories

| Repo | Role |
|------|------|
| [metrik-protocol](https://github.com/Absol-Labs/metrik-protocol) | Hub — canonical docs and `@absol-labs/shared` (types, EIP-712, ABI) |
| [metrik-contracts](https://github.com/Absol-Labs/metrik-contracts) | Metered escrow on Base; owns the contract ABI |
| [metrik-oracle](https://github.com/Absol-Labs/metrik-oracle) | The verifier — infra-agnostic delivery probe + attestation submitter |
| [metrik-sdk](https://github.com/Absol-Labs/metrik-sdk) | `@absol-labs/sdk` — TypeScript client (open, read, claim, close, reclaim, watch) |
| [metrik-agent](https://github.com/Absol-Labs/metrik-agent) | `@absol-labs/agent` — spend mandates, x402 facilitator, MCP server, framework tools, Reclaim zkTLS, non-custodial [CDP](https://www.coinbase.com/developer-platform) wallets |
| [metrik-site](https://github.com/Absol-Labs/metrik-site) | Marketing landing + dApp |


