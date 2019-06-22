#!/bin/bash
mkdir -p i3/home/user
cp -r ~/.bashrc ~/.vimrc ~/.Xdefaults ~/.Xresources ~/.i3 i3/home/user/.
rm i3/home/user/.i3/display.icc # remove display icc profile ... its machine specific 
mkdir -p i3/home/user/.gnupg
cp ~/.gnupg/*.conf i3/home/user/.gnupg/.
sed 's/default-key [A-Z0-9]*$/default-key 12345678/' -i i3/home/user/.gnupg/gpg.conf # remove default key ... its user specific
mkdir -p i3/etc/X11/xorg.conf.d
cp /etc/X11/xorg.conf.d/00-keyboard.conf i3/etc/X11/xorg.conf.d/.
cp /etc/X11/xorg.conf.d/10-evdev.conf i3/etc/X11/xorg.conf.d/.
