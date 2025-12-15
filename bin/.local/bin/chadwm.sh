#!/bin/sh

#set resolution to the monitor
LID_MONITOR="eDP-1"
EXTERNAL_MONITOR=$(xrandr | grep " connected" | grep -v "$LID_MONITOR" | awk '{print $1}' | head -n 1)

# Load X resources and settings
xrdb merge ~/.Xresources
xset r rate 200 50 &
setxkbmap -layout us,ru -option 'grp:caps_toggle' &

# Autoconfigure monitor on HDMI connection
if xrandr | grep -q 'HDMI-1 connected'; then
	xrandr --newmode "2560x1440R"  241.50  2560 2608 2640 2720  1440 1443 1448 1481 +hsync -vsync
	xrandr --addmode HDMI-1 "2560x1440R"
	xrandr --output "$LID_MONITOR" --off --output "$EXTERNAL_MONITOR" --mode "2560x1440R" 
fi

# Start essential services
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
picom &
# Optional: uncomment to run dwmblocks or other apps
sleep 1
dwmblocks &

# This loop is for debugging chadwm with gdb.
# If chadwm crashes, gdb will create a log at /home/xploit/gdb-chadwm.log
# and the window manager will restart.
# For a stable "production" setup, you might want to replace this loop
# with a simple `exec chadwm` call.
#while type chadwm > /dev/null && type gdb > /dev/null; do
#	gdb -x /home/xploit/git/github.com/dimatock/dwm/gdb.script chadwm > /tmp/gdb.stdout.log 2> /tmp/gdb.stderr.log && continue
#done

# Fallback in case the loop exits (e.g., gdb not found)
exec chadwm
