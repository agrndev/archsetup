#!/bin/bash

GITHUB_REPO="https://github.com/agrndev/archsetup"
CLONING_PATH=~/.local/share/archsetup

sudo pacman -Sy --noconfirm --needed git

rm -rf ${CLONING_PATH}
git clone --recursive ${GITHUB_REPO} ${CLONING_PATH} > /dev/null

source ${CLONING_PATH}/install.sh
