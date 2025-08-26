#!/bin/bash

echo "starting desktop.sh"

# ------------------------------
# HYPRLAND
# ------------------------------
sudo pacman -S --noconfirm --needed \
  hyprland \
  hyprpaper \
  hyprlock \
  hypridle \
  hyprpicker \
  hyprsunset \
  waybar \
  nautilus \
  cliphist \
  polkit-gnome \
  qt5-wayland \
  qt6-wayland

yay -S --noconfirm --needed tofi

# ------------------------------
# FONT
# ------------------------------
sudo pacman -S --noconfirm --needed \
noto-fonts \
noto-fonts-emoji \
ttf-font-awesome \
ttf-cascadia-mono-nerd \
ttf-ibm-plex \
cantarell-fonts

# ------------------------------
# NOTIFICATION
# ------------------------------
sudo pacman -S --noconfirm --needed dunst

# ------------------------------
# SCREENSHARE
# ------------------------------
sudo pacman -S --noconfirm --needed \
  xdg-desktop-portal-hyprland \
  grim \
  slurp

echo "desktop.sh finished"
