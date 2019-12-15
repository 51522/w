#!/bin/sh

cat /dev/null > /tmp/hosts/block
echo List Generation

URLS="http://adaway.org/hosts.txt \
https://hosts-file.net/.%5Cad_servers.txt \
https://mirror.cedia.org.ec/malwaredomains/domains.hosts \
http://winhelp2002.mvps.org/hosts.txt \
https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext \
https://www.malwaredomainlist.com/hostslist/hosts.txt \
https://zeustracker.abuse.ch/blocklist.php?download=hostfile \
https://gitlab.com/ZeroDot1/CoinBlockerLists/raw/master/hosts \
https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt"

wget -q -O- $URLS | grep -v "^#" | cut -d "#" -f 1 | sed 's/127\.0\.0\.1/0\.0\.0\.0/' | grep "^0.0.0.0" | sed 's/  */ /g' | sed 's/\t/ /g' |sed 's/\r//' | cut -d " " -f 1,2 | tr A-Z a-z | sort | uniq > /tmp/hosts/block

echo Clear List

cd /tmp/hosts
sed -i '/localhost/d' block
sed -i '/localhost.localdomain/d' block
sed -i '/ad.admitad.com/d' block
sed -i '/api.cc.skype.com/d' block
sed -i '/api.mcr.skype.com/d' block
sed -i '/api.skype.com/d' block
sed -i '/avatar.skype.com/d' block
sed -i '/b.config.skype.com/d' block
sed -i '/client-s.gateway.messenger.live.com/d' block
sed -i '/contacts.skype.com/d' block
sed -i '/dev.microsofttranslator.com/d' block
sed -i '/diagnostics.support.microsoft.akadns.net/d' block
sed -i '/diagnostics.support.microsoft.com/d' block
sed -i '/edge.skype.com/d' block
sed -i '/m.hotmail.com/d' block
sed -i '/mobile.pipe.aria.microsoft.com/d' block
sed -i '/msftncsi.com/d' block
sed -i '/msg.skype.com/d' block
sed -i '/next-services.apps.microsoft.com/d' block
sed -i '/nexus.officeapps.live.com/d' block
sed -i '/profile.skype.com/d' block
sed -i '/s.gateway.messenger.live.com/d' block
sed -i '/skype.net/d' block
sed -i '/ui.skype.com/d' block
sed -i '/www.msftncsi.com/d' block
sed -i '/stat.online.sberbank.ru/d' block
sed -i '/s.click.aliexpress.com/d' block
sed -i '/yandex.ru/d' block
sed -i '/yastatic.net/d' block
sed -i '/r.mail.ru/d' block
sed -i '/c.fa.jd.com/d' block
sed -i '/whale.jd.com/d' block
sed -i '/saturn.jd.com/d' block
sed -i '/t.paypal.com/d' block
sed -i '/b.stats.paypal.com/d' block
sed -i '/l.deals.ebay.com/d' block
sed -i '/stats.ebay.com/d' block
sed -i '/www.ojrq.net/d' block
sed -i '/letyshops.com/d' block
sed -i '/rutracker.org/d' block
sed -i '/nnm-club.me/d' block
sed -i '/nnm-club.ws/d' block
sed -i '/nnmclub.to/d' block
sed -i '/nnm-club.lib/d' block
sed -i '/connectivitycheck.gstatic.com/d' block
sed -i '/badges.instagram.com/d' block
sed -i '/graph.instagram.com/d' block
sed -i '/au.download.windowsupdate.com/d' block
sed -i '/au.v4.download.windowsupdate.com/d' block
sed -i '/bg.v4.a.dl.ws.microsoft.com/d' block
sed -i '/bg.v4.emdl.ws.microsoft.com/d' block
sed -i '/bg1.v4.a.dl.ws.microsoft.com/d' block
sed -i '/bg1.v4.emdl.ws.microsoft.com/d' block
sed -i '/bg2.v4.a.dl.ws.microsoft.com/d' block
sed -i '/bg2.v4.emdl.ws.microsoft.com/d' block
sed -i '/bg3.v4.a.dl.ws.microsoft.com/d' block
sed -i '/bg3.v4.emdl.ws.microsoft.com/d' block
sed -i '/bg4.v4.a.dl.ws.microsoft.com/d' block
sed -i '/bg4.v4.emdl.ws.microsoft.com/d' block
sed -i '/bg5.v4.a.dl.ws.microsoft.com/d' block
sed -i '/bg5.v4.emdl.ws.microsoft.com/d' block
sed -i '/ctldl.windowsupdate.com/d' block
sed -i '/displaycatalog.mp.microsoft.com/d' block
sed -i '/dl.delivery.mp.microsoft.com/d' block
sed -i '/download.microsoft.com/d' block
sed -i '/download.windowsupdate.com/d' block
sed -i '/ds.download.windowsupdate.com/d' block
sed -i '/emdl.ws.microsoft.com/d' block
sed -i '/fe2.update.microsoft.com/d' block
sed -i '/fe2.update.microsoft.com.akadns.net/d' block
sed -i '/fe2.wq.microsoft.com/d' block
sed -i '/fe2.ws.microsoft.com/d' block
sed -i '/fe3.delivery.dsp.mp.microsoft.com.nsatc.net/d' block
sed -i '/fe3.delivery.mp.microsoft.com/d' block
sed -i '/fg.ds.b1.download.windowsupdate.com/d' block
sed -i '/fg.v4.download.windowsupdate.com/d' block
sed -i '/microsoftwindowsupdate.net/d' block
sed -i '/sls.update.microsoft.com/d' block
sed -i '/sls.update.microsoft.com.akadns.net/d' block
sed -i '/statsfe1.ws.microsoft.com/d' block
sed -i '/statsfe2.update.microsoft.com.akadns.net/d' block
sed -i '/statsfe2.ws.microsoft.com/d' block
sed -i '/tlu.dl.delivery.mp.microsoft.com/d' block
sed -i '/v4.download.windowsupdate.com/d' block
sed -i '/windowsupdate.com/d' block
sed -i '/windowupdate.org/d' block
sed -i '/www.download.windowsupdate.com/d' block
sed -i '/alipromo.com/d' block
sed -i '/rutrk.org/d' block
sed -i '/adsrv.ea.com/d' block

# Clear Bad Domain
sed -i '/www.turkishạirlines.com/d' block
sed -i '/ɢoogle.com/d' block
sed -i '/secret.ɢoogle.com/d' block
sed -i '/myètherwället.com/d' block
sed -i '/mÿethèrwallét.com/d' block

echo Restart dnsmasq
killall -q dnsmasq
/usr/sbin/dnsmasq
