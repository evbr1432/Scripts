#!/bin/bash
getp (){
df|awk '{print $5}'|awk 'NR==2{print $1}'|grep -Eo '[0-9]{1,3}';}
if [[ getp -gt 10 ]]; then
	echo "Your space is over 80%. Please delete some items" | mail evbr1432@colorado.edu
fi





