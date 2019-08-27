#!/bin/bash

SSMLINK=https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-manual-agent-install.html#agent-install-al
SSMPKG=/tmp/ssm-agent.rpm

#Function to check if SSM is already installed 

checkssm() {
 echo "*****Checking if SSM agent is already installed*****"
 if [ ! -z $(which amazon-ssm-agent) ]; then
  echo ""
  echo "SSM agent is already installed in `which amazon-ssm-agent`"
  echo ""
  sleep 2
  echo "*****Checking if SSM is running*****"
  sleep 3
 fi
 SSM_RUNNING=`ps -ef | grep ['a']mazon-ssm-agent | wc -l`
 if [ ${SSM_RUNNING} -gt 0 ]; then
  echo "SSM agent is already installed and running -- nothing left to do"
  echo ""
  ps -ef | grep ['a']mazon-ssm-agent
  exit 1
 else
 echo "SSM agent is installed but not running.. starting it.."
 fi
 systemctl restart amazon-ssm-agent
 RET_VAL=$?
 if [ ${RET_VAL} -eq 0 ]; then
  echo "SSM agent successfully started!"
 exit 1
  else
 echo "Could not start SSM agent.. exiting!"
 fi
 exit 1
}

#Function to install SSM if not present 

installssm() {
 if [ ! -f /etc/redhat-release ]; then
  echo "This is not a RedHat distro, please go to ${SSMLINK} to find the right installation fine"
 else
 echo "Installing SSM.."
 curl ${SSMLINK} -o ${SSMPKG} && rpm -Uvh ${SSMPKG}
 rm -rf ${SSMPKG}
 fi
 RET_VAL=$?
 if [ ${RET_VAL} -gt 0 ]; then
  echo "Error in installing SSM agent, exiting!!"
 fi
}
checkssm
installssm
