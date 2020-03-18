#! /bin/bash

case "$1" in
  -r|--right)
    xrandr --output eDP1 --auto --output DP1 --auto --right-of eDP1
    ;;
  -l|--left)
    xrandr --output eDP1 --auto --output DP1 --auto --left-of eDP1
    ;;
  -u|--up)
    xrandr --output eDP1 --auto --output DP1 --auto --above eDP1
    ;;
  -u|--up)
    xrandr --output eDP1 --auto --output DP1 --auto --below eDP1
    ;;
  -o|--off)
    xrandr --output DP1 --off
esac