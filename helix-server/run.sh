#!/bin/bash
set -e
export NAME="${NAME:-p4depot}"
export DATAVOLUME="${DATAVOLUME:-/data}"

if [ -n "${SSMCODE}" -a -n "${SSMID}" ]; then
  /usr/bin/amazon-ssm-agent -register -code "${SSMCODE}" -id "${SSMID}" --region "us-east-2"
  echo "AWS SSM Agent registered, starting ..."
  /usr/bin/amazon-ssm-agent >/dev/null 2>&1 &
else
  echo "No SSM ID & Code, so skipping setup of AWS SSM Agent."
fi

/usr/local/bin/setup-perforce.sh

sleep 2

exec /usr/bin/tail --pid=$(cat /var/run/p4d.$NAME.pid) -f "$DATAVOLUME/$NAME/log"
