#!/bin/bash
#=======================================================#
#Script Name: Kerberos_Password_Expiry-Notification.sh
#Date: Apr 19, 2017.
#Modified: Nov 03, 2017.
#Auther: Krishna Bagal.
#Info:  Kerberos Password expiry notification to User.
#=======================================================#
#log file
>/tmp/user_status.log
#set hostname as veriable
HOSTNAME=`hostname`
#last 5 min time format 
DATE=`date +%b" "%d" "%R`
DATE1=`date +%b" "%d" "%R -d "-1  min"`
DATE2=`date +%b" "%d" "%R -d "-2  min"`
DATE3=`date +%b" "%d" "%R -d "-3  min"`
DATE4=`date +%b" "%d" "%R -d "-4  min"`
DATE5=`date +%b" "%d" "%R -d "-5  min"`
#set some veriables
MAIL="/usr/bin/mail"
USERS="krishna.bagal@gmail.com"
MSG="Please do reply on this mail only by keeping krishna.bagal@gmail.com for password regenerate request."
#running loop
for a in "$DATE1" "$DATE2" "$DATE3" "$DATE4" "$DATE5"
do
        tail -10000 /var/log/kerberos/kdc.log |grep -wi "^$a" | egrep -i "CLIENT KEY EXPIRED" | cut -d@ -f 1 |egrep -vi "<ignore users>" |awk {'print "Your Login Password has been Expired: "$NF'} | uniq  >>/tmp/user_status.log
done

#if we got data then send mail to user and ops.
if [ -s /tmp/user_status.log ];then
        for a in `cat /tmp/user_status.log| awk {'print $NF'}`
        do
                LDAPMAILADD=$(/usr/bin/ldapsearch -H ldap://<ldap.server> -b dc=<dc-name>,dc=<name> -D cn=<cn-name>,dc=<dc-name>,dc=<me> -w <Password> -LLL |grep -i $a |grep -i mail |awk {'print $2'})
                echo "$MSG" | $MAIL -s "Your VPN Password is expired" $LDAPMAILADD -c $USERS 
        done
else
        echo OK
fi
