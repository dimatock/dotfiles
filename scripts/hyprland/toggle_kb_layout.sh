#!/bin/bash

hyprctl keyword input:kb_layout $(hyprctl getoption input:kb_layout -j | jq -r '.str' | awk '{if ($1=="us,") print "ru"; else print "us,"}')