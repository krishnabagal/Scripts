#!/bin/bash
echo ""
echo -e "-----------------:\033[0;32mWebsite Check Status\033[0m:--------------------"
echo "-----------------------------------------------------"
echo "Enter Website Name to check the status:"
echo ""
read -p "Enter Website: " k
echo ""
curl -IsSf http://$k -o /dev/null && echo "Status: OK" || echo "Status: Failed"
echo ""
