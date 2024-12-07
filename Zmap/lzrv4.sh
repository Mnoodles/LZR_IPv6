#!/bin/bash

declare -A site
site["23"]="telnet"
site["80"]="http"
site["107"]="siemens"
site["110"]="pop3"
site["135"]="mssql"
site["143"]="imaps"
site["162"]="snmp"
site["306"]="mysql"
site["443"]="https"
site["445"]="smb"
site["465"]="stmp"
site["502"]="Modbus"
site["623"]="smb"
site["631"]="lip"
site["953"]="dns"
site["995"]="pop3s"
site["1021"]="orel"
site["1121"]="mimikatz"
site["1321"]="orel"
site["1433"]="mssql"
site["1521"]="oracle"
site["1723"]="ppp"
site["1883"]="mqtt"
site["3389"]="rdp"
site["3495"]="smb"
site["5432"]="post"
site["5672"]="amqp"
site["5900"]="vnc"
site["6379"]="redis"
site["6443"]="kubernetes"
site["7001"]="https"
site["7547"]="http"
site["8080"]="http"
site["8443"]="ssl"
site["8888"]="ftp"
site["20000"]="ftp"
site["27017"]="mongodb"


for port in "${!site[@]}"
do
  sudo zmap -p $port --output-filter="success = 1 && repeat = 0" -f "saddr,daddr,sport,dport,seqnum,acknum,window" -O json --source-ip=192.168.19.128 -w Zmap/ips.txt|
  sudo ./lzr --handshakes ${site[$port]} -f "Zmap/LZRv4/$port.json" --sendInterface ens33
done