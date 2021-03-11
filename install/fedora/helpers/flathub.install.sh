#!/usr/bin/env bash

echo
echo "=== Start 'flatpak.install.sh' ==="
echo

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
  echo "This script must be executed as root."
  exit
fi

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo
echo "=== End 'flatpak.install.sh' ==="
echo
