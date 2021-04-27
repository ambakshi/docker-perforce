#!/bin/bash
set -e

[ $# -gt 0 ] || set -- /lib/systemd/systemd --system --log-target=journal

if test -e /run/secrets/p4passwd; then
    export P4PASSWD=$(cat /run/secrets/p4passwd)
fi
if [[ "$1" =~ systemd ]]; then
    export NAME="${NAME:-p4depot}"
    if [ "$CASE_INSENSITIVE" = 1 ]; then
        export P4EXTRAFLAGS="$P4EXTRAFLAGS -C1"
    fi
    (cat /etc/default/perforce; env | grep -E '^(P4|SWARM|NAME)') > /etc/default/perforce.tmp
    mv /etc/default/perforce.tmp /etc/default/perforce
    bash /usr/local/bin/setup-perforce.sh
    sleep 2
fi
exec "$@"
