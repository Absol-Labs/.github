# Phase 2 kickoff (Codex) — Akash-on-Base, end-to-end, production

Successor to `r1-kickoff.md` (R1 is live on testnet). **Phase 2 builds the whole product
end-to-end for Akash only, settling on Base only — no cross-chain, no second network,
nothing mocked.** Canonical plan: `metrik-protocol/docs/master-plan.md`; build-scope
tracker: `metrik-protocol#30`.

> **Current local execution state:** the workspace now keeps an authoritative
> [`implementation-track.md`](../../../implementation-track.md) at the repo root. Read it
> before choosing the next issue. It records completed work, local merge state, blockers,
> and `human-intervention` issues.

## The scope rule

Build **only `phase:p2`** issues. Anything labeled **`phase:p3`** (cross-chain,
multi-DePIN — io.net/Aethir, decentralized verifier/AVS) is **out of scope — do not start
it**. If a `phase:p2` issue seems to require `phase:p3` work, STOP and flag it.

## Autonomous operation — self-merge and continue

For Phase 2 you operate autonomously: open a PR per issue, then **squash-merge it yourself,
delete the branch, and pick up the next issue in the build order** — but ONLY when **all**
of these hold:

- **CI is green** — typecheck + tests + format/lint all pass. **Never merge red.**
- **Every Implementation-Checklist item and Acceptance-Criterion in the issue is satisfied.**
- **The Security Pass is completed honestly** (funds safety, signer safety, replay safety,
  fail-safe defaults, no secrets in code/logs).
- **One issue per PR**, with `Closes #N` and an honest before/after in the description.
- **Nothing was faked, mocked, or stubbed** to go green.

After merging: `git fetch` + reset to `main`, then take the **next issue in the build order
whose `Depends on:` are all merged.** Keep going.

**Do NOT self-merge — instead STOP, open a `human-intervention` issue, and move to the next
independent issue — when any of these is true:**

- CI is red, or you cannot make tests genuinely pass.
- You're blocked on a real external thing: a funded account, an Akash deployment + its
  public URL, a hosting secret, a key, or a not-yet-published `@absol-labs/shared`.
- The change requires a **deploy, an on-chain broadcast of value, or publishing a package**
  — these ALWAYS need explicit human approval; never do them autonomously.
- The change would alter the protocol seam (attestation format / EIP-712 domain / escrow
  ABI) in a way the spec doesn't already define — flag it.
- The work needs **new scope or a new feature**. **Never create feature/roadmap issues
  yourself** — only `human-intervention` issues are allowed; new feature issues are a human
  decision.

This autonomous-merge policy **supersedes the generic "squash-merge after review" line** in
each repo's `AGENTS.md` for the Phase-2 build.

## Build order — work issues in this sequence

Respect each issue's own `Depends on:`. Within a stage, issues can run in parallel unless
one depends on another.

## Current status snapshot (adapt this before starting)

**Completed locally and merged to local `main`:**

- `metrik-protocol#23` — service binding model
- `metrik-protocol#31` — user-facing Metrik branding pass
- `metrik-oracle#39` — SLA quality checks beyond liveness
- `metrik-site` branding sweep related to `#31`

**Current hard blocker:**

- `metrik-protocol#34` — human intervention required to publish `@absol-labs/shared`
  with the new `ServiceBinding` surface

**Implication:** do **not** start downstream work that would require the unpublished
binding surface or fake a local fork of it into another repo. Use the tracker file to
confirm whether an issue is genuinely independent before starting.

**Stage 1 — On-chain interface (contracts first; the ABI must stabilize before anything
binds to it):**

1. `metrik-contracts#8` — protocol fee module (verified-volume fee)
2. `metrik-contracts#10` — SLA receipt primitive (EAS / event-first)
3. `metrik-contracts#9` — emergency guardian / pausability (no fund seizure)
4. `metrik-contracts#7` — threshold / M-of-N oracle verifier
5. `metrik-contracts#6` — external security review package (Slither, coverage, audit handoff)
   → then the new ABI is published to `@absol-labs/shared` (ABI-sync work `metrik-protocol#9`;
   the actual publish is `metrik-protocol#34`, a human-gated/ops step).

