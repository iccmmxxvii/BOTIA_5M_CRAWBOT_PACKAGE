# BOTIA / 4coinsbot — BTC Up/Down 5m (Crawbot Package)

This package contains a portable, pre-patched version of **4coinsbot** adapted for **BTC Up/Down 5m** markets on Polymarket.

## What is included
- `repo/4coinsbot_5m/` : patched bot code (interval configurable, portable paths)
- `repo/4coinsbot_5m/config/config.json` : BTC-only 5m PAPER config (dry_run=true)
- `docs/ENV_TEMPLATE.env` : environment variable template
- `tools/validate_gamma.py` : checks that the current 5m slug exists on Gamma
- `scripts/setup_vps.sh` : installs deps on a Linux VPS and prepares `.env`
- `scripts/run_paper.sh` : runs the bot + logs to `logs/runtime.log`
- `docs/CRAWBOT_PROMPT.md` : a ready-to-paste task prompt for Crawbot/OpenClaw

## Safety default
- Default is **PAPER** (`dry_run=true`). To go live, set `dry_run=false` AFTER testing and lowering limits.
- Always start with small sizes.

## Notes on market slug
The bot uses: `btc-updown-5m-<epoch_slot>` where `epoch_slot` is divisible by 300 seconds.
Verified that Polymarket uses this format for 5m crypto pages. See Polymarket 5m crypto hub. (Search evidence)
