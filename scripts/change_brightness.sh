#!/bin/bash

BRIGHTNESS_STEP=20%
NOTIFICATION_TIME=1500

get_icon() {
  echo $(cat ~/.config/themes/current/files/icons | grep "brightness="| sed "s/brightness=//")
}

get_percentage() {
  echo $(brightnessctl -m | awk -F "," '{print $4}' | sed "s/%//")
}

send_notification() {
  brightness="$(get_percentage)%"
  notify-send \
  -t $NOTIFICATION_TIME \
  -h string:x-dunst-stack-tag:brightness \
  -h int:value:$brightness \
  "$(get_icon)    $brightness"
}

play_sound() {
  ~/.scripts/alert.sh
}

case "$1" in
  up)
    if [[ $(get_percentage) -lt 100 ]]; then
      brightnessctl set "$BRIGHTNESS_STEP+"
      send_notification
      play_sound
    fi
    ;;
  down)
    if [[ $(get_percentage) -gt 0 ]]; then
      brightnessctl set "$BRIGHTNESS_STEP-"
      send_notification
      play_sound
    fi
    ;;
esac
