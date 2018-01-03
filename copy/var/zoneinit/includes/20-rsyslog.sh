#!/bin/sh

# Create extra logfile folder for proftpd:
test -d /var/log/haproxy || mkdir -p /var/log/haproxy

# Use logadm for rotate the logfiles
logadm -w /var/log/haproxy/haproxy.log -p 1d -C 10 -N -m 640 -c
logadm -w /var/log/haproxy/access.log -p 1d -C 10 -N -m 640 -c

