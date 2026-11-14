#!/bin/sh

set -e

export PATH="/opt/bin:/opt/sbin:$PATH"

# Verifikasi apakah Entware sudah terinstall
if [ -x "/opt/bin/opkg" ] || command -v opkg >/dev/null 2>&1; then
  echo "[*] Entware sudah terinstall ($(which opkg 2>/dev/null || echo '/opt/bin/opkg'))"
  echo "[*] Melewati instalasi Entware."
  exit 0
fi

echo "[*] Menginstall Entware..."
cd /tmp && curl -sL https://raw.githubusercontent.com/zainalicious/Modem-Setup/main/installentware.sh | sh
echo "[+] Instalasi Entware selesai."
