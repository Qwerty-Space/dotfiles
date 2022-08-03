#!/bin/sh

ddcutil -n "ATNM91A020664" setvcp D6 0x04 &> /dev/null &
ddcutil -n "ATNM91A038207" setvcp D6 0x04 &> /dev/null &

