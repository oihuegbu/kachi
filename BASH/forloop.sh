#Automation bash script displaying names in a list.
#This also uses the for loop

#!/bin/bash

#Created names
names='Emanuel Kash Lajarrid Angie'

#Using for loop to display names
for names in $names
do
echo my name is $names
done