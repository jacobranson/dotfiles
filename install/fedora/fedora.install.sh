#!/usr/bin/env bash

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
  echo "This script must be executed as root."
  exit
fi

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
