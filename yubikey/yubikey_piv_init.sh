#!/bin/bash

set -e

if [[ $# -ne 4 ]]; then
  echo "${0} PIN PUK private-key-file public-key-file"
  exit
fi

for device in $(ykman list -s); do
  echo "reseting PIV...for device ${device}"
  ykman -d $device piv reset -f
  echo "generating management key on device..."
  ykman -d $device piv change-management-key -g -p -P 123456 -m 010203040506070801020304050607080102030405060708
  echo "setting PIN and PUK..."
  ykman -d $device piv change-pin -P 123456 -n "${1}"
  ykman -d $device piv change-puk -p 12345678 -n "${2}"

  echo "importing private key into 9a..."
  ykman -d $device piv import-key -P "${1}" --touch-policy CACHED 9a "${3}"
  echo "importing certificate into 9a..."
  ykman -d $device piv generate-certificate -P "${1}" -s "/CN=SSH-key" 9a "${4}"

done
