#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

  echo "===================================================================================="
                        hostnamectl
  echo "===================================================================================="
  echo "         \   ^__^                                                                  "
  echo "          \  (oo)\_______                                                          "
  echo "             (__)\       )\/\                                                      "
  echo "                 ||----w |                                                         "
  echo "                 ||     ||                                                         "
  echo "===================================================================================="

echo "======================Deploy minion=============================================================="

apt-get update -qq
apt-get install -qqy hugo

# Run the bootstrap script on the minion
wget -O bootstrap-salt.sh https://bootstrap.saltstack.com
sh bootstrap-salt.sh

echo "======================Deploy minion=============================================================="
