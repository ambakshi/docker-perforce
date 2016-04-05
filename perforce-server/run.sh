#!/bin/bash

set -e

service crond start
service rsyslog start

if [ ! -d /data/etc ]; then
	echo First time installation, copying configuration from /etc/perforce to /data/etc and relinking
	mkdir -p /data/etc
	cp -r /etc/perforce/* /data/etc/
fi 

mv /etc/perforce /etc/perforce.orig
ln -s /data/etc /etc/perforce	


NAME="${NAME:-$HOSTNAME}"
if [ -z "$P4PASSWD" ]; then
    WARN=1
    P4PASSWD="pass12349ers!"
fi

# This is hardcoded in configure-helix-p4d.sh :(
P4SSLDIR="$P4ROOT/ssl"

for DIR in $P4ROOT $P4SSLDIR; do
    mkdir -m 0700 -p $DIR
    chown perforce:perforce $DIR
done

if ! p4dctl list 2>/dev/null | grep -q $NAME; then
    /opt/perforce/sbin/configure-helix-p4d.sh $NAME -n -p $P4PORT -r $P4ROOT -u $P4USER -P "${P4PASSWD}"
fi

p4dctl start -t p4d $NAME

touch ~perforce/.p4config
chmod 0600 ~perforce/.p4config
chown perforce:perforce ~perforce/.p4config
cat > ~perforce/.p4config <<EOF
P4USER=$P4USER
P4PORT=$P4PORT
P4PASSWD="$P4PASSWD"
EOF

p4 login <<EOF
$P4PASSWD
EOF

## Load up the default tables
p4 user -i < /root/p4-users.txt
p4 group -i < /root/p4-groups.txt
p4 protect -i < /root/p4-protect.txt

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
