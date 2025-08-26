#!/bin/bash

NOTIFICATION_TIME=1500

send_notification() {
  notify-send \
    -t $NOTIFICATION_TIME \
    "Airplane mode $1"
}

status=$(nmcli radio wifi)
case $status in
  enabled)
    nmcli radio all off
    send_notification disabled
    ;;
  disabled)
    nmcli radio all on
    send_notification enabled
    ;;
esac
