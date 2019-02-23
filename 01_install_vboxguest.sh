#!/bin/bash
echo "Please give me sudo"
sudo echo "Thx"

# VirtualBox Guest Tools (for virtual install)
# xrandr --output default --mode 800x600
sudo yum -y update
sudo yum -y install deltarpm epel-release 
sudo yum -y groupinstall "Development tools"
sudo yum -y install kernel-devel dkms bzip2 tar wget
wget https://download.virtualbox.org/virtualbox/5.2.12/VBoxGuestAdditions_5.2.12.iso
sha256sum VBoxGuestAdditions_5.2.12.iso > this.sha256sum
echo "b81d283d9ef88a44e7ac8983422bead0823c825cbfe80417423bd12de91b8046  VBoxGuestAdditions_5.2.12.iso" > ref.sha256sum
if [[ "$(diff this.sha256sum ref.sha256sum)" ]]; then
	echo "ERROR: VBoxGuestAdditions_5.2.12.iso different";
	exit 1;
fi
rm this.sha256sum ref.sha256sum
mkdir vboxga
sudo mount VBoxGuestAdditions_5.2.12.iso vboxga
cd vboxga
sudo ./VBoxLinuxAdditions.run
cd ..
sudo umount vboxga

# firewall
sudo yum -y install firewalld
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo systemctl status firewalld # check status [optional]
#sudo journalctl -xn # in case something went wrong
sudo firewall-cmd --add-service ssh --permanent
sudo firewall-cmd --remove-service dhcpv6-client --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-all # list rules [optional]

