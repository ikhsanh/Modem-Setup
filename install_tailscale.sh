#!/bin/sh

set -e

echo "[*] Install tailscale dari Entware..."
export PATH="/opt/bin:/opt/sbin:$PATH"

# Pastikan opkg yang digunakan berasal dari Entware (/opt/bin/opkg)
if [ -x "/opt/bin/opkg" ]; then
  OPKG="/opt/bin/opkg"
else
  echo "[!] opkg Entware (/opt/bin/opkg) tidak ditemukan!"
  echo "[!] Pastikan instalasi Entware di /opt sudah berjalan dengan benar."
  exit 1
fi

# Verifikasi apakah Tailscale sudah terinstall di Entware
if [ -x "/opt/bin/tailscale" ]; then
  echo "[*] Tailscale sudah terinstall: /opt/bin/tailscale"
  echo "[*] Melewati instalasi Tailscale."
  exit 0
fi

echo "[*] Mengupdate paket Entware..."
$OPKG update
$OPKG install cron
$OPKG install tailscale_nohf

echo "[+] Instalasi Tailscale selesai."
