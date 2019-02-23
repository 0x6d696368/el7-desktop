#!/bin/bash
echo needs sudo
sudo echo thx
sudo yum install -y http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
sudo yum install --enablerepo=elrepo-kernel -y kernel kernel-ml
# Normal `kernel` and `kernel-ml` sometimes don't play along nicely.
# So we do the following to make sure grub sees all kernels:
sudo grub2-mkconfig --output=/boot/grub2/grub.cfg
