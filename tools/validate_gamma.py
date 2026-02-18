#!/usr/bin/env python3
"""Validate that the current BTC 5m market slug exists on Gamma.
Tries slot, slot-interval, slot+interval. Prints the first slug that exists.
"""
import time, os, json, requests
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[1]
CONFIG_PATH = PROJECT_ROOT / "repo" / "4coinsbot_5m" / "config" / "config.json"
cfg = json.loads(CONFIG_PATH.read_text())

interval = int(cfg.get("market", {}).get("interval_sec", 300))
tag = str(cfg.get("market", {}).get("interval_tag", "5m"))
gamma = cfg.get("data_sources", {}).get("polymarket", {}).get("gamma_api", "https://gamma-api.polymarket.com")

now = int(time.time())
base_slot = (now // interval) * interval

def check(slot:int)->bool:
    slug = f"btc-updown-{tag}-{slot}"
    url = f"{gamma}/events?slug={slug}"
    r = requests.get(url, timeout=10)
    r.raise_for_status()
    data = r.json()
    return slug, bool(data)

for slot in (base_slot, base_slot-interval, base_slot+interval):
    try:
        slug, ok = check(slot)
        print(f"{slug} -> {'FOUND' if ok else 'NOT_FOUND'}")
        if ok:
            print("OK_SLUG=", slug)
            break
    except Exception as e:
        print(f"ERROR slot={slot}: {e}")
