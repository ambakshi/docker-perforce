#!/bin/bash
NAME="${NAME:-$HOSTNAME}"

set -e

service crond start
service rsyslog start

NAME="${NAME:-$HOSTNAME}"
if [ -z "$P4PASSWD" ]; then
    WARN=1
    P4PASSWD="pass12349ers!"
fi

if [ ! -e /etc/ssh/ssh_host_rsa_key ]; then
    /sbin/service sshd start
    /sbin/service sshd stop >/dev/null
fi
if ! test -e $P4ROOT/init; then
    /opt/perforce/git-fusion/libexec/configure-git-fusion.sh -n \
        --super $P4USER \
        --superpassword "$P4PASSWD" \
        --gfp4password "$P4PASSWD" \
        --p4port $P4PORT \
        --p4root $P4ROOT \
        --timezone ${TZ:-UTC} \
        --server new \
        --id $NAME
    touch $P4ROOT/init
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


echo >&2 "Starting sshd ..."
exec /usr/sbin/sshd -D
