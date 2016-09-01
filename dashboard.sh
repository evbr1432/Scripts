#!/bin/bash
#dashboard.sh - Displays free memory, network stats, and some account info 
#Created by: Evan Brookens

#Checks free memory usage with free command and gets 3rd column, 2 row to print
freeMem(){
 free -h|awk '{print $3}'|awk 'NR==2{print $1}'
}

#Function to print CPU load by getting 8th,9th,and 10th column of info

CpuLoad(){
 uptime|awk '{print " "$8" "$9" "$10" "}'
}

#function for getting network stats of recieved and trasmited bytes

Network(){
#lo Recieved bytes
 if [ $1 == "loRX" ]
  then
   ifconfig lo|grep RX|awk '{print $5}'|awk 'NR==1{print $1}'
#lo Transmitted bytes
 elif [ $1 == "loTX" ]
   then
   ifconfig lo|grep TX|awk '{print $5}'|awk 'NR==1{print $1}'
#enp0s3 Recieved bytes
 elif [ $1 == "enRX" ]
   then
   ifconfig enp0s3|grep RX|awk '{print $5}'|awk 'NR==1{print $1}'
#enp0s3 Transmitted bytes
 elif [ $1 == "enTX" ]
   then
   ifconfig enp0s3|grep TX|awk '{print $5}'|awk 'NR==1{print $1}'    
 fi
}

#Function to ping goolge and yahoo, grep for "unknown" host, if found return no.

NetworkCheck(){
if [[ $(ping -c1 google.com|grep -q unknown) && $(ping -c1 yahoo.com|grep -q unknown) ]];
 then
  echo Internet Connectivity: No;
 else
  echo Internet Connectivity: Yes;
fi
}

#Function to gather account info. Again, if loop for readability.

AccountInfo(){
#Counts number of users in etc/passwd
 if [ $1 == "NumUsers" ]
  then
   cat /etc/passwd|wc -l
#Gets active users with w command and counting lines excluding the header
 elif [ $1 == "ActiveUsers" ]
  then
   w -h|wc -l
#Cuts etc/passwed on feild 7(shells), then counts the number of entires of each, sorts them in ascending order, then grabs the last line which is the most popular entry, and finally prints the most popular shell.
 elif [ $1 == "FreqShell" ]
  then
   cat /etc/passwd|cut -d':' -f7|uniq -c|sort -n|tail -1|awk '{print $2}'
 fi
}
#Headers and function calls
echo "CPU AND MEMORY RESOURCES.........."
echo -n "CPU Load Average:" $(CpuLoad)
echo "      Free Ram:" $(freeMem)
echo -e "\nNETWORK CONNECTIONS............."
echo -n "lo Bytes Received:" $(Network loRX)
echo "   Bytes Trasmitted:" $(Network loTX)
echo -n "enp0s3 Bytes received:" $(Network enRX)
echo "   Bytes Trasmitted:" $(Network enTX)
NetworkCheck
echo -e "\nACCOUNT INFORMATION........."
echo -n "Total Users:" $(AccountInfo NumUsers)
echo "    Number Active:" $(AccountInfo ActiveUsers)
echo  "Most Frequently Used Shell:" $(AccountInfo FreqShell)




