# OKX & Binance Independent PoR Verifier

> **Non-profit · Open-source · Independent · No sponsorship · No conflict of interest**

---

## ⚠️ ABSOLUTE SECURITY DECLARATIONS (top of file)

1. This is a **non-profit, open-source tool**. **NO COMMERCIAL USE ALLOWED.**
2. **No sponsorship, no funding, no conflict of interest.** Independent verification only. No platform has paid, funded, or influenced this work.
3. **No trading, no yield, no token, no fiduciary responsibility.** Use at your own risk. This tool does not provide financial advice, investment advice, or any guarantee of platform solvency.

---

## What This Tool Does

A tiny Flask service for **independent, third-party verification** of crypto platform Proof-of-Reserves (PoR).

### Why it matters

Crypto platforms publish their own PoR data — but users have no way to independently verify it. OKX publishes open-source verification code; Binance does not. This tool fills the gap by:

- Preloading **OKX's Top-50 BTC addresses** (verified 2026-10-27, 50/50 chain-snapshot match, total 152,691.90 BTC ≥ snapshot 146,440.59 BTC)
- Fetching **real-time on-chain balance** via [blockstream.info](https://blockstream.info) (independent third-party public API)
- Comparing any user-input BTC address against OKX's verified list
- Flagging whether Binance's known cold-wallet addresses are present (via OKLink public address tags)

### What it does NOT do

- ❌ No trading, no order book, no matchmaking
- ❌ No yield products, no interest, no "passive income"
- ❌ No token issuance, no airdrop, no referral program
- ❌ No user data storage, no cookies, no tracking
- ❌ No KYC, no registration, no account

---

## Quick Start

### Prerequisites

- Python 3.9+
- `pip install flask requests`

### Run locally

```bash
# Clone (or download as ZIP)
git clone https://github.com/yanghuawei94-crypto/okx-binance-por-verifier.git
cd okx-binance-por-verifier

# Install dependencies
pip install flask requests

# Start the service (default port 5001 — port 5000 is macOS AirPlay Receiver)
python3 app.py

# Test the OKX Top-1 address (10,000+ BTC, verified 2026-10-27)
curl "http://127.0.0.1:5001/check?address=1CY7fykRLWXeSbKB885Kr4KjQxmDdvW923"

# Check metadata (verification sources, dates, commit hashes)
curl "http://127.0.0.1:5001/por-meta"
```

### Deploy (free, serverless)

Deploy to [PythonAnywhere](https://www.pythonanywhere.com/) or [Render](https://render.com/) for free:

```bash
# PythonAnywhere: upload via web UI → Web → Add new web app → Flask → point to app.py
# Render: connect GitHub repo → New → Web Service → Build command: pip install flask requests → Start command: python3 app.py
```

---

## API Reference

### `GET /check?address=<BTC_ADDRESS>`

Check if a BTC address is in OKX's verified Top-50 PoR list or Binance's known cold-wallet list.

**Response (OKX Top-1 address):**
```json
{
  "address": "1CY7fykRLWXeSbKB885Kr4KjQxmDdvW923",
  "onchain_balance_btc": 10000.00042114,
  "onchain_status": "ok",
  "in_okx_public_por_list": true,
  "in_binance_public_por_list": false,
  "okx_list_size": 50,
  "binance_list_size": 2,
  "interpretation": "✅ This address IS in OKX's verified Top-50 BTC PoR list (2026-10-27, 50/50 chain match); 📊 Real-time on-chain balance: 10000.00042114 BTC (blockstream.info, independent third-party)",
  "disclaimer": { ... }
}
```

**Error (invalid format):**
```json
{ "error": "Invalid BTC address format", "address": "notabcaddress...", "disclaimer": { ... } }
```

**Error (missing parameter):**
```json
{ "error": "Missing 'address' parameter", "example": "...", "disclaimer": { ... } }
```

### `GET /por-meta`

Metadata about verification sources, dates, and independent proof.

**Response:**
```json
{
  "tool_version": "1.0.0",
  "okx_top50_btc_addresses_loaded": 50,
  "binance_btc_addresses_loaded": 2,
  "okx_verification_date": "2026-10-27",
  "okx_verification_result": "50/50 addresses chain-snapshot match; total chain balance 152,691.90 BTC >= snapshot 146,440.59 BTC",
  "okx_zulk_global_proof": "Ok(()) — verified 2026-10-27 on independent machine, COMMIT_HASH 3aa0802",
  "binance_source": "OKLink public cold-wallet tags + Binance public PoR page",
  "blockstream_info": "Real-time on-chain balance API, independent third-party",
  "disclaimer": { ... }
}
```

---

## Data Sources (all P0 — primary source, independent)

| Data | Source | Verification |
|---|---|---|
| OKX Top-50 BTC addresses | OKX public PoR CSV snapshot | **50/50 chain-snapshot match** (2026-10-27, blockstream.info) |
| OKX global zk-STARK proof | OKX open-source `zk_STARK_Validator_V2` | **`Ok(())`** (2026-10-27, independent machine, COMMIT_HASH 3aa0802) |
| Binance cold-wallet addresses | OKLink public address tags + Binance PoR page | Labeled addresses, P0 chain label |
| Real-time BTC balance | blockstream.info public API | Independent third-party, no affiliation |

### Known limitations

- OKX verifier defaults to OKLink RPC (their own browser). For independent verification, replace with blockstream.info or other public RPC.
- Binance does **not** publish open-source zk-SNARKs verification code. Binance PoR is front-end only — independent replication is not currently possible.
- OKX Top-50 covers ~97.45% of their public BTC reserves. Full coverage requires all addresses, not just Top-50.
- Blockstream.info API may have rate limits for heavy use.

---

## Project Structure

```
okx-binance-por-verifier/
├── app.py                          # Flask service (main entry)
├── data/
│   └── okx_top50_btc_addresses.json  # Preloaded 50 verified addresses (2026-10-27)
├── requirements.txt                # Flask, requests
├── POR_VERIFICATION_DETAILS.md     # Full verification methodology
├── TWITTER_DRAFT.md                # First public announcement thread
└── README.md                       # This file
```

---

## License

**CC BY-NC-ND 4.0** — Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International.

You are free to copy and redistribute this work in any medium or format for **non-commercial purposes**, as long as you give appropriate credit and do not modify it. **No commercial use allowed.** See [CC BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/) for full terms.

---

## How to Contribute

**PRs welcome, but with restrictions:**
- Bug fixes, additional data sources, documentation improvements — ✅ welcome
- New features that could be interpreted as "trading", "yield", "investment advice" — ❌ not accepted
- Any sponsorship, funding, or commercial ties disclosed in PR — ❌ not accepted

**Security issues:** If you find a bug or vulnerability, please open a GitHub issue with the label `security`.

---

## Author

Independent crypto compliance researcher. 10+ years of experience in on-chain forensics, regulatory due diligence, and PoR verification.

**No affiliation** with OKX, Binance, or any crypto platform. **No sponsorship, no funding, no conflict of interest.** This tool is built independently and released for public use.

Contact: Open a GitHub issue. No DMs, no email — all communication must be public and auditable.

---

## Version History

| Version | Date | Changes |
|---|---|---|
| 1.0.0 | 2026-10-28 | Initial release. OKX Top-50 BTC verification, blockstream.info integration, three absolute security declarations |

---

> **Use this tool at your own risk.** It does not prove platform solvency, nor does it guarantee platform honesty. It only verifies on-chain addresses against publicly available PoR data. Always do your own research.
