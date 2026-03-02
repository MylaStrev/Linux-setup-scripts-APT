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
        sudo apt install -y -q  "$pkg"
    fi
done

# download orca slicer from orca website

wget -q --show-progress https://github.com/OrcaSlicer/OrcaSlicer/releases/download/v2.3.1/OrcaSlicer-Linux-flatpak_V2.3.1_x86_64.flatpak

# check file in downloads

if flatpak list | grep -q "OrcaSlicer"; then
    echo "orca is installed"
else
    echo "installing orcaslicer..."
    sudo flatpak install OrcaSlicer-Linux-flatpak_V2.3.1_x86_64.flatpak --assumeyes
fi
