#!/usr/bin/bash

# Status information to place in a dunst notification

notify_id=818

function get_time {
    local label=" "
    local current_time=`date +"%H:%M"`

    echo "${label} ${current_time}"
}

function get_date {
    local label=" "
    local current_date=`date +"%F [%-V]"`

    echo "${label} ${current_date}"
}

function get_battery {
    local BATTERY_ID='BAT0'
    local BATTERY_PATH="/sys/class/power_supply/$BATTERY_ID"

    local capacity status
	  capacity=$(cat "$BATTERY_PATH"/capacity)
	  status=$(cat "$BATTERY_PATH"/status)

    local charging=" "
    local high=" "
    local medium=" "
    local low=" "

    if [[ "$status" = "Discharging" ]]; then
		    if ((capacity >= 75)); then
			      icon=$high
		    elif ((capacity >= 25)); then
			      icon=$medium
		    else
			      icon=$low
		    fi
	  else
		    icon=$charging
	  fi

    echo "${icon} ${capacity}%"
}

function get_brightness {
    local label=" "
    local brightness=`light`
    printf -v br_int %.0f "$brightness"

    echo "${label} ${br_int}%"
}

# function get_network {
#     local wifi_icon="直 "
#     local eth_icon=" "
#
#     local ssid=`iw wlp3s0 info | grep -Po '(?<=ssid ).*'`
#     local eth=``
# }

dunstify --appname="status" -r $notify_id -u low "`get_time`
 `get_date`
 `get_battery`
 `get_brightness`"
