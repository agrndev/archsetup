#!/bin/bash

NOTIFICATION_TIMEOUT=1500
ICON=$(grep "volume_muted=" ~/.config/themes/current/files/icons | sed "s/volume_muted=//")

send_notification() {
  notify-send -t \
    $NOTIFICATION_TIMEOUT \
    -h string:x-dunst-stack-tag:mute \
    -i "$album_art" "$ICON   muted" "$current_song"
}

wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
send_notification
