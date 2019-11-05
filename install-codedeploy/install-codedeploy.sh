#!/bin/bash
#Commands to install AWS CodeDeploy
REGION=`curl -s http://169.254.169.254/latest/dynamic/instance-identity/document|grep region|awk -F\" '{print $4}'`
echo "Starting the process to install AWS CodeDeploy.."
yum install ruby -y
curl https://aws-codedeploy-${REGION}.s3.amazonaws.com/latest/install -s -o /opt/install-codedeploy 
cd /opt/ && chmod +x ./install-codedeploy
./install-codedeploy auto
systemctl start codedeploy-agent 
PROCESS=$(ps -ef | grep -i codedeploy | grep -v grep | wc -l)
if [ ${PROCESS} -ge 1 ];
 then
 echo "CodeDeploy is installed and running!"
 else
 echo "CodeDeploy is not running! Please troubleshoot! Exiting.."
 fi
 exit 1 
echo "All done!"
