#!/bin/bash
set -e

service crond start
service rsyslog start

#######################################
## old code
#######################################
mkdir -m 0755 -p $(dirname $P4ROOT)
mkdir -m 0700 -p $P4ROOT $P4SSLDIR
chown -R perforce:perforce $P4ROOT $P4SSLDIR
cd /opt/perforce/servers
if [ ! -e /opt/perforce/servers/.profile ]; then
    cat >> /opt/perforce/servers/.profile <<-EOF
	export P4ROOT=$P4ROOT
	export P4SSLDIR=$P4SSLDIR
	export P4PORT=$P4PORT
	export P4USER=$P4USER
	EOF
	cat /opt/perforce/servers/.profile | tee -a /etc/profile
    chown perforce:perforce /opt/perforce/servers/.profile
fi

if [ ! -e "$P4SSLDIR/privatekey.txt" ]; then
    runuser -l perforce -c "/opt/perforce/sbin/p4d -Gc $*"
fi

if [ ! -e "$P4ROOT/init" ]; then
    runuser -l perforce -c "/opt/perforce/sbin/p4d -d $*"
    sleep 10
    p4 passwd -O '' -P p4admin p4admin
    cat << EOF | p4 -P p4admin protect -i
    Protections:
        write user * * //...
        admin user swarm * //...
        super user p4admin * //...
EOF
    p4 -u swarm user -o | p4 -u swarm user -i
    p4 -u swarm passwd -P swarm
    p4 -P p4admin admin stop
    sleep 5
    touch "$P4ROOT/init"
    chown perforce:perforce "$P4ROOT/init"
fi

exec runuser -l perforce -c "/opt/perforce/sbin/p4d $*"
#######################################
## old code
#######################################
mkdir -m 0755 -p $(dirname $P4ROOT)
mkdir -m 0700 -p $P4ROOT $P4SSLDIR
chown -R perforce:perforce $P4ROOT $P4SSLDIR
cd /opt/perforce/servers
if [ ! -e /opt/perforce/servers/.profile ]; then
    cat >> /opt/perforce/servers/.profile <<-EOF
	export P4ROOT=$P4ROOT
	export P4SSLDIR=$P4SSLDIR
	export P4PORT=$P4PORT
	export P4USER=$P4USER
	EOF
	cat /opt/perforce/servers/.profile | tee -a /etc/profile
    chown perforce:perforce /opt/perforce/servers/.profile
fi

if [ ! -e "$P4SSLDIR/privatekey.txt" ]; then
    runuser -l perforce -c "/opt/perforce/sbin/p4d -Gc $*"
fi

if [ ! -e "$P4ROOT/init" ]; then
    runuser -l perforce -c "/opt/perforce/sbin/p4d -d $*"
    sleep 10
    p4 passwd -O '' -P p4admin p4admin
    cat << EOF | p4 -P p4admin protect -i
    Protections:
        write user * * //...
        admin user swarm * //...
        super user p4admin * //...
EOF
    p4 -u swarm user -o | p4 -u swarm user -i
    p4 -u swarm passwd -P swarm
    p4 -P p4admin admin stop
    sleep 5
    touch "$P4ROOT/init"
    chown perforce:perforce "$P4ROOT/init"
fi

exec runuser -l perforce -c "/opt/perforce/sbin/p4d $*"
#######################################
## old code
#######################################
mkdir -m 0755 -p $(dirname $P4ROOT)
mkdir -m 0700 -p $P4ROOT $P4SSLDIR
chown -R perforce:perforce $P4ROOT $P4SSLDIR
cd /opt/perforce/servers
if [ ! -e /opt/perforce/servers/.profile ]; then
    cat >> /opt/perforce/servers/.profile <<-EOF
	export P4ROOT=$P4ROOT
	export P4SSLDIR=$P4SSLDIR
	export P4PORT=$P4PORT
	export P4USER=$P4USER
	EOF
	cat /opt/perforce/servers/.profile | tee -a /etc/profile
    chown perforce:perforce /opt/perforce/servers/.profile
fi

if [ ! -e "$P4SSLDIR/privatekey.txt" ]; then
    runuser -l perforce -c "/opt/perforce/sbin/p4d -Gc $*"
fi

if [ ! -e "$P4ROOT/init" ]; then
    runuser -l perforce -c "/opt/perforce/sbin/p4d -d $*"
    sleep 10
    p4 passwd -O '' -P p4admin p4admin
    cat << EOF | p4 -P p4admin protect -i
    Protections:
        write user * * //...
        admin user swarm * //...
        super user p4admin * //...
EOF
    p4 -u swarm user -o | p4 -u swarm user -i
    p4 -u swarm passwd -P swarm
    p4 -P p4admin admin stop
    sleep 5
    touch "$P4ROOT/init"
    chown perforce:perforce "$P4ROOT/init"
fi

exec runuser -l perforce -c "/opt/perforce/sbin/p4d $*"

