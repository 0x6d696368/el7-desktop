#!/bin/bash
if [ "$1" ]; then
	output="$1"
else
	output="$(date +%Y%m%dT%H%M%S%z)"
fi
width=$(xrandr | head -n 1 | awk '{print $8}')
heigth=$(xrandr | head -n 1 | awk '{print $10}' | awk 'gsub(",$","")')

echo "Recording will start in 1 second ..."

sleep 1

# FIXME: pulse audio is broken :(
#ffmpeg -y \
#       -f x11grab -s ${width}x${heigth} -i ${DISPLAY} \
#       -f pulse -i default -sample_rate 44100 -channels 1 \
#       -codec:v h264 -preset ultrafast -tune stillimage -crf 32 -r 10 \
#       -codec:a libvorbis -qscale:a 0 -ac 1 -ar 44100 \
#       ${output}.mp4

ffmpeg -y \
       -f x11grab -s ${width}x${heigth} -i ${DISPLAY} \
       -codec:v h264 -preset ultrafast -tune stillimage -crf 32 -r 10 \
       ${output}.mp4

