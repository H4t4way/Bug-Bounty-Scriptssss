#!/bin/bash

echo "            _                         "
echo "  ___ _   _| |__   _____   _____ _ __ "
echo " / __| | | | '_ \ / _ \ \ / / _ \ '__|"
echo " \__ \ |_| | |_) | (_) \ V /  __/ |   "
echo " |___/\__,_|_.__/ \___/ \_/ \___|_|   "

domain=$1
while read line; do
   app=$(echo $line | cut -f 3 -d "/")
   alias=$(host -t CNAME $app | grep 'alias for' | awk '{print $NF}' )
   echo $alias | xargs -n1 dig @1.1.1.1 | grep -A10 NXDOMAIN &>/dev/null
   codice=$(echo "$?")
        if [ $codice == 0 ]; then
                echo "$line :  possibile takeover"
                echo "$line : $alias " >> takeover
        fi
   echo "$line  $alias" >>  domains
done
sort -u domains >> alias
rm -r  domains
