# Metrik

**The trust and payment layer for the agent economy — pay only for delivery that's proven.**

> _"x402 proves the payment, Metrik proves the delivery."_

Metrik is where AI agents discover, pay for, and verify third-party services. An agent
escrows stablecoins, an independent **verifier** confirms the service is actually being
delivered, and payment is released **only for verified delivery** — with automatic refund
on failure and on-chain reputation. Metrik is **infra-agnostic** (a seller runs its service
on any backend — Akash, io.net, AWS, bare metal — and Metrik only ever sees a URL + a payout
wallet) and settles **single-chain**. Built to complement [x402](https://www.x402.org/).

Agents also get the infrastructure to transact safely: a **non-custodial wallet** (keys
never held by Metrik), signed **spend mandates**, and **MCP / x402** tooling.

> **Status:** live end-to-end on **testnet** (real escrow + oracle + real Akash compute +
> metered accrual). The marketplace and verification hardening are being built.

## The repos

| Repo | Role |
|------|------|
| [metrik-protocol](https://github.com/Absol-Labs/metrik-protocol) | **Hub** — spec, `@absol-labs/shared` (types / EIP-712 / ABI), whitepaper, master plan |
| [metrik-contracts](https://github.com/Absol-Labs/metrik-contracts) | On-chain metered escrow + M-of-N verifier (EVM / Base). Owns the contract ABI |
| [metrik-oracle](https://github.com/Absol-Labs/metrik-oracle) | **The verifier** — infra-agnostic delivery probe + attestation submitter (single-chain) |
| [metrik-sdk](https://github.com/Absol-Labs/metrik-sdk) | TypeScript developer SDK |
| [metrik-agent](https://github.com/Absol-Labs/metrik-agent) | x402 + MCP + framework tools + spend mandates + non-custodial wallets — the agent layer |

## Start here

- **What Metrik is / who it serves:** [master-plan.md](https://github.com/Absol-Labs/metrik-protocol/blob/main/docs/master-plan.md)
- **Positioning:** [product-strategy.md](https://github.com/Absol-Labs/metrik-protocol/blob/main/docs/product-strategy.md)
- **How delivery is proven:** [verification-model.md](https://github.com/Absol-Labs/metrik-protocol/blob/main/docs/verification-model.md)
- **Spec:** [attestation.md](https://github.com/Absol-Labs/metrik-protocol/blob/main/docs/spec/attestation.md)
- **How to contribute:** [CONTRIBUTING.md](https://github.com/Absol-Labs/.github/blob/main/CONTRIBUTING.md)
- **Building with AI agents (Codex):** [docs/CODEX-KICKOFF-MODEL-A.md](https://github.com/Absol-Labs/.github/blob/main/docs/CODEX-KICKOFF-MODEL-A.md)

> **Naming:** the product is **Metrik**. Repos and the deployed EIP-712 domain keep the
> historical `streamproof` / `StreamProof` identifiers for compatibility.
