# Phase 2 kickoff (Codex) — Akash-on-Base, end-to-end, production

Successor to `r1-kickoff.md` (R1 is live on testnet). **Phase 2 builds the whole product
end-to-end for Akash only, settling on Base only — no cross-chain, no second network,
nothing mocked.** The canonical plan is `metrik-protocol/docs/master-plan.md`; the
build-scope tracker is `metrik-protocol#30`.

## The scope rule

Build **only `phase:p2`** issues. Anything labeled **`phase:p3`** (cross-chain,
multi-DePIN, decentralized verifier network) is **out of scope — do not start it**. If a
`phase:p2` issue seems to require `phase:p3` work, STOP and flag it (see the rule below).

## Suggested build order (respect each issue's `Depends on:`)

1. **On-chain interface first** (everything downstream binds to it): protocol fee module
   (`metrik-contracts#8`), SLA bond/insurance tier (`metrik-contracts#22`), SLA receipt
   primitive (`metrik-contracts#10`), emergency guardian/pausability (`metrik-contracts#9`),
   coverage gate (`metrik-contracts#5`) → then ABI sync (`metrik-protocol#9`) so
   `@absol-labs/shared` re-publishes.
2. **Verification + binding:** serviceRef↔service binding (`metrik-protocol#23`), SLA
   quality checks beyond liveness (`metrik-oracle#39`), signer hardening
   (`metrik-oracle#8/#9`, `metrik-contracts#7`).
3. **SDK:** typed errors / safe approvals (`metrik-sdk#6`), operator onboarding spec
   (`metrik-sdk#24`), gas abstraction (`metrik-sdk#8`).
4. **Agent path:** signed mandates (`metrik-agent#3`) → x402 verified-stream facilitator
   (`metrik-agent#4`) → MCP server gated by mandates (`metrik-agent#5`) → non-custodial
   wallet provisioning (`metrik-agent#15`) → example agent (`metrik-agent#8`) → zkTLS L4
   (`metrik-agent#12`) → end-to-end hire→stream→settle (`metrik-agent#13`).
5. **Hardening / hygiene:** cross-repo threat model (`metrik-protocol#7`), observability +
   runbook (`metrik-oracle#11`), security review package (`metrik-contracts#6`), docs
   reconcile (`metrik-protocol#11`), canonical spec (`metrik-protocol#2`), branding rename
   (`metrik-protocol#31`).

## Human-intervention rule (unchanged, still in force)

If a `phase:p2` issue needs a real thing you don't have (a funded account, an Akash
deployment + its public URL, a hosting secret, a key, a published `@absol-labs/shared`) —
or it needs a new piece of scope — **STOP. Do not fake it.** Open a `human-intervention`
issue describing exactly what's needed, and move to the next independent issue. Never fake,
mock, or stub to proceed. **Never create new feature/roadmap issues yourself — new issues
are a human decision.** Hosting and on-chain deploys/broadcasts are explicit human/ops
steps: build and verify locally; do not deploy or broadcast value without human approval.

## Per-issue prompt

Use the Task prompt in `codex-kickoff.md` PART C, and add to step 1:
> Also read `metrik-protocol/docs/master-plan.md` (scope + architecture) and
> `metrik-protocol/docs/verification-model.md`. Phase 2 verifies Akash via **L1**
> (public-endpoint probe) plus **L4 zkTLS** for the agent path — never the provider admin
> API. Settle on **Base only**; do not add cross-chain or a second network.

**Start with the contract-interface issues** (`metrik-contracts#8` fee, `#22` bond) so the
ABI is stable, then re-publish `@absol-labs/shared` and proceed down the order above.
