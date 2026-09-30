#!/usr/bin/bash

# instructions stolen here:
# https://gist.github.com/diffficult/cb8c385e646466b2a3ff129ddb886185
# sudo pacman -S qemu virt-manager dnsmasq iptables ebtables swtpm edk2-ovmf

## pre-requisites
## have qemu, libvirt, kvm, swtpm, edk2-ovmf installed
## have a CPU that supports virtualisation and have it enabled
## through your BIOS

## after fresh install you need the following:
## sudo gpasswd -a <username> kvm
## sudo gpasswd -a <username> libvirt

sudo modprobe kvm_amd

# TPM is needed for certain Windows VMs if you need to use an enterprise/managed
# Windows installation. BitLocker requires TPM for instance.
# If you are already using TPM as part of your system on a daily basis, then
# you probably do not need to load this module manually, and you can comment
# the line below.
sudo modprobe tpm

sudo systemctl start libvirtd
sudo virsh net-start default
