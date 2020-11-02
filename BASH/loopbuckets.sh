#Bash script using automation to remove buckets in S3

#!/bin/bash

#buckets created in S3
buckets='kashbucket2020 mannybucket2021 angiebucket2022'

#Using for loops to delete buckets
for x in $buckets
do
    aws s3 rb s3://$x
    echo 'removed the following buckets' $buckets
done

