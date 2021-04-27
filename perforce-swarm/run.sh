#!/bin/bash

set -e

if [ ! -e /run/lock/configure-swarm ]; then
    if test -e /run/secrets/swarm_passwd; then
        export SWARM_PASSWD=$(cat /run/secrets/swarm_passwd)
    fi
    if test -e /run/secrets/p4passwd; then
        export P4PASSWD=$(cat /run/secrets/p4passwd)
    fi
    until nc -w1 ${P4PORT/:/ }; do
        echo "waiting for perforce port be up at ${P4PORT/:/ }"
        sleep 1
    done
    until p4 info 2>/dev/null; do
        echo "waiting for perforce info be up at ${P4PORT/:/ }"
        sleep 1
    done
    sleep 5
    if ! test -e /run/lock/configure-swarm; then
        /opt/perforce/swarm/sbin/configure-swarm.sh \
            -n \
            -p "$P4PORT" -u "$SWARM_USER" -w "$SWARM_PASSWD" \
            -U "$P4USER" -W "$P4PASSWD" \
            -c -g \
            -H "$HOSTNAME" -e "$MXHOST"
        touch /run/lock/configure-swarm
    fi
    systemctl enable apache2
    apachectl stop || true
    apachectl stop || true

fi

exec /lib/systemd/systemd --system --log-target=journal
