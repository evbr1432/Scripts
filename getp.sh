#!/bin/bash
#getp.sh - Checks for the usage percent and sends an email to example.yahoo.com if the disk usage percentage is over the variable set in DiskPerct

getp (){
df|awk '{print $5}'|awk 'NR==2{print $1}'|grep -Eo '[0-9]{1,3}';
}

DiskPerct=80
if [[ getp -gt $DiskPerct ]]; then
	echo "Your space is over $DiskPerct. Please delete some items" | mail example@yahoo.com
fi





