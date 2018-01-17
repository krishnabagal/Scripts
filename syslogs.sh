#!/bin/bash
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==#
#Script Name: syslogs.sh 
#Date: Sep 08th, 2017. 
#Modified: Jan 11th, 2017.
#Versioning: 0.1 = updated command to delete old files (last 30 days) folder from
#                  location. (Dec 19th, 2017) 
#            0.2 = Updated command to delete last year files and folders. (Jan 11th, 2017.)
#Author: Krishna Bagal.
#Info: Script will dump ps, free, top and netstat logs for reference.
#Ticket: NA
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==#
DATEnTIME=`date +%Y_%m_%d-%H:%M`
DATE=`date +%Y_%m_%d`
LOGDIR="/var/log/systemlogs"
MKDIR="/bin/mkdir"
CURMONTH=`date +%Y_%m_`
ONEMONTH=`date +%Y_%m_30 -d "1 month ago"`
LASTMONTH=`date +%m -d "1 month ago"`
LASTYEAR=`date +%Y -d "last year"`
DELCURFOLDER=`date +%Y_"$LASTMONTH"_??`
DELLASTFOLDER=`date +"$LASTYEAR"_"$LASTMONTH"_??`
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
                /bin/ps -auxfff > $LOGDIR/$DATE/$DATEnTIME-ps
                /usr/bin/top -c -n1 -b > $LOGDIR/$DATE/$DATEnTIME-top
                /usr/bin/free -mt > $LOGDIR/$DATE/$DATEnTIME-free
                /bin/netstat -atunlp > $LOGDIR/$DATE/$DATEnTIME-netstat
        fi
else 
        echo "$LOGDIR Directory is not present."
        echo "Creating now.!!!!"
        $MKDIR -p $LOGDIR
fi
 
if [ -d $LOGDIR/$ONEMONTH ];
then
        rm -rfv $LOGDIR/$DELCURFOLDER
        rm -rfv $LOGDIR/$DELLASTFOLDER
else 
        echo "This Months Logs are Present."
        exit 0
fi
