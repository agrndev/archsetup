#!/bin/bash/

echo "starting program.sh"

# ------------------------------
# SHELL PROGRAMS
# ------------------------------
sudo pacman -S --noconfirm --needed \
  uwsm \
  wget \
  curl \
  unzip \
  yazi \
  fzf \
  ripgrep \
  bat \
  wl-clipboard \
  man \
  tldr \
  fastfetch \
  btop \
  gcc \
  clang \
  npm \
  nodejs \
  go \
  lua

# ------------------------------
# YAY (AUR)
# ------------------------------
CLONING_PATH="/tmp/yay"

sudo pacman -Sy --noconfirm --needed base-devel

rm -rf ${CLONING_PATH}
git clone https://aur.archlinux.org/yay.git ${CLONING_PATH} > /dev/null
cd ${CLONING_PATH}
makepkg -si --noconfirm > /dev/null
cd
rm -rf ${CLONING_PATH}

echo "programs.sh finished"
