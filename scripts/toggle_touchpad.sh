#!/bin/bash

NOTIFICATION_TIME=1500

case "$1" in
  on)
    notify-send \
      -t $NOTIFICATION_TIME \
      -h string:x-dunst-stack-tag:touchpad \
      "Touchpad enabled"
    ;;
  off)
    notify-send \
      -t $NOTIFICATION_TIME \
      -h string:x-dunst-stack-tag:touchpad \
      "Touchpad disabled"
    ;;
esac
