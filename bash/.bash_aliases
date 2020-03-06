# Rofi stuff
rofi_run() {
    rofi -run-list-command ". ~/.config/rofi/aliases.sh" \
    -run-command "/bin/bash -i -c '{cmd}'" -show run;
}

lst() {
    depth=${1:-2}
    lsd --group-dirs first --tree --depth $depth;
}

# lst() {
#     if [ -z $1 ] 
#         then
#             lsd --tree --depth 2
#         else
#             lsd --tree --depth $1 
#     fi
# }

alias l='lsd --group-dirs first'
alias ll='lsd -l --total-size --date "+%F %T" --group-dirs first'
alias la='lsd -lA --total-size --date "+%F %T" --group-dirs first'
alias d='du --exclude "./.*" -hd1'
alias da='du -hd1'
alias tunnel='bash ~/scripts/tunnel.sh'
alias ff='firefox'
alias slock='betterlockscreen -l dimblur & xset dpms force off &'
alias hc='herbstclient'
alias tqwerty='telegram-desktop -many -key qwertyspace'

# Scripts
alias screenshot='/home/qwerty/scripts/screenshot'

# SSH
alias zeus='ssh qwertyspace@zeus.feralhosting.com'
mntzeus() {
    sshfs qwertyspace@zeus.feralhosting.com:/media/sdh1/home/qwertyspace /mnt/zeus && cd /mnt/zeus
}

# Make a directory and cd into it
mkcd() {
    mkdir -p "$@" && cd "$@";
}

backup() {
    for file in "$@"; do
        local new=${file}.$(date '+%Y-%m-%d_%H-%M-%S')
        while [[ -f $new ]]; do
            new+="~";
        done;
        \cp -ip "$file" "$new";
    done
}

# Compress PNG images
DATE=$(date '+%Y-%m-%d_%H-%M-%S')
compresspng() {
    backup "$@" && mogrify -filter Triangle \
    -define filter:support=2 -unsharp 0.25x0.08+8.3+0.045 \
    -dither None -posterize 136 -quality 82 -define png:compression-filter=5 \
    -define png:compression-level=9 -define png:compression-strategy=1 \
    -define png:exclude-chunk=all -interlace none -depth 8 \
    -colorspace sRGB "$@";
}

vol() {
    pactl list sinks | perl -000ne 'if(/#0/){/(\d+%)/; print "$1\n"}';
}

# Compare two directories
dirdiff() {
    find "$1/" "$2/" "$2/" -printf '%P\n' | sort | uniq -u | sed "s/^/$1\//"
    find "$1/" "$1/" "$2/" -printf '%P\n' | sort | uniq -u | sed "s/^/$2\//"
}

# Copy files with a progress bar
cpstat () {
    tar c "$1" | pv | tar x -C "$2"
}

# Check for errors in FLAC files in chosen directory
audiocheck() {
    find "$1" -type f -iname '*.flac' -print0 | xargs --null flac -wst
}

