#!/bin/bash

set -e

source ~/.config/pve/auth.cfg
echo "OTP:"
read otp
echo "otp: ${otp}"

access_resp=$(curl --silent -d "username=${username}&password=${password}&otp=${otp}" https://"${pve_addr}"/api2/json/access/ticket)
echo "access_resp: ${access_resp}"
ticket=$(echo $access_resp |  jq --raw-output '.data.ticket' | sed 's/^/PVEAuthCookie=/')
csrf=$(echo $access_resp |  jq --raw-output '.data.CSRFPreventionToken' | sed 's/^/CSRFPreventionToken:/')

echo "ticket: ${ticket}"
echo "csrf: ${csrf}"

tmpfile=$(mktemp /tmp/spice.XXXXXX)
echo "Temp file is ${tmpfile}"
echo '[virt-viewer]' > $tmpfile
echo 'delete-this-file=1' >> $tmpfile

curl --silent -d "" -H "${csrf}" -b "${ticket}" https://"${pve_addr}"/api2/json/nodes/"${pve_node}"/qemu/"${pve_vmid}"/spiceproxy |\
jq --raw-output '.data | to_entries | map("\(.key)=\(.value)") | join("\n")' >> \
$tmpfile

xdg-open "${tmpfile}"

