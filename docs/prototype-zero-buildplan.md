# Prototype-Zero Build Plan — the ordered worklist for Codex

The exact order Codex works the issues to reach the **prototype** (one verified Akash
compute stream on Base Sepolia: open via SDK → oracle verifies → accrues → 2 failures
pause → buyer reclaims). Do these **one at a time, one PR each**, in this order.

## The human-intervention rule (important)

Some steps cannot be done in code (broadcasting on-chain, publishing a package,
running a real Akash job, providing funded keys/RPC). When you hit one:

1. **Do NOT fake it, mock it, or skip it silently.**
2. **Create a new GitHub issue** in the relevant repo titled `human: <action>`, with
   the **`human-intervention`** label, describing exactly what the human must do and
   **what to test** when they do it. Link the issue(s) it unblocks.
3. **Continue with the next codeable item** in this list. Come back to the swap/verify
   steps once the human has acted.

Everything that *can* be coded now should be fully coded, tested, and PR'd now.

---

## Phase A — code now (no human needed), in order

> Where a step would consume `@streamproof/shared` (not yet published), **vendor the
> ABI/types locally** (copy from `streamproof-protocol/src/abi.ts` + `src/index.ts`)
> exactly as the oracle already does with `protocol-types.ts`, and leave the
> "swap to the published package" work for Phase C. Do not block on the publish.

| # | Repo | Issue | What | Tests without human |
|---|------|-------|------|---------------------|
| 1 | contracts | **#4** | ABI artifact (`abi/StreamEscrow.json`) + drift-check CI | `forge inspect` diff in CI |
| 2 | protocol | **#5** | publish setup: release workflow + `publishConfig` + `.npmrc` + versioning doc. *(Codex writes the workflow; the actual tag/publish is human → create the human issue.)* | workflow lints; dry build |
| 3 | oracle | **#4** | discovery + durable store (config, SQLite, viem `getLogs`) | unit tests w/ mock RPC / local anvil |
| 4 | oracle | **#5** | EIP-712 signer + multi-chain submitter (idempotent) | integration test vs **local anvil** escrow |
| 5 | oracle | **#3** | Akash adapter (zod schemas, fail-safe mapping) against documented endpoints | unit tests w/ **fixtures + mocked `fetch`** |
| 6 | oracle | **#6** | end-to-end poll loop wiring | local anvil + stubbed adapter demo test |
| 7 | sdk | **#3** | `StreamProofClient` config + viem clients + read views | constructs + reads vs anvil |
| 8 | sdk | **#4** | `hireAkashCompute` (approve + open + parse `StreamOpened`) | anvil + MockUSDC tests |
| 9 | sdk | **#5** | status / close / claim / reclaim + polling helper | anvil tests |
| 10 | sdk | **#9** | example scripts (env-driven) | code written; *running* them is human |

Also along the way: oracle **#2** (Akash telemetry spike) — Codex drafts
`docs/runbooks/akash-telemetry.md` from the documented endpoints and wires the adapter
to them, but **"capture real responses from a live Akash job + confirm sufficiency" is
human** → create that human issue.

## Phase B — hand-offs (human-intervention issues Codex creates as it hits them)

These get a `human-intervention` issue and are set aside for us to run + test:
- **protocol:** `human: tag & publish @streamproof/shared v0.1.0` (GitHub Packages;
  confirm org `.npmrc` + `packages: write`). Unblocks Phase C.
- **contracts:** `human: deploy + verify StreamEscrow on Base Sepolia` (funded deployer
  key, mock-vs-real-USDC decision, `--broadcast`, Basescan verify, record artifact).
- **oracle:** `human: run a real Akash testnet job + capture telemetry` (validates the
  #2 spike + #3 adapter against reality).
- **shared/e2e:** `human: run the prototype end-to-end on Base Sepolia + real Akash`
  (needs deployed escrow + running oracle + funded buyer/operator + oracle signer key).
- **creds umbrella:** `human: provision Base Sepolia RPC + funded deployer/buyer/operator
  + oracle signer key` (the secrets gate the above depend on).

## Phase C — after the human publishes `@streamproof/shared`

| # | Repo | Issue | What |
|---|------|-------|------|
| 11 | oracle | **#7** | swap the local `protocol-types.ts` shim → `@streamproof/shared` |
| 12 | sdk | **#2** | swap local ABI/types shim → `@streamproof/shared` |

## Definition of "prototype zero" reached

All Phase-A issues merged and green; Phase-B human issues filed; and — once the human
runs the deploy + publish + a real Akash job — the e2e demo (Phase-B "run end-to-end")
shows verified accrual, pause-on-failure, and reclaim against Base Sepolia. Everything
not in this plan (verifier ladder, multi-chain/Solana, fees, receipts, more adapters,
x402/MCP, frameworks) stays deferred per the [ROADMAP](../ROADMAP.md) cut-line.
