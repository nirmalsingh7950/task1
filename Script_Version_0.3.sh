#!/bin/bash 

if [ $# -gt 0 ] ; then
#copy first common lines upto colors and write it in merge file
sed -n '/apiVers/,/  colors:/p' $1 > merge

mergeFile=$1

touch $mergeFile

touch temp2
#CLUSTER BLOCK
echo "clusters:" >> temp2
for arg
do 
	if [ $1 ] ; then
	     break
	else
		sed -nr '/- name: clus/,/contexts:/p' $arg | sed '$d' >> temp2
	fi
done
##################################################
#CONTEXTS BLOCK
echo "contexts:" >> temp2
for arg
do
	 if [ $1 ] ; then
             break
     else
        sed -nr '/context:/,/current-context:/p' $arg | sed '$d' >> temp2
	fi
done
###################################################################
# CURRENT CONTEXT
touch temp
for arg
do 
	 if [ $1 ] ; then
             break
	else
	sed -nr '/current-context:/p' $arg >> temp
fi
done
# randomly picking the current context from temp file and append it to the end of merge file
shuf -n 1 temp >> temp2
rm temp
####################################################################################
#USERS BLOCK
echo "users:" >> temp2
for arg
do
	 if [ $1 ] ; then
             break
     else
	 sed -n '/users:/,$ p' $arg | sed '1d' >> temp2
 fi
done
cp temp2 $mergeFile
rm temp2


else
 echo "Arguments missing!"
fi
