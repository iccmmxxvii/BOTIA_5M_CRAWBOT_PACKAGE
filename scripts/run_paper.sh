#!/usr/bin/env bash
set -euo pipefail
cd /opt/botia_5m/repo/4coinsbot_5m
source .venv/bin/activate

echo "Running BTC 5m bot in PAPER mode (dry_run=true)."
echo "Config: config/config.json"
python3 -u src/main.py 2>&1 | tee -a logs/runtime.log
