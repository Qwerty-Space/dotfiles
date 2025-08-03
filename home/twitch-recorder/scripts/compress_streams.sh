#!/bin/bash

# Function to check if a Twitch channel is live
function compress() {
  find $1 -type f \( -name "Uncompressed*.mp4" -o -name "Uncompressed*.webm" \) -execdir sh -c '
    file="{}"
    echo compressing: {}
    output_file="${file//Uncompressed /}"
    output_file="${output_file//.webm/.mp4}"
    echo output: $output_file
    ffmpeg -i "{}" -r 30 -b:v 1.5M "$output_file" && rm "{}"
  ' \;
  # fd --type f --threads=1 "^Uncompressed.*\.(mp4|webm)$" $1 --exec sh -c '
  #   echo compressing: {}
  #   file="{.}"
  #   output_file="${file//Uncompressed /}"
  #   echo output: $output_file.mp4
  #   ffmpeg -i "{}" -r 30 -b:v 1.5M "$output_file.mp4" && rm "{}"
  # '
}

# Check if the user provided a path as an argument
if [[ -n $1 && -d $1 ]]; then
  # Call the is_live function with the channel name in lowercase
  compress "$1" # The "${1,,}" syntax converts the input to lowercase
else
  echo "Pass a valid path as an argument" # Prompt the user to provide an argument
fi
