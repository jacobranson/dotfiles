#!/usr/bin/env bash

echo
echo "=== Start 'vscode.install.sh' ==="
echo

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
  echo "This script must be executed as root."
  exit
fi

MICROSOFT_KEY=https://packages.microsoft.com/keys/microsoft.asc

sudo rpm --import "$MICROSOFT_KEY"
sudo cp ../assets/vscode.repo /etc/yum.repos.d
sudo dnf check-update
sudo dnf install -y code

echo
echo "=== End 'vscode.install.sh' ==="
echo
