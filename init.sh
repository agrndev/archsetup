#!/bin/bash

GITHUB_REPO="https://github.com/agrndev/archsetup"
CLONING_PATH="~/.local/share/archsetup"
INSTALL_PATH="${CLONING_PATH}/install.sh"

sudo pacman -Sy --noconfirm --needed git

rm -rf ${CLONING_PATH}
git clone --recursive ${GITHUB_REPO} ${CLONING_PATH} > /dev/null

source ${INSTALL_PATH}
