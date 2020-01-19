#!/bin/sh

echo Generated List 
cd /opt/etc/dnscrypt
python generate-domains-blacklist.py -i > blacklist.txt

echo Restart dnscrypt
/opt/etc/init.d/S09dnscrypt-proxy2 restart
