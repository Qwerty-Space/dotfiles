#!/bin/bash

# Function to check if a Twitch channel is live
function is_live() {
  local channel_name=$1 # Store the channel name passed as an argument
  # store the channel link
  local channel_link="https://www.twitch.tv/$channel_name"
  # Fetch the HTML content of the Twitch channel page using curl
  local content=$(curl -s $channel_link)
  # Extract the title
  local description=$(echo "$content" | sed -E 's/.*"description":"([^"]+)".*/\1/')
  # Convert Unicode escape sequences to UTF-8 (e.g., \u003e -> >)
  local utf8_description=$(echo -e "$description" | sed 's/\\u\([0-9a-fA-F]\{4\}\)/\\x\1/g' | while read -r line; do echo -e "$line"; done)
  # Convert to a safe filename
  local filename=$(echo "$utf8_description" | tr -cd '[:alnum:][:space:]._-')
  # Get today's date
  local now=$(date -u "+%Y-%m-%d")

  # Check if the content contains the string "isLiveBroadcast"
  if [[ $content == *"isLiveBroadcast"* ]]; then
    echo "$channel_name is live" # Print a message if the channel is live
    notify-send ""
    dunstify -a "$USER@$(cat /etc/hostname)" "Recording $channel_name's stream"
    echo "Steam Title:  $utf8_description"
    # Download the stream, converting the video to 30 FPS with a bitrate of 2500K
    yt-dlp -o "$now $filename.%(ext)s" --postprocessor-args "-vf fps=30 -b:v 2500k" $channel_link
    dunstify -a "$USER@$(cat /etc/hostname)" "$channel_name's stream downloaded"
  else
    echo "$channel_name is not live :(" # Print a message if the channel is not live
  fi
}

# Check if the user provided a channel name as an argument
if [[ -z $1 ]]; then
  echo "Pass a channel name as an argument" # Prompt the user to provide an argument
else
  # If a second argument (directory) is provided and exists, change to that directory
  if [[ -n $2 && -d $2 ]]; then
    cd "$2" || {
      echo "Failed to change directory to $2"
      exit 1
    }
  elif [[ -n $2 ]]; then
    echo "Directory $2 does not exist."
    exit 1
  fi
  # Call the is_live function with the channel name in lowercase
  is_live "${1,,}" # The "${1,,}" syntax converts the input to lowercase
fi