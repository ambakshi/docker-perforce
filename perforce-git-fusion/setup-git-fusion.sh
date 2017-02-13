#!/bin/bash
set -e

if [ -z "$GFP4PASSWD" ]; then
    GFP4PASSWD="gfp4password"
fi

GFP4ROOT="${GFP4ROOT:-$P4ROOT/gfp4}"
SSH_HOST_KEYS="${SSH_HOST_KEYS:-$GFP4ROOT/ssh_host_keys}"

if ! test -e "$SSH_HOST_KEYS"; then
    if ! test -e /etc/ssh/ssh_host_rsa_key; then
        ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
        ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
        ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa
        ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519
    fi
    mkdir -p "$SSH_HOST_KEYS"
    cp /etc/ssh/ssh_host_* "$SSH_HOST_KEYS"
fi

if ! test -e /etc/ssh/ssh_host_rsa_key; then
    rm -f /etc/ssh/ssh_host_*
    test -e /etc/ssh || mkdir -p /etc/ssh
    for key in "$SSH_HOST_KEYS"/*; do
        ln -sfn $key /etc/ssh/
    done
fi

if ! test -e $GFP4ROOT/init; then
    /opt/perforce/git-fusion/libexec/configure-git-fusion.sh -n \
        --server local \
        --super $P4USER \
        --superpassword "$P4PASSWD" \
        --gfp4password "$GFP4PASSWD" \
        --p4port $P4PORT \
        --timezone ${TZ:-UTC} \
        --unknownuser reject \
        --id ${GFP4NAME:-$HOSTNAME}
    touch $GFP4ROOT/init
fi

if [ "$GFP4PASSWD" == "gfp4password" ]; then
    echo -e "\n***** WARNING: USING DEFAULT PASSWORD FOR NEW GIT FUSION USERS ******\n"
    echo "Please change as soon as possible:"
    echo "   GFP4PASSWD=$GFP4PASSWD"
    echo -e "\n***** WARNING: USING DEFAULT PASSWORD FOR NEW GIT FUSION USERS ******\n"
fi
