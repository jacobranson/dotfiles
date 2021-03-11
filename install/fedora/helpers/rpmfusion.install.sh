#!/usr/bin/env bash

echo
echo "=== Start 'rpmfusion.install.sh' ==="
echo

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
  echo "This script must be executed as root."
  exit
fi

RPM_FUSION_FREE=https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
RPM_FUSION_NONFREE=https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf install -y "$RPM_FUSION_FREE" "$RPM_FUSION_NONFREE"
sudo dnf groupupdate -y core
sudo dnf groupupdate -y multimedia \
  --setop="install_weak_deps=False" \
  --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate -y sound-and-video

echo
echo "=== End 'rpmfusion.install.sh' ==="
echo
