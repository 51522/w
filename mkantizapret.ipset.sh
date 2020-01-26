#!/bin/sh

logger "start update of antizapret"
domains=/tmp/domains.$$
dnsmasqcfg=/etc/storage/antizapret.dnsmasq
dnsmasqtmp=$dnsmasqcfg.$$
iplist=/tmp/iplist.$$
ipsetip=tor-ip

escape(){
    rm -f $domains $iplist $dnsmasqtmp
}
trap escape EXIT
touch $dnsmasqcfg

echo "check.torproject.org
rutracker.org
rutor.org
rutor.info
rutor.is
mega-tor.org
kinozal.tv
nnmclub.to
nnm-club.me
nnm-club.ws
tfile.me
tfile-home.org
tfile1.cc
megatfile.cc
megapeer.org
megapeer.ru
tapochek.net
tparser.org
tparser.me
rustorka.com
rustorka.net
uniongang.tv
fast-torrent.ru
hdrezka.download
720-hd-online.com
1001kniga.download
1080hd-film.online
ace-tv.ru
adultmult.org
aiomp3.cc
alexfilm.org
allfon.tv
baraban.tv
cinemana.ru
coldfilm.ru
cwer.ru
ereko.tv
fan-tv.ru
fast-film.ru
film4ik.tv
film1080.ru
film-hd.org
film-online.org
filmhd1080.net
filmhd1080.online
filmi720hd.net
football2.ru
footballobzzor.ru
fost-torrent.org
foxi.tv
funtik.tv
gmp3.ru
goodmp3.top
goodmuz.ru
hd-serial.net
hd-videobox1.ru
hd.zfilm.cc
hdrezko.ru
hdtv-club.com
hdvideobox.net
hdzavr.com
ipleer.top
ivbox.me
kinoclub.me
kinogo.by
kinogo-go.com
livefootball.su
lost-film-hd.world
lux-film.net
multik.me
zvukof.top
rezka.ag
hdrezka.ag
hdrezka.me
hdrezka.tv
filmix.co
filmix.cc
filmix.net
filmix.me
seasonvar.ru
kinozoro.net
all-ebooks.com
audiobooks.pw
fb2-books.ru
google.lib.rus.ec
lib.rus.ec
flibusta.is
flibs.me
flisland.net
flibusta.site
7-zip.org
edem.tv
lurkmore.co
4pna.com
2019.vote
api.telegram.org
telegram.org
tdesktop.com
tdesktop.org
tdesktop.info
tdesktop.net
telesco.pe
telegram.dog
telegram.me
t.me
telegra.ph
web.telegram.org
desktop.telegram.org
updates.tdesktop.com
venus.web.telegram.org
flora.web.telegram.org
vesta.web.telegram.org
pluto.web.telegram.org
aurora.web.telegram.org" >$domains || exit

modprobe ip_set_hash_ip
modprobe xt_set
ipset create tor iphash 2>/dev/null
ipset create $ipsetip iphash 2>/dev/null
ipset create $ipsetip-tmp iphash 2>/dev/null

# Список IP адресов
echo "flush $ipsetip-tmp" >$iplist
cat $domains | grep "^\([[:digit:]]\{1,3\}\.\)\{3\}[[:digit:]]\{1,3\}$" | while read domain
do
    echo "add $ipsetip-tmp $domain"
done >>$iplist
echo "swap $ipsetip-tmp $ipsetip
flush $ipsetip-tmp" >>$iplist
cat $iplist | ipset restore
rm -f $iplist

# Список доменов для dnsmasq
echo "ipset=/onion/tor" >$dnsmasqtmp
cat $domains  | grep -v -e "^\([[:digit:]]\{1,3\}\.\)\{3\}[[:digit:]]\{1,3\}$" | grep -e "^[a-z0-9\.-]\+$" | sed 's/^\*\.//' | while read domain
do
    echo "ipset=/$domain/tor"
done >>$dnsmasqcfg.$$
mv -f $dnsmasqtmp $dnsmasqcfg
restart_dhcpd
restart_firewall
logger "update antizapret was finished"
