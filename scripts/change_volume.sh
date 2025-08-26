#!/bin/bash

VOLUME_STEP=5
MAX_VOLUME=100
NOTIFICATION_TIMEOUT=2000

get_volume() {
  echo $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o '[0-9]\+' | tr -d '\n' | sed 's/^0\+//')
}

volume_to_progress_bar() {
  echo $(( $(get_volume) * 100 / MAX_VOLUME ))
}

get_icon() {
  local volume=$(get_volume)
  if [[ $volume -le 0 ]]; then
    echo $(grep "volume_muted=" ~/.config/themes/current/files/icons | sed "s/volume_muted=//")
  elif [[ $volume -lt $(($MAX_VOLUME / 2)) ]]; then
    echo $(grep "volume_low=" ~/.config/themes/current/files/icons | sed "s/volume_low=//")
  else
    echo $(grep "volume_high=" ~/.config/themes/current/files/icons | sed "s/volume_high=//")
  fi
}

send_notification() {
  local volume=$(get_volume)
  local title=$(~/.scripts/media.sh title)
  local thumbnail=$(~/.scripts/media.sh thumbnail)

  notify-send \
      -t $NOTIFICATION_TIMEOUT \
      -h string:x-dunst-stack-tag:volume \
      -h int:value:$(volume_to_progress_bar)\
      -i "$thumbnail" \
      "$(get_icon)      $volume%" \
      "$title"
}

case "$1" in
    raise)
      wpctl set-mute @DEFAULT_AUDIO_SINK@ 0

      volume=$(get_volume)
      if [ $(( "$volume" + "$VOLUME_STEP" )) -gt $MAX_VOLUME ]; then
        wpctl set-volume @DEFAULT_AUDIO_SINK@ $MAX_VOLUME%
      else
        wpctl set-volume @DEFAULT_AUDIO_SINK@ "$VOLUME_STEP%+"
      fi
      send_notification
    ;;
    lower)
      wpctl set-volume @DEFAULT_AUDIO_SINK@ "$VOLUME_STEP%-"
      send_notification
    ;;
esac

