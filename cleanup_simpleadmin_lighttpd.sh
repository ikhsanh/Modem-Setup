#!/bin/sh

set -e

echo "[*] Membersihkan SimpleAdmin & Lighttpd..."

cd /tmp && mount -o remount,rw /

systemctl stop simpleadmin-httpd lighttpd || true
systemctl daemon-reload
systemctl disable simpleadmin-httpd lighttpd || true
systemctl daemon-reload

rm -f /usr/sbin/lighttpd*
rm -f /var/lib/opkg/info/lighttpd*
rm -rf /usrdata/simpleadmin
rm -f /lib/systemd/system/simpleadmin-httpd.service
rm -f /lib/systemd/system/multi-user.target.wants/simpleadmin-httpd.service
rm -f /lib/systemd/system/lighttpd.service
rm -f /lib/systemd/system/multi-user.target.wants/lighttpd.service
rm -f /usrdata/etc/data/mobileap_cfg.xml.simpleadmin.bak
rm -f /etc/data/mobileap_cfg.xml.simpleadmin.bak
rm -f /tmp/simpleadmin-go-at.lock
rm -rf /etc/lighttpd.d
rm -f /etc/initscripts/lighttpd
rm -f /data/www/lighttpd.user
rm -f /data/lighttpd.conf
rm -rf /usrdata/etc/lighttpd.d
rm -f /usrdata/etc/initscripts/lighttpd
rm -f /usrdata/data/www/lighttpd.user
rm -f /usrdata/data/lighttpd.conf
rm -f /usrdata/root/bin/simplepasswd
umount /opt || true
rm -rf /opt
rm -rf /usrdata/opt
systemctl disable opt.mount || true
rm -f /lib/systemd/system/opt.mount
systemctl daemon-reload

echo "[+] Pembersihan SimpleAdmin & Lighttpd selesai."

