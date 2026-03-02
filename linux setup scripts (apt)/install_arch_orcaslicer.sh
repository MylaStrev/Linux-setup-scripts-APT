#!/bin/bash

PACKAGES=(
"wget"
"flatpak"
)

# check for wget and flatpak

echo "## CHECKING FOR SNAP"
for pkg in "${PACKAGES[@]}"; do
    if dpkg -s "$pkg" &> /dev/null; then
        echo "## $pkg is already installed, skipping..."
    else
        echo "installing $pkg..."
        sudo pacman -S -q --noconfirm "$pkg"
    fi
done

# download orca slicer from orca website

wget -q --show-progress https://github.com/OrcaSlicer/OrcaSlicer/releases/download/v2.3.1/OrcaSlicer-Linux-flatpak_V2.3.1_x86_64.flatpak

# check file in downloads

if [ -f ~/Downloads/OrcaSlicer-Linux-flatpak_V2.3.1_x86_64.flatpak ]; then
    echo "file found, now installing..."
    sudo flatpak install OrcaSlicer-Linux-flatpak_V2.3.1_x86_64.flatpak
else
    echo "ORCASLICER FILE NOT FOUND"
fi
