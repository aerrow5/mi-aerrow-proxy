#!/bin/sh

# Do we need to register an account?
#quickstart=0
test -f /var/lib/acme/conf/target || quickstart=1
test -d /var/lib/acme/conf || mkdir -p /var/lib/acme/conf

email=$(mdata-get system:acme_email)

cat > /var/lib/acme/conf/responses <<EOF
"acme-enter-email": "$email"
"acme-agreement:https://letsencrypt.org/documents/LE-SA-v1.2-November-15-2017.pdf": true
"acmetool-quickstart-choose-server": https://acme-v01.api.letsencrypt.org/directory
"acmetool-quickstart-choose-method": proxy
"acmetool-quickstart-complete": true
"acmetool-quickstart-install-cronjob": true
"acmetool-quickstart-install-haproxy-script": true
"acmetool-quickstart-install-redirector-systemd": false
"acmetool-quickstart-key-type": rsa
"acmetool-quickstart-rsa-key-size": 2048
"acmetool-quickstart-ecdsa-curve": nistp256
EOF

#cat > /srv/mail/ssl/acme/conf/perm <<EOF
#keys 0640 0710 0 6
#EOF

# Do quickstart to register an account
if [ $quickstart -eq 1 ]; then
    /opt/local/bin/acmetool quickstart --batch
fi

echo '44 7 * * 0 /opt/local/bin/acmetool --xlog.severity=debug > /var/log/acmetool.log 2>&1' >> /var/spool/cron/crontabs/root

# Request the primary hostnames
#hostname=$(mdata-get sdc:hostname).$(mdata-get sdc:dns_domain)
# You need to manually run this:
#/opt/local/bin/acmetool want <host>
