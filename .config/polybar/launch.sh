#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

#for m in $(polybar --list-monitors | cut -d":" -f1); do
  #interface="$(cat /proc/net/wireless | perl -ne '/(\w+):/ && print $1')";
  #NETWORK_INTERFACE=$interface MONITOR=$m polybar -c ~/.config/polybar/config.ini main &
  #done

#interface="wlp59s0";
interface="enp58s0u1u4";
NETWORK_INTERFACE=$interface MONITOR=DP3 polybar -c ~/.config/polybar/config.ini top_bar &
NETWORK_INTERFACE=$interface MONITOR=eDP1 polybar -c ~/.config/polybar/config.ini top_bar &
