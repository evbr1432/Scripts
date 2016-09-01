freeMem(){
 free -h|awk '{print $3}'|awk 'NR==2{print $1}'
}
CpuLoad(){
 uptime|awk '{print " "$8" "$9" "$10" "}'
}
NetworkCheck(){
 echo lo Bytes Received: $(ifconfig lo|grep RX|awk '{print $5}'|awk 'NR==1{print $1}') $(echo -e lo Bytes Trasmitted:) $(ifconfig lo|grep TX|awk '{print $5}'|awk 'NR==1{print $1}') 
 echo enp0s3 Bytes Received: $(ifconfig enp0s3|grep RX| awk '{print $5}'|awk 'NR==1{print $1}') $(echo -e "\tenp0s3 Bytes Transmitted:") $(ifconfig enp0s3|grep TX| awk '{print $5}'|awk 'NR==1{print $1}')
 if (ping -c1 google.com|grep -q unkown); 
  then echo Internet Connectivity: NO
  else echo Internet Connectivity: YES;
 fi 
}
echo "CPU AND MEMORY RESOURCES.........."
echo -n "CPU Load Average:" $(CpuLoad)
echo -n "	"
echo "Free Ram:" $(freeMem)
echo -e "\n"
echo NETWORK CONNECTIONS.............
NetworkCheck
