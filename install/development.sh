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

echo "development.sh finished"
