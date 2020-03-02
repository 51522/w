#!/bin/sh

logger "download msblock list"
cat /dev/null > /etc/storage/msblock
echo Download List
wget -q -O- https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt | grep -v "^#" | cut -d "#" -f 1 | sed 's/127\.0\.0\.1/0\.0\.0\.0/' | grep "^127.0.0.1" | sed 's/  */ /g' | sed 's/\t/ /g' |sed 's/\r//' | cut -d " " -f 1,2 | tr A-Z a-z | sort | uniq > /etc/storage/msblock

echo Generation Block List
echo Restart dnsmasq
killall -q dnsmasq
/usr/sbin/dnsmasq
logger "msblock list downloaded"
