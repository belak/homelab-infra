#!/bin/bash

set -euo pipefail

ROOT=/run/media/belak
INSTANCE_ID=${1:-}

if [[ -z "$INSTANCE_ID" ]]; then
  echo Missing instance id argument
  exit 1
fi

if [[ $(id -u) != 0 ]]; then
  echo Must be root
  exit 1
fi

# TODO: this may not be the right location any more
cp meta-data network-config user-data cmdline.txt $ROOT/system-boot

# Not sure this is needed
#cp 99-kubernetes-cri.conf $ROOT/writable/etc/sysctl.d

# TODO: this may not be the right location any more

sed -i "s/INSTANCE_ID/$INSTANCE_ID/" $ROOT/system-boot/{meta-data,network-config,user-data}
echo $INSTANCE_ID > $ROOT/writable/etc/hostname

umount $ROOT/{system-boot,writable}
sync
