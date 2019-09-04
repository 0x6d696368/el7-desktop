#!/bin/bash
xwid=$(xdotool getactivewindow)
windowname=$(xdotool getwindowname "${xwid}" | sed 's/[^A-Za-z0-9]/_/g')
gnome-screenshot -a -f "$(cat ~/.globalpwd)/screenshot_${windowname}_$(date +%Y%m%dT%H%M%S%z).png"
