#!/bin/bash
pwd=$PWD 

url=$1 


if [ ! -d "$pwd/$url" ];then
mkdir $pwd/$url
fi
if [ ! -d "$pwd/$url/recon" ];then
mkdir $pwd/$url/recon
fi

if [ ! -d "$pwd/$url/recon/potential_takeovers" ];then
mkdir $pwd/$url/recon/potential_takeovers
fi
if [ ! -d "$pwd/$url/recon/wayback" ];then
mkdir $pwd/$url/recon/wayback
fi
if [ ! -d "$pwd/$url/recon/wayback/params" ];then
mkdir $pwd/$url/recon/wayback/params
fi
if [ ! -d "$pwd/$url/recon/wayback/extensions" ];then
mkdir $pwd/$url/recon/wayback/extensions
fi
if [ ! -d "$pwd/$url/recon/whatweb" ];then
mkdir $pwd/$url/recon/whatweb
fi
if [ ! -d "$pwd/$url/recon/gowitness" ];then
mkdir $pwd/$url/recon/gowitness
fi


echo "[+] Harvesting subdomains with assetfinder..."
./assetfinder $url| grep '.'$url | sort -u | tee -a $pwd/$url/recon/assetfinder.txt

echo "[+] Harvesting subdomains with amass..."
amass enum -passive -d $url | tee -a $pwd/$url/recon/amass.txt

echo "[+] Harvesting subdomains with crt.sh ..."
python3 certsh.py -d $url | tee -a $pwd/$url/recon/crtsh.txt

echo "[+] Harvesting subdomains with sublist3r ..."

python3 ~/Sublist3r/sublist3r.py -d $url -o $pwd/$url/recon/sublist3r.txt

echo "[+] Combine all subdomains ..."
cat $pwd/$url/recon/*.txt >> $pwd/$url/recon/all.txt
cat $pwd/$url/recon/all.txt | sort -u | tee -a $pwd/$url/recon/finallist.txt

echo "Check for Alive..."
cat $pwd/$url/recon/finallist.txt $pwd/$url/recon/all.txt >> $pwd/$url/recon/listwithaltdns.txt
cat $pwd/$url/recon/listwithaltdns.txt | sort -u | tee -a $pwd/$url/recon/finalunique.txt
cat $pwd/$url/recon/finalunique.txt | sed 's/https\?:\/\///' | tee -a $pwd/$url/recon/removehttpsandhttp.txt
cat $pwd/$url/recon/removehttpsandhttp.txt | ./httprobe | tee -a $pwd/$url/recon/finalalive.txt
