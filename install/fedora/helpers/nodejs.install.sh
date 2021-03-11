#!/usr/bin/env bash

echo
echo "=== Start 'nodejs.install.sh' ==="
echo

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
  echo "This script must be executed as root."
  exit
fi

sudo dnf install -y nodejs
npm config set prefix ~/.local

echo
echo "=== End 'nodejs.install.sh' ==="
echo
