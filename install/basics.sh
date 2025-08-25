#!/bin.bash

echo "starting basics.sh"

# ------------------------------
# NETWORK
# ------------------------------
sudo pacman -S --noconfirm --needed \
  iwd \
  networkmanager \
  network-manager-applet \
  nm-connection-editor

sudo systemctl enable --now iwd.service
sudo systemctl enable --now NetworkManager.service

# This fixes graphical.target waiting 60s on boot
sudo systemctl disable systemd-networkd-wait-online.service
sudo systemctl mask systemd-networkd-wait-online.service
sudo systemctl disable NetworkManager-wait-online.service
sudo systemctl mask NetworkManager-wait-online.service

# ------------------------------
# BLUETOOTH
# ------------------------------
sudo pacman -S --noconfirm --needed blueberry
sudo systemctl enable --now bluetooth.service

# ------------------------------
# AUDIO
# ------------------------------
sudo pacman -S --noconfirm --needed pipewire wireplumber

# ------------------------------
# BRIGHTNESS
# ------------------------------
sudo pacman -S --noconfirm --needed brightnessctl
sudo chmod +s $(which brightnessctl)
brightnessctl set 50%

# ------------------------------
# POWER PROFILE
# ------------------------------
sudo pacman -S --noconfirm --needed power-profiles-daemon
powerprofilesctl set balanced || true

# ------------------------------
# TIMEZONE
# ------------------------------
SCRIPT_PATH="/etc/NetworkManager/dispatcher.d/on_connect.sh"

cat <<EOF | sudo tee $SCRIPT_PATH
#!/bin/bash

update_timezone() {
  timezone="\$(curl --fail -s ipinfo.io | jq -r '.timezone')"
  if [[ ! -z timezone ]]; then
    sudo timedatectl set-timezone \$timezone
  fi
}

if [[ \$2 -eq up ]]; then
  update_timezone
fi
EOF

sudo chown root:root $SCRIPT_PATH
sudo chmod u+x $SCRIPT_PATH

sudo systemctl enable --now NetworkManager-dispatcher.service
sudo systemctl start NetworkManager-dispatcher.service

# ------------------------------
# PRINTER
# ------------------------------
sudo pacman -S --noconfirm --needed cups cups-pdf cups-filters cups-browsed system-config-printer avahi nss-mdns
sudo systemctl enable --now cups.service

sudo mkdir -p /etc/systemd/resolved.conf.d
echo -e "[Resolve]\nMulticastDNS=no" | sudo tee /etc/systemd/resolved.conf.d/10-disable-multicast.conf
sudo systemctl enable --now avahi-daemon.service

if ! grep -q '^CreateRemotePrinters Yes' /etc/cups/cups-browsed.conf; then
  echo 'CreateRemotePrinters Yes' | sudo tee -a /etc/cups/cups-browsed.conf
fi
sudo systemctl enable --now cups-browsed.service

echo "basics.sh finished"
