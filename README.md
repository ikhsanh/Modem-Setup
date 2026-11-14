# Modem-Setup

Script otomatisasi untuk konfigurasi dan setup modem Quectel / Linux-based modem (pembersihan service SimpleAdmin/Lighttpd lama, instalasi Wget, Entware, Tailscale, dan Quectool).

---

## 🚀 Quick Install

Jalankan perintah berikut melalui SSH/Terminal pada modem Anda:

```sh
cd /tmp && curl -sL https://raw.githubusercontent.com/ikhsanh/Modem-Setup/main/setup.sh | sh
```

### Jalankan dengan Pilihan Otomatis (Non-interaktif)

Anda juga dapat langsung menentukan nomor opsi tanpa melalui prompt interaktif:

* **Opsi 1: All in One** (Install semua komponen + Quectool)
  ```sh
  cd /tmp && curl -sL https://raw.githubusercontent.com/ikhsanh/Modem-Setup/main/setup.sh | sh -s 1
  ```

* **Opsi 2: Tanpa Quectool** (Install semua komponen KECUALI Quectool)
  ```sh
  cd /tmp && curl -sL https://raw.githubusercontent.com/ikhsanh/Modem-Setup/main/setup.sh | sh -s 2
  ```

---

## 📋 Menu & Fitur

Saat `setup.sh` dijalankan, script akan menampilkan menu:

1. **All in one (Install semua + Quectool)**
   * Pembersihan SimpleAdmin & Lighttpd
   * Pengecekan & instalasi Wget
   * Instalasi Entware
   * Instalasi Tailscale (cron & tailscale_nohf)
   * Unduh dan instalasi Quectool terbaru
2. **Install semua KECUALI Quectool**
   * Menjalankan seluruh langkah di atas, namun melewati instalasi Quectool.

---

## 📂 Struktur Modul Script

Repositori ini disusun secara modular sehingga setiap tahapan dapat dieksekusi secara terpisah jika diperlukan:

| File | Deskripsi |
| --- | --- |
| `setup.sh` | Script utama (orchestrator) dengan menu interaktif dan deteksi argumen. |
| `cleanup_simpleadmin_lighttpd.sh` | Membersihkan service `simpleadmin-httpd`, `lighttpd`, mount `/opt`, dan file konfigurasi terkait. |
| `install_wget.sh` | Memeriksa ketersediaan `wget` dan menginstalnya jika belum ada. |
| `install_entware.sh` | Menginstal package manager Entware (`/opt`). |
| `install_tailscale.sh` | Menginstal `cron` dan `tailscale_nohf` melalui Entware `opkg`. |
| `install_quectool.sh` | Mengambil rilis `.tar.gz` terbaru dari Quectool Fork, mengekstrak ke `/tmp`, dan menjalankan instalasi. |

---

## 🔗 Sumber & Referensi (Credits)

Terima kasih kepada proyek-proyek dan sumber berikut:

* **Wget Installer**: [ikhsanh/wget-rg501q](https://github.com/ikhsanh/wget-rg501q)
* **Entware Setup**: [zainalicious/Modem-Setup](https://github.com/zainalicious/Modem-Setup)
* **Quectool Fork Release**: [fa0xh1/quectool-fork-release](https://github.com/fa0xh1/quectool-fork-release)
* **Upstream Quectool**: [snowzach/quectool](https://github.com/snowzach/quectool)
* **Tailscale**: [Entware Package Repository](https://entware.net/)
