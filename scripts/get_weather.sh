#!/bin/bash

get_location() {
  echo $(curl -s ipinfo.io/city)
}

location=$(get_location)

if [[ -z $location ]]; then
  echo "location not found"
  exit 1
fi

regex_location=$(echo $location | sed -e 's/ã/a/g' \
				                              -e 's/õ/o/g' \
    			       	                    -e 's/á/a/g' \
    			       	                    -e 's/é/e/g' \
    			       	                    -e 's/í/i/g' \
    			       	                    -e 's/ó/o/g' \
    			       	                    -e 's/ú/u/g' \
    			       	                    -e 's/â/a/g' \
    			       	                    -e 's/ê/e/g' \
    			       	                    -e 's/î/i/g' \
    			       	                    -e 's/ô/o/g' \
    			       	                    -e 's/û/u/g' \
    			       	                    -e 's/ä/a/g' \
    			       	                    -e 's/ë/e/g' \
    			       	                    -e 's/ï/i/g' \
    			       	                    -e 's/ö/o/g' \
    			       	                    -e 's/ü/u/g' \
    			       	                    -e 's/[^a-zA-Z0-9 ]//g' \
				                              -e 's/ /_/g;')

weather=$(curl -s wttr.in/${regex_location}?format=1)

if [[ -n $weather ]]; then
  echo $weather
else
  echo "couldn't retrieve wheater data"
fi
