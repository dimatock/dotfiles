#!/bin/bash
DEFAULT_LAYOUT="us"
if [ -z "$1" ]; then
  hyprctl keyword input:kb_layout "$DEFAULT_LAYOUT"
else
  hyprctl keyword input:kb_layout "$1"
fi

