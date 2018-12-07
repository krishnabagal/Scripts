#!/bin/bash
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=#
#Script Name: check-home.sh
#Date: Dec 04th, 2018. 
#Modified: NA
#Versioning: NA
#Author: Krishna Bagal.
#Info: Find and send mail to user if file size is grater than threshold value.
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=#
HOSTNAME=`/bin/hostname -f`
MAIL="/usr/bin/mail"
FIND="/usr/bin/find"
GREP="/bin/grep"
DIR="/home/"
USERFILEOUTPUT="/tmp/homedirsize"
IGNOREUSER="tom|jerry"
USERLIST="/tmp/homediruserlist"
MAILBODY="/tmp/homedirsizebody"
THRESHOLD="100M"

# List file
$FIND $DIR -type f -size +$THRESHOLD  >$USERFILEOUTPUT

# List user file list
cat $USERFILEOUTPUT |cut -d"/" -f3 |uniq |egrep -v "$IGNOREUSER" >$USERLIST

for USER in `cat $USERLIST`
do
        >$MAILBODY
        echo "=================================================================" >> $MAILBODY
        echo "Host: $HOSTNAME" >> $MAILBODY
        echo "User: $USER" >> $MAILBODY
        echo "=================================================================" >> $MAILBODY
        echo "" >> $MAILBODY
        echo ":File Size More than $THRESHOLD:" >> $MAILBODY
        echo "----------------------------------" >> $MAILBODY
        echo "" >> $MAILBODY
        $GREP -i $USER $USERFILEOUTPUT >> $MAILBODY
        echo "" >> $MAILBODY
        echo "=================================================================" >> $MAILBODY
        echo ":------: Kindly Delete/Clean Unwanted Files and Folders :-------:"  >> $MAILBODY
        echo "=================================================================" >> $MAILBODY
        $MAIL -s "Please Clean Your Home Directory on $HOSTNAME" $USER@<domain>.com < $MAILBODY
        >$MAILBODY
done
