#!/usr/bin/env bash

echo
echo "=== Start 'purge.install.sh' ==="
echo

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
