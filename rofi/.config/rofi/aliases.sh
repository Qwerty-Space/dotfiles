#!/bin/zsh

source ~/.zsh_aliases
print -rl -- ${(k)aliases} .zsh_aliases | grep -v .zsh_aliases
