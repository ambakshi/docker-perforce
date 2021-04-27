#!/bin/bash

set -e

export P4ROOT="/data/PerforceSample"
export P4PORT="1666"

if [ ! -e "$P4ROOT" ]; then
    tar zxf /root/sampledepot.tar.gz -C /data
    p4d -r $P4ROOT -jr $P4ROOT/checkpoint
    p4d -r $P4ROOT -xu
fi
if [ ! -e "$P4ROOT/.changepass" ]; then
    p4d -r $P4ROOT -J off --daemonsafe --pid-file=/run/p4d.pid
    until p4 info 2>/dev/null; do
        sleep 1
    done
    # Change bruno's password from empty string to bruno, because
    # swarm doesn't like empty strings
    p4 -u bruno -p '' passwd -O '' -P 'bruno'
    kill -TERM `cat /run/p4d.pid`
    sleep 1
    while p4 info >/dev/null 2>&1; do
        sleep 1
    done
    rm -f /run/p4d.pid
    touch "$P4ROOT/.changepass"
fi
chmod 0700 $P4ROOT
chown -R perforce:perforce $P4ROOT

if test -e /run/secrets/p4passwd; then
    export P4PASSWD=$(cat /run/secrets/p4passwd)
fi
echo "P4ROOT=$P4ROOT" >> /etc/default/perforce
echo "P4PASSWD=$P4PASSWD" >> /etc/default/perforce
echo "P4EXTRAFLAGS=$P4EXTRAFLAGS" >> /etc/default/perforce


exec "$@"
