# StreamProof

**Verified payments for the machine economy — pay DePIN services per second, only while delivery is proven.**

StreamProof is the SLA-verification and conditional-payment layer between **AI
agents** and **DePIN networks** (compute, storage, bandwidth). An agent funds a job,
an off-chain **verifier** confirms the service is actually being delivered, and USDC
is released to the operator **only for verified delivered time** — settled, over
time, **on the chain where the service lives**. Built to complement
[x402](https://www.x402.org/).

## The repos

| Repo | Role |
|------|------|
| [streamproof-protocol](https://github.com/Absol-Labs/streamproof-protocol) | **Hub** — spec, `@absol-labs/shared` (types / EIP-712 / ABI), whitepaper, settlement strategy |
| [streamproof-contracts](https://github.com/Absol-Labs/streamproof-contracts) | On-chain escrow (EVM now; SVM/CosmWasm later). Owns the contract ABI |
| [streamproof-oracle](https://github.com/Absol-Labs/streamproof-oracle) | **The verifier** + DePIN adapters + the decentralization ladder + multi-chain submitter |
| [streamproof-sdk](https://github.com/Absol-Labs/streamproof-sdk) | TypeScript developer SDK |
| [streamproof-agent](https://github.com/Absol-Labs/streamproof-agent) | x402 + MCP + framework tools + spend mandates — the agent wedge |

## Start here

- **Spec:** [protocol/docs/spec/attestation.md](https://github.com/Absol-Labs/streamproof-protocol/blob/main/docs/spec/attestation.md)
- **Cross-repo roadmap + prototype scope:** [ROADMAP.md](https://github.com/Absol-Labs/.github/blob/main/ROADMAP.md)
- **How to contribute:** [CONTRIBUTING.md](https://github.com/Absol-Labs/.github/blob/main/CONTRIBUTING.md)
- **Working with AI agents (Codex):** [docs/codex-playbook.md](https://github.com/Absol-Labs/.github/blob/main/docs/codex-playbook.md)