**Stage 2 — Binding + spec (the core of network-derived supply integration):**

6. `metrik-protocol#23` — serviceRef ↔ service binding model (per-stream verification
   target). Changing shared types → republish via `#34`.

**Stage 3 — SDK seam:**

7. `metrik-sdk#24` — operator integration: health/quality endpoint spec + payout onboarding
8. `metrik-sdk#8` — gas abstraction (ERC-4337 paymaster) for agents

**Stage 4 — Verifier hardening (oracle):**

9. `metrik-oracle#39` — SLA quality checks beyond liveness (canary, latency, throughput)
10. `metrik-oracle#8` — Stage-1 managed/enclave signing (Turnkey or AWS Nitro)
11. `metrik-oracle#9` — Stage-2 threshold signing (Lit) + UMA optimistic dispute
12. `metrik-oracle#11` — observability: health, metrics, alerts, recovery runbook

**Stage 5 — Agent path:**

13. `metrik-agent#9` — budget-guardrail + key-custody review + threat doc (do this security
    design BEFORE wiring any fund-moving path)
14. `metrik-agent#4` — x402 verified-streaming facilitator
15. `metrik-agent#5` — MCP server (hire / status / reclaim) gated by mandates
16. `metrik-agent#15` — non-custodial agent wallet provisioning (Coinbase CDP / Privy)
17. `metrik-agent#12` — zkTLS consumer-attested delivery proof (L4)
18. `metrik-agent#6` — LangChain tool (first framework)
19. `metrik-agent#7` — ElizaOS / CrewAI adapters
20. `metrik-agent#13` — end-to-end hire → stream → settle journey (the integration capstone)

**Stage 6 — Web surface:**

21. `metrik-site#14` — real per-stream binding UI (choose a real deployment / serviceRef)
22. `metrik-site#13` — operator listings + marketplace surface (two-sided)

**Cross-cutting (anytime / as triggered):** `metrik-protocol#31` (branding rename);
`metrik-protocol#34` (publish `@absol-labs/shared` — human-gated, whenever shared changes).

**Carryover `phase:p1` deps — confirm merged before relying on them:**
`metrik-protocol#9` (ABI sync) and `metrik-agent#3` (signed mandates, EIP-712/VC). The
mandate engine is already real + tested; `#3` only adds signed-credential form.

**Pending a human decision — DO NOT START until relabeled `phase:p2`:**
`metrik-contracts#22` (SLA bond / insurance tier) and `metrik-protocol#25` (SLA reputation +
verified-uptime data). The master plan scopes these into Phase 2, but they are not yet
labeled `phase:p2`. If relabeled, slot the bond after Stage 1 and reputation after the SLA
receipt (`#10`).

## Adapted next-issue rule

The original build order is the architectural ideal, but the *actual* next issue must be
chosen by this rule:

1. Prefer the earliest `phase:p2` issue whose own `Depends on:` are closed **and** whose
   implementation does not require an unpublished package, a real credential, a funded
   account, a live deployment, or a new piece of scope.
2. If the next architecturally-ordered issue is blocked, open or reference the correct
   `human-intervention` issue and move to the next independent one.
3. Record the decision and blocker in `implementation-track.md`.

As of now, the practical blocker chain is:

- `metrik-protocol#34` blocks `metrik-sdk#24`
- `metrik-sdk#24` blocks parts of the site/operator onboarding lane
- several agent issues are still blocked by open dependencies (`#2`, `#3`, `#5`)
- oracle observability (`#11`) is blocked by `metrik-protocol#6`

## Per-issue prompt

Use the Task prompt in `codex-kickoff.md` PART C, and add to step 1:
> Also read `metrik-protocol/docs/master-plan.md` (scope + architecture),
> `implementation-track.md` (current completed work + blockers), and
> `metrik-protocol/docs/verification-model.md`. Phase 2 verifies Akash via **L1**
> (public-endpoint probe) plus **L4 zkTLS** for the agent path — never the provider admin
> API. Settle on **Base only**; do not add cross-chain or a second network.

**Do not blindly restart at `metrik-contracts#8`.** Start from the earliest *currently
independent* issue after consulting `implementation-track.md`, then proceed down the build
order, self-merging green PRs and raising `human-intervention` issues when blocked.
