#!/usr/bin/env bash

# add keybind to autostart
# hc keybind <keybind> spawn path/to/this/script/new_tag.sh

# i put my mod variables in here:
source ~/.config/herbstluftwm/vars.sh

hc() {
    herbstclient "$@"
}

tagname=$(rofi -dmenu -lines 0 | xargs)

hc chain , add $tagname , sprintf VAL "$Mod-%s" tags.count keybind VAL use $tagname
