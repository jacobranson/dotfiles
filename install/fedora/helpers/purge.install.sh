#!/usr/bin/env bash

echo
echo "=== Start 'purge.install.sh' ==="
echo

dnf remove -y \
  nano \
  nano-default-editor \
  vim-minimal \
  totem \
  gnome-weather \
  gnome-maps

echo
echo "=== End 'purge.install.sh' ==="
echo
