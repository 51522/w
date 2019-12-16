#!/bin/sh

domains=/tmp/domains.$$
dnsmasqcfg=/tmp/unblock.dnsmasq
dnsmasqtmp=$dnsmasqcfg.$$

escape(){
    rm -f $domains $dnsmasqtmp
}
trap escape EXIT
echo "# Tor check
check.torproject.org
# Торрент-трекеры
rutracker.org
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
# Каталоги медиаконтента для программ
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
# Книги
all-ebooks.com
audiobooks.pw
fb2-books.ru
google.lib.rus.ec
lib.rus.ec
flibusta.is
flibs.me
flisland.net
flibusta.site
# Разное
7-zip.org
edem.tv
lurkmore.co
4pna.com
2019.vote
# Телеграм
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
aurora.web.telegram.org" >> $domains || exit
modprobe ip_set_hash_ip
modprobe ip_set_hash_net
modprobe xt_set
ipset create unblock hash:net
ipset flush unblock
while read line || [ -n "$line" ]; do
  [ -z "$line" ] && continue
  [ "${line:0:1}" = "#" ] && continue
  cidr=$(echo $line | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/[0-9]{1,2}')
  [ ! -z "$cidr" ] && continue
  ipset -exist add unblock $cidr
  range=$(echo $line | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}-[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
  [ ! -z "$range" ] && continue
  ipset -exist add unblock $range 
  addr=$(echo $line | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
  [ ! -z "$addr" ] && continue
  ipset -exist add unblock $addr
done < $domains || exit
while read line || [ -n "$line" ]; do
  [ -z "$line" ] && continue
  [ "${line:0:1}" = "#" ] && continue
  echo $line | grep -Eq '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' && continue
  echo "ipset=/$line/unblock" >> $dnsmasqtmp
done < $domains || exit
echo "ipset=/onion/unblock" >> $dnsmasqtmp
echo "server=/onion/127.0.0.1#9053" >> $dnsmasqtmp
mv -f $dnsmasqtmp $dnsmasqcfg
restart_dhcpd
restart_firewall