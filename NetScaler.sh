#!/bin/bash
#empty /tmp/lbconfigfile file
>/tmp/lbconfigfile
#collect vserver information
cat $1 |grep -i "bind\ lb\ vserver" |awk {'print $4'} |sed "s|$|:|g" |tr -d "\n" |tr -s ":" " " >>/tmp/lbconfigfile

for a in `cat /tmp/lbconfigfile`
do
	vserver=$(cat $1 |grep -i "bind\ lb\ vserver" |grep -E "(^| )$a( |$)" |head -1 |awk {'print $4'})
	sergrp=$(cat $1 |grep -i "bind\ lb\ vserver" |grep -E "(^| )$vserver( |$)" |head -1  |awk {'print $5'})
	hosts=$(cat $1 |grep -i "bind\ serviceGroup" |grep -E "(^| )$sergrp( |$)" |grep -v monitorName |awk {'print $4":"$5'})
		echo "vserver: $vserver"
		echo "ServiceGroup: $sergrp"
		echo "Hosts:"
		echo "$hosts"
		echo "--------------------------------------------"
done
