# Japanese Input Settings
# export GTK_IM_MODULE='ibus'
# export QT_IM_MODULE='ibus'
# export XMODIFIERS=@im='ibus'
export GTK_IM_MODULE=xim

# Run startx on Startup
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
