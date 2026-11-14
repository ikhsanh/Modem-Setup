#!/bin/sh

set -e

echo "[*] Install tailscale dari Entware..."
export PATH="/opt/bin:/opt/sbin:$PATH"

if ! command -v opkg >/dev/null 2>&1; then
  echo "[!] opkg tidak ditemukan! Pastikan Entware sudah terinstall terlebih dahulu."
  exit 1
fi

opkg update
opkg install cron
opkg install tailscale_nohf

echo "[+] Instalasi Tailscale selesai."

