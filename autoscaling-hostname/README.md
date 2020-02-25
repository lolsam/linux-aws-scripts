### Setting hostname of autoscaled instances 

Background: 
At work I ran into a similar case as this question posted on StackOverflow, and came up with a workaround. 
https://stackoverflow.com/questions/35586337/aws-autoscaling-increment-name-tag 

Although AWS has a feature to tag the 'Name' value of an instance launched via autoscaling it doesn't make those names unique.

For example, in an autoscaling group if the Name tag is set as 'prod-webapp', and new instances are launched via autoscaling, they will all be named 'prod-webapp'

This is a frustrating limitation of AWS, especially when troubleshooting and needing to login to a server. If your monitoring platform shows 'prod-webapp' is having a problem, there is not a method to differentiate which instance an Engineer needs to login to. 

A workaround is to use AWS Cli to set a UNIQUE hostname AND Name each instance differently. 

Simply paste/modify the script provided under Userdata. 
