#!/usr/bin/env bash

echo
echo "=== Start 'fonts.install.sh' ==="
echo

FONTS_DIR=~/.local/share/fonts
FIRA_CODE_BOLD=https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Bold/complete/Fira%20Code%20Bold%20Nerd%20Font%20Complete.ttf?raw=true
FIRA_CODE_BOLD_MONO=https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Bold/complete/Fira%20Code%20Bold%20Nerd%20Font%20Complete%20Mono.ttf?raw=true
FIRA_CODE_LIGHT=https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Light/complete/Fira%20Code%20Light%20Nerd%20Font%20Complete.ttf?raw=true
FIRA_CODE_LIGHT_MONO=https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Light/complete/Fira%20Code%20Light%20Nerd%20Font%20Complete%20Mono.ttf?raw=true
FIRA_CODE_MEDIUM=https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Medium/complete/Fira%20Code%20Medium%20Nerd%20Font%20Complete.ttf?raw=true
FIRA_CODE_MEDIUM_MONO=https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Medium/complete/Fira%20Code%20Medium%20Nerd%20Font%20Complete%20Mono.ttf?raw=true
FIRA_CODE_REGULAR=https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.ttf?raw=true
FIRA_CODE_REGULAR_MONO=https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete%20Mono.ttf?raw=true
FIRA_CODE_SEMIBOLD=https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/SemiBold/complete/Fira%20Code%20SemiBold%20Nerd%20Font%20Complete.ttf?raw=true
FIRA_CODE_SEMIBOLD_MONO=https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/SemiBold/complete/Fira%20Code%20SemiBold%20Nerd%20Font%20Complete%20Mono.ttf?raw=true

mkdir -p "$FONTS_DIR"
curl -fLo "$FONTS_DIR/Fira Code Bold Nerd Font Complete.ttf" "$FIRA_CODE_BOLD"
curl -fLo "$FONTS_DIR/Fira Code Bold Nerd Font Complete Mono.ttf" "$FIRA_CODE_BOLD_MONO"
curl -fLo "$FONTS_DIR/Fira Code Light Nerd Font Complete.ttf" "$FIRA_CODE_LIGHT"
curl -fLo "$FONTS_DIR/Fira Code Light Nerd Font Complete Mono.ttf" "$FIRA_CODE_LIGHT_MONO"
curl -fLo "$FONTS_DIR/Fira Code Medium Nerd Font Complete.ttf" "$FIRA_CODE_MEDIUM"
curl -fLo "$FONTS_DIR/Fira Code Medium Nerd Font Complete Mono.ttf" "$FIRA_CODE_MEDIUM_MONO"
curl -fLo "$FONTS_DIR/Fira Code Regular Nerd Font Complete.ttf" "$FIRA_CODE_REGULAR"
curl -fLo "$FONTS_DIR/Fira Code Regular Nerd Font Complete Mono.ttf" "$FIRA_CODE_REGULAR_MONO"
curl -fLo "$FONTS_DIR/Fira Code SemiBold Nerd Font Complete.ttf" "$FIRA_CODE_SEMIBOLD"
curl -fLo "$FONTS_DIR/Fira Code SemiBold Nerd Font Complete Mono.ttf" "$FIRA_CODE_SEMIBOLD_MONO"

echo
echo "=== End 'fonts.install.sh' ==="
echo
