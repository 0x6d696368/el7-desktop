#!/bin/bash
# old heavy version depending on imagemagick
#import -window `xdotool getactivewindow` "~/screenshot_$(xdotool getwindowname `xdotool getactivewindow`)_$(date +%Y%m%dT%H%M%S%z).png"
xwid=$(xdotool getactivewindow)
xwd -frame -silent -id "${xwid}" | xwdtopnm | pnmtopng > "$(cat ~/.globalpwd)/screenshot_$(xdotool getwindowname "${xwid}")_$(date +%Y%m%dT%H%M%S%z).png"
