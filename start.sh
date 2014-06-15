#!/bin/bash

DOMAIN="172.16.158.30"

ADMIN_PASSWORD=`pwgen -c -n -1 12`
echo ejabberd admin password: $ADMIN_PASSWORD

sudo chown ejabberd:ejabberd /var/lib/ejabberd

if [ ! -f /etc/ssl/certificate.crt ]; then

  #Add SSL cert/pem for ejabberd
  openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=Pennsylvania/L=NA/O=Dis/CN=$DOMAIN" -keyout /etc/ejabberd/certificate.key  -out /etc/ejabberd/certificate.crt
  cat /etc/ejabberd/certificate.crt /etc/ejabberd/certificate.key > /etc/ejabberd/ejabberd.pem

  #Config for ejabberd
  sed -i -e"s/host\.name/$DOMAIN/g" /etc/ejabberd/ejabberd.cfg
  /usr/local/bin/supervisord
  sleep 10s
  ejabberdctl register admin $DOMAIN $ADMIN_PASSWORD
fi
/usr/local/bin/supervisord

tail -f /dev/null
