freeMem(){
 free -h|awk '{print $3}'|awk 'NR==2{print $1}'
}
CpuLoad(){
 uptime|awk '{print " "$8" "$9" "$10" "}'
}

Network(){
 if [ $1 -eq 1 ]
  then
   ifconfig lo|grep RX|awk '{print $5}'|awk 'NR==1{print $1}'

 elif [ $1 -eq 2 ]
   then
   ifconfig lo|grep TX|awk '{print $5}'|awk 'NR==1{print $1}'

 elif [ $1 -eq 3 ]
   then
   ifconfig enp0s3|grep RX|awk '{print $5}'|awk 'NR==1{print $1}'
 
 elif [ $1 -eq 4 ]
   then
   ifconfig enp0s3|grep TX|awk '{print $5}'|awk 'NR==1{print $1}'    
 fi
}
NetworkCheck(){
if [[ $(ping -c1 google.com|grep -q unknown) && $(ping -c1 yahoo.com|grep -q unknown) ]];
 then
  echo Internet Connectivity: No;
 else
  echo Internet Connectivity: Yes;
fi
}
AccountInfo(){
 if [ $1 -eq 1 ]
  then
   cat /etc/passwd|wc -l
 elif [ $1 -eq 2 ]
  then
   w -h|wc -l
 elif [ $1 -eq 3 ]
  then
   cat /etc/passwd|cut -d':' -f7|uniq -c|sort -n|tail -1|awk '{print $2}'
 fi
}

echo "CPU AND MEMORY RESOURCES.........."
echo -n "CPU Load Average:" $(CpuLoad)
echo "      Free Ram:" $(freeMem)
echo -e "\nNETWORK CONNECTIONS............."
echo -n "lo Bytes Received:" $(Network 1)
echo "   Bytes Trasmitted:" $(Network 2)
echo -n "enp0s3 Bytes received:" $(Network 3)
echo "   Bytes Trasmitted:" $(Network 4)
NetworkCheck
echo -e "\nACCOUNT INFORMATION........."
echo -n "Total Users:" $(AccountInfo 1)
echo "    Number Active:" $(AccountInfo 2)
echo  "Most Frequently Used Shell:" $(AccountInfo 3)




