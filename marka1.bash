#!/bin/bash
# Author: Jason Carman; jason.carman@senecapolytechnic.ca
# Date: March 14, 2023
# Updated: January 24, 2025
# Purpose: Generate a text file submission for Assignment 2
# Usage: Run this on the Ubuntu VM you created in your Assignment 1, then copy the output file to your host.
#

clear

if [[ $(whoami) != "root" ]]; then
  echo "You must be root to run this script. Please use sudo." 2> /dev/null
  exit 1
fi

read -p "Please enter your username: " user

cat << EOF > /home/$user/a1output.txt
Username: $user
Unique ID: $(echo $user | sha256sum)

#####
# IP Address:
$(ip a)

#####
# nftables configuration:
$(sudo nft list ruleset)

#####
# Apache status:
$(systemctl status apache2)

#####
# Mariadb status:
$(systemctl status mariadb)

#####
# Wordpress installed:
$(ls -la /usr/share/wordpress)

#####
# Wordpress config:
$(head -10 /etc/wordpress/config-ubu2.php)
EOF

echo "a1output.txt has been created in your home directory.  Please submit it to the Assignment 1 folder on BlackBoard."