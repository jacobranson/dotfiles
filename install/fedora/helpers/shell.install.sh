#!/usr/bin/env bash

echo
echo "=== Start 'shell.install.sh' ==="
echo

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
  echo "This script must be executed as root."
  exit
fi

sudo dnf install -y \
  util-linux-user \
  neofetch \
  byobu \
  fish \
  starship \
  micro \
  tldr \
  exa \
  bat \
  htop \
  mosh \
  fzf \
  asciinema \
  xclip \
  xsel \
  wl-clipboard

chsh jacob -s $(which fish)
fish -c "set -Ux EDITOR (which micro)"
fish -c "set -U fish_greeting"

echo
echo "=== End 'shell.install.sh' ==="
echo
