#!/bin/bash

echo "starting configuration.sh"

# ------------------------------
# BASH FILES
# ------------------------------
cp ~/.local/share/archsetup/dotfiles/bash/bashrc ~/.bashrc
cp ~/.local/share/archsetup/dotfiles/bash/bash_profile ~/.bash_profile
cp ~/.local/share/archsetup/dotfiles/bash/bash_aliases ~/.bash_aliases

# ------------------------------
# SCRIPTS
# ------------------------------
cp ~/.local/share/archsetup/scripts ~/.scripts

# ------------------------------
# DOTFILES
# ------------------------------
cp -R --remove-destination ~/.local/share/archsetup/dotfiles/config/. ~/.config/

# ------------------------------
# THEMES
# ------------------------------
SOURCE_THEMES_PATH=~/.local/share/archsetup/themes
DESTINATION_THEMES_PATH=~/.config/themes

mkdir -p $DESTINATION_THEMES_PATH

for theme in "${SOURCE_THEMES_PATH}/*"
do
  ln -snf $theme "${DESTINATION_THEMES_PATH}/"
done

CURRENT_PATH=~/.config/themes/current
mkdir -p $CURRENT_PATH

ln -snf "${DESTINATION_THEMES_PATH}/everforest" "${CURRENT_PATH}/files"
ln -snf "${DESTINATION_THEMES_PATH}/everforest/wallpapers/1.jpg" "${CURRENT_PATH}/wallpaper"

mkdir -p ~/.config/nvim/lua/plugins
ln -snf "${CURRENT_PATH}/nvim.lua" ~/.config/nvim/lua/plugins/theme.lua

mkdir -p ~/.config/dunst
ln -snf "${CURRENT_PATH}"/dunst ~./config/dunst/dunstrc

mkdir -p ~/.config/btop/themes
ln -snf "${CURRENT_PATH}/btop.theme" ~/.config/btop/themes/current.theme

mkdir -p ~/.config/fastfetch
ln -snf "${CURRENT_PATH}/fastfetch.jsonc" ~/.config/fastfetch/config.jsonc

echo "configuration.sh finished"
