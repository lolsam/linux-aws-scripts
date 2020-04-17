#!/bin/bash
echo "---------------------------------------------"
echo "Which environment? stg or prd?"
read AWSENV
case $AWSENV in 
	'prd')
	;; 
	'stg')
	;; 
	*) echo "Invalid environment! Please enter either 'stg' or 'prd'"; exit 1;;
esac 
echo "---------------------------------------------"
echo "Do you want to suspend or resume autoscaling?"
read ANSWER
case $ANSWER in 
	'suspend') 
	;; 
	'resume') 
	;; 
	*) echo "Invalid environment! Please enter either 'suspend' or 'resume'"; exit 1;;
esac 
#Prod
if [ ${AWSENV} == "prd" ] && [ ${ANSWER} == "suspend" ]; then
	REGION="us-east-2"
	echo "Okay, suspending autoscaling. Make sure to resume it once deployment is complete!"
	aws autoscaling ${ANSWER}-processes --auto-scaling-group-name ${AWSENV}-asg-rtrapi --scaling-processes HealthCheck ReplaceUnhealthy --region ${REGION}
	aws autoscaling ${ANSWER}-processes --auto-scaling-group-name ${AWSENV}-asg-dsvc --scaling-processes HealthCheck ReplaceUnhealthy --region ${REGION}
	aws autoscaling ${ANSWER}-processes --auto-scaling-group-name ${AWSENV}-asg-emb --scaling-processes HealthCheck ReplaceUnhealthy --region ${REGION}
	aws autoscaling ${ANSWER}-processes --auto-scaling-group-name ${AWSENV}-asg-rspd --scaling-processes HealthCheck ReplaceUnhealthy --region ${REGION}
	aws autoscaling ${ANSWER}-processes --auto-scaling-group-name ${AWSENV}-asg-rtrweb --scaling-processes HealthCheck ReplaceUnhealthy --region ${REGION}
	aws autoscaling ${ANSWER}-processes --auto-scaling-group-name ${AWSENV}-asg-webv4 --scaling-processes HealthCheck ReplaceUnhealthy --region ${REGION}
	aws autoscaling ${ANSWER}-processes --auto-scaling-group-name ${AWSENV}-asg-webv6 --scaling-processes HealthCheck ReplaceUnhealthy --region ${REGION}
	echo "No errros? It worked!"
elif [ ${AWSENV} == "prd" ] && [ ${ANSWER} == "resume" ]; then
	REGION="us-east-2"
	echo "Okay, resuming autoscaling...gimme about 5 seconds.."
	aws autoscaling ${ANSWER}-processes --auto-scaling-group-name ${AWSENV}-asg-rtrapi --scaling-processes HealthCheck ReplaceUnhealthy --region ${REGION}
	aws autoscaling ${ANSWER}-processes --auto-scaling-group-name ${AWSENV}-asg-dsvc --scaling-processes HealthCheck ReplaceUnhealthy --region ${REGION}
	aws autoscaling ${ANSWER}-processes --auto-scaling-group-name ${AWSENV}-asg-emb --scaling-processes HealthCheck ReplaceUnhealthy --region ${REGION}
	aws autoscaling ${ANSWER}-processes --auto-scaling-group-name ${AWSENV}-asg-rspd --scaling-processes HealthCheck ReplaceUnhealthy --region ${REGION}
	aws autoscaling ${ANSWER}-processes --auto-scaling-group-name ${AWSENV}-asg-rtrweb --scaling-processes HealthCheck ReplaceUnhealthy --region ${REGION}
	aws autoscaling ${ANSWER}-processes --auto-scaling-group-name ${AWSENV}-asg-webv4 --scaling-processes HealthCheck ReplaceUnhealthy --region ${REGION}
	aws autoscaling ${ANSWER}-processes --auto-scaling-group-name ${AWSENV}-asg-webv6 --scaling-processes HealthCheck ReplaceUnhealthy --region ${REGION}
	echo "No errors? It worked!"
#Stage
elif [ ${AWSENV} == "stg" ] && [ ${ANSWER} == "suspend" ]; then
	REGION="us-west-2"
	echo "Okay, suspending autoscaling. Make sure to resume it once deployment is complete!"
	aws autoscaling ${ANSWER}-processes --auto-scaling-group-name ${AWSENV}-asg-webv6 --scaling-processes HealthCheck ReplaceUnhealthy --region ${REGION}
	aws autoscaling ${ANSWER}-processes --auto-scaling-group-name ${AWSENV}-asg-webv4 --scaling-processes HealthCheck ReplaceUnhealthy --region ${REGION}
	aws autoscaling ${ANSWER}-processes --auto-scaling-group-name ${AWSENV}-asg-emb --scaling-processes HealthCheck ReplaceUnhealthy --region ${REGION}
	aws autoscaling ${ANSWER}-processes --auto-scaling-group-name ${AWSENV}-asg-dsvc --scaling-processes HealthCheck ReplaceUnhealthy --region ${REGION}
	echo "No errros? It worked!"
elif [ ${AWSENV} == "stg" ] && [ ${ANSWER} == "resume" ]; then
	REGION="us-west-2"
	echo "Okay, resuming autoscaling...gimme about 5 seconds.."
	aws autoscaling ${ANSWER}-processes --auto-scaling-group-name ${AWSENV}-asg-webv6 --scaling-processes HealthCheck ReplaceUnhealthy --region ${REGION}
	aws autoscaling ${ANSWER}-processes --auto-scaling-group-name ${AWSENV}-asg-webv4 --scaling-processes HealthCheck ReplaceUnhealthy --region ${REGION}
	aws autoscaling ${ANSWER}-processes --auto-scaling-group-name ${AWSENV}-asg-emb --scaling-processes HealthCheck ReplaceUnhealthy --region ${REGION}
	aws autoscaling ${ANSWER}-processes --auto-scaling-group-name ${AWSENV}-asg-dsvc --scaling-processes HealthCheck ReplaceUnhealthy --region ${REGION}
	echo "No errros? It worked!"
fi
