#!/bin/bash

echo "   _     ____  _____  "
echo "  (_)___/ ___||  ___| "
echo "  | / __\___ \| |_    "
echo "  | \__ \___) |  _|   "
echo " _/ |___/____/|_|     "
echo "|__/                  "

mkdir -p javascriptfiles
RED='\033[0;31m'
NC='\033[0m'
CUR_PATH=$(pwd)
while read domain; do
        printf "\n${RED}$domain${NC}\n"
        line=$(echo $domain | cut -f 3 -d "/")
        filename="javascriptfiles/$line"
        curl -s -X GET -L  $domain | grep -Eoi "src=\"[^>]+></script>" | cut -d '"' -f  2  >> "$filename"
        echo "$domain   " >> javascriptfiles/index

done
