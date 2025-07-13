#!/usr/bin/bash

# Kill existing portals
pkill -f xdg-desktop-portal

# Set environment variables
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=Hyprland
export GDK_BACKEND=wayland

# Start the portal backend
/usr/lib/xdg-desktop-portal-wlr &
sleep 1
# Start the main portal
/usr/lib/xdg-desktop-portal &
