#!/bin/sh

set -e

if ! command -v wget >/dev/null 2>&1; then
  echo "[!] wget tidak ditemukan, menginstall wget..."
  curl -fsSL https://raw.githubusercontent.com/ikhsanh/wget-rg501q/main/install_wget.sh | bash
  echo "[+] wget berhasil diinstall"
else
  echo "[*] wget sudah tersedia: $(which wget)"
fi

