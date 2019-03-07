#!/bin/ksh

pkill bar
DOCK=$(xrandr | egrep ^DP4 | awk '{print $2}')
if [ $DOCK -eq "connected" ]; then
  xrandr --output DP4 --mode 1920x1080 --right-of eDP1
fi

feh --bg-max ~/wallpaper.png
~/bin/barstarter
