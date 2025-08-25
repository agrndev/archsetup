#!/bin/bash

BRIGHTNESS_STEP=20%

case "$1" in
  up)
    brightnessctl set "${BRIGHTNESS_STEP}+"
    ;;
  down)
    brightnessctl set "${BRIGHTNESS_STEP}-"
    ;;
esac
