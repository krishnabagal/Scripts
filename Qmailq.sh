#!/bin/bash
echo ""
echo -e "-----------------:\033[0;32mGet Qmail info\033[0m:--------------------"
echo "-----------------------------------------------------"
echo "Enter 1 to view Top mail accounts"
echo "Enter 2 to view mails of mention domain"
echo "Enter 3 to get list of qid of mention domain "
echo "Enter 4 to get mail header manually using qid (for that you needed qid)"
echo "Enter 5 to Deleting mail from queue of mention domain"
echo ""
read -p "Enter your choice: " k
echo ""
Top ()
{
echo  "Top mail accounts: "
sudo  /var/qmail/queue/queue.pl -R | awk '/From:/ {print $2}' | sort | uniq -c | sort -n |tail
}

Viewmails ()
{
read -p "Enter domain name: " n
echo ""
echo "----"
echo "To view mails of $n domain:"
for a in `sudo  /var/qmail/queue/queue.pl -R | grep -B1 $n  |grep ^[A-Z0-9] |head -100 |awk {'print $1'}`; do sudo  /var/qmail/queue/queue.pl -v$a |egrep "Mailing-List|Message-ID:|From:|To:|Subject:|-" ; done
}

qid ()
{
read -p "Enter the domain name: " n
echo "Some qid of $n domain:"
sudo  /var/qmail/queue/queue.pl -R | grep -B1 $n  |grep ^[A-Z0-9] |awk {'print $1'} |head
}
viewmailqid ()
{
echo "To view mail header of manually using qid: "
read -p "Enter qid: " n
sudo  /var/qmail/queue/queue.pl -v$n |egrep "Mailing-List|Message-ID:|From:|To:|Subject:|-"
}
deleteq ()
{
read -p  "Enter the domain name: " n
echo ""
echo "Deleting the mails of $n from queue"
sudo /var/qmail/scripts/mailRemove.py --real $n
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
qid
elif test $k = 4;
then
viewmailqid
elif test $k = 5;
then
deleteq
fi
