---
name: Protocol task
about: Implementation task for StreamProof
title: "[Phase] "
labels: ""
assignees: ""
---

## Phase

## Owner Track

## Outcome

## Requirements

## Acceptance Criteria

## Security Pass Required

This issue is not complete until the checklist below is explicitly reviewed if
the change touches funds, signatures, service verification, external data, or
secret handling.

- [ ] Funds safety: no path can overpay the operator, double-refund the buyer, or move more than the original deposit.
- [ ] Signer/replay safety: signatures, sequence numbers, domain separation, and timestamp rules are preserved.
- [ ] Fail-safe defaults: missing, stale, failed, ambiguous, invalid, or unverifiable external state cannot create operator accrual.
- [ ] Secret handling: private keys, credentials, API keys, RPC tokens, and live provider credentials are never committed, logged, persisted, or mocked to fake success.

## Notes
