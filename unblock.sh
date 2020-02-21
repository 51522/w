#!/bin/sh

logger "start update of unblock"

domains=/tmp/domains.$$
dnsmasqcfg=/tmp/unblock.dnsmasq
dnsmasqtmp=$dnsmasqcfg.$$

escape(){
    rm -f $domains $dnsmasqtmp
}
trap escape EXIT
touch $dnsmasqcfg

cat /dev/null > $domains

echo "# Tor check
check.torproject.org

# Tutanota
tutanota.ru
w1.tutanota.de
w2.tutanota.de
w3.tutanota.de
w4.tutanota.de
tutanota.de
tutanota.com
mail.tutanota.com
mail.tutanota.de
2a02:790:1:d::100:164
81.3.6.160
81.3.6.162
81.3.6.163
81.3.6.164
81.3.6.165
134.249.148.16
188.40.109.72

# Protonmail
api.protonmail.ch
protonmail.com
www.protonmail.com
mail.protonmail.com
185.70.41.130
18.195.178.81
185.70.40.189
185.70.40.189
185.70.40.182
185.70.40.182

# Торрент-трекеры
rutracker.org
rutor.org
rutor.info
rutor.is
mega-tor.org
kinozal.tv
lostfilm.tv
novafilm.tv
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
waffles.ch

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
kinogo.by
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
aurora.web.telegram.org
149.154.160.0/20
91.108.4.0/22
91.108.8.0/22
91.108.12.0/22
91.108.16.0/22
91.108.56.0/22
91.223.123.154
109.239.140.0/24
67.198.55.0/24
2001:67c:4e8:1033:6:100:0:a
2001:67c:4e8:1033:5:100:0:a
2001:67c:4e8:1033:3:100:0:a
2001:67c:4e8:1033:2:100:0:a
2001:67c:4e8:1029:1:0:439:131
2001:67c:4e8:1029::439:31" >> $domains || exit

ipset flush unblock

i_wait_counter=0;
until [ $i_wait_counter -ge 5 ]
do
  i_wait_counter=$(( $i_wait_counter + 1 ))
  if ( ping -c1 -W 5 1.1.1.1 >/dev/null ); then
    #to break from cycle when got internet connection
    i_wait_counter=6
  else
    logger "waiting of internet connection ($i_wait_counter try of 5)..."
    if [ $i_wait_counter -lt 5 ]; then
      sleep 10
    fi
  fi
done

if [ $i_wait_counter -eq 6 ]; then
# internet is on

  while read domain || [ -n "$domain" ]; do
    [ -z "$domain" ] && continue
    [ "${domain:0:1}" = "#" ] && continue
    cidr=$(echo $domain | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/[0-9]{1,2}')

    if [ ! -z "$cidr" ]; then
      ipset -exist add unblock $cidr
      continue
    fi
    
    range=$(echo $domain | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}-[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')

    if [ ! -z "$range" ]; then
      ipset -exist add unblock $range
      continue
    fi
    
    addr=$(echo $domain | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')

    if [ ! -z "$addr" ]; then
      ipset -exist add unblock $addr
      continue
    fi
    
    nslookup $domain 127.0.0.1:65053 | grep -v '127.0.0.1' | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | awk '{system("ipset -exist add unblock "$1)}'
  done < $domains || exit
else
  logger "no internet connection"
fi

cat /dev/null > $dnsmasqcfg

while read domain || [ -n "$domain" ]; do
  [ -z "$domain" ] && continue
  [ "${domain:0:1}" = "#" ] && continue
  echo $domain | grep -Eq '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' && continue
  echo "ipset=/$domain/unblock" >> $dnsmasqtmp
done < $domains || exit
mv -f $dnsmasqtmp $dnsmasqcfg
echo "ipset=/onion/unblock" >> $dnsmasqcfg
echo "server=/onion/127.0.0.1#9053" >> $dnsmasqcfg
restart_dhcpd
restart_firewall
logger "update of unblock was finished"
