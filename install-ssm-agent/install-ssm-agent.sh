#!/bin/bash
{
SSMLINK=https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
SSMPKG=/tmp/ssm-agent.rpm

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
 if [ ! -f /etc/redhat-release ]; then
  echo "This is not a RedHat distro, please go to AWS docs to find the right installation fine"
 else
 echo "Installing SSM.."
 curl ${SSMLINK} -o ${SSMPKG} && rpm -Uvh ${SSMPKG}
 rm -rf ${SSMPKG}
 fi
 RET_VAL=$?
 if [ ${RET_VAL} -gt 0 ]; then
  echo "Error in installing SSM agent, exiting!!"
 fi
 ps -ef | grep ['a']mazon-ssm-agent
 }
#Calling functions
checkssm 
installssm
}
