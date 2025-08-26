#!/bin/bash

NOTIFICATION_TIMEOUT=1500
ICON=$(grep "microphone_muted=" ~/.config/themes/current/files/icons | sed "s/microphone_muted=//")

send_notification() {
  notify-send \
    -t $NOTIFICATION_TIMEOUT \
    -h string:x-dunst-stack-tag:mic_mute \
    "$ICON  Microphone $1"
}

get_status() {
  if wpctl get-volume @DEFAULT_SOURCE@ | grep -q "MUTED"; then
    echo "disabled"
  else
    echo "enabled"
  fi
}

status=$(get_status)
case $status in
  enabled)
    wpctl set-mute @DEFAULT_SOURCE@ 1
    send_notification disabled
    ;;
  disabled)
    wpctl set-mute @DEFAULT_SOURCE@ 0
    send_notification enabled
    ;;
esac
