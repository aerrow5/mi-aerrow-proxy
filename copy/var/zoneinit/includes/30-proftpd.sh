#!/bin/sh

# Create extra logfile folder for proftpd:
test -d /var/log/proftpd || mkdir -p /var/log/proftpd
test -d /opt/local/etc/proftpd/authorized_keys || mkdir -p /opt/local/etc/proftpd/authorized_keys
test -d /opt/local/etc/proftpd/ssh || mkdir -p /opt/local/etc/proftpd/ssh

# Create dummy user files and set right ownership:
touch /opt/local/etc/proftpd/blacklist.dat
touch /opt/local/etc/proftpd/ftp.{users,groups}
chown nobody:nobody /opt/local/etc/proftpd/ftp.{users,groups}
chmod 600 /opt/local/etc/proftpd/ftp.{users,groups}

# Create certificates:
ssh-keygen -q -f /opt/local/etc/proftpd/ssh/ssh_host_rsa_key -N '' -t rsa
ssh-keygen -q -f /opt/local/etc/proftpd/ssh/ssh_host_dsa_key -N '' -t dsa
openssl dhparam -out /opt/local/etc/proftpd/dhparams.pem 2048

# Modify proftpd configuration file
# ....

# Use logadm for rotate the logfiles
logadm -w /var/log/proftpd/proftpd.log -p 1d -C 10 -N -m 640 -c
logadm -w /var/log/proftpd/xfer.log -p 1d -C 10 -N -m 640 -c
logadm -w /var/log/proftpd/sftp.log -p 1d -C 10 -N -m 640 -c
logadm -w /var/log/proftpd/access.log -p 1d -C 10 -N -m 640 -c
logadm -w /var/log/proftpd/auth.log -p 1d -C 10 -N -m 640 -c

# Enable proftpd service
/usr/sbin/svcadm enable svc:/pkgsrc/proftpd:default
