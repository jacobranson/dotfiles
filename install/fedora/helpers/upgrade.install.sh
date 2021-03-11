#!/usr/bin/env bash

echo
echo "=== Start 'upgrade.install.sh' ==="
echo

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
  echo "This script must be executed as root."
  exit
fi

sudo dnf upgrade -y

echo
echo "=== End 'upgrade.install.sh' ==="
echo
