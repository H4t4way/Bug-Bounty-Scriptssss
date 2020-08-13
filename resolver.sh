#!/bin/bash

echo "                      _                 "
echo "  _ __ ___  ___  ___ | |_   _____ _ __  "
echo " | '__/ _ \/ __|/ _ \| \ \ / / _ \ '__| "
echo " | | |  __/\__ \ (_) | |\ V /  __/ |    "
echo " |_|  \___||___/\___/|_| \_/ \___|_|    "

mkdir -p ip_out
while read domain; do
   line=$(echo $domain | cut -f 3 -d "/")
   IP=$(dig +short $line | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | head -1)
   if [ -n "$IP" ]; then
        echo $IP
        echo "$IP" > ip_out/$line
        echo "$line : $IP " >> ip_out/index
        echo "$IP" >> ip_out/only_ip
   fi
done
