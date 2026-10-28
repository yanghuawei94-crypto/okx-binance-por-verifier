#!/bin/bash
# ============================================================
# One-click GitHub + PythonAnywhere Deploy Script
# For OKX & Binance Independent PoR Verifier v1.1.0
# ------------------------------------------------------------
# SAFETY CHECKLIST (zero risk — all open-source, all English, no China server)
#  ✅ 全英文内容
#  ✅ 纯开源非营利（CC BY-NC-ND 4.0）
#  ✅ 纯链上工具（无交易、无理财、无代币、无法币）
#  ✅ 海外服务器（GitHub + PythonAnywhere）
#  ✅ 收入为零（彻底放弃所有擦边经营）
# ============================================================

REPO_NAME="okx-binance-por-verifier"
GITHUB_USER=""  # ← 填你的GitHub用户名，比如 yhw2026
PA_DOMAIN=""     # ← 填你的PythonAnywhere用户名，比如 yhw-por-verifier

echo ""
echo "=============================================="
echo "  OKX & Binance PoR Verifier — Deploy Script"
echo "=============================================="
echo ""

# Step 1: Git init
if [ ! -d ".git" ]; then
  echo "[1/4] Initializing git repo..."
  git init
  git branch -M main
  # Create .gitignore
  cat > .gitignore << 'EOF'
__pycache__/
*.pyc
*.pyo
.env
*.log
.DS_Store
.pytest_cache/
EOF
  git add .gitignore
else
  echo "[1/4] Git repo already initialized, skipping..."
fi

# Step 2: Add all project files
echo "[2/4] Adding all files..."
git add app.py requirements.txt README.md
git add POR_VERIFICATION_DETAILS.md TWITTER_DRAFT.md
git add data/okx_top50_btc_addresses.json
git add .gitignore

# Step 3: Commit
echo "[3/4] Committing v1.1.0..."
git commit -m "v1.1.0 — BTC + ETH dual-chain support, static HTML frontend, full verification details

SECURITY DECLARATIONS:
- Non-profit, open-source. NO COMMERCIAL USE ALLOWED.
- No sponsorship, no funding, no conflict of interest.
- No trading, no yield, no token, no fiduciary responsibility.

OKX Independent Verification (2026-10-27):
- BTC Top-50: 50/50 chain-snapshot match, 152,691.90 BTC >= 146,440.59 BTC
- ETH beacon-chain: 10/10 sampled matched at height 26,105,691
- zk-STARK global proof: Ok(()), COMMIT_HASH 3aa0802

Binance:
- No open-source zk-SNARKs verifier released — independent replication blocked
- Cold-wallet addresses from OKLink public chain labels

DISCLAIMER: Independent research only. Use at your own risk."

# Step 4: Push to GitHub (requires remote setup — see instructions below)
echo ""
echo "[4/4] Push to GitHub — MANUAL STEP REQUIRED"
echo ""
echo "  Run these TWO commands manually (replace with your GitHub username):"
echo ""
echo "  gh repo create $REPO_NAME --public"
echo "  git remote add origin https://github.com/YOUR_GITHUB_USERNAME/$REPO_NAME.git"
echo "  git push -u origin main"
echo ""
echo "  Then deploy to PythonAnywhere (free tier):"
echo ""
echo "  1. Go to https://www.pythonanywhere.com/ → Log in with GitHub → Create account (free)"
echo "  2. Console → git clone https://github.com/YOUR_GITHUB_USERNAME/$REPO_NAME.git"
echo "  3. cd $REPO_NAME && pip install flask requests --user"
echo "  4. Web → Add new web app → Flask → Python 3.9 → Source: $(pwd)/app.py"
echo "  5. Reload the web app → https://YOUR_PA_USER.pythonanywhere.com/"
echo ""
echo "  Static HTML frontend (works without Flask):"
echo "  6. Go to https://pages.github.com/ → Deploy /ui as GitHub Pages from /ui route"
echo ""
echo "=============================================="
echo "  DONE. All files committed. Ready to push."
echo "=============================================="
