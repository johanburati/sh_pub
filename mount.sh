#!/bin/bash
# Mount/umount disk on rescue VM

if [[ $EUID -ne 0 ]]; then
  echo "Error: Must be run as root"
  exit 1
fi

mkdir -p /rescue

if /bin/mountpoint -q /rescue; then
  echo "# Unmounting, please wait"
  umount /rescue/run
  umount /rescue/dev/pts
  umount /rescue/dev
  umount /rescue/sys
  umount /rescue/proc
  disk=$(dmesg | gawk 'match($0, /: \[(.*)\] Attached SCSI disk/, a) {disk=a[1]} END{print disk}')
  if [ -b /dev/${disk}2 ]; then
    umount /rescue/boot
  fi
  umount /rescue
else
  echo "# Mounting, please wait"
  disk=$(dmesg | gawk 'match($0, /: \[(.*)\] Attached SCSI disk/, a) {disk=a[1]} END{print disk}')
  if [ -b /dev/${disk}2 ]; then
    mount -o nouuid /dev/${disk}2 /rescue
    mount -o nouuid /dev/${disk}1 /rescue/boot
  else
    mount /dev/${disk}1 /rescue
  fi
  if /bin/mountpoint -q /rescue; then
    mount -t proc proc /rescue/proc
    mount -t sysfs sys /rescue/sys
    mount -o bind /dev /rescue/dev
    mount -o bind /dev/pts /rescue/dev/pts
    mount -o bind /run /rescue/run
  fi
fi
echo "# Done"