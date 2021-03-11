#!/usr/bin/env bash

echo
echo "=== Start 'fedora.install.sh' ==="
echo

./helpers/upgrade.install.sh
./helpers/rpmfusion.install.sh
./helpers/vscode.install.sh
./helpers/dotnet.install.sh
./helpers/nodejs.install.sh
./helpers/rust.install.sh
./helpers/fonts.install.sh
./helpers/purge.install.sh
./helpers/shell.install.sh
./helpers/flathub.install.sh
./helpers/apps.install.sh
./helpers/config.install.sh

echo
echo "=== End 'fedora.install.sh' ==="
echo
