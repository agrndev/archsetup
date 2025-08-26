#!/bin/bash

echo "starting develompent.sh"

# ------------------------------
# NVIM
# ------------------------------
sudo pacman -S --noconfirm --needed nvim luarocks

# ------------------------------
# TERMINAL
# ------------------------------
sudo pacman -S --noconfirm --needed kitty

# ------------------------------
# DOCKER
# ------------------------------
sudo pacman -S --noconfirm --needed docker docker-buildx docker-compose
sudo usermod -aG docker ${USER}

echo "development.sh finished"
