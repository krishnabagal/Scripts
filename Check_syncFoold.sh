#!/bin/bash
echo ""
echo -e "-----------------:\033[0;32mGet Qmail info\033[0m:--------------------"
echo "-----------------------------------------------------"
echo "Enter 1 to check high request IP's"
echo "Enter 2 to check high request domain. "
echo "Enter 3 to Blocked IP in IPTABLES. "
echo "Enter 4 to check whois of IP addedress. "
echo ""
read -p "Enter your choice: " k
echo ""
Top ()
{
echo  "High request from IP's: "
/bin/netstat -an 2>/dev/null | grep SYN_RECV | awk '{print $5}' | cut -f1 -d:| sort | uniq -c | sort -n | tail
echo ""
}

Viewdomain ()
{
echo "High request Domain List : "
echo ""
echo "----"
sudo tail -2000  /var/log/nginx/access.log  | awk '{print $1}' |  sort | uniq -c | sort -rn | head -3
echo ""
}

BlockIP ()
{
read -p "Enter IP Address: " n
echo ""
echo "----"
sudo /sbin/iptables -I INPUT -s $n -j DROP
echo ""
}

WhoisIP ()
{
read -p "Enter IP Address: " n
echo ""
echo "----"
/usr/bin/whois $n 
echo ""
}


if [ "$k" == "" ]; then
echo -e "\t\t\033[0;31mNo arguments provided\033[0m"
echo ""
exit 1
elif test $k = 1;
then
Top
elif test $k = 2;
then
Viewdomain
elif test $k = 3;
then
BlockIP
elif test $k = 4;
then 
WhoisIP 
fi 

