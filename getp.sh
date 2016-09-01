#!/bin/bash
getp (){
df|awk '{print $5}'|awk 'NR==2{print $1}'|grep -Eo '[0-9]{1,3}';}
getp
DiskPerct=80
if [[ getp -gt $DiskPerct ]]; then
	echo "Your space is over $DiskPerct. Please delete some items" | mail evbr1432@colorado.edu
fi





