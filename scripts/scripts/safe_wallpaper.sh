#!/bin/bash
# create and delete file

filepath=/run/user/1000/wallpaper_safe
text="If this file exists, the slideshow will be safe"

if [ -e "$filepath" ]; then
    rm "$filepath"
    dunstify -a "$USER@$(hostname)" "Resume normal slideshow"
else
    echo "$text" > "$filepath"
    dunstify -a "$USER@$(hostname)" "Safe mode"
fi
