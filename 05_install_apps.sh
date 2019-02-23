#!/bin/bash
echo "Please give me sudo"
sudo echo "Thx"

sudo yum -y update                                                               
sudo yum -y install deltarpm epel-release http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm 

sudo yum -y install vlc argyllcms xournal gromit-mpx arandr


