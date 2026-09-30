#!/usr/bin/bash

# Volume notification: Pulseaudio and dunst
# inspired by gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a

icon_path=/usr/share/icons/Adwaita/64x64/status/
notify_id=506
sink_nr=0   # use `pacmd list-sinks` to find out sink_nr

function get_volume {
    pacmd list-sinks | awk '/\tvolume:/ { print $5 }' | tail -n+$((sink_nr+1)) | head -n1 | cut -d '%' -f 1
}

function get_volume_icon {
    if [ "$1" -lt 34 ]
    then
        echo -n "奄"
    elif [ "$1" -lt 67 ]
    then
        echo -n "奔"
    elif [ "$1" -le 100 ]
    then
        echo -n "墳"
    else
        echo -ne "\ufc5b"
    fi
}

function volume_notification {
    volume=`get_volume`
    vol_icon=`get_volume_icon $volume`
    muted=$(pacmd list-sinks | awk '/muted/ { print $2 }' | tail -n+$((sink_nr+1)) | head -n1)
    if [ $muted == 'yes' ]
    then
        dunstify --appname="volume-muted" -r $notify_id -u low "`get_volume_icon $(get_volume)`"  "`get_volume`"
    else
        dunstify --appname="volume" -r $notify_id -u low "${vol_icon}"  "${volume}"
    fi
}

function mute_notification {
    muted=$(pacmd list-sinks | awk '/muted/ { print $2 }' | tail -n+$((sink_nr+1)) | head -n1)
    if [ $muted == 'yes' ]
    then
        dunstify --appname="volume-muted" -r $notify_id -u low "婢"  "mute"
    else
        dunstify --appname="volume" -r $notify_id -u low "`get_volume_icon $(get_volume)`"  "`get_volume`"
    fi
}

case $1 in
    up)
        pactl set-sink-volume $sink_nr +5%
        volume_notification
        ;;
    down)
        pactl set-sink-volume $sink_nr -5%
        volume_notification
	    ;;
    mute)
        pactl set-sink-mute $sink_nr toggle
        mute_notification
        ;;
    *)
        echo "Usage: $0 up | down | mute"
        ;;
esac
