#!/bin/bash
echo "Please give me sudo"
sudo echo "Thx"

sudo yum -y install system-config-printer cups cups-pdf
sudo systemctl start cups

