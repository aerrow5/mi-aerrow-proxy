#!/bin/sh

# setup log rotating:
logadm -w /var/log/nginx/access.default.site.log -p 1d -C 10 -N -o www -g www -m 640 -c
logadm -w /var/log/nginx/access.log -p 1d -C 10 -N -o root -g root -m 640 -c
logadm -w /var/log/nginx/error.log -p 1d -C 10 -N -o root -g root -m 640 -c

logadm -w /var/log/munin/munin-node.log -p 1d -C 10 -N -o root -g root -m 640 -c

/usr/sbin/svcadm enable -r svc:/pkgsrc/nginx:default
