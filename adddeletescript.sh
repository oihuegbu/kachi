#!/bin/bash
addbucket="$1"
deletebucket="$2"


#make bucket command
aws s3 mb s3://$addbucket

#remove bucket command
aws s3 rb s3://$deletebucket

#listbucket
aws s3 ls