#!/bin/bash
function set_brightness {
    #sudo ~/.config/rogauracore/rogauracore brightness $currentbrightness
    sudo rogauracore initialize_keyboard
    sudo rogauracore brightness $currentbrightness
    sleep 0.1 
    xset r rate 300 50
    setxkbmap be

}
currentbrightness=$(cat ~/scripts/currentvars/currentbrightness)

if [ $1 == "up" ]; then
    if [ $((currentbrightness)) -lt 3 ]; then
        ((currentbrightness+=1))
        echo $currentbrightness > ~/scripts/currentvars/currentbrightness
        set_brightness
    fi
elif [ $1 == "down" ]; then
    if [ $((currentbrightness)) -gt 0 ]; then
        ((currentbrightness-=1))
        echo $currentbrightness > ~/scripts/currentvars/currentbrightness
        set_brightness
    fi
fi

