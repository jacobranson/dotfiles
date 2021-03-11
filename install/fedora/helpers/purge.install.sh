#!/usr/bin/env bash

echo
echo "=== Start 'purge.install.sh' ==="
echo

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
  echo "This script must be executed as root."
  exit
fi

sudo dnf remove -y \
  nano \
  nano-default-editor \
  vim-minimal \
  libreoffice-* \
  totem \
  gnome-weather \
  gnome-maps \
  gnome-photos \
  rhythmbox

echo
echo "=== End 'purge.install.sh' ==="
echo
