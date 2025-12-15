#!/bin/sh

# This script handles lid close/open events to manage displays.
# It needs to be triggered by an ACPI event with an argument "open" or "close".

# Set the DISPLAY environment variable
export DISPLAY=:0
export XAUTHORITY=/home/xploit/.Xauthority

# Monitor names (adjust if necessary)
LID_MONITOR="eDP-1"

# We need to find an external monitor that is connected.
# xrandr output is parsed to find a connected monitor that is not the laptop's one.
EXTERNAL_MONITOR=$(xrandr | grep " connected" | grep -v "$LID_MONITOR" | awk '{print $1}' | head -n 1)

handle_close() {
    if [ -n "$EXTERNAL_MONITOR" ]; then
        # If external monitor is connected, turn off laptop screen and keep external active
        xrandr --output "$LID_MONITOR" --off --output "$EXTERNAL_MONITOR" --mode "2560x1440R" 
    else
        # If no external monitor, let the system suspend.
        # This can be configured in logind.conf. For now, we do nothing.
        :
    fi
}

handle_open() {
    # Turn on laptop screen. If an external monitor was used, extend displays.
    if [ -n "$EXTERNAL_MONITOR" ]; then
         xrandr --output "$LID_MONITOR" --auto --right-of "$EXTERNAL_MONITOR"
    else
         xrandr --output "$LID_MONITOR" --auto
    fi
}

# By default, we check the lid state from /proc
if [ -f /proc/acpi/button/lid/LID0/state ]; then
    LID_STATE=$(cat /proc/acpi/button/lid/LID0/state | awk '{print $2}')
    if [ "$LID_STATE" = "closed" ]; then
	handle_close
    elif [ "$LID_STATE" = "open" ]; then
	handle_open
    fi
fi

exit 0
