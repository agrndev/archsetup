#!/bin/bash

set -e

INSTALL_FOLDER=~/.local/share/archsetup/install

echo "Starting system setup..."

source ${INSTALL_FOLDER}/programs.sh
source ${INSTALL_FOLDER}/basics.sh
source ${INSTALL_FOLDER}/configuration.sh
source ${INSTALL_FOLDER}/development.sh
source ${INSTALL_FOLDER}/desktop.sh
source ${INSTALL_FOLDER}/apps.sh
source ${INSTALL_FOLDER}/services.sh

echo "Installation succeeded."
echo "Rebooting system..."
sleep 4
reboot
