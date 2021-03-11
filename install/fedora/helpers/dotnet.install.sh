#!/usr/bin/env bash

echo
echo "=== Start 'dotnet.install.sh' ==="
echo

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
  echo "This script must be executed as root."
  exit
fi

sudo dnf install -y dotnet-sdk-5.0

echo
echo "=== End 'dotnet.install.sh' ==="
echo
