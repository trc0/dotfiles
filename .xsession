#!/bin/ksh
# vim: ts=2 sw=2 et
export ENV=$HOME/.kshrc
if [ -x /usr/local/bin/dbus-launch -a -z "${DBUS_SESSION_BUS_ADDRESS}" ]; then
  eval `dbus-launch --sh-syntax --exit-with-session`
fi

## add some nice fonts
for i in $(ls /usr/local/share/fonts/); do
  if [ -d "/usr/local/share/fonts/$i" ]; then
    xset fp+ "/usr/local/share/fonts/$i"
  fi
done

for i in $(ls /usr/local/share/fonts/powerline); do
  if [ -d "/usr/local/share/fonts/powerline/$i" ]; then
    xset fp+ "/usr/local/share/fonts/powerline/$i"
  fi
done

# display setup when docked
EXDISP=$(xrandr | egrep ' connected' | egrep -v primary | awk '{print $1}')
DOCK=$(xrandr | egrep ^$EXDISP | awk '{print $2}')
if [ $DOCK -eq "connected" ]; then
#  xrandr --output eDP-1 --off
   xrandr --output $EXDISP --mode 1920x1080 --left-of eDP1
fi
export EXDISP

xset b off
xset fp rehash
fc-cache -v
fc-cache -vf /usr/local/share/fonts/powerline/SourceCodePro

compton &
dunst &
urxvtd -q -o -f &
feh --bg-max ~/wallpaper.png &
xrdb ~/.Xresources &
~/bin/barstarter &

export LC_CTYPE="en_US.UTF-8"

xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation" 1
xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation Button" 2
xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation Axes" 6 7 4 5

cwm -v 1>~/cwm.log 2>&1
