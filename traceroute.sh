#!/bin/bash
>/tmp/treoute
>/tmp/treoute2
echo "-:Host/IP: $1"
traceroute -I -n -w 2 $1 >/dev/null 
if [ $? -eq 0 ];then
	Trs=$(traceroute -I -n -w 2 $1 2>/dev/null | tail -1 | awk '{print $1}')
	echo "-:Total Hops: $Trs"
	echo "-----------------------Please wait.!!"
		/usr/bin/mtr --report $1 >/tmp/treoute
	echo "..Done..!!!"
	sleep 2
	clear
		echo "-:Host/IP: $1"
		echo "-:Total Hops: $Trs"
		echo "--------------------------------------"
			cat /tmp/treoute |grep -iA30 "1.|" |awk {'print $3 '} |tr -s "%" " " |cut -d"." -f1 |grep -v ^0 >>/tmp/treoute2
				if [ -s  /tmp/treoute2 ]; then
					echo "-:Hops details:"
						cat /tmp/treoute |grep -iA30 "1.|" |awk {'print $1$2" ---------------------- Packet Lost="$3 '}
				else
					echo "No Packet Drops.!!! :)"
				fi
else 
	echo "Failed to resolve host: Name or service not known"
fi
