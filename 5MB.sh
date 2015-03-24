#!/bin/bash
#-------------------------------------------------------------------#
#Script to show, list of file's that having size more than 5MB.
#
#-------------------------------------------------------------------#
echo ""
echo -ne "\033[36mEnter the Directory Path to Search: \033[0m"
read F

if [ -d $F ]
then
    if [ "$(ls -A $F)" ]
    then

    du -sk $F/* > tmp
    cat tmp |awk {'print $1'} > tmp2
    for A in `cat tmp2`
    do
        if [ "$A" -ge "5120" ]
        then
            cat tmp |grep $A >> tmp3
        fi
    done

            if [ -f tmp3 ]
            then
                echo " "
                echo -e "\033[36mBelow are the file details having more than 5MB: \033[0m"
                echo ""
                echo -e "\033[36mDetails in KB:\033[0m"
                echo "-------------------------------------"
                echo -e "\033[35mSize\033[0m\t\033[32mLocation\033[0m"
                echo "-------------------------------------"
                sort -u tmp3
                echo ""
                rm -rf tmp tmp2 tmp3
            else
                echo " "
                echo -e "\033[32m\tNo File Present in $F Directory More Than 5MB..\033[0m "
                rm -rf tmp tmp2
                echo " "
                fi
            else
                echo " "
                echo -e "\033[31m\t$F Directory is Blank Directory...\033[0m "
                echo " "
                fi
else
    echo " "
    echo -e "\033[31m\tDirectory not present. Please try again !!!!!\033[0m"
    echo " "
fi
