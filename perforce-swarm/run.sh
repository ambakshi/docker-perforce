#!/bin/bash
# ftp://ftp.perforce.com/perforce/tools/sampledepot.tar.gz
set -e

service rsyslog start
service crond start

if [ ! -e /var/run/configure-swarm ]; then
    /opt/perforce/swarm/sbin/configure-swarm.sh \
        -p "${P4PORT:-perforce:1666}" -u "${P4USER:-swarm}" -w "${P4PASSWD:-swarm}" \
        -H $HOSTNAME -e "${MXHOST:-localhost}"
    touch /var/run/configure-swarm
fi
echo '<?php phpinfo(); ?>' > /opt/perforce/swarm/public/phpinfo.php
for i in `seq 20`; do
    test -e /var/run/httpd/httpd.pid && break
    sleep 2
done
exec tail --pid=$(< /var/run/httpd/httpd.pid) -F /var/log/httpd/*
