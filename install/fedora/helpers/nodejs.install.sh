#!/usr/bin/env bash

echo
echo "=== Start 'nodejs.install.sh' ==="
echo

sudo dnf install -y nodejs
npm config set prefix ~/.local

echo
echo "=== End 'nodejs.install.sh' ==="
echo
