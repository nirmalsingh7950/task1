#!/bin/bash 

if [ $# -gt 0 ] ; then
#copy first common lines upto colors and write it in merge file
sed -n '/apiVers/,/  colors:/p' $1 > merge


#CLUSTER BLOCK
echo "clusters:" >> merge
for arg
do 
	sed -nr '/- name: clus/,/contexts:/p' $arg | sed '$d' >> merge
done
##################################################
#CONTEXTS BLOCK
echo "contexts:" >> merge
for arg
do
        sed -nr '/context:/,/current-context:/p' $arg | sed '$d' >> merge
done
###################################################################
# CURRENT CONTEXT
touch temp
for arg
do 
	sed -nr '/current-context:/p' $arg >> temp
done
# randomly picking the current context from temp file and append it to the end of merge file
shuf -n 1 temp >> merge
rm temp
####################################################################################
#USERS BLOCK
echo "users:" >> merge
for arg
do
	 sed -n '/users:/,$ p' $arg | sed '1d' >> merge
done


else
 echo "Arguments missing!"
fi
