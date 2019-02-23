#!/bin/bash
# old heavy version depending on imagemagick
import -window root "$(cat ~/.globalpwd)/screenshot_$(date +%Y%m%dT%H%M%S%z).png"
# new slimmer version does not work: https://github.com/i3/i3/issues/2435
#xwd -silent -name root | xwdtopnm | pnmtopng > "$(cat ~/.globalpwd)/screenshot_$(date +%Y%m%dT%H%M%S%z).png"
