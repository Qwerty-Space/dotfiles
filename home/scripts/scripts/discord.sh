#!/bin/bash

trap 'kill $(jobs -p)' EXIT

/usr/bin/discord-canary &
PID=$!

/bin/systemd-notify --ready

while(true); do
    FAIL=0

    kill -0 $PID
    if [[ $? -ne 0 ]]; then FAIL=1; fi

    if [[ $FAIL -eq 0 ]]; then /bin/systemd-notify WATCHDOG=1; fi

    sleep 2
done

