#!/bin/sh

set -e

echo "[*] Mencari dan mengunduh quectool release (.tar.gz)..."
cd /tmp

QUECTOOL_URL=$(curl -fsSL https://github.com/fa0xh1/quectool-fork-release/releases | grep -o '/fa0xh1/quectool-fork-release/releases/download/[^"]*\.tar\.gz' | head -n 1)

if [ -z "$QUECTOOL_URL" ]; then
  QUECTOOL_URL=$(curl -fsSL https://github.com/fa0xh1/quectool-fork-release/releases/latest | grep -o '/fa0xh1/quectool-fork-release/releases/download/[^"]*\.tar\.gz' | head -n 1)
fi

if [ -n "$QUECTOOL_URL" ]; then
  case "$QUECTOOL_URL" in
    /*) QUECTOOL_URL="https://github.com$QUECTOOL_URL" ;;
  esac
else
  # Fallback via GitHub API
  QUECTOOL_URL=$(curl -fsSL -H "User-Agent: Mozilla/5.0" https://api.github.com/repos/fa0xh1/quectool-fork-release/releases/latest | grep -o 'https://github.com/fa0xh1/quectool-fork-release/releases/download/[^"]*\.tar\.gz' | head -n 1)
  if [ -z "$QUECTOOL_URL" ]; then
    QUECTOOL_URL=$(curl -fsSL -H "User-Agent: Mozilla/5.0" https://api.github.com/repos/fa0xh1/quectool-fork-release/releases | grep -o 'https://github.com/fa0xh1/quectool-fork-release/releases/download/[^"]*\.tar\.gz' | head -n 1)
  fi
fi

if [ -n "$QUECTOOL_URL" ]; then
  echo "[+] Mengunduh quectool: $QUECTOOL_URL"
  curl -fsSL "$QUECTOOL_URL" -o /tmp/q.tar.gz || wget -O /tmp/q.tar.gz "$QUECTOOL_URL"
  tar -xzf /tmp/q.tar.gz
  cd /tmp && bash install.sh
  echo "[+] Instalasi Quectool selesai."
else
  echo "[!] Gagal mendapatkan link release quectool (.tar.gz)"
  exit 1
fi

