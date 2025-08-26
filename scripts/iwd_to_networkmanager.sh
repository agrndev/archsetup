#!/bin/bash

PASSWORD_FOLDER="/var/lib/iwd"

parse_passphrase() {
  echo $(sudo cat "${PASSWORD_FOLDER}/$1.psk" | grep "Passphrase=" | sed 's/Passphrase=//g')
}

parse_ssid() {
  echo $(iwctl station "$1" show | grep "Connected network" | sed 's/Connected network//g')
}

success() {
   iwctl station "$1" disconnect
   sudo systemctl enable NetworkManager.service
}

fail() {
  sudo systemctl stop NetworkManager.service
}

get_wifi_adapters() {
  echo $(iwctl device list | grep -o "wlan[0-9]*")
}

sudo systemctl start NetworkManager.service

adapters=$(get_wifi_adapters)

if [[ -z $adapters ]]; then
  fail
  echo "No wireless adapters found"
  exit 1
fi

for adapter in $adapters; do
  echo "Found adapter: $adapter"

  ssid=$(parse_ssid "$adapter")

  if [[ -n $ssid ]]; then
    echo "$adapter is connected to $ssid"

    passphrase=$(parse_passphrase "$ssid")
    echo "Passphrase found"

    echo "Trying to connect to $ssid network..."
    if nmcli device wifi connect "$ssid" password "$passphrase"; then
        success "$adapter"
        exit 0
    else
        echo "Failed to connect to $ssid"
    fi
  fi
done

fail
