#!/bin/bash
echo "Please give me sudo"
sudo echo "Thx"

sudo yum -y update                                                               
sudo yum -y install deltarpm epel-release http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm 

sudo yum -y install vlc argyllcms xournal gromit-mpx arandr

sudo yum -y install http://download-ib01.fedoraproject.org/pub/epel/6/i386/Packages/x/xinput_calibrator-0.7.5-3.el6.i686.rpm

sudo yum-config-manager --enable cr

# screenkey
mkdir ~/github
cd ~/github
git clone https://gitlab.com/wavexx/screenkey.git


