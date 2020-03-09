#!/bin/bash 

if [ $# -gt 0 ] ; then
#copy first common lines upto colors and write it in merge file
sed -n '/apiVers/,/  colors:/p' $2 > $1


#CLUSTER BLOCK
echo "clusters:" >> $1
for arg
do 
	if [ "$arg" =  "$1" ] ; then
		continue
	else
		sed -nr '/- name: clus/,/contexts:/p' $arg | sed '$d' >> $1
	fi
done
##################################################
#CONTEXTS BLOCK
echo "contexts:" >> $1
for arg
do
	if [ "$arg" =  "$1" ] ; then
                continue
        else
       		sed -nr '/context:/,/current-context:/p' $arg | sed '$d' >> $1
	fi
done
###################################################################
# CURRENT CONTEXT
touch temp
for arg
do 
	sed -nr '/current-context:/p' $arg >> temp
done
# randomly picking the current context from temp file and append it to the end of merge file
shuf -n 1 temp >> $1
rm temp
####################################################################################
#USERS BLOCK
echo "users:" >> $1
for arg
do
	if [ "$arg" =  "$1" ] ; then
                continue
        else
 		sed -n '/users:/,$ p' $arg | sed '1d' >> $1
	fi
done


else
 echo "Arguments missing!"
fi
