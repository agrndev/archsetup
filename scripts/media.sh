#!/bin/bash

get_album() {
  echo $(playerctl -f {{album}} metadata)
}

get_song() {
  echo "$(get_artist) - $(get_title)"
}

get_artist() {
  echo $(playerctl -f {{artist}} metadata)
}

get_title() {
  echo $(playerctl -f {{title}} metadata)
}

get_media_data() {
  echo "$(get_artist) $(get_title) $(get_album)"
}

get_thumbnail() {
  art_url=$(playerctl -f {{mpris:artUrl}} metadata)

  if [[ $art_url == "https://"* ]]; then
    path="$(echo $path | sed "s/.*\///")"

    if [[ ! -f "/tmp/$path" ]]; then
      wget -O "/tmp/$path" "$art_url"
    fi

    echo "/tmp/$path"
  fi

  if [[ $art_url == "file://"* ]]; then
    echo "${art_url/file:\/\//}"
  fi
}

if ! playerctl status &> /dev/null; then
  exit 0
fi

case "$1" in
  album)
    echo $(get_album)
    ;;
  song)
    echo $(get_song)
    ;;
  artist)
    echo $(get_artist)
    ;;
  title)
    echo $(get_title)
    ;;
  media)
    echo $(get_media_data)
    ;;
  thumbnail)
    echo $(get_thumbnail)
    ;;
esac
