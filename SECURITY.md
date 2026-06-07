# Security Policy

StreamProof moves funds based on signed delivery attestations. Security is a
first-class concern across every repo.

## Reporting

Report vulnerabilities **privately** to the maintainers (do not open a public issue
for an exploitable finding). Include repro steps and impact.

## Standing rules (all repos)

- **Testnet only** until the external contract review package is complete. No
  mainnet value.
- **No secrets in git/logs/PRs** — private keys, RPC URLs with tokens, API keys,
  mnemonics. `.env.example` is variable names only.
- **Buyer-favoring + fail-safe** — missing/stale/failed/unverifiable verification
  must never create operator accrual; adapters return `Failed` on any uncertainty.
- **Single trusted oracle signer is the accepted v1 (testnet) risk** — the
  decentralization ladder (threshold/MPC → dispute → restaked AVS/CRE + TEE) is the
  mitigation. See `streamproof-oracle/docs/verifier-ladder.md`.
- Every PR touching funds, signatures, verification, or autonomous spend completes a
  **Security Pass** checklist before merge.

## Threat model

The canonical cross-repo threat model lives in
[`streamproof-protocol/docs/threat-model.md`](https://github.com/Absol-Labs/streamproof-protocol/blob/main/docs/threat-model.md).
Per-repo specifics are in each repo's `docs/security.md`.
