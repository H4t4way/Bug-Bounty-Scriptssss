#!/bin/bash

GREEN="\033[1;32m"
RED="\033[0;31m"
RESET="\033[0m"

echo -e "${GREEN}                                         "
echo -e "      ______                                     "
echo -e "      |___ / _ ____   __                         "
echo -e "        |_ \| '_ \ \ / /                         "
echo -e "       ___) | | | \ V /                          "
echo -e "      |____/|_| |_|\_/  - by $RED@env-discord-channel$RESET "

sleep 2;
aquatone-discover -d $1
aquatone-scan -d $1 --ports huge
aquatone-takeover -d $1
mkdir $HOME/Recon/$1
python3 ~/tools/Sublist3r/sublist3r.py -d $1 -o $HOME/Recon/$1/$1.txt
cat $HOME/Recon/$1/$1.txt | httprobe > $HOME/Recon/$1/$1_live.txt
cat $HOME/Recon/$1/$1_live.txt $HOME/aquatone/$1/urls.txt | sort -u > $HOME/Recon/$1/final_urls.txt
cat $HOME/Recon/$1/final_urls.txt |sed 's/https\?:\/\///' > $HOME/Recon/$1/url.txt
nmap -iL $HOME/Recon/$1/url.txt -Pn -n -sn -oG $HOME/Recon/$1/resolved.txt
cat $HOME/Recon/$1/resolved.txt | grep ^Host | cut -d " " -f 2 > $HOME/Recon/$1/host.txt
masscan -iL $HOME/Recon/$1/host.txt -p 0-65535  -oX $HOME/Recon/$1/mass_output.xml --max-rate 100000
cat $HOME/Recon/$1/final_urls.txt | aquatone -out $HOME/Recon/$1/ -ports xlarge
gau $1 -subs > $HOME/Recon/$1/wayback_temp.txt
echo $1 | waybackurls >> $HOME/Recon/$1/wayback_temp.txt
cat wayback_temp.txt | uniq -u > wayback.txt
rm -r wayback_temp.txt
python3 ~/tools/dirsearch/dirsearch.py -L $HOME/Recon/$1/final_urls.txt -E -x 403 --plain-text-report=$HOME/Recon/$1/dirsearch.txt
echo -e "---+++++++++==============================+++++++++---"
