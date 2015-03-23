#!/bin/bash
#------------------------------------------------------#
#Script to accept three arguments
#and work on Opration type with number of Iterations.
#------------------------------------------------------#
#3
echo ""
if [ "$#" -eq "3" ]
then
    V1="$1"
    V2="$2"
    V3="$3"
else
    echo -n "Enter the 1st value : "
    read "V1"
    echo -n "Enter Opration Type (+,-,*,/) : "
    read "V2"
    echo -n "Enter Number of Iterations : "
    read "V3"
fi
echo ""
echo "Result :- "
echo "------------------"
for (( i=1; i<="$V3"; i++ ))
do
    Z=`expr "$V1" "$V2" "$i"`
    echo " $V1 $V2 $i = $Z "
done
echo "------------------"
echo ""
