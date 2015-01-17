#!/bin/bash

if [ ! -e /etc/ssh/ssh_host_rsa_key ]; then
    /sbin/service sshd start
    /sbin/service sshd stop >/dev/null
fi
if ! test -e /root/.ssh/authorized_keys; then
    mkdir -p -m 0700 /root/.ssh
    ssh-keygen -q -f /root/.ssh/id_rsa -N ""
    cat /root/.ssh/id_rsa.pub | tee -a /root/.ssh/authorized_keys
    chmod 0400 /root/.ssh/*
    cat /root/.ssh/id_rsa
fi
echo >&2 "Starting sshd ..."
/usr/sbin/sshd -D
