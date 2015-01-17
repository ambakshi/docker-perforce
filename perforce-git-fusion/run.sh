#!/bin/bash
SERVER="${SERVER:-$HOSTNAME}"

if [ ! -e /etc/ssh/ssh_host_rsa_key ]; then
    /sbin/service sshd start
    /sbin/service sshd stop >/dev/null
fi
if ! test -e $P4ROOT/init; then
    /opt/perforce/git-fusion/libexec/configure-git-fusion.sh -n \
        --super p4admin \
        --superpassword 'p4admin1234!'
        --gfp4password 'gitadmin1234!' \
        --p4port ssl:$HOSTNAME:1666 \
        --p4root $P4ROOT \
        --timezone 'America/Los_Angeles' \
        --server new \
        --id $SERVER
    touch $P4ROOT/init
fi

p4dctl status $SERVER || p4dctl restart $SERVER

echo >&2 "Starting sshd ..."
exec /usr/sbin/sshd -D
