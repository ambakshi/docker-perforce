#!/usr/bin/with-contenv bash
set -e

service crond start
service rsyslog start
service sshd start

export NAME="${NAME:-p4depot}"

/usr/local/bin/setup-perforce.sh
/usr/local/bin/setup-git-fusion.sh

cp /opt/perforce/git-fusion/libexec/p4gf_submit_trigger_wrapper.sh /usr/local/bin/
/opt/perforce/git-fusion/libexec/p4gf_submit_trigger.py --install "$P4PORT" "$P4USER" "$P4PASSWD"

exec /usr/bin/tail --pid=$(cat /var/run/p4d.$NAME.pid) -F "$DATAVOLUME/$NAME/log" /var/log/git-*
