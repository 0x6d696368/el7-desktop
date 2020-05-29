#!/bin/bash
./00_generate_install.sh 01_install_i3.src i3 | sed 's#/home/user/#~/#g'> 01_install_i3.sh; chmod u+x 01_install_i3.sh
