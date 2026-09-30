#!/usr/bin/bash

# Brightness notification: dunst

notify_id=817

function get_brightness {
    light
}

function brightness_notification {
    brightness=`get_brightness`
    printf -v br_int %.0f "$brightness"
    #echo $br_int
    dunstify --appname="brightness" -r $notify_id -u low ""  "${br_int}"
}

case $1 in
    up)
        light -A 10
        brightness_notification
        ;;
    down)
        light -U 10
        brightness_notification
	    ;;
    *)
        echo "Usage: $0 up | down "
        ;;
esac
