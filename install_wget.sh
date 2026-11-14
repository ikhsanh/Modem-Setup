#!/bin/sh

set -e

if ! command -v wget >/dev/null 2>&1; then
  echo "[!] wget tidak ditemukan, menginstall wget..."
  cd /tmp
  # Unduh installer ke /tmp terlebih dahulu agar aman dan utuh
  curl -fsSL https://raw.githubusercontent.com/ikhsanh/wget-rg501q/main/install_wget.sh -o /tmp/install_wget.sh
  chmod +x /tmp/install_wget.sh
  bash /tmp/install_wget.sh
  rm -f /tmp/install_wget.sh
  echo "[+] wget berhasil diinstall"
else
  echo "[*] wget sudah tersedia: $(which wget)"
fi
