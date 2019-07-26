#!/bin/bash
# old heavy version depending on imagemagick
#import -window `xdotool getactivewindow` "~/screenshot_$(xdotool getwindowname `xdotool getactivewindow`)_$(date +%Y%m%dT%H%M%S%z).png"
xwid=$(xdotool getactivewindow)
windowname=$(xdotool getwindowname "${xwid}" | sed 's/[^A-Za-z0-9]/_/g')
#xwd -frame -silent -id "${xwid}" | xwdtopnm | pnmtopng > "$(cat ~/.globalpwd)/screenshot_${windowname}_$(date +%Y%m%dT%H%M%S%z).png"
# new with gnome-screenshot
gnome-screenshot -w -f "$(cat ~/.globalpwd)/screenshot_${windowname}_$(date +%Y%m%dT%H%M%S%z).png"
