# This bash script automates the creation of buckets in S3
# and deletes them after creation.

#!/bin/bash

#create variables
createbucket="$1"
deletebucket="$2"

#create bucket
aws s3 mb s3://$createbucket

#Wait 3 seconds (optional)
sleep 3

#Notify of bucket loaded to S3
echo "Bucket loaded to s3..."

#Wait 2 seconds (optional)
sleep 2

#Delete bucket
aws s3 rb s3://$deletebucket

#Wait 3 seconds (optional)
sleep 3

#Bucket deletion notification
echo "Bucket deleted from s3..."

#Wait 2 seconds (optional)
sleep 2

#list bucket
aws s3 ls
