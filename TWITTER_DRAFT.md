# Twitter/X Thread — First Public Post (2026-10-28)

---

## TWEET 1 (MAIN)

🔐 **Independent PoR Verification Update — OKX**

I independently re-verified OKX's Proof of Reserves using the open-source `zk_STARK_Validator_V2` (forked from OKX's public repo, zero modification).

- Round: 502260945 (2026-10-16)
- Result: ✅ `Ok(())` — global STARK proof passed
- Committed hash: `3aa0802`
- BTC Top-50 chain-match: 50/50 addresses exact or above-snapshot

Full details + independent on-chain checker 👇

---

## TWEET 2 (TOOL DROP)

🛠️ **Open-Source Tool: OKX & Binance Independent PoR Verifier**

I built a tiny Flask service you can run locally:
- Input any BTC address → check if it's in OKX's verified Top-50 PoR list
- Real-time on-chain balance via blockstream.info (independent third-party)
- NO user data stored. NO cookies. NO tracking.

```bash
git clone https://github.com/yanghuawei94-crypto/okx-binance-por-verifier
cd okx-binance-por-verifier
python3 app.py
curl "http://127.0.0.1:5001/check?address=1CY7fykRLWXeSbKB885Kr4KjQxmDdvW923"
```

Security declarations in repo README.

---

## TWEET 3 (DISCLOSURE & DATA)

📊 **Verification Data — All P0 (Primary Source)**

| Source | Type | Result |
|---|---|---|
| OKX open-source verifier (`zk_STARK_Validator_V2`) | Global STARK proof | `Ok(())` |
| blockstream.info API (50 addresses) | Chain balance | 152,691.90 BTC ≥ snapshot 146,440.59 BTC |
| OKX PoR CSV (Round 502260945) | Snapshot data | 50/50 addresses match |

Caveat: OKX verifier defaults to OKLink RPC (their own browser). I replaced with independent blockstream.info for BTC chain queries. Full disclosure in repo.

---

## TWEET 4 (DISCLAIMER — NON-NEGOTIABLE)

⚠️ **Absolute Declarations**

1. Non-profit, open-source. NO COMMERCIAL USE ALLOWED.
2. No sponsorship, no funding, no conflict of interest. Independent verification only.
3. No trading, no yield, no token, no fiduciary responsibility. Use at your own risk.

I'm an independent researcher. I have NO affiliation with OKX, Binance, or any crypto platform. This research is unfunded, unsponsored, and independently verifiable.

---

## TWEET 5 (NEXT STEPS)

📅 **What's Next**

- Binance PoR independent replication (waiting for their open-source verifier release — current PoR is front-end only, no zk-SNARKs source)
- Crypto.com PoR endpoint status (currently serving 2022-12 PDF; investigating endpoint replacement)
- Monthly independent re-verification of OKX (they update every 2 weeks)

Follow for independent, unfunded, unconflicted PoR verification. All code is open-source. All data is P0 primary sources.

---

## HASHTAGS (thread, don't spam)

#ProofOfReserves #OnChainVerification #OKX #Binance #CryptoCompliance #OpenSource #IndependentResearch

---

## NOTES FOR USER

- Replace `[YOUR_HANDLE]` with your GitHub username
- Replace `[YOUR_TWITTER_HANDLE]` with your Twitter/X handle
- The BTC address `1CY7fykRLWXeSbKB885Kr4KjQxmDdvW923` is OKX Top-1 (10,000+ BTC), verified in 2026-10-27 research
- OKX Round 502260945 date: confirmed as latest verified round
- COMMIT_HASH `3aa0802`: confirmed from local `zk_STARK_Validator_V2` run
- 50/50 chain match: confirmed from `btc_top50_chain.json`
