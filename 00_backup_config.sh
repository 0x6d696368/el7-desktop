#!/bin/bash
mkdir -p i3/home/user
cp -r ~/.bashrc ~/.vimrc ~/.Xdefaults ~/.Xresources ~/.i3 i3/home/user/.
rm i3/home/user/.i3/display.icc # remove display icc profile ... its machine specific 
mkdir -p i3/home/user/.gnupg
cp ~/.gnupg/*.conf i3/home/user/.gnupg/.
sed 's/default-key [A-Z0-9]*$/default-key 12345678/' -i i3/home/user/.gnupg/gpg.conf # remove default key ... its user specific
mkdir -p i3/home/user/.config
cp ~/.config/gromit-mpx.cfg i3/home/user/.config/.
mkdir -p i3/home/user/screencast
cp ~/screencast/screencast.sh ~/screencast/convert_for_web.sh i3/home/user/screencast/.
mkdir -p i3/home/user/.local/share/applications
cp ~/.local/share/applications/mimeapps.list i3/home/user/.local/share/applications/.
mkdir -p i3/etc/X11/xorg.conf.d
cp /etc/X11/xorg.conf.d/00-keyboard.conf i3/etc/X11/xorg.conf.d/.
cp /etc/X11/xorg.conf.d/10-evdev.conf i3/etc/X11/xorg.conf.d/.
