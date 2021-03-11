#!/usr/bin/env bash

echo
echo "=== Start 'vscode.install.sh' ==="
echo

MICROSOFT_KEY=https://packages.microsoft.com/keys/microsoft.asc

rpm --import "$MICROSOFT_KEY"
cp ../assets/vscode.repo /etc/yum.repos.d
dnf check-update
dnf install -y code

echo
echo "=== End 'vscode.install.sh' ==="
echo
