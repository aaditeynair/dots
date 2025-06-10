#!/bin/bash
picom -b
dunst &

EWW_BIN="/home/aadi/dev/eww/target/release/eww"

if [[ ! $(pidof eww) ]]; then
    ${EWW_BIN} daemon
fi

${EWW_BIN} open clock
