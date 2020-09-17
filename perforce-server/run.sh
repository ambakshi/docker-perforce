#!/bin/bash
set -ex

if [ $# -eq 0 ] || [ "$1" = /usr/sbin/init ]; then
    export NAME="${NAME:-p4depot}"
    bash /usr/local/bin/setup-perforce.sh
    sleep 2
    exec /usr/sbin/init
fi

# Assume user just wants to run an ad-hoc command like bash
exec "$@"
