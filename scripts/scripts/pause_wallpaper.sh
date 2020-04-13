#!/bin/bash
# create and delete file

filepath=/run/user/1000/wallpaper_paused
text="If this file exists, the slideshow will be paused"

if [ -e "$filepath" ]; then
    rm "$filepath"
    dunstify -a "$USER@$(hostname)" "Resume slideshow"
else
    echo "$text" > "$filepath"
    dunstify -a "$USER@$(hostname)" "Pause slideshow"
fi
