#!/bin/bash

args=$#

if [ $args == 2 ] ; then

file1=$1
file2=$2


#grep command to get line number of clusters and contexts and sed used to get only number from grep command by trimming :clusters:
line1=$(grep -n 'clusters:' $file1 | sed 's/:clusters://')
line2=$(grep -n 'contexts:' $file1 | sed 's/:contexts://')
line3=$(grep -n 'users:' $file1 | sed 's/:users://')

i=1

#creating a new merge2 file which contain data from both the file
touch merge

#header copy

while [ $i -le $line1 ]
do
	#rec="$(awk 'NR=='$i'{print $0}' $file1)"
	 awk 'NR=='$i'{print $0}' $file1 > temp
	 cat temp >> merge
	#echo $rec >> merge
	i=`expr $i + 1`
done

#################################################################################3

# clusters to contexts copy

j=$i

while [ $i -lt $line2 ] 
do
	#fileRec=$(awk 'NR=='$i'{print;}' $file1)
	#echo $fileRec >> merge
	awk 'NR=='$i'{print $0}' $file1 > temp
         cat temp >> merge
	i=`expr $i + 1`
done

while [ $j -lt $line2 ]
do
        #fileRec=$(awk 'NR=='$j'{print;}' $file2)
        #echo $fileRec >> merge
	awk 'NR=='$j'{print $0}' $file2 > temp
         cat temp >> merge
        j=`expr $j + 1`
done


#####################################################################

#contexts to users

while [ "$i" -lt "$line3" ]
do
	#fileRec=$(awk 'NR=='$i'{print;}' $file1)
	#echo $fileRec >> merge
	awk 'NR=='$i'{print $0}' $file1 > temp
         cat temp >> merge
	i=`expr $i + 1`
done

j=`expr $j + 1`

while [ "$j" -lt "$line3" ]
do
        #fileRec=$(awk 'NR=='$j'{print;}' $file2)
        #echo $fileRec >> merge
	awk 'NR=='$j'{print $0}' $file2 > temp
         cat temp >> merge
        j=`expr $j + 1`
done


#################################################################

# users to end of file

eof=$(awk 'END{print NR}' $file1)

while [ "$i" -le "$eof" ]
do
        #fileRec=$(awk 'NR=='$i'{print;}' $file1)
        #echo $fileRec >> merge
	awk 'NR=='$i'{print $0}' $file1 > temp
         cat temp >> merge
        i=`expr $i + 1`
done

j=`expr $j + 1`

while [ "$j" -le "$eof" ]
do
        #fileRec=$(awk 'NR=='$j'{print;}' $file2)
        #echo $fileRec >> merge
	awk 'NR=='$j'{print $0}' $file2 > temp
         cat temp >> merge
        j=`expr $j + 1`
done
rm temp
else
	echo "Missing parameters."
	echo "Accepts two parameters."
fi
