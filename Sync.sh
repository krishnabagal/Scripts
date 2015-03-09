#!/bin/bash
echo ""
echo -e "--------------:\033[0;32mGet info\033[0m:-------------------"
echo "-------------------------------------------"
echo "Enter 1 to Check High Request IP's"
echo "Enter 2 to Blocked IP in IPTABLES. "
echo ""
read -p "Enter your choice: " k
echo ""
Top ()
{
ip=$(/bin/netstat -an 2>/dev/null | grep SYN_RECV | awk '{print $5}' | cut -f1 -d:| sort | uniq -c | sort -n | tail -5)
domain=$(sudo tail -2000  /var/log/nginx/access.log  | awk '{print $1}' |  sort | uniq -c | sort -n | tail -3)
echo "---------------------------------"
echo "Date: "`date "+%d %b %Y  %T"`""
echo "Hostname: `hostname` "
echo "---------------------------------"
echo ""
echo -e "-----:\033[0;32mTop 5 High request IP's\033[0m:-----"
echo ""
echo " No of       IP"
echo " Reuest    Address"
echo "---------------------"
echo -e "$ip"
echo ""
echo -e "-----:\033[0;32mHigh request Domain List\033[0m:-----"
echo ""
echo "Per 2000 req:"
echo ""
echo " No of       IP"
echo " Reuest    Address"
echo "---------------------"
echo -e "$domain "
echo ""
echo ""
echo -e "\033[0;32mNetwork packet details\033[0m:"
echo ""
sudo netstat -an|awk '/tcp/ {print $6}'|sort|uniq -c
echo ""
echo -e "-----:\033[0;35mNo of Request for IP:\033[0m:-----"
echo ""
sudo netstat -tunlpa |grep -i syn |awk {'print $4'} |cut -d: -f1 |sort|uniq -c |sort  -n |tail -3
echo

echo "--------------------------------------"
}

BlockIP ()
{
read -p "Enter IP Address: " n
echo ""
echo "----"
sudo /sbin/iptables -I INPUT -s $n -j DROP
sudo iptables -L -nv |grep $n
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
BlockIP
fi
