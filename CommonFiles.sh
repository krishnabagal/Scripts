#!/bin/bash
#-------------------------------------------------------------------------------#
#Script to check common file's from source and destination directory.
#if there are some common file's then move to backup directory.
 
#Note: Source directory is /mnt/test and distination directory is /mnt/abc
#      ibackup directory is /mnt/hhh
#      Modify this directory as per your requirment.
#-------------------------------------------------------------------------------#
echo ""
echo -n "Enter the First Directory Path : "
read A
if [ -d $A ]
then
echo -n "Enter the Second Directory Path : " 
read B
else 
echo ""
echo -e "\033[031m\tPlease Enter Valid Directory!!!!!\033[0m"
echo ""
exit
fi
if [ -d $B ]
then
echo -n "Enter the Backup folder : "
read C
else
echo ""
echo -e "\033[031m\tPlease Enter Valid Directory!!!!!\033[0m"
echo ""
exit
fi

if [ -d $C ]
then
    ls -ll $A |awk {'print $9'} |sed '1 d' > tmp1
    ls -ll $B |awk {'print $9'} |sed '1 d' > tmp2 


    for Z in `cat tmp2`
    do 
        find $A -type f -name $Z -print -exec cp {} $C \; >> tmp3 
    done

        for X in `cat tmp1`
        do 
            find $B -type f -name $X -print >> tmp4   
        done

            if [ -s tmp3 ]
            then
                for Y in `cat tmp3`
                do 
                    rm -rf $Y 
                done
            elif [ -s tmp4 ]
            then 
                for M in `cat tmp4`
                do 
                    rm -rf $M 
                done
            else 
                echo " "
                echo -e " \tFile Are Not Common On Both Directory.. "
                echo " "
                rm -rf tmp1 tmp2 tmp3 tmp4 
                exit
            fi  

echo ""
echo "Below are the Common Files Present on $A and $B Directory:" 
echo ""
paste tmp3 tmp4 
echo ""

echo -e "\033[32m\tCommon File are Moved to $C Directory.\033[0m"
echo ""
rm -rf tmp1 tmp2 tmp3 tmp4 
else
    echo ""
    echo -e "\033[031m\tPlease Enter Valid Directory!!!!!\033[0m"
    echo ""
fi
