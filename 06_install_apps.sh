#!/bin/bash
echo "Please give me sudo"
sudo echo "Thx"

sudo yum -y update                                                               
sudo yum -y install wget 

mkdir ~/apps
cd ~/apps
wget https://github.com/mooltipass/moolticute/releases/download/v0.42.1/Moolticute-x86_64.AppImage
chmod u+x Moolticute-x86_64.AppImage

# unfortunately latest kdenlive version CentOS 7 supports is:
wget https://files.kde.org/kdenlive/release/kdenlive-18.12.1b-x86_64.appimage
chmod u+x kdenlive-18.12.1b-x86_64.appimage


