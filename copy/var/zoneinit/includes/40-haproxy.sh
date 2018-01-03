#!/bin/sh

# Create dummy certificate:
# Generate all keys and cefiticates in /www/cert/ directory
openssl genrsa -out /www/cert/dummy.key 2048
openssl req -new -key /www/cert/dummy.key -out /www/cert/dummy.csr -subj "/C=GB/L=London/O=Company Ltd/CN=haproxy"
openssl x509 -req -days 3650 -in /www/cert/dummy.csr -signkey /www/cert/dummy.key -out /www/cert/dummy.crt

cat /www/cert/dummy.crt /www/cert/dummy.key > /www/cert/dummy.pem

# Startup haproxy:
/usr/sbin/svcadm enable svc:/pkgsrc/haproxy:default
