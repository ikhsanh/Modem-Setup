#!/bin/sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_RAW_URL="https://raw.githubusercontent.com/zainalicious/Modem-Setup/main"

run_step() {
  SCRIPT_NAME="$1"
  if [ -f "$SCRIPT_DIR/$SCRIPT_NAME" ]; then
    sh "$SCRIPT_DIR/$SCRIPT_NAME"
  else
    echo "[*] Mengunduh dan menjalankan $SCRIPT_NAME..."
    curl -fsSL "$REPO_RAW_URL/$SCRIPT_NAME" | sh
  fi
}

# Menu pilihan instalasi
echo "=========================================="
echo "          MODEM SETUP INSTALLER           "
echo "=========================================="
echo "Pilih opsi instalasi:"
echo "1) All in one (Install semua + Quectool)"
echo "2) Install semua KECUALI Quectool"
echo "=========================================="

CHOICE="${1:-}"
if [ -z "$CHOICE" ]; then
  printf "Masukkan pilihan [1/2]: "
  if [ -t 0 ]; then
    read -r CHOICE
  else
    read -r CHOICE < /dev/tty 2>/dev/null || CHOICE="1"
  fi
fi

case "$CHOICE" in
  1)
    echo "[+] Mode: All in one dipilih."
    ;;
  2)
    echo "[+] Mode: Install semua tanpa Quectool dipilih."
    ;;
  *)
    echo "[!] Pilihan tidak valid ($CHOICE). Harap pilih 1 atau 2."
    exit 1
    ;;
esac

# 1. Bersihkan SimpleAdmin & Lighttpd
run_step "cleanup_simpleadmin_lighttpd.sh"

# 2. Check & Install wget
run_step "install_wget.sh"

# 3. Install Entware
run_step "install_entware.sh"

# 4. Install Tailscale dari Entware
run_step "install_tailscale.sh"

# 5. Install Quectool (hanya untuk opsi 1)
if [ "$CHOICE" = "1" ]; then
  run_step "install_quectool.sh"
fi

echo "=========================================="
echo "[+] Selesai! Semua konfigurasi telah diterapkan."
echo "=========================================="
