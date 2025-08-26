#!/bin/bash

timezone="$(curl --fail -s ipinfo.io | jq -r '.timezone')"

if [[ -n timezone ]]; then
  sudo timedatectl set-timezone $timezone
fi
