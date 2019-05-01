#!/usr/bin/with-contenv bash
set -e

#service crond start
#service rsyslog start

export NAME="${NAME:-p4depot}"

bash -x /usr/local/bin/setup-perforce.sh

sleep 2

exec /usr/bin/tail --pid=$(cat /var/run/p4d.$NAME.pid) -f "$DATAVOLUME/$NAME/logs/log"
