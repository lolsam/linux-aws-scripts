#!/bin/bash
{
SSMLINK=https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb

checkssm() {
 echo "*****Checking if SSM agent is already installed*****"
 if [ ! -z $(which amazon-ssm-agent) ]; then
  echo ""
  echo "SSM agent is already installed in `which amazon-ssm-agent`"
  echo ""
  exit 1 
fi
}

installssm() {
 mkdir /tmp/ssm
 cd /tmp/ssm
 wget ${SSMLINK}
 sudo dpkg -i amazon-ssm-agent.deb
 sudo systemctl enable amazon-ssm-agent
}
#Calling functions
checkssm 
installssm

#Setup logrotate for SSM log files to maintain disk space 

sudo bash -c "cat << EOF > /etc/logrotate.d/amazon
/var/log/amazon/ssm/errors.log {
        daily
        missingok
        rotate 4
        compress
        delaycompress
        copytruncate
        minsize 100k
}
EOF"

sudo logrotate -f /etc/logrotate.d/amazon
