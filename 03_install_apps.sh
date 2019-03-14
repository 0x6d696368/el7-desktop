#!/bin/bash
echo "Please give me sudo"
sudo echo "Thx"

sudo yum -y update
sudo yum -y install deltarpm 

sudo yum -y install vim-enhanced ctags firefox gnupg2 pinentry-gtk evince eog file-roller \
	thunderbird wget gedit xdg-utils gvfs gvfs-mtp pulseaudio pavucontrol \
	qrencode

mkdir ~/.vim/spell/
wget http://ftp.vim.org/vim/runtime/spell/de.utf-8.spl -O ~/.vim/spell/de.utf-8.spl
wget http://ftp.vim.org/vim/runtime/spell/de.utf-8.sug -O ~/.vim/spell/de.utf-8.sug

