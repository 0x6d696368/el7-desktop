#!/bin/bash
mkdir -p i3/home/user
cp -r ~/.bashrc ~/.i3/ ~/.vimrc ~/.Xdefaults i3/home/user/.
mkdir -p i3/home/user/.gnupg
cp ~/.gnupg/*.conf i3/home/user/.gnupg/.
sed 's/default-key [A-Z0-9]*$/default-key 12345678/' -i i3/home/user/.gnupg/gpg.conf
mkdir -p i3/etc/X11/xorg.conf.d
cp /etc/X11/xorg.conf.d/00-keyboard.conf i3/etc/X11/xorg.conf.d/.
cp /etc/X11/xorg.conf.d/10-evdev.conf i3/etc/X11/xorg.conf.d/.
