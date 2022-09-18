#!/bin/sh
# run discord in tmux

while true; do
    discord-canary
    echo "Press Ctrl-C to stop..."
    echo "Restarting in 5"
    for i in {4..1}; do
        sleep 1
        echo $i
    done
    echo "Restarting..."
done
