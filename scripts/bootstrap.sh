#!/bin/bash

# Allow incoming traffic for SSH, HTTPS, and HTTP
sudo ufw allow 22
sudo ufw allow 443
sudo ufw allow 80
sudo ufw allow OpenSSH
sudo ufw allow "Nginx Full"

# Enable the firewall
sudo ufw --force enable
