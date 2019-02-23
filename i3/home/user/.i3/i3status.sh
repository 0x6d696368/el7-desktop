#!/bin/sh
# shell script to prepend i3status with more stuff

i3status -c ~/.i3/i3status.conf | while :
do
        read line
	brightness=$(expr \( $(cat /sys/class/backlight/intel_backlight/brightness) \* 100 \) \/ \( $(cat /sys/class/backlight/intel_backlight/max_brightness) \* 1 \))
        echo "$line | ${brightness}" || exit 1
done
