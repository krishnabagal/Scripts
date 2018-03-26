#!/bin/bash
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==#
#Script Name: syslogs.sh 
#Date: Sep 08th, 2017. 
#Modified: Mar 20th, 2018.
#Versioning: 0.1 = updated command to delete old files (last 30 days) folder from
#                  location. (Dec 19th, 2017) 
#            0.2 = Updated command to delete last year files and folders. (Jan 11th, 2017.)
#            0.3 = Updated command to keep only one week logs. (Mar 19th, 2018.)
#            0.3 = Update data/logs in single file. (Mar 20th, 2018.)
#Author: Krishna Bagal.
#Info: Script will dump ps, free, top and netstat logs for reference.
#Ticket: NA
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==#
DATEnTIME=`date +%Y_%m_%d-%H:%M`
DATE=`date +%Y_%m_%d`
LOGDIR="/var/log/systemlogs"
MKDIR="/bin/mkdir"
CURMONTH=`date +%Y_%m_`
LASTWEEK=`date +%d -d "1 week ago"`
HOSTNAME=`hostname -f`
HOSTIP=`hostname -i`
UPTIME=`/usr/bin/uptime`
CURRENTDATE=`date`
KERNELVERSION=`/bin/uname -r`
if [ -d $LOGDIR ];
then
        if [ -d $LOGDIR/$DATE ];
        then
                echo "==============================: System Info :==============================" >> $LOGDIR/$DATE/$DATEnTIME.log
                echo -e "\t\t\t\t\t\t$CURRENTDATE" >> $LOGDIR/$DATE/$DATEnTIME.log
                echo "Hostname: $HOSTNAME" >> $LOGDIR/$DATE/$DATEnTIME.log
                echo "Host IP: $HOSTIP" >> $LOGDIR/$DATE/$DATEnTIME.log
                /usr/bin/lsb_release -d >> $LOGDIR/$DATE/$DATEnTIME.log
                echo "Kernel Version: $KERNELVERSION" >> $LOGDIR/$DATE/$DATEnTIME.log
                echo "" >> $LOGDIR/$DATE/$DATEnTIME.log
                echo Uptime: $UPTIME >> $LOGDIR/$DATE/$DATEnTIME.log
                echo "" >> $LOGDIR/$DATE/$DATEnTIME.log
                echo "=============================: Space Log  :===============================" >> $LOGDIR/$DATE/$DATEnTIME.log
                /bin/df -hT >> $LOGDIR/$DATE/$DATEnTIME.log
                echo "=============================: Memory Info :==============================" >> $LOGDIR/$DATE/$DATEnTIME.log
                /usr/bin/free -mlt >> $LOGDIR/$DATE/$DATEnTIME.log
                echo "=============================: Process Log :==============================" >> $LOGDIR/$DATE/$DATEnTIME.log
                /bin/ps -eo %mem,%cpu,user,pid,ppid,stat,start,cmd --sort=-%mem >> $LOGDIR/$DATE/$DATEnTIME.log
                echo "=============================: Top Command :==============================" >> $LOGDIR/$DATE/$DATEnTIME.log
                /usr/bin/top -c -n1 -b >> $LOGDIR/$DATE/$DATEnTIME.log
                echo "=============================: Network Log :==============================" >> $LOGDIR/$DATE/$DATEnTIME.log
                /bin/netstat -atunlp >> $LOGDIR/$DATE/$DATEnTIME.log
                echo "==========================================================================" >> $LOGDIR/$DATE/$DATEnTIME.log
        else 
                echo "$LOGDIR/$DATE Directory not present. Creating now...!!!"
                sleep 3
                $MKDIR -p $LOGDIR/$DATE
                echo "==============================: System Info :==============================" >> $LOGDIR/$DATE/$DATEnTIME.log
                echo -e "\t\t\t\t\t\t\t\t$date"
                echo "Hostname: $HOSTNAME" >> $LOGDIR/$DATE/$DATEnTIME.log
                echo "Host IP: $HOSTIP" >> $LOGDIR/$DATE/$DATEnTIME.log
                /usr/bin/lsb_release -d >> $LOGDIR/$DATE/$DATEnTIME.log
                /bin/uname -r >> $LOGDIR/$DATE/$DATEnTIME.log
                echo "" >> $LOGDIR/$DATE/$DATEnTIME.log
                echo $UPTIME >> $LOGDIR/$DATE/$DATEnTIME.log
                echo "" >> $LOGDIR/$DATE/$DATEnTIME.log
                echo "=============================: Space Log  :===============================" >> $LOGDIR/$DATE/$DATEnTIME.log
                /bin/df -hT >> $LOGDIR/$DATE/$DATEnTIME.log
                echo "=============================: Memory Info :==============================" >> $LOGDIR/$DATE/$DATEnTIME.log
                /usr/bin/free -mlt >> $LOGDIR/$DATE/$DATEnTIME.log
                echo "=============================: Process Log :==============================" >> $LOGDIR/$DATE/$DATEnTIME.log
                /bin/ps -eo %mem,%cpu,user,pid,ppid,stat,start,cmd --sort=-%mem >> $LOGDIR/$DATE/$DATEnTIME.log
                echo "=============================: Top Command :==============================" >> $LOGDIR/$DATE/$DATEnTIME.log
                /usr/bin/top -c -n1 -b >> $LOGDIR/$DATE/$DATEnTIME.log
                echo "=============================: Network Log :==============================" >> $LOGDIR/$DATE/$DATEnTIME.log
                /bin/netstat -atunlp >> $LOGDIR/$DATE/$DATEnTIME.log
                echo "==========================================================================" >> $LOGDIR/$DATE/$DATEnTIME.log
        fi
else 
        echo "$LOGDIR Directory is not present."
        echo "Creating now.!!!!"
        $MKDIR -p $LOGDIR
fi
 
/usr/bin/find $LOGDIR -type d -mtime +7 -exec rm -rfv {} \;
