#Automation script creating a file, adding text to the file
#and deleting file.
#This also uses the if/else condition

#!/bin/bash

MYFILE=testing123.txt

#Notification creating file
echo "Creating text File"

#Wait 2 seconds
sleep 2

#Create file
touch $MYFILE

#List file
ls

#Notification to add text file
echo "Adding text" > $MYFILE

#If statement. If file is empty then send a notification advising such.
#If not, then populate file with text.
if [ -s $MYFILE ]
then
    echo "$MYFILE is FULL"

else
    echo "$MYFILE is EMPTY"
    echo "Populating file"
    sleep 2
    echo "Adding text" > $MYFILE
fi  
cat $MYFILE

#Notification advising of file removal
echo "Removing File"

#Wait time
sleep 2

#Remove file
rm -rf $MYFILE

#Create file
touch $MYFILE

#If statement to check if file exists
if [ -e $MYFILE ]
then
    echo "$MYFILE is Exsists and is EMPTY"
fi

