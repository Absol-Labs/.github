# Codex Kickoff — paste this to onboard the agent

Use this **once at the start of a Codex session** to load full context, then use the
**Task prompt** at the bottom for each issue. The per-repo `AGENTS.md` (esp. its
"Working discipline" section) and the org `CONTRIBUTING.md` / `ROADMAP.md` are binding.

---

## PART A — Product overview (read and internalize)

**What StreamProof is.** StreamProof is the **SLA-verification and conditional-payment
layer** between AI agents and DePIN networks (decentralized physical infrastructure:
GPU compute, storage, bandwidth, sensors). An agent (or app) funds a job up front, an
off-chain **verifier** continuously confirms the service is actually being delivered,
and USDC is released to the operator **only for verified delivered time** — settling,
over time, **on the blockchain where the DePIN service lives**. The moment delivery
fails, payment pauses automatically and unspent funds remain reclaimable by the buyer.

**The problem.** AI agents are becoming the primary buyers of physical infrastructure
(renting GPUs on Akash/io.net, storage on Filecoin, connectivity on Helium). But they
pay like it's 2010: upfront, lump-sum, with **zero proof the service was delivered**.
If a rented GPU dies after 20 minutes, there's no automatic refund and no way to pay
only for the minutes actually served. Payment rails (including Coinbase's **x402**)
settle the *payment* but never verify the *service* — they treat continuous physical
services like one-shot API calls.

**The solution — "verify first, pay as you go".** StreamProof inserts a verification +
conditional-release layer:
1. A buyer opens a **stream**: escrows USDC, names the operator + a `serviceRef`, sets
   a `ratePerSecond` and a `maxDuration`.
2. An **oracle/verifier** polls the DePIN service's live state (e.g. an Akash lease's
   health) every few seconds and signs an **EIP-712 attestation**: at time `checkedAt`,
   stream X was `Delivered` or `Failed` (reading number `sequence`).
3. The **escrow** accrues payment for verified, in-window time only; **two consecutive
   failures pause** accrual; the operator can **claim** earned funds; the buyer can
   **reclaim** everything that was never earned (on close or expiry).

**The buyer-favoring guarantee (the heart of it).** Money only moves for time that is
delivered AND within `[openedAt, expiresAt]` AND not in a failed/paused window. Missing,
stale, failed, post-expiry, or invalidly-signed verification creates **zero** accrual.
`accrued ≤ deposit` and `claimed + claimable + reclaimable ≤ deposit`, always (fuzz-
proven). This is non-negotiable and must never be weakened.

**Where it sits vs x402.** x402 standardizes *how an agent pays* over HTTP and settles
USDC. StreamProof adds the missing half — *did the service actually get delivered, and
should money keep flowing?* It **complements** x402 (can reuse its USDC settlement),
adding the metered, verified, mid-service-cancellable dimension x402 lacks.

**The moat.** The escrow is commodity; the **Verifier Network** is the defensible
layer — "Chainlink for DePIN SLAs". v1 uses a single trusted oracle signer (accepted
testnet-only risk); the roadmap climbs a **decentralization ladder**: single signer
(Turnkey/Nitro) → threshold/MPC (Lit) + optimistic dispute (UMA) → restaked AVS
(EigenLayer) or Chainlink CRE + TEE-attested reads. See
`streamproof-oracle/docs/verifier-ladder.md`.

**Cross-chain direction.** Verification is chain-agnostic; **settlement is a pluggable
per-chain target** — the goal is to settle USDC on the chain where the service lives
(EVM, Solana, Cosmos, FVM), phased Base → Solana(relayer) → native Solana →
Cosmos/FVM via audited rails (CCTP/Axelar/Wormhole), never a custom bridge. See
`streamproof-protocol/docs/settlement-strategy.md`.

**Beachhead.** Akash (prototype, easiest to verify) → io.net (AI-native, Solana) →
Aethir (enterprise revenue). **Business model:** a protocol fee on verified volume +
an SLA data/reputation product.

**The repos (and how they fit).**
| Repo | Role |
|------|------|
| `streamproof-protocol` | **Hub** — the spec + `@absol-labs/shared` (types, EIP-712 typed-data, contract ABI) + whitepaper + settlement strategy. Everything depends on it. |
| `streamproof-contracts` | The escrow (`evm/` now; SVM/CosmWasm later). **Owns the ABI**, which the hub re-exports. |
| `streamproof-oracle` | **The verifier** — discovery → durable store → DePIN adapters → EIP-712 signer → multi-chain submitter. The crown-jewel, most security-critical repo. |
| `streamproof-sdk` | TypeScript developer SDK (open/monitor/claim/reclaim). |
| `streamproof-agent` | x402 + MCP server + framework tools + spend mandates — the agent-facing wedge. |

**The seam (never break it).** The EIP-712 attestation + the contract ABI are the only
cross-repo contract; they live canonically in `@absol-labs/shared`. Consume them;
never fork them. Changing them is a breaking protocol change requiring a coordinated,
version-bumped update across repos.

**Prototype scope (what to build first).** One verified Akash compute stream on Base
Sepolia: open via SDK → oracle verifies → accrues → 2 failures pause → buyer reclaims →
thin demo. Single env-key signer on testnet is fine for the prototype. Everything else
(verifier ladder, multi-chain/Solana, fees, receipts, more adapters, frameworks) is
deferred. The exact "DO now" issue list is in `ROADMAP.md` (the prototype cut-line).

---

## PART B — How you must work (binding)

Read the repo's `AGENTS.md` **"Working discipline"** section in full — it is binding.
The essence:
- **Read the whole issue first** (Summary, Implementation Detail, Checklist, Acceptance
  Criteria, Security Pass, Dependencies) + the spec if relevant. Understand before coding.
- **Finish the whole issue** — every checklist item, every acceptance criterion. If
  blocked, STOP and say what's blocked; never silently skip.
- **Never fake/mock/stub to go green.** No hardcoded successes, no `// TODO` on required
  paths, no skipped/weakened tests, no faking an integration. Mocks are only for genuine
  unit-test isolation, never to pretend the feature works.
- **No fake green paths** — if you need a real key/RPC/funded account/published package/
  deployed contract/external API and don't have it, **ask the human**.
- **Fail-safe + buyer-favoring** — never report delivered/success on uncertainty.
- **Respect `Depends on:` and the ROADMAP cut-line.** One issue per PR.
- **Be honest** in the PR about what's done/passed/skipped. Complete the Security Pass.
- **Never** commit secrets, merge to `main`, or broadcast/publish without human approval.

---

## PART C — Task prompt (use per issue; fill `<REPO>` / `<ISSUE>`)

> You are a senior protocol engineer in the **StreamProof** org (`Absol-Labs`). You
> already have the product overview and the working-discipline rules — follow them
> exactly.
>
> You are working in **`Absol-Labs/<REPO>`** on issue **#`<ISSUE>`**.
>
> 1. Read the repo's `AGENTS.md` (especially "Working discipline"), the org
>    `CONTRIBUTING.md` + `ROADMAP.md`, and the full issue:
>    `gh issue view <ISSUE> --repo Absol-Labs/<REPO>`. If the protocol is involved,
>    read `streamproof-protocol/docs/spec/attestation.md`.
> 2. Confirm every `Depends on:` (including cross-repo deps like "needs
>    `@absol-labs/shared` published") is closed. If not, STOP and report the blocker.
> 3. Give me a 3–5 step plan for this issue before editing anything.
> 4. Branch off `main`: `git checkout -b <type>/issue-<ISSUE>-<slug>`.
> 5. Implement the **whole** issue per its Implementation Detail — satisfy every
>    checklist item and acceptance criterion. Tests-first for funds/signatures/
>    telemetry/spend. No mocking/stubbing/faking to pass; if you need a real dependency
>    you don't have, STOP and ask.
> 6. Make the repo's checks genuinely pass:
>    - TS repos: `pnpm typecheck && pnpm test && pnpm build`
>    - contracts: from `evm/` — `forge fmt --check && forge build && forge test`
> 7. Show the diff and the real passing test output. Open a PR with `gh pr create`:
>    `Closes #<ISSUE>`, a short before/after, and the truthfully-ticked Security Pass.
>    Do NOT merge, broadcast on-chain value, or publish packages without my approval.
> 8. In the PR, state exactly what was done, what passed, and anything skipped/partial
>    and why.
>
> Start by reading `AGENTS.md` + the issue, then give me the plan.

**Recommended first issue:** `streamproof-protocol` #5 (publish `@absol-labs/shared`)
— the keystone that unblocks the oracle, sdk, and agent repos.
