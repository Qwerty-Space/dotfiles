# The following lines were added by compinstall
zstyle :compinstall filename '/home/qwerty/.zshrc'

# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
unsetopt beep
# End of lines configured by zsh-newuser-install

# completion
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
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

# colour aliases
alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv="mv -i"
# human-readable sizes
alias df='df -h'
# show sizes in MB
alias free='free -m'

# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"

export EDITOR=/usr/bin/vim

# Add ~/bin to PATH
export PATH="$HOME/.local/bin:$PATH"
# Add cargo binaries to path
export PATH="$PATH:$HOME/.cargo/bin"
# Pyenv stuff
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

if [[ $TERM == "rxvt-unicode-256color" ]]; then
    cat /etc/motd
fi


