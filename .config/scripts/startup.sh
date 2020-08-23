#!/bin/sh

~/.fehbg &

#xrdb ~/.Xressources
~/scripts/xrdbgpu.sh > /dev/null &

polybar top > /dev/null &
polybar bot > /dev/null &

#compton -b --backend glx --blur-background --blur-method kawase --blur-strength 12 &
picom --config .config/picom/picom.conf &

mpd > /dev/null &

sudo mount -t ntfs-3g /dev/nvme0n1p4 ~/Share &

sudo bluetooth off &

xset r rate 300 50 &        #   now in bspwmrc with rogauracore
setxkbmap be &
xset m 0 0 &
