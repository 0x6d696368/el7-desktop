#!/bin/bash
echo "Please give me sudo"
sudo echo "Thx"

sudo yum -y update                                                               
sudo yum -y install deltarpm epel-release                                        

sudo yum -y install \
	redshift \
	zathura zathura-pdf-poppler zathura-ps \
	net-tools \
	pciutils \
	systat \
	usbutils \
	polkit-gnome \
	Thunar \
	p7zip \
	p7zip-plugins \
	pwgen \
	pass \
	darktable \
	pandoc wkhtmltopdf msttcore-fonts-installer \
	texlive-latex \
	libreoffice libreoffice-langpack-en libreoffice-langpack-de \
	exo

xdg-mime default zathura.desktop application/pdf                                 

