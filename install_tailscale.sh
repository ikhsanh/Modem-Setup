#!/bin/sh

set -e

export PATH="/opt/bin:/opt/sbin:$PATH"

if ! command -v opkg >/dev/null 2>&1; then
  echo "[!] opkg tidak ditemukan! Pastikan Entware sudah terinstall terlebih dahulu."
  exit 1
fi

# Verifikasi apakah Tailscale sudah terinstall
if command -v tailscale >/dev/null 2>&1 || [ -x "/opt/bin/tailscale" ]; then
  echo "[*] Tailscale sudah terinstall: $(which tailscale 2>/dev/null || echo '/opt/bin/tailscale')"
  echo "[*] Melewati instalasi Tailscale."
  exit 0
fi

echo "[*] Install tailscale dari Entware..."
opkg update
opkg install cron
opkg install tailscale_nohf

echo "[+] Instalasi Tailscale selesai."
