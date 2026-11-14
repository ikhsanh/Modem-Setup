#!/bin/sh

set -e

TAG="v2.4.141"
echo "[*] Mencari dan mengunduh quectool release ($TAG)..."
cd /tmp

# Cari link download .tar.gz untuk tag v2.4.141
QUECTOOL_URL=$(curl -fsSL "https://github.com/fa0xh1/quectool-fork-release/releases/expanded_assets/${TAG}" 2>/dev/null | grep -o "/fa0xh1/quectool-fork-release/releases/download/${TAG}/[^\"]*\.tar\.gz" | head -n 1)

if [ -z "$QUECTOOL_URL" ]; then
  QUECTOOL_URL=$(curl -fsSL "https://github.com/fa0xh1/quectool-fork-release/releases/tag/${TAG}" 2>/dev/null | grep -o "/fa0xh1/quectool-fork-release/releases/download/${TAG}/[^\"]*\.tar\.gz" | head -n 1)
fi

if [ -z "$QUECTOOL_URL" ]; then
  # Coba via GitHub API untuk tag v2.4.141
  QUECTOOL_URL=$(curl -fsSL -H "User-Agent: Mozilla/5.0" "https://api.github.com/repos/fa0xh1/quectool-fork-release/releases/tags/${TAG}" 2>/dev/null | grep -o "https://github.com/fa0xh1/quectool-fork-release/releases/download/${TAG}/[^\"]*\.tar\.gz" | head -n 1)
fi

# Fallback ke releases umum jika tag spesifik tidak ditemukan
if [ -z "$QUECTOOL_URL" ]; then
  QUECTOOL_URL=$(curl -fsSL https://github.com/fa0xh1/quectool-fork-release/releases 2>/dev/null | grep -o '/fa0xh1/quectool-fork-release/releases/download/[^"]*\.tar\.gz' | head -n 1)
fi

if [ -z "$QUECTOOL_URL" ]; then
  QUECTOOL_URL=$(curl -fsSL -H "User-Agent: Mozilla/5.0" https://api.github.com/repos/fa0xh1/quectool-fork-release/releases/latest 2>/dev/null | grep -o 'https://github.com/fa0xh1/quectool-fork-release/releases/download/[^"]*\.tar\.gz' | head -n 1)
fi

if [ -n "$QUECTOOL_URL" ]; then
  case "$QUECTOOL_URL" in
    /*) QUECTOOL_URL="https://github.com$QUECTOOL_URL" ;;
  esac
  echo "[+] Mengunduh quectool ($TAG): $QUECTOOL_URL"
  rm -f /tmp/q.tar.gz
  curl -fsSL "$QUECTOOL_URL" -o /tmp/q.tar.gz || wget -O /tmp/q.tar.gz "$QUECTOOL_URL"
  tar -xzf /tmp/q.tar.gz
  cd /tmp && bash install.sh
  echo "[+] Instalasi Quectool ($TAG) selesai."
else
  echo "[!] Gagal mendapatkan link release quectool .tar.gz untuk versi $TAG"
  exit 1
fi
