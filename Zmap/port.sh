#!/bin/bash

# 定义要扫描的端口列表
ports=(23 80 107 110 135 143 162 306 443 445 465 502 623 631 953 953 995 1021 1121 1321 1433 1521 1723 1883 3389 3495 5432 5672 5900 6379 6443 7001 7547 8080 8443 8888 20000 27017)

# 对每个端口执行 zmap 扫描
for port in "${ports[@]}"
do
    echo "Scanning port $port..."
    zmap -p $port --output-filter="success = 1 && repeat = 0" -f "saddr,daddr,sport,dport,seqnum,acknum,window" -O json --source-ip=192.168.19.128 -w ips.txt >"port_$port.json"
    sleep 60
done