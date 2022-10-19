#!/bin/bash
ssid=$1
password=$2

# already connected
curl -s google.com >/dev/null && exit 0

if [ -z "$ssid" ] || [ -z "$password" ]; then
  echo need network name and password > /dev/stderr
  exit 1
fi
sudo systemctl start wpa_supplicant
sleep 3
network=$(wpa_cli -- add_network | tail -n 1)
wpa_cli -- set_network $network ssid \"$ssid\"
wpa_cli -- set_network $network psk \"$password\"
wpa_cli -- set_network $network key_mgmt WPA-PSK
wpa_cli -- enable_network $network
