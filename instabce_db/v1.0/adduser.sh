#!/bin/sh
# adduser
# Run as: root
# Writer: Y

ADDGROUPS="oinstall dba"
ADDUSERS="oracle"
PASSWORD="oracle"
TEMP=500
for group in $ADDGROUPS ; do
        if [ -z "$( awk -F: '{print $1}' /etc/group |grep $group)" ]; then 
                groupadd -g $TEMP  $group
		TEMP=$(($TEMP+1))
                echo " Add new group $group"
        else
                echo " Group $group already existed"
        fi
done 
for user in $ADDUSERS ; do
        if [ -z "$( awk -F: '{print $1}' /etc/passwd |grep $user)" ]; then 
                useradd  $user
		echo $PASSWORD | passwd --stdin $user 
                echo " Add new user $user and passwd"
        else
                echo " User $user already existed"
        fi 
done 
if $(usermod -g oinstall -G dba -u 500 oracle) ;  then 
  echo " Modify user oracle account success"
else
  echo " Modify user oracle account failure"
fi
