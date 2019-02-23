#!/bin/bash
echo needs sudo
sudo echo thx
sudo yum update 'VirtualBox-*'
sudo /usr/lib/virtualbox/vboxdrv.sh setup
