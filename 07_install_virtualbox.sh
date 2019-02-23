#!/bin/bash
echo needs sudo
sudo echo thx
sudo wget http://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo -O /etc/yum.repos.d/virtualbox.repo
sudo yum install VirtualBox-6.0 gcc make perl kernel-devel kernel-headers

