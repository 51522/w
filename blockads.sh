#!/bin/sh

logger "download blockads list"
cat /dev/null > /tmp/hosts
echo List Generation

URLS="https://raw.githubusercontent.com/51522/w/master/privacy-hosts \
https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt \
https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/AdguardDNS.txt \
https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts \
https://gitlab.com/ZeroDot1/CoinBlockerLists/raw/master/hosts \
http://adaway.org/hosts.txt"

wget -q -O- $URLS | grep -v "^#" | cut -d "#" -f 1 | sed 's/127\.0\.0\.1/0\.0\.0\.0/' | grep "^0.0.0.0" | sed 's/  */ /g' | sed 's/\t/ /g' |sed 's/\r//' | cut -d " " -f 1,2 | tr A-Z a-z | sort | uniq > /tmp/hosts

echo Clear List

cd /tmp
sed -i '/localhost/d' hosts
sed -i '/localhost.localdomain/d' hosts
sed -i '/ad.admitad.com/d' hosts
sed -i '/s.click.aliexpress.com/d' hosts
sed -i '/yandex.ru/d' hosts
sed -i '/yastatic.net/d' hosts
sed -i '/alipromo.com/d' hosts
sed -i '/rutrk.org/d' hosts

# Clear Bad Domain
sed -i '/www.turkishạirlines.com/d' hosts
sed -i '/ɢoogle.com/d' hosts
sed -i '/secret.ɢoogle.com/d' hosts
sed -i '/myètherwället.com/d' hosts
sed -i '/mÿethèrwallét.com/d' hosts
sed -i '/банрек.рус/d' hosts
sed -i '/укроп-петрушка-огурцы.рф/d' hosts
sed -i '/хельга.рф/d' hosts
sed -i '/эхх.рф/d' hosts

echo Restart dnsmasq
killall -q dnsmasq
/usr/sbin/dnsmasq
logger "update blockads list was finished"
