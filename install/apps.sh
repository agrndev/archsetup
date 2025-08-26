#!/bin/bash

echo "starting apps.sh"

# ------------------------------
# ESSENTIALS
# ------------------------------
sudo pacman -S --noconfirm --needed \
  libreoffice \
  gnome-calculator \
  gnome-calendar

# ------------------------------
# BROWSER
# ------------------------------
sudo pacman -S --noconfirm --needed firefox qutebrowser

# ------------------------------
# MEDIA
# ------------------------------
sudo pacman -S --noconfirm --needed \
  imv \
  mpv \
  evince \
  obs-studio

# ------------------------------
# STEAM
# ------------------------------
sudo sed -i '/^\s*#\[multilib\]/,/^$/{s/^\s*#//}' /etc/pacman.conf
sudo pacman -Sy

sudo pacman -S --noconfirm --needed steam

# ------------------------------
# DEFAULT APPS
# ------------------------------
xdg-mime default imv.desktop image/png
xdg-mime default imv.desktop image/jpeg
xdg-mime default imv.desktop image/gif
xdg-mime default imv.desktop image/webp
xdg-mime default imv.desktop image/bmp
xdg-mime default imv.desktop image/tiff

xdg-mime default mpv.desktop video/mp4
xdg-mime default mpv.desktop video/x-msvideo
xdg-mime default mpv.desktop video/x-matroska
xdg-mime default mpv.desktop video/x-flv
xdg-mime default mpv.desktop video/x-ms-wmv
xdg-mime default mpv.desktop video/mpeg
xdg-mime default mpv.desktop video/ogg
xdg-mime default mpv.desktop video/webm
xdg-mime default mpv.desktop video/quicktime
xdg-mime default mpv.desktop video/3gpp
xdg-mime default mpv.desktop video/3gpp2
xdg-mime default mpv.desktop video/x-ms-asf
xdg-mime default mpv.desktop video/x-ogm+ogg
xdg-mime default mpv.desktop video/x-theora+ogg
xdg-mime default mpv.desktop video/application/ogg

xdg-mime default org.gnome.Evince.desktop application/pdf

xdg-settings set default-web-browser firefox.desktop
xdg-mime default firefox.desktop x-scheme-handler/http
xdg-mime default firefox.desktop x-scheme-handler/https

echo "apps.sh finished"
