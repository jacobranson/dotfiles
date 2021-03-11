#!/usr/bin/env bash

echo
echo "=== Start 'rpmfusion.install.sh' ==="
echo

RPM_FUSION_FREE=https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
RPM_FUSION_NONFREE=https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

dnf install -y "$RPM_FUSION_FREE" "$RPM_FUSION_NONFREE"
dnf groupupdate -y core
dnf groupupdate -y multimedia \
  --setop="install_weak_deps=False" \
  --exclude=PackageKit-gstreamer-plugin
dnf groupupdate -y sound-and-video

echo
echo "=== End 'rpmfusion.install.sh' ==="
echo
