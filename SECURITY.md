# Security Policy

Metrik moves funds based on signed delivery attestations, so security is a first-class concern
across every repo. This policy applies org-wide; per-repo specifics live in each repo's
`docs/security.md`.

## Reporting

Report vulnerabilities **privately** — do not open a public issue for an exploitable finding.
Email `arunabha@armore.ai` or use GitHub private security advisories on the affected repo.
Include reproduction steps, affected repo and version, and the concrete impact. We prioritize
anything that lets an operator accrue for undelivered work, lets a buyer's escrowed funds be
taken or locked, or forges an attestation.

## Standing rules (all repos)

Everything on-chain today is **testnet only** (Base Sepolia, chainId 84532) — no mainnet value
moves, and none should until an external contract review is complete. No secrets ever land in
git, logs, or PRs: private keys, RPC URLs carrying tokens, API keys, and mnemonics stay out, and
`.env.example` files carry variable names only. Any key pasted into a chat or shared channel is
treated as burned and rotated.

The verifier and contracts are **buyer-favoring and fail-safe by construction**: missing, stale,
failed, or unverifiable verification must never create operator accrual, and probe adapters
return `Failed` on any uncertainty. Two consecutive failed checks auto-pause a stream and the
buyer reclaims unspent funds; `checkedAt ≤ block.timestamp` is enforced on-chain. Every pull
request touching funds, signatures, verification, or autonomous spend completes a Security Pass
checklist before merge.

## Accepted v1 risk: the federated verifier

The on-chain verifier supports an M-of-N threshold attestation, but in the current testnet v1 a
single operator runs it (2-of-3 signing, one trust domain). We state this plainly rather than
imply decentralization we have not shipped. The mitigation is the verification ladder: L4
decentralizes the verifier into independent, staked, multi-vantage operators, and L5 adds an
optimistic dispute window with bonds and slashing
([UMA Optimistic Oracle V3](https://uma.xyz/)) as recourse against a bad attestation. The staged
plan is documented in
[metrik-oracle/docs/verifier-ladder.md](https://github.com/Absol-Labs/metrik-oracle/blob/main/docs/verifier-ladder.md).

## Threat model

The canonical cross-repo threat model is
[metrik-protocol/docs/threat-model.md](https://github.com/Absol-Labs/metrik-protocol/blob/main/docs/threat-model.md).
