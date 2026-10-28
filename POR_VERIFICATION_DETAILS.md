# PoR Verification Methodology — Full Details

## OKX Independent Verification (Round 502260945, 2026-10-16)

### Layer 1: Global zk-STARK Proof

**Tool**: OKX open-source `zk_STARK_Validator_V2` (https://github.com/okx/proof-of-reserves)
**Command**: `cargo run --release --bin verify_global`
**Result**: ✅ `Ok(())`
**Committed hash**: `3aa0802`
**Verification machine**: Independent laptop (no OKX dependencies, no pre-configured RPC)

### Layer 2: BTC Top-50 Chain Verification

**Method**: Cross-reference OKX PoR CSV top-50 BTC addresses against blockstream.info chain API
**Snapshot date**: OKX Round 502260945 (2026-10-16)
**Verification date**: 2026-10-27
**Results**:

| Metric | Value |
|---|---|
| Addresses checked | 50 / 50 |
| Addresses with zero chain-snapshot diff | 30 / 50 |
| Addresses within ±1 BTC of snapshot | 45 / 50 |
| Total chain balance | 152,691.90 BTC |
| Total snapshot balance | 146,440.59 BTC |
| Coverage ratio | **104.2%** (chain ≥ snapshot) |
| Top-50 coverage of OKX public BTC reserves | **97.45%** |

### Layer 3: ETH Beacon Chain Sampling

**Method**: Random 10-address sample from OKX ETH snapshot vs Lodestar consensus-layer API
**Result**: 10/10 addresses exactly matched beacon chain balances at snapshot height 26,105,691

### Layer 4: Known Limitations

1. **OKX verifier RPC default**: OKX's `rpc.json` defaults to OKLink (their own browser + API key). For true independence, replace with blockstream.info or other public RPC.
2. **`CheckBalance` silent exit**: OKX's un-documented `CheckBalance` flag causes silent exit without `--mode` parameter. Use `verify_global` instead.
3. **Top-50 ≠ full coverage**: Top-50 addresses cover ~97.45% of BTC reserves. Full list requires downloading OKX's full PoR CSV.

---

## Binance PoR Status (as of 2026-10-28)

### What we can verify

- Binance PoR page: https://www.binance.com/en/proof-of-reserves (active, weekly updates)
- Latest round: Audit Time 2026-10-01 00:00 UTC, Block 969369
- Report PDF: Requires Binance login (not publicly downloadable)
- Chain balance (from P0 public address labels): Two large cold wallets total ~316,797.60 BTC (~52% of self-reported reserves)

### What we cannot verify (critical gap)

- **No open-source zk-SNARKs verifier released by Binance** — PoR is front-end only, no independent replication possible
- **No public PoR CSV dump** — addresses are shown on-page but not downloadable as structured data
- **Report PDF requires login** — full PoR data not publicly accessible

### Independent Binance verification status

**Blocked at infrastructure level**. Until Binance releases open-source verification code and structured PoR data, independent replication is not possible.

What we **can** do:
- Chain balance checks on known-labeled Binance addresses (OKLink + other public tags)
- Periodic checks that PoR page is still active and showing consistent data
- Comparative analysis vs other platforms' PoR disclosures

---

## Crypto.com PoR Status (as of 2026-10-28)

### Critical finding: PoR stopgap >3 years

- PoR page HTTP 200, but **embedded PDF is December 2022 version** (document creation/modification dates verified via PDF metadata)
- Merkle verification endpoint: Returns 200 OK but data matches 2022 snapshot, not current reserves
- Auditing firm listed: Mazars — **Mazars publicly exited crypto PoR work in December 2022**
- **No replacement auditor announced**
- No open-source verification code

### Independent verification status

**Not possible** — Crypto.com has not published current PoR data since 2022. Any PoR verification on Crypto.com is based on 3-year-old data, not current reserves.

---

## Verification Tool Architecture

### Security model

```
User input (BTC address)
         │
         ▼
   Input validation (1/3/bc1 prefix check)
         │
    ┌────┴────┐
    ▼         ▼
blockstream.info   Preloaded OKX Top-50 JSON
   API call         (verified 2026-10-27)
    3rd-party          /
   independent        /
    chain data       /
    └─────┬──────────┘
          ▼
    Compare: Is address in OKX list?
          │
    ┌─────┴─────┐
    ▼           ▼
  in_okx:    NOT in OKX
  True/False  ├─→ Check Binance list (OKLink tags)
                          │
                     ┌────┴────┐
                     ▼         ▼
               in_binance   NOT in either
               True/False   → Generic: "not in verified lists"
          │
          ▼
    Build response (chain balance + list membership + disclaimer)
```

### No-follow design principles

1. **No user data**: Address parameter is read-only, never stored, never logged
2. **No cookies/sessions**: Pure stateless HTTP, no browser fingerprinting
3. **Third-party only**: Chain balance from blockstream.info, not from any crypto platform
4. **Transparent sources**: Every data point's source is in the API response and README
5. **Version pinning**: Dependencies pinned in requirements.txt for reproducibility

---

## Evidence Rating Methodology (P0/P1/P2)

| Level | Definition | Examples |
|---|---|---|
| **P0** | Primary source, independently verifiable | Blockchain data (blockstream.info), regulatory registers (FCA, ESMA, VARA), corporate filings (SEC EDGAR), OKX open-source verifier output |
| **P1** | Authoritative secondary source, credible | Major crypto media (The Block, CoinDesk), chain explorer address tags (OKLink, Etherscan), auditor press releases |
| **P2** | Community/third-party compilation, indirect | Forum posts, aggregated statistics, second-hand reports |

This tool uses **only P0 sources** for address verification. Binance cold-wallet addresses are P1 (OKLink labels).

---

## UBO (Ultimate Beneficial Owner) Determination Levels

| Level | Definition |
|---|---|
| **D1** | Direct evidence from register or court document |
| **D2** | Inference with documented reasoning |
| **D3** | Not publicly available |

OKX Top-50 verification uses D1 (blockstream.info direct chain read). No UBO determination is made by this tool — it only verifies address membership in public PoR lists.
