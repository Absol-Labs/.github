# Absol Labs

Trust infrastructure for the agent economy.

Software agents are starting to buy things from sellers no human vetted. We build the layer that
makes those purchases safe to make.

<br>

## <img src="https://raw.githubusercontent.com/Absol-Labs/.github/main/profile/metrik-logo.svg" width="22" align="center" alt=""> &nbsp;Metrik

**Payment that clears only for delivery that was verified.**

An agent escrows USDC into a stream — a rate per second, a budget, an expiry. An independent
verifier probes the seller's endpoint every interval, and the seller earns only for the intervals
that passed. Time that failed verification never becomes their money; the buyer withdraws it.

Sellers stay on whatever infrastructure they already use. Metrik sees a URL and a payout wallet,
nothing else.

> _x402 proves the payment. Metrik proves the delivery._

**[metrik.live](https://metrik.live)** &nbsp;·&nbsp; [app](https://app.metrik.live) &nbsp;·&nbsp;
[docs](https://metrik.live/docs) &nbsp;·&nbsp; [for agents](https://metrik.live/SKILL.md)

Metrik proves **delivery** — that a service responded correctly, in time, to a challenge it could
not have answered in advance. It does not prove the output is *right*; no one can do that cheaply
yet, and we would rather say so.

<br>

### Repositories

| | |
|---|---|
| **metrik-protocol** | Canonical spec and shared types |
| **metrik-contracts** | Settlement escrow on Base |
| **metrik-oracle** | The verifier |
| **metrik-sdk** | TypeScript client |
| **metrik-agent** | Agent tooling — wallets, spend mandates, MCP |
| **metrik-site** | Marketing site and app |

Private while Metrik is on testnet.

<br>

---

<sub>Base Sepolia testnet. Unaudited, no mainnet value. &nbsp;·&nbsp;
[Security policy](https://github.com/Absol-Labs/.github/blob/main/SECURITY.md)</sub>
