#!/bin/bash
picom &
dunst &

EWW_BIN="/home/aadi/dev/eww/target/release/eww"

if [[ ! $(pidof eww) ]]; then
	${EWW_BIN} daemon
fi

${EWW_BIN} open weather
${EWW_BIN} open music
${EWW_BIN} open system
${EWW_BIN} open clock
