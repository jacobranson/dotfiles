#!/usr/bin/env bash

echo
echo "=== Start 'config.install.sh' ==="
echo

ln -s ~/.config/fish/config.fish ../../config/config.fish
ln -s ~/.config/kitty/kitty.conf ../../config/kitty.conf
ln -s ~/.config/kitty/startup.session ../../config/startup.session
ln -s ~/.config/micro/settings.json ../../config/micro.json
ln -s ~/.gitconfig ../../config/gitconfig

echo
echo "=== End 'config.install.sh' ==="
echo
