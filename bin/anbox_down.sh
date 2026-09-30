#!/usr/bin/bash

# instructions stolen here:
# https://forum.garudalinux.org/t/ultimate-guide-to-install-anbox-in-any-arch-based-distro-especially-garuda/7453

# Run the following to see if your kernel already has binder/ashmem running (eg linux-zen)
# zgrep -Ei "binder|ashmem" /proc/config.gz

systemctl stop --user anbox-session-manager
sudo systemctl stop anbox-container-manager
sudo systemctl stop systemd-networkd.socket
sudo systemctl stop systemd-networkd
sudo umount /dev/binderfs
sudo rmdir /dev/binderfs
#modprobe -r binder_linux
#modprobe -r ashmem_linux
