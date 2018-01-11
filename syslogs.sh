#!/bin/bash
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=#
#Script Name: syslogs.sh 
#Date: Sep 08th, 2017. 
#Modified: NA
#Versioning: NA
#Owner: Krishna Bagal.
#Info: Script will dump ps, free, top and netstat logs for reference.
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=#

DATEnTIME=`date +%Y_%m_%d-%H:%M`
DATE=`date +%Y_%m_%d`
LOGDIR="/var/log/systemlogs"
MKDIR="/bin/mkdir"

if [ -d $LOGDIR ];
then
        if [ -d $LOGDIR/$DATE ];
        then
                /bin/ps auxfff > $LOGDIR/$DATE/$DATEnTIME-ps
                /usr/bin/top -c -n1 -b > $LOGDIR/$DATE/$DATEnTIME-top
                /usr/bin/free -mt > $LOGDIR/$DATE/$DATEnTIME-free
                /bin/netstat -atunlp > $LOGDIR/$DATE/$DATEnTIME-netstat
        else 
                echo "$LOGDIR/$DATE Directory not present. Creating now...!!!"
                sleep 3
                $MKDIR -p $LOGDIR/$DATE
                /bin/ps auxfff > $LOGDIR/$DATE/$DATEnTIME-ps
                /usr/bin/top -c -n1 -b > $LOGDIR/$DATE/$DATEnTIME-top
                /usr/bin/free -mt > $LOGDIR/$DATE/$DATEnTIME-free
                /bin/netstat -atunlp > $LOGDIR/$DATE/$DATEnTIME-netstat
        fi
else 
        echo "$LOGDIR Directory is not present."
        echo "Creating now.!!!!"
        $MKDIR -p $LOGDIR
fi
/usr/bin/find /var/log/systemlogs/ -mtime +30 -exec rm -rf {} \;
