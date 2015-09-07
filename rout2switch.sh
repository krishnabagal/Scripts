#!/bin/bash
######################################################
# Script to FAILOVER and FAILBACK Gateway
######################################################
#Reliance IP
RelLink=X.X.X.X
RelGW=X.X.X.X
#Primary (TATA) IP:
PriLink=X.X.X.X
PriGW=X.X.X.X
#check network
curl -IsSf -m 5 http://google.com -o /dev/null
stat=`echo $?`

if [ "$stat" = "0" ]; then
        echo "Link up: $curIP"
else
        echo "Link Down: TATA X.X.X.X"
        bash /tmp/r2 
fi

#check another link
curl -IsSf -m 5 http://google.com -o /dev/null
stat1=`echo $?`
if [ "$stat1" = 0 ]; then 
        echo "Link up: $curIP"
else 
        echo "Link Down: Reliance X.X.X.X"
        bash /tmp/r1 
fi

#current route IP
curIP=`/usr/bin/dig +short myip.opendns.com @resolver1.opendns.com`
#Check primary link,
ping -c 3 (GW IP) >/dev/null
ChPy=`echo $?`

if [ "$ChPy" = 0 ]; then 
        echo "TATA is UP"
                if [ "$curIP" = "$PriLink" ];then 
                        echo "GW: TATA"
                else 
                        bash /tmp/r1 
                fi
fi


=====================
cat /tmp/r2 
route del default
/sbin/route add default gw X.X.X.X eth0

