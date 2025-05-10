#!/bin/bash

# Function to check if a Twitch channel is live
function compress() {
  find $1 -type f -name "Uncompressed*.mp4" -execdir sh -c '
    file="{}"
    ffmpeg -i "{}" -r 30 -b:v 1.5M "${file//Uncompressed /}" && \
    rm "{}"
  ' \;
}

# Check if the user provided a path as an argument
if [[ -n $1 && -d $1 ]]; then
  # Call the is_live function with the channel name in lowercase
  compress "$1" # The "${1,,}" syntax converts the input to lowercase
else
  echo "Pass a valid path as an argument" # Prompt the user to provide an argument
fi
