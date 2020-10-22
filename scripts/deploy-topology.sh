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
# #https://github.com/chef/bento/tree/master/packer_templates/centos
# vagrant box add "bento/centos-7.8" --provider=virtualbox
# vagrant mutate "bento/centos-7.8" libvirt
# vagrant up --provider=libvirt "vg-controller-82"

# Ansible provision OK
#https://github.com/chef/bento/tree/master/packer_templates/centos
# vagrant box add "bento/centos-8.2" --provider=virtualbox
# vagrant mutate "bento/centos-8.2" libvirt
# vagrant up --provider=libvirt "vg-controller-83"

#No output has been received in the last 10m0s, this potentially indicates a stalled build or something wrong with the build itself.
#https://github.com/chef/bento/tree/master/packer_templates/centos
# vagrant box add "bento/fedora-32" --provider=virtualbox
# vagrant mutate "bento/fedora-32" libvirt
# vagrant up --provider=libvirt "vg-controller-84"

# https://app.vagrantup.com/centos/boxes/7
# vagrant box add "centos/7" --provider=libvirt
# vagrant up --provider=libvirt "vg-controller-85"

#vg-controller-86: /tmp/vagrant-shell: line 8:  3409 Killed                  dnf -y update
# https://app.vagrantup.com/fedora/boxes/32-cloud-base
# vagrant box add "fedora/32-cloud-base" --provider=libvirt
# vagrant up --provider=libvirt "vg-controller-86"

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


# https://github.com/chef/bento/tree/master/packer_templates/ubuntu
# vagrant box add "bento/ubuntu-19.10" --provider=virtualbox
# vagrant mutate "bento/ubuntu-19.10" libvirt
# vagrant init --template Vagrantfile.provision.topology.erb
# # vagrant up --provider=libvirt
# vagrant up --provider=libvirt puppet
# vagrant up --provider=libvirt puppet-agent-ubuntu
# vagrant up --provider=libvirt puppet-agent-centos

# https://github.com/chef/bento/tree/master/packer_templates/ubuntu
# vagrant box add "bento/ubuntu-19.10" --provider=virtualbox
# vagrant mutate "bento/ubuntu-19.10" libvirt
# vagrant init --template Vagrantfile.provision.bash.ubuntu.erb
# # must be created in project root directory with Vagrantfile template file
# vagrant up --provider=libvirt "kuma-control-plane"

# https://github.com/chef/bento/tree/master/packer_templates/ubuntu
# vagrant box add "bento/ubuntu-20.04" --provider=virtualbox
# vagrant mutate "bento/ubuntu-20.04" libvirt
# vagrant init --template Vagrantfile.provision.bash.ubuntu.erb
# # must be created in project root directory with Vagrantfile template file
# vagrant up --provider=libvirt "kuma-control-plane"
# vagrant up --provider=libvirt "redis"

vagrant box list #veridy installed boxes
vagrant status #Check the status of the VMs to see that none of them have been created yet
vagrant status
virsh list --all #show all running KVM/libvirt VMs
