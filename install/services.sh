#!/bin/bash

sudo cp ~/.local/share/archsetup/services/set-mute-button.service /lib/systemd/system/
sudo systemctl enable set-mute-button.service
