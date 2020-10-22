#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

echo "========================================================================================="
vagrant plugin install vagrant-libvirt #The vagrant-libvirt plugin is required when using KVM on Linux
vagrant plugin install vagrant-mutate #Convert vagrant boxes to work with different providers

echo "========================================================================================="

# It is possible to run Salt in a masterless mode, 
# but using a Salt master will make it easier to expand on your deployment in the future
vagrant box add "bento/debian-10.4" --provider=virtualbox
vagrant mutate "bento/debian-10.4" libvirt
vagrant init --template Vagrantfile.topology.erb
# Salt master
# the master will configure the minion’s software
vagrant up --provider=libvirt "salt-master"
# Salt minion
# The static site generator used is Hugo, a fast framework written in Go
# The Salt minion will run the production webserver which serves the Hugo site
# The minion will also run a webhook server which will receive code update notifications from GitHub.
vagrant up --provider=libvirt "hugo-webserver"

vagrant box list #veridy installed boxes
vagrant status #Check the status of the VMs to see that none of them have been created yet
vagrant status
virsh list --all #show all running KVM/libvirt VMs
