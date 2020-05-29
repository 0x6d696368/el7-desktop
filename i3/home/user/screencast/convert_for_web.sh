#!/bin/bash

if [[ $# -lt 1 ]]; then
	echo "Usage: ${0} <screencast.mp4> [start time] [end time]"
	exit 1
fi

output=$(echo ${1} | sed 's/\.mp4$/_web.mp4/g')

if ! echo ${output} | grep -q "_web.mp4$"; then
	echo "ERROR: filename does not end with .mp4"
	exit 1
fi

ss=""
to=""

if [[ $# -ge 2 ]]; then
	ss="-ss ${2}"
fi
if [[ $# -ge 3 ]]; then
	to="-to ${3}"
fi

ffmpeg -y -i "${1}" \
	-codec:v h264 -preset veryslow -profile:v baseline -level 3.0 -tune stillimage \
	-movflags +faststart -pix_fmt yuv420p -crf 40 -r 10 \
	-codec:a libfdk_aac -ac 1 -ar 22050 -vbr 0 \
	${ss} ${to} ${output}


