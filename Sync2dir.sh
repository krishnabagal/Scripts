#!/bin/bash   
#--------------------------------------------------------------------------#
#Script that sync file between two folder 
#
#Note: Use /mnt/test is source folder and /mnt/abc is your backup folder. 
#      Change source and backup directory as per your need. 
#--------------------------------------------------------------------------#


#Use while true to run script continue 
while true 
do

#take the list of files that persent in /mnt/test directory and stored in /tmp/sw-filelist 
ls -ll /mnt/test |awk  {'print $9'} |sed '1 d' >/tmp/sw-filelist

#Use for loop to check below status.   

#call sw-filelist to check source file MD(Modify Date), MT(Modify Time), MM(Modify Min)
for list in `cat /tmp/sw-filelist`
do
D=`stat /mnt/test/$list |grep Modify | tr "-" " " |awk {'print $4'}`    
E=`stat /mnt/test/$list |grep Modify | tr ":" " " |awk {'print $3'}`
F=`stat /mnt/test/$list |grep Modify | tr ":" " " |awk {'print $4'}`  

#check if file is present or not in backup directory 
#if yes then check MD, MT,MM
#else move that file to backup direcotry    

if [ -f /mnt/abc/$list ]
then
A=`stat /mnt/abc/$list |grep Modify | tr "-" " " |awk {'print $4'}`    
B=`stat /mnt/abc/$list |grep Modify | tr ":" " " |awk {'print $3'}`
C=`stat /mnt/abc/$list |grep Modify | tr ":" " " |awk {'print $4'}`  

#check sourec and backup directory date of file
#if its old then move to backup directory       
    if [ "$A" -lt "$D" ]
    then    
        mv /mnt/test/$list /mnt/abc/
    fi
#if its same then check hours
        if [ "$A" -eq "$D" ]
        then 
#if hours are not same then move to backup directory   
            if [ "$B" -lt "$E" ]
            then        
                mv /mnt/test/$list /mnt/abc/ 
            fi 
#if hours are same then check the minute 
                if [ "$B" -eq "$E" ]
                then
                    if [ "$C" -lt "$F" ]
                    then
                        mv /mnt/test/$list /mnt/abc/    
                    fi
              
                fi
        fi
else
    mv /mnt/test/$list /mnt/abc/
fi

#delete the /tmp/sw-filelist
rm -rf /tmp/sw-filelist

done
#wait for 15 Sec.
sleep 15
done
