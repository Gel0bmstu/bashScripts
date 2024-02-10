#!/bin/bash

HDMI=$(xrandr |grep ' connected' |grep 'HDMI' |awk '{print $1}')

# Display not connected
if [[ -z "$HDMI" ]]; then
    echo "HDMI not connected"
    xrandr --auto
    feh --bg-scale /home/gel0/bg-1.jpg
    exit 0
fi

ENABLED_CHECK="$(xrandr | grep $HDMI | cut -d \( -f1  | wc -w )"

# HDMI display is enabled, turn if off
if [[ $ENABLED_CHECK = 3 ]]; then 
    echo "Disable $HDMI"
    xrandr --output $HDMI --off
    feh --bg-scale /home/gel0/bg-1.jpg
    exit 0
fi

# HDMI display is connected, but not enabled, turn it on
PRIMARY=$(xrandr | grep ' connected' | grep 'primary' | awk '{print $1}')
~/.screenalyout/home.sh
i3-msg "workspace 4, move workspace to output $HDMI"
feh --bg-scale /home/gel0/bg-1.jpg
killall polybar
/home/gel0/.config/polybar/launch.sh --blocks
