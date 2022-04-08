#!/bin/bash
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

userresources=$HOME/.Xresources

# merge in defaults and keymaps

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

### Custom Stuff ##
# Stop terminal beeps and screensaver
xset b off 
# xset s off
# xset -dpms

# Setup Monitors

xrandr --output HDMI-A-0 --primary --mode 1920x1080 --rate 144
xrandr --output DisplayPort-0 --mode 1920x1080 --rate 144 --right-of HDMI-A-0

# Launch Herstluftwm
exec herbstluftwm
xset r rate 660 25
