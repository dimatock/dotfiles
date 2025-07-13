#!/bin/sh

CLASS=$1
CMD=$2

# Check if a window with the specified class exists.
# We use `grep -q` which is silent and exits immediately on first match.
if hyprctl clients | grep -q "class: $CLASS"; then
  # If it exists, focus the window using a robust regex.
  hyprctl dispatch focuswindow "class:^$CLASS$"
else
  # If it does not exist, launch the command.
  $CMD
fi

