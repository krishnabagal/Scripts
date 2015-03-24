#!/bin/bash
##########################################################################
### Find the Folder (does not include folder / size of subdirectories) ###
##########################################################################
echo ""
echo "Enter The Folder Name That You Want To Search: "
read -p": " F
echo ""
echo "Details:"
echo "-------------------------------------"
echo -e "Size\tLocation"
echo "-------------------------------------"
find / -type d -name $F -exec du -sSh {} \;
C=$(find / -type d -name $F -exec du -sSk {} \; |awk {'print $1'} | tr "\n" "+" |sed -e 's#+# + #g' -e 's# + $##g')
D=$(expr $C )
echo ""
echo  "Total Size:$D kb"
echo ""
