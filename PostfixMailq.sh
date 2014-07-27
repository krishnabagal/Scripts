#!/bin/bash
echo ""
echo -e "-----------------:\033[0;32mGet Qmail info\033[0m:--------------------"
echo "-----------------------------------------------------"
echo "Enter 1 to view Top mail accounts."
echo "Enter 2 to view All Email header. "
echo "Enter 3 to View All Email logs. "
echo "Enter 4 to Deleting mail from queue of mention domain"
echo ""
read -p "Enter your choice: " k
echo ""
Top ()
{
echo  "Top mail accounts: "
mailq | awk '/^[0-9,A-F]/ {print $7}' | sort | uniq -c | sort -n |tail
echo ""
}

Viewmails ()
{
read -p "Enter Email account: " n
echo ""
echo "----"
echo "To view Email headers of $n :"
for a in `mailq |grep $n | awk {'print $1'} |cut -d! -f1|tr -s "*" " "`; do sudo postcat -q $a |grep  -w "\(ENVELOPE RECORDS\|message_arrival_time\|sasl_method\|sasl_username\|sender\|Return-Path\|log_client_address\|original_recipient\|Subject\)"; echo ------------; done|sed s/named_attribute:\ //g
echo ""
}

Viewmailslog ()
{
read -p "Enter Email account: " n
echo ""
echo "----"
echo "To view Email logs of $n :"
for a in `mailq |grep $n  | awk {'print $1'} `; do  sudo cat /var/log/maillog |grep $a; echo ----  ; done
echo ""
}

deleteq ()
{
read -p  "Enter the Email address: " n
echo ""
echo "Deleting the mails of $n from queue"
for a in `mailq |grep $n  | awk {'print $1'} |cut -d! -f1|tr -s "*" " "`; do sudo postsuper -d $a; done
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
Viewmails
elif test $k = 3;
then
Viewmailslog
elif test $k = 4;
then
deleteq
fi
