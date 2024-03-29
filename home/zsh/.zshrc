# The following lines were added by compinstall
zstyle :compinstall filename '/home/qwerty/.zshrc'

HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
unsetopt beep
setopt hist_ignore_all_dups
setopt hist_expire_dups_first
setopt hist_find_no_dups

# completion
autoload -Uz compinit; compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' squeeze-slashes false
zmodload zsh/complist
# Include hidden files
_comp_options+=(globdots)

autoload -Uz promptinit
promptinit

PROMPT="%F{blue}%B[%m %F{red}%~%F{blue}]%f%b "
# RPROMPT="%F{red}%B%U[%m %F{blue}%~%F{red}]%f%b%u "

# window title
autoload -Uz add-zsh-hook

function xterm_title_precmd () {
    print -Pn -- '\e]2;[%n@%m %~]\a'
    [[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}[%n\005{-}@\005{m}%m\005{-} \005{B}%~]\005{-}\e\\'
}

function xterm_title_preexec () {
    print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
    [[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}[%n\005{-}@\005{m}%m\005{-} \005{B}%~]\005{-}] ' && print -n -- "${(q)1}\e\\"; }
}

if [[ "$TERM" == (alacritty*|gnome*|konsole*|putty*|rxvt*|screen*|tmux*|xterm*) ]]; then
    add-zsh-hook -Uz precmd xterm_title_precmd
    add-zsh-hook -Uz preexec xterm_title_preexec
fi

# don't use quotes in ls
export QUOTING_STYLE=literal

# load aliases
source ~/.zsh_aliases

# dircolours
eval $(dircolors ~/.dir_colors)

# escape key codes
bindkey -e
bindkey "\e[5~" beginning-of-history    # PAGE UP
bindkey "\e[6~" end-of-history          # PAGE DOWN
bindkey "\e[7~" beginning-of-line       # HOME
bindkey "\e[8~" end-of-line             # END
bindkey "\e[3~" delete-char             # DELETE
bindkey "\e[2~" quoted-insert           # INSERT

vi-forward-nonword() {
    zle vi-forward-word-end
    zle vi-forward-char
}
zle -N vi-forward-nonword
bindkey "\e[1;5C" vi-forward-nonword
bindkey "\e[1;5D" vi-backward-word
bindkey "\e[1;5E" vi-backward-kill-word

# make time builtin look like bash
TIMEFMT=$'\nreal\t%*Es\nuser\t%*Us\nsys\t%*Ss'

# automatically cd on dir name
setopt autocd

# print error on glob match failiure
setopt nomatch

# report background job status immediately
setopt notify

# copy current command line to clipboard
function clip_cmd() {
    echo -nE "$BUFFER" | xclip -sel clip
}
zle -N clip_cmd
bindkey "^X" clip_cmd

# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"

# pyenv stuff
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# termite stuff
source /etc/profile.d/vte.sh

# Show the motd
# generated with:
# figlet -otf shadow qwerty@ && figlet -ktf shadow <hostname>
if [[ $TERM == "xterm-256color" ]]; then
    hostname=$(cat /etc/hostname)
    cat "$HOME/.config/motd/$hostname" 2> /dev/null
fi

# tere
tere() {
    local result=$(command tere "$@")
    [ -n "$result" ] && cd -- "$result"
}

# ibus stuff
GTK_IM_MODULE=ibus
QT_IM_MODULE=ibus
XMODIFIERS=@im=ibus

if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
    tmux >/dev/null 2>&1
fi

