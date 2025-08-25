#!/bin/bash

VOLUME_STEP=5%

case "$1" in
  raise)
    wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ "${VOLUME_STEP}+"
    ;;
  lower)
    wpctl set-volume @DEFAULT_AUDIO_SINK@ "${VOLUME_STEP}-"
    ;;
esac
