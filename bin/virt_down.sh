#!/usr/bin/bash

## take network down
## stop libvirt
## unload kernel modules

sudo virsh net-destroy default
sudo systemctl stop libvirtd.socket
sudo systemctl stop libvirtd-admin.socket
sudo systemctl stop libvirtd-ro.socket
sudo systemctl stop libvirtd
sudo modprobe -r kvm_amd

# TPM kernel module loads a couple of other things.
# They all need to removed in the correct sequence, or it will fail.
# Obviously you do not need this if you are using TPM on your system for day
# to day stuff and should just remove/comment the lines below
sudo modprobe -r tpm_crb
sudo modprobe -r tpm_tis
sudo modprobe -r tpm_tis_core         
sudo modprobe -r tpm
