#!/bin/bash
echo needs sudo
sudo echo thx

# N-mode on Intel Corporation Centrino Advanced-N 6205 is doggy; disable it
if [[ $(lspci -n | grep -o "^.* 8086:0082 (rev [0-9]*)$") ]]; then
echo "options iwlwifi 11n_disable=1" | sudo tee /etc/modprobe.d/iwlwifi.conf
sudo modprobe -rfv iwlwifi
sudo modprobe -v iwlwifi
fi # if [[ $(lspci -n | grep -o "^.* 8086:0082 (rev [0-9]*)$") ]]; then



