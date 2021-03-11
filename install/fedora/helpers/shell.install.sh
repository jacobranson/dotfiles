#!/usr/bin/env bash

echo
echo "=== Start 'shell.install.sh' ==="
echo

sudo dnf install -y \
  util-linux-user \
  neofetch \
  fish \
  starship \
  micro \
  tldr \
  exa \
  bat \
  xclip \
  xsel \
  wl-clipboard

chsh jacob -s $(which fish)
fish -c "set -Ux EDITOR (which micro)"

echo
echo "=== End 'shell.install.sh' ==="
echo
