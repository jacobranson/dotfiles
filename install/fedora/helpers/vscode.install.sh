#!/usr/bin/env bash

echo
echo "=== Start 'vscode.install.sh' ==="
echo

MICROSOFT_KEY=https://packages.microsoft.com/keys/microsoft.asc

sudo rpm --import "$MICROSOFT_KEY"
sudo cp ../assets/vscode.repo /etc/yum.repos.d
sudo dnf check-update
sudo dnf install -y code

echo
echo "=== End 'vscode.install.sh' ==="
echo
