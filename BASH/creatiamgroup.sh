#This bash script uses a for loop to create an IAM group within AWS

#!/bin/bash

#File creations with environmental variables
filenames"$1 $2 $3"

#For loop to create IAM groups
for a in $groups
do
aws iam create-group --group-name $a

#Notification that group has been created
echo "$groups has been created"
done