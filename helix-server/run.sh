#!/bin/bash
set -e
export NAME="${NAME:-p4depot}"
export DATAVOLUME="${DATAVOLUME:-/data}"

/usr/local/bin/setup-perforce.sh

sleep 2

exec /usr/bin/tail --pid=$(cat /var/run/p4d.$NAME.pid) -f "$DATAVOLUME/$NAME/log"
