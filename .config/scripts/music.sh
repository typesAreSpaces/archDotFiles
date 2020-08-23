#!/bin/bash
SERVICE="ncmpcpp"
if pgrep -x "$SERVICE" >/dev/null
then
    kill $(pgrep -x "$SERVICE")
else
    bspc rule -a '*' -o state=floating rectangle=640x360+0+690 sticky=on
    exec urxvt -e ncmpcpp
fi
