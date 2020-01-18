#!/bin/sh

cat /dev/null > /opt/etc/hosts
echo List Generation

URLS="https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt \
https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts \
https://gitlab.com/ZeroDot1/CoinBlockerLists/raw/master/hosts \
http://adaway.org/hosts.txt \
https://hosts-file.net/.%5Cad_servers.txt \
https://mirror.cedia.org.ec/malwaredomains/domains.hosts \
http://winhelp2002.mvps.org/hosts.txt \
https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext \
https://www.malwaredomainlist.com/hostslist/hosts.txt"

wget -q -O- $URLS | grep -v "^#" | cut -d "#" -f 1 | sed 's/127\.0\.0\.1/0\.0\.0\.0/' | grep "^0.0.0.0" | sed 's/  */ /g' | sed 's/\t/ /g' |sed 's/\r//' | cut -d " " -f 1,2 | tr A-Z a-z | sort | uniq > /opt/etc/hosts

echo Clear List

cd /opt/etc
sed -i '/localhost/d' hosts
sed -i '/localhost.localdomain/d' hosts
sed -i '/ad.admitad.com/d' hosts
sed -i '/api.cc.skype.com/d' hosts
sed -i '/api.mcr.skype.com/d' hosts
sed -i '/api.skype.com/d' hosts
sed -i '/avatar.skype.com/d' hosts
sed -i '/b.config.skype.com/d' hosts
sed -i '/client-s.gateway.messenger.live.com/d' hosts
sed -i '/contacts.skype.com/d' hosts
sed -i '/dev.microsofttranslator.com/d' hosts
sed -i '/diagnostics.support.microsoft.akadns.net/d' hosts
sed -i '/diagnostics.support.microsoft.com/d' hosts
sed -i '/edge.skype.com/d' hosts
sed -i '/m.hotmail.com/d' hosts
sed -i '/mobile.pipe.aria.microsoft.com/d' hosts
sed -i '/msftncsi.com/d' hosts
sed -i '/msg.skype.com/d' hosts
sed -i '/next-services.apps.microsoft.com/d' hosts
sed -i '/nexus.officeapps.live.com/d' hosts
sed -i '/profile.skype.com/d' hosts
sed -i '/s.gateway.messenger.live.com/d' hosts
sed -i '/skype.net/d' hosts
sed -i '/ui.skype.com/d' hosts
sed -i '/www.msftncsi.com/d' hosts
sed -i '/stat.online.sberbank.ru/d' hosts
sed -i '/s.click.aliexpress.com/d' hosts
sed -i '/yandex.ru/d' hosts
sed -i '/yastatic.net/d' hosts
sed -i '/r.mail.ru/d' hosts
sed -i '/c.fa.jd.com/d' hosts
sed -i '/whale.jd.com/d' hosts
sed -i '/saturn.jd.com/d' hosts
sed -i '/t.paypal.com/d' hosts
sed -i '/b.stats.paypal.com/d' hosts
sed -i '/l.deals.ebay.com/d' hosts
sed -i '/stats.ebay.com/d' hosts
sed -i '/www.ojrq.net/d' hosts
sed -i '/letyshops.com/d' hosts
sed -i '/rutracker.org/d' hosts
sed -i '/nnm-club.me/d' hosts
sed -i '/nnm-club.ws/d' hosts
sed -i '/nnmclub.to/d' hosts
sed -i '/nnm-club.lib/d' hosts
sed -i '/connectivitycheck.gstatic.com/d' hosts
sed -i '/badges.instagram.com/d' hosts
sed -i '/graph.instagram.com/d' hosts
sed -i '/au.download.windowsupdate.com/d' hosts
sed -i '/au.v4.download.windowsupdate.com/d' hosts
sed -i '/bg.v4.a.dl.ws.microsoft.com/d' hosts
sed -i '/bg.v4.emdl.ws.microsoft.com/d' hosts
sed -i '/bg1.v4.a.dl.ws.microsoft.com/d' hosts
sed -i '/bg1.v4.emdl.ws.microsoft.com/d' hosts
sed -i '/bg2.v4.a.dl.ws.microsoft.com/d' hosts
sed -i '/bg2.v4.emdl.ws.microsoft.com/d' hosts
sed -i '/bg3.v4.a.dl.ws.microsoft.com/d' hosts
sed -i '/bg3.v4.emdl.ws.microsoft.com/d' hosts
sed -i '/bg4.v4.a.dl.ws.microsoft.com/d' hosts
sed -i '/bg4.v4.emdl.ws.microsoft.com/d' hosts
sed -i '/bg5.v4.a.dl.ws.microsoft.com/d' hosts
sed -i '/bg5.v4.emdl.ws.microsoft.com/d' hosts
sed -i '/ctldl.windowsupdate.com/d' hosts
sed -i '/displaycatalog.mp.microsoft.com/d' hosts
sed -i '/dl.delivery.mp.microsoft.com/d' hosts
sed -i '/download.microsoft.com/d' hosts
sed -i '/download.windowsupdate.com/d' hosts
sed -i '/ds.download.windowsupdate.com/d' hosts
sed -i '/emdl.ws.microsoft.com/d' hosts
sed -i '/fe2.update.microsoft.com/d' hosts
sed -i '/fe2.update.microsoft.com.akadns.net/d' hosts
sed -i '/fe2.wq.microsoft.com/d' hosts
sed -i '/fe2.ws.microsoft.com/d' hosts
sed -i '/fe3.delivery.dsp.mp.microsoft.com.nsatc.net/d' hosts
sed -i '/fe3.delivery.mp.microsoft.com/d' hosts
sed -i '/fg.ds.b1.download.windowsupdate.com/d' hosts
sed -i '/fg.v4.download.windowsupdate.com/d' hosts
sed -i '/microsoftwindowsupdate.net/d' hosts
sed -i '/sls.update.microsoft.com/d' hosts
sed -i '/sls.update.microsoft.com.akadns.net/d' hosts
sed -i '/statsfe1.ws.microsoft.com/d' hosts
sed -i '/statsfe2.update.microsoft.com.akadns.net/d' hosts
sed -i '/statsfe2.ws.microsoft.com/d' hosts
sed -i '/tlu.dl.delivery.mp.microsoft.com/d' hosts
sed -i '/v4.download.windowsupdate.com/d' hosts
sed -i '/windowsupdate.com/d' hosts
sed -i '/windowupdate.org/d' hosts
sed -i '/www.download.windowsupdate.com/d' hosts
sed -i '/alipromo.com/d' hosts
sed -i '/rutrk.org/d' hosts
sed -i '/adsrv.ea.com/d' hosts

# Clear Bad Domain
sed -i '/www.turkishạirlines.com/d' hosts
sed -i '/ɢoogle.com/d' hosts
sed -i '/secret.ɢoogle.com/d' hosts
sed -i '/myètherwället.com/d' hosts
sed -i '/mÿethèrwallét.com/d' hosts

echo Restart dnsmasq
killall -q dnsmasq
/usr/sbin/dnsmasq

