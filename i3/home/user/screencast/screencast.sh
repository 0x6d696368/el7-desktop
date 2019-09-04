#!/bin/bash
monitor="primary"

OPTIND=1 
while getopts "h?d:" opt; do
	case "$opt" in
	h|\?)
		echo "usage: ${0} [-d XRANDR MONITOR NAME] [recording name]"
		exit 0;
	;;
	d)
		monitor="$OPTARG"
	;;
	esac
done

shift $((OPTIND-1))
[ "${1:-}" = "--" ] && shift

if [ "$1" ]; then
	output="$1"
else
	output="$(date +%Y%m%dT%H%M%S%z)"
fi


crop=$(xrandr | grep "${connected}" | grep "${monitor}")
if [ -z "${crop}" ]; then
	echo "ERROR: Could not get display crop."
	exit 1
fi

size=$(echo "${crop}" | head -n 1 | grep -o "[0-9]\+x[0-9]\++[0-9]\++[0-9]\+")
width=$(echo "${size}" | sed 's/\([0-9]\+\)x\([0-9]\+\)+\([0-9]\+\)+\([0-9]\+\)/\1/g')
heigth=$(echo "${size}" | sed 's/\([0-9]\+\)x\([0-9]\+\)+\([0-9]\+\)+\([0-9]\+\)/\2/g')
xoffset=$(echo "${size}" | sed 's/\([0-9]\+\)x\([0-9]\+\)+\([0-9]\+\)+\([0-9]\+\)/\3/g')
yoffset=$(echo "${size}" | sed 's/\([0-9]\+\)x\([0-9]\+\)+\([0-9]\+\)+\([0-9]\+\)/\4/g')

~/github/screenkey/screenkey -p fixed --persist -g $(expr ${width} - 300)x20+$(expr ${xoffset} + 300)+$(expr ${yoffset} + ${heigth} - 20) &
SCREENKEY_PID=$!

echo "Recording will start in 1 second ..."

sleep 1

ffmpeg -y \
       -f x11grab -s ${width}x${heigth} -i ${DISPLAY}+${xoffset},${yoffset} \
       -f pulse -thread_queue_size 32 -i default -sample_rate 44100 -channels 1 \
       -codec:v h264 -preset ultrafast -tune stillimage -crf 32 -r 10 \
       -codec:a mp3 -qscale:a 0 -ac 1 -ar 44100 \
       ${output}.mp4

# FIXME libvorbis causes wrong visual audio sync in kdenlive :(
#	-codec:a libvorbis -qscale:a 0 -ac 1 -ar 44100 \

#ffmpeg -y \
#       -f x11grab -s ${width}x${heigth} -i ${DISPLAY} \
#       -codec:v h264 -preset ultrafast -tune stillimage -crf 32 -r 10 \
#       "${output}.mp4"

kill ${SCREENKEY_PID}


