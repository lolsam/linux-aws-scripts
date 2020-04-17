### Suspending and Resuming autoscaling via AWS CLI/Bash

Goal: to suspend or resume autoscaling using AWS CLI/Shell Scripting. 

Suspending/resuming autoscaling from the AWS Console takes too long, involves too many clicks, and is a mundane process. 

This is an interactive script that requires 2 user inputs: environment and autoscaling process to suspend/resume.  

If AutoScaling is going haywire or you need to perform maintenance/code deployments on your servers that could cause ec2 instances to go unhealthy, suspending autoscaling is a good idea. 
