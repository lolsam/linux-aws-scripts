### Setting hostname of autoscaled instances 

Although AWS has a feature to tag the 'Name' value of instances launched via autoscaling it doesn't set unique names. 

For example, if an autoscaling group launches 4 instances, and the Name tag is configured under AutoScaling Grous, all instances will have the same name.

This is a frustrating limitation of AWS. Especially when troubleshooting and needing to login to an instance. If your monitoring platform shows 'prod-webapp' is having a problem there is not a method to differentiate which instance an Ops Engineer needs to login to. 

A workaround is to use AWS Cli to set to set a UNIQUE hostname AND the Name tag of your instance. 

Simply paste/modify the script provided under userdata. 
