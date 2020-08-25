#!/bin/bash
# Enumeration Script by Luke Williams, June 2020
for IP in $@
do

if [[ $IP == $0 ]]
then
continue
fi

export IP

if [[ ! -d $IP ]]
then
mkdir $IP
fi

NMAPA="${IP}/nmap_a_allports.txt"
nmap -A -p- -Pn $IP | tee  ${NMAPA}

if [[ ! -z  $(grep -i '80/tcp' ${NMAPA}) ]]
then
gobuster dir -x .php,.html,.asp,.aspx,.jsp,.txt,.cgi -u http://${IP} -s 200,204,301,302,307,401,403,500 -w /usr/share/wordlists/dirb/big.txt -t 12 -o "${IP}/gobuster-80.txt"
echo "Port 80 is open - don't forget to nikto" > "${IP}/reminder.txt"
fi

if [[ ! -z $(grep -i '443/tcp' ${NMAPA}) ]]
then
echo "Port 443 is open - don't forget to nikto" >> "${IP}/reminder.txt"
gobuster dir -x .php,.html,.asp,.aspx,.jsp,.txt,.cgi -u http://${IP} -s 200,204,301,302,307,401,403,500 -w /usr/share/wordlists/dirb/big.txt -t 12 -o "${IP}/gobuster-443.txt"
fi

if [[ ! -z $(grep -i smb ${NMAPA}) || ! -z $(grep -i samba ${NMAPA}) ]]
then enum4linux -d ${IP} | tee "${IP}/enum4linux_results"
fi

if [[ ! -z $(grep -i '111/tcp' ${NMAPA}) ]]
then
echo "RPCINFO:"
rpcinfo $IP | tee "${IP}/rpcinfo_results"
fi

nmap -sU -Pn $IP | tee "${IP}/nmap_udp"

done
