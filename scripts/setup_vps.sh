#!/usr/bin/env bash
set -euo pipefail

echo "[1/6] Creating working dir /opt/botia_5m (requires sudo)..."
sudo mkdir -p /opt/botia_5m
sudo chown -R "$USER":"$USER" /opt/botia_5m

echo "[2/6] Copying package contents..."
rsync -a --delete ./ /opt/botia_5m/

cd /opt/botia_5m/repo/4coinsbot_5m

echo "[3/6] Creating Python venv..."
python3 -m venv .venv
source .venv/bin/activate

echo "[4/6] Installing requirements..."
pip install --upgrade pip
pip install -r requirements.txt

echo "[5/6] Preparing .env..."
if [ ! -f .env ]; then
  cp .env.example .env
  echo "Created .env from template. EDIT IT NOW with your real keys (PRIVATE_KEY, POLYMARKET_API_*)."
else
  echo ".env already exists."
fi

echo "[6/6] Gamma validation..."
cd /opt/botia_5m
source /opt/botia_5m/repo/4coinsbot_5m/.venv/bin/activate
python3 tools/validate_gamma.py || true

echo "Setup complete."
echo "Next: run scripts/run_paper.sh (after editing /opt/botia_5m/repo/4coinsbot_5m/.env)"
