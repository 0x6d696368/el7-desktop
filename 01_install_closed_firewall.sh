#!/bin/bash
echo "Please give me sudo"
sudo echo "Thx"

# firewall
sudo yum install -y firewalld                                                    
sudo systemctl start firewalld                                                   
sudo systemctl enable firewalld                                                  
sudo systemctl status firewalld # check status [optional]                        
#sudo journalctl -xn # in case something went wrong                              
sudo firewall-cmd --remove-service ssh --permanent                               
sudo firewall-cmd --remove-service dhcpv6-client --permanent                     
sudo firewall-cmd --reload                                                       
sudo firewall-cmd --list-all # list rules [optional]                             

