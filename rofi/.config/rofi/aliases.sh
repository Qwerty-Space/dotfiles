#!/bin/zsh

# alias | awk -F'[ =]' '{print $2}'
print -rl -- ${(k)aliases} .zsh_aliases | grep -v .zsh_aliases

source ~/.zsh_aliases
