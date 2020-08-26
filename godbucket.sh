#!/bin/bash

#variables
Emptyfile="$1"

#create file
echo "creating $Emptyfile..."
echo "Hello World" > $Emptyfile

sleep 3

echo "Printing contents of file"
cat $Emptyfile

#list file
sleep 3
echo "listing file directory"
ls

#delete file
sleep 3
echo "deleting file"
rm -rf $Emptyfile

#list file
sleep 3
echo "updated file directory"
ls