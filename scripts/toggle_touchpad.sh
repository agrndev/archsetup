#!/bin/bash

case "$1" in
  on)
    notify-send "touchpad enabled"
    ;;
  off)
    notify-send "touchpad disabled"
    ;;
esac
