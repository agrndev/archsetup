#!/bin/bash

NOTIFICATION_TIMEOUT=2500
PICTURES_FOLDER=~/Pictures
FILETYPE=jpg

get_filepath() {
  echo $PICTURES_FOLDER/$(generate_filename)
}

generate_filename() {
  echo "screenshot-$(date +'%Y-%m-%d_%H-%M-%S').$FILETYPE"
}

send_notification() {
    notify-send \
      -t $NOTIFICATION_TIMEOUT \
      -i $1 "saved in $1"
}

file=$(get_filepath)
case "$1" in
  print)
    grim $file
    wl-copy < $file
    send_notification $file
    ;;
  snippet)
    grim -g "$(slurp -d)" $file
    wl-copy < $file
    send_notification $file
    ;;
esac
