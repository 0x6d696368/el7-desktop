#!/bin/bash
echo needs sudo
sudo echo thx

# N-mode on Intel Corporation Centrino Advanced-N 6205 is doggy; disable it
if [[ $(lspci -n | grep -o "^.* 8086:0\(082\|88e\) (rev [0-9]*)$") ]]; then
# FIXME: doesn't seem to help / doesn't seem to be the actual problem
#echo "options iwlwifi 11n_disable=1" | sudo tee /etc/modprobe.d/iwlwifi.conf
#sudo modprobe -rfv iwlwifi
sudo modprobe -rfv iwldvm
sudo modprobe -rfv iwlwifi
sudo modprobe -v iwlwifi
sudo modprobe -v iwldvm
fi # if [[ $(lspci -n | grep -o "^.* 8086:0082 (rev [0-9]*)$") ]]; then



