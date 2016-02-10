#!/bin/bash
echo ""
echo -e "-----------------:\033[0;32mGet NetScaler Info\033[0m:--------------------"
echo "-----------------------------------------------------"
echo "Enter 1 to check vserver with hosts details."
echo "Enter 2 to check individual vserver healht and hosts status."
echo "Enter 3 to check all details."
echo ""
read -p "Enter your choice: " k
echo ""

NormalDetails ()
{

#empty /tmp/lbconfigfile file
>/tmp/lbconfigfile
#collect vserver information
cat LBConfig.txt |grep -i "bind\ lb\ vserver" |awk {'print $4'} |sed "s|$|:|g" |tr -d "\n" |tr -s ":" " " >>/tmp/lbconfigfile

for a in `cat /tmp/lbconfigfile`
do
	vserver=$(cat LBConfig.txt |grep -i "bind\ lb\ vserver" |grep -E "(^| )$a( |$)" |head -1 |awk {'print $4'})
	sergrp=$(cat LBConfig.txt |grep -i "bind\ lb\ vserver" |grep -E "(^| )$vserver( |$)" |head -1  |awk {'print $5'})
	hosts=$(cat LBConfig.txt |grep -i "bind\ serviceGroup" |grep -E "(^| )$sergrp( |$)" |grep -v monitorName |awk {'print $4":"$5'})
		echo "vserver: $vserver"
		echo "ServiceGroup: $sergrp"
		V=$(cat OID |grep -E "(^| )$a( |$)" |awk {'print $2'})
		VS=$(/usr/local/nagios/libexec/check_netscaler_vserver.pl -H 10.30.0.10 -C icinga -S $V)
		echo "vserver Status: $VS"
                echo :--
		echo "Hosts:"
		echo "$hosts"
		echo "--------------------------------------------"
done

}


FullDetails ()
{
#empty /tmp/lbconfigfile file
>/tmp/lbconfigfile
#collect vserver information
read -p "Enter your vserver: " vservername

#for a in `cat /tmp/lbconfigfile`
#do
	vserver=$(cat LBConfig.txt |grep -i "bind\ lb\ vserver" |grep -E "(^| )$vservername( |$)" |head -1 |awk {'print $4'})
	sergrp=$(cat LBConfig.txt |grep -i "bind\ lb\ vserver" |grep -E "(^| )$vserver( |$)" |head -1  |awk {'print $5'})
	>/tmp/lb2
	cat LBConfig.txt |grep -i "bind\ serviceGroup" |grep -E "(^| )$sergrp( |$)" |grep -v monitorName |awk {'print $4":"$5'} >>/tmp/lb2
		echo "vserver: $vserver"
		echo "ServiceGroup: $sergrp"
		V=$(cat OID |grep -E "(^| )$vservername( |$)" |awk {'print $2'})
		VS=$(/usr/local/nagios/libexec/check_netscaler_vserver.pl -H 10.30.0.10 -C icinga -S $V)
		echo "vserver Status: $VS"
                echo :--
		echo "Hosts:"
			for b in `cat /tmp/lb2`
			do
				s=$(echo "nc -w 1 $b" |tr -s ":" " ")
				$s >>/dev/null  && echo -e "$b:\033[32mup\033[0m" || echo -e "$b:\033[31mDown\033[0m"
			done
		echo "--------------------------------------------"
}

ALL ()
{
#empty /tmp/lbconfigfile file
>/tmp/lbconfigfile
#collect vserver information
cat LBConfig.txt |grep -i "bind\ lb\ vserver" |awk {'print $4'} |sed "s|$|:|g" |tr -d "\n" |tr -s ":" " " >>/tmp/lbconfigfile

for a in `cat /tmp/lbconfigfile`
do
	vserver=$(cat LBConfig.txt |grep -i "bind\ lb\ vserver" |grep -E "(^| )$a( |$)" |head -1 |awk {'print $4'})
	sergrp=$(cat LBConfig.txt |grep -i "bind\ lb\ vserver" |grep -E "(^| )$vserver( |$)" |head -1  |awk {'print $5'})
	>/tmp/lb2
	cat LBConfig.txt |grep -i "bind\ serviceGroup" |grep -E "(^| )$sergrp( |$)" |grep -v monitorName |awk {'print $4":"$5'} >>/tmp/lb2
		echo "vserver: $vserver"
		echo "ServiceGroup: $sergrp"
		V=$(cat OID |grep -E "(^| )$a( |$)" |awk {'print $2'})
		VS=$(/usr/local/nagios/libexec/check_netscaler_vserver.pl -H 10.30.0.10 -C icinga -S $V)
		echo "vserver Status: $VS"
                echo :--
		echo "Hosts:"
			for b in `cat /tmp/lb2`
			do
				s=$(echo "nc -w 1 $b" |tr -s ":" " ")
				$s >>/dev/null  && echo -e "$b:\033[32mup\033[0m" || echo -e "$b:\033[31mDown\033[0m"
			done
		echo "--------------------------------------------"
done
}

if [ "$k" == "" ]; then
echo -e "\t\t\033[0;31mNo arguments provided\033[0m"
echo ""
exit 1
elif test $k = 1;
then
NormalDetails
elif test $k = 2;
then
FullDetails
elif test $k = 3;
then
ALL
fi 
