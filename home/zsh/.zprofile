# export GTK_IM_MODULE=fcitx
unset GTK_IM_MODULE
export GTK_IM_MODULE=
export QT_IM_MODULE=fcitx

# Run startx on Startup
# if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
#   exec startx
# fi
