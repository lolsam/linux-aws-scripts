#!/bin/bash -x
{ EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone` 
EC2_REGION="`echo \"$EC2_AVAIL_ZONE\" | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`" 
echo "******Setting up the Name tag*****"
INSTANCEID=`curl -s http://169.254.169.254/latest/meta-data/instance-id`
LAST4=`curl -s http://169.254.169.254/latest/meta-data/instance-id|awk -F '-' {'print $2'} | tail -c 5`
EC2HOSTNAME=$(aws ec2 create-tags --resources ${INSTANCEID} --tags Key=Name,Value=${ENVIRON}-${APP}-${LAST4})
