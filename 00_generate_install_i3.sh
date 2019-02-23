#!/bin/bash
cat 01_install_i3.src | grep "# COPY i3 CONFIGURATION FILES" -B 10000000
for i in $(find i3 -type d | sed 's/i3//' | grep -v '^$'); do
	echo "mkdir -p ${i}"
done
for i in $(find i3 -type f | sed 's/i3//' | grep -v '^$'); do
	if [ "$(file --mime-type "i3/${i}" | cut -d' ' -f 2 | grep "text/")" ]; then
		echo "cat > tmp << PASTECONFIGURATIONFILE"
		cat i3/${i} | sed 's/\\/\\\\/g;s/\$/\\\$/g;s/`/\\`/g;'
		echo "PASTECONFIGURATIONFILE"
	else
		echo "base64 -d > tmp << PASTECONFIGURATIONFILE"
		base64 i3/${i}
		echo "PASTECONFIGURATIONFILE"
	fi
	if [ "$(echo ${i} | grep home)" ]; then
		echo "mv tmp \"${i}\""
	else
		echo "sudo mv tmp \"${i}\""
	fi
done
cat 01_install_i3.src | grep "# COPY i3 CONFIGURATION FILES" -A 10000000
