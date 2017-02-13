#!/usr/bin/with-contenv bash
set -ex

export NAME="${NAME:-p4depot}"

bash -x /usr/local/bin/setup-perforce.sh
bash -x /usr/local/bin/setup-git-fusion.sh

cp /opt/perforce/git-fusion/libexec/p4gf_submit_trigger_wrapper.sh /usr/local/bin/
/opt/perforce/git-fusion/libexec/p4gf_submit_trigger.py --install "$P4PORT" "$P4USER" "$P4PASSWD"

exec /usr/sbin/sshd -D -e
