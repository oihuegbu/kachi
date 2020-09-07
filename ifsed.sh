#!/bin/bash


#lights=beta.txt
lights=$1

#create a file called lights
touch beta.txt
r=0
na=2




while
    [ $r -le 1 ]
        do
    echo "Turn the lights off!"
    r=$(( $r + 2 ))
done

if
    [ $na -eq 2 ]
        then
            echo "turn on the lights"
fi


#while
#    [ $na -eq 0 ]
 #       do
  ##         na=$(( $na+1 ))

#done

#while 
#    [ ]