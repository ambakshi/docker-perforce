#!/bin/bash

set -e

service crond start
service rsyslog start

NAME="${NAME:-$HOSTNAME}"
if [ -z "$P4PASSWD" ]; then
    WARN=1
    P4PASSWD="pass12349ers!"
fi

if ! p4dctl list 2>/dev/null | grep -q $NAME; then
    /opt/perforce/sbin/configure-perforce-server.sh $NAME -n -p $P4PORT -r $P4ROOT -u $P4USER -P "${P4PASSWD}"
fi

p4dctl status $NAME || p4dctl start $NAME

echo "   P4USER=$P4USER (the admin user)"
if [ -n "$WARN" ]; then
    echo -e "\n***** WARNING: USING DEFAULT PASSWORD ******\n"
    echo "Please change as soon as possible:"
    echo "   P4PASSWD=$P4PASSWD"
    echo -e "\n***** WARNING: USING DEFAULT PASSWORD ******\n"
fi
sleep 2

# exec /usr/bin/p4web -U perforce -u $P4USER -b -p $P4PORT -P "$P4PASSWD" -w 8080

exec /usr/bin/tail --pid=$(cat /var/run/p4d.$NAME.pid) -f "$P4ROOT/log"


