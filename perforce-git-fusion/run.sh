#!/bin/bash

if [ ! -e /etc/ssh/ssh_host_rsa_key ]; then
    /sbin/service sshd start
    /sbin/service sshd stop >/dev/null
fi
echo >&2 "Starting sshd ..."
/usr/sbin/sshd -D
