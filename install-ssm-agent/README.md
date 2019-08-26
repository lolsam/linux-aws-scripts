### Installing AWS SSM Agent

AWS Systems Manager is one of the most useful tools in the AWS ecosystem for managing fleet of instances.  

Imagine if there is a need to install a certain package or execute a certain shell command on 100s of servers. SSH'ing into each one would take hours. SSM simplifies this task by allowing us to take action on one or hundreds of instances.  

However, for AWS to be able to talk to EC2 instances, SSM agent must be installed on the server. With the exception of Amazon Linux AMI SSM agent is not installed by default on other Linux distros.  

Shell script in this repository checks if SSM Manger is already installed on your system. If it is not, it grabs the latest SSM agent from AWS' website and installs it on your system then starts the service.  

How to call this script:  
```
wget -O - https://raw.githubusercontent.com/lolsam/linux-scripts/master/install-ssm-agent/install-ssm-agent.sh | bash -x
```
