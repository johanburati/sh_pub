#!/bin/bash
az account set --subscription  10d9454f-7aa8-4265-a17f-18d4cbe7087d

# check if in chroot
if [[ mountpoint -q /rescue ]]; then
	mkdir -p /rescue
	mount -t proc proc /rescue/proc
	mount -t sysfs sys /rescue/sys
	mount -o bind /dev /rescue/dev
	mount -o bind /dev/pts /rescue/dev/pts
	mount -o bind /run /rescue/run
	chroot /rescue
fi

