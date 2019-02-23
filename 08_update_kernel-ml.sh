#!/bin/bash
echo needs sudo
sudo echo thx
# Normal `kernel` and `kernel-ml` sometimes don't play along nicely.
# So we do the following to make sure grub sees all kernels:
sudo yum remove -y kernel kernel-ml
sudo yum update -y kernel kernel-ml
sudo yum install --enablerepo=elrepo-kernel -y kernel kernel-ml
sudo grub2-mkconfig --output=/boot/grub2/grub.cfg
