#!/usr/bin/with-contenv bash

set -e

service rsyslog start
service crond start

export P4ROOT="/data/PerforceSample"
export P4PORT="1666"
export P4USER="p4admin"

if [ ! -e "$P4ROOT" ]; then
    tar zxf sampledepot.tar.gz -C /data
    p4d -r $P4ROOT -jr $P4ROOT/checkpoint
    p4d -r $P4ROOT -xu
fi
chown -R perforce:perforce $P4ROOT

exec runuser -l perforce -c "/opt/perforce/sbin/p4d -r $P4ROOT -p $P4PORT"
