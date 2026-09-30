#!/usr/bin/bash

# instructions stolen here:
# https://forum.garudalinux.org/t/ultimate-guide-to-install-anbox-in-any-arch-based-distro-especially-garuda/7453

# Run the following to see if your kernel already has binder/ashmem running (eg linux-zen)
# zgrep -Ei "binder|ashmem" /proc/config.gz

#modprobe binder_linux # uncomment if not using a kernel with baked in binderfs
#modprobe ashmem_linux # uncomment if not using a kernel with baked in ashmem
sudo systemctl start systemd-networkd
sudo mkdir -p /dev/binderfs
sudo mount -t binder none /dev/binderfs
sudo systemctl start anbox-container-manager
systemctl start --user anbox-session-manager
