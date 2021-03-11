#!/usr/bin/env bash

echo
echo "=== Start 'apps.install.sh' ==="
echo

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
  echo "This script must be executed as root."
  exit
fi

flatpak install -y flathub \
  org.freedesktop.Platform.ffmpeg-full \
  org.gnome.Lollypop \
  io.github.celluloid_player.Celluloid \
  org.blender.Blender \
  org.gimp.GIMP \
  org.inkscape.Inkscape \
  org.kde.Krita \
  org.onlyoffice.desktopeditors \
  com.obsproject.Studio \
  com.transmissionbt.Transmission \
  com.github.maoschanz.drawing \
  us.zoom.Zoom \
  com.discordapp.Discord \
  io.mrarm.mcpelauncher \
  com.mojang.Minecraft \
  org.libretro.RetroArch

sudo dnf install -y \
  kitty \
  godot \
  steam \
  lutris

echo
echo "=== End 'apps.install.sh' ==="
echo
