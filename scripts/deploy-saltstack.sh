#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

echo "========================================================================================="
vagrant plugin install vagrant-libvirt #The vagrant-libvirt plugin is required when using KVM on Linux
vagrant plugin install vagrant-mutate #Convert vagrant boxes to work with different providers

# Saltstack provisioning
# https://app.vagrantup.com/centos/boxes/8
vagrant box add "centos/8" --provider=libvirt
vagrant up --provider=libvirt "master"
vagrant up --provider=libvirt "client1"
vagrant up --provider=libvirt "client2"

vagrant box list #veridy installed boxes
vagrant status #Check the status of the VMs to see that none of them have been created yet
vagrant status
virsh list --all #show all running KVM/libvirt VMs

echo "========================================================================================="


