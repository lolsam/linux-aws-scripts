#!/usr/bin/sudo bash 
curl -fsSL https://get.docker.com/ | sh
systemctl start docker 
systemctl status docker 
systemctl enable docker 

#Adding user to Docker group
usermod -aG docker $(whoami)

