#!/bin/bash

# additional needed packages
#sudo apt install nvidia-cuda-toolkit -y

NEEDED_PACKAGES=(
"snapd"
"flatpak"
)

# list apps here
APT_PACKAGES=(
"sl"
"fastfetch"
"vlc"
"obs-studio"
"git"
"blender"
"wget"
)

SNAP_PACKAGES=(
"spotify"
"steam"
)

SNAP_CLASSIC_PACKAGES=(
"obsidian"
)

FLATPACK_PACKAGES=(
"github-desktop"
)

# check for and install snap
echo "## CHECKING FOR SNAP"
for pkg in "${NEEDED_PACKAGES[@]}"; do
    if dpkg -s "$pkg" &> /dev/null; then
        echo "## $pkg is already installed, skipping..."
    else
        echo "installing $pkg..."
        sudo apt install -y "$pkg"
    fi
done

#apt package install
echo "## INSTALLING APT PACKAGES"
for pkg in "${APT_PACKAGES[@]}"; do
    if dpkg -s "$pkg" &> /dev/null; then
        echo "## $pkg is already installed, skipping..."
    else
        echo "## installing $pkg..."
        sudo apt install -y "$pkg"
    fi
done

#snap package install
echo "## INSTALLING SNAP PACKAGES"
for pkg in "${SNAP_PACKAGES[@]}"; do
    if snap list "$pkg" &> /dev/null; then
        echo "## $pkg is already installed, skipping..."
    else
        echo "## installing $pkg via snap..."
        sudo snap install "$pkg"
    fi
done

for pkg in "${SNAP_CLASSIC_PACKAGES[@]}"; do
    if snap list "$pkg" &> /dev/null; then
        echo "## $pkg is already installed, skipping.. "
    else
        echo "## installing $pkg via snap --classic"
        sudo snap install "$pkg" --classic
    fi
done

for pkg in "${FLATPACK_PACKAGES[@]}"; DO
    if flatpak list --app | grep -q "$pkg"; then
        echo "## $pkg is already installed, skipping.. "
    else
        echo "## installing $pkg via flatpak..."
        sudo flatpack install "$pkg" --assumeyes
    fi
done

# section to install orca slicer
# check file in downloads
# downloads orcaslicer from orcaslicer.com and then installs
if [ -f ~/Downloads/OrcaSlicer-Linux-flatpak_V2.3.1_x86_64.flatpak ]; then
    echo "file found, checking if installed..."
    else wget -q --show-progress https://github.com/OrcaSlicer/OrcaSlicer/releases/download/v2.3.1/OrcaSlicer-Linux-flatpak_V2.3.1_x86_64.flatpak
fi

if flatpak list --app | grep -q "OrcaSlicer"; then
    echo "orca is installed"
    else
    echo "installing orcaslicer..."
    sudo flatpak install OrcaSlicer-Linux-flatpak_V2.3.1_x86_64.flatpak --assumeyes
fi

#update code
echo "## CHECKING FOR AND INSTALLING APT PACKAGE UPDATES"
sudo apt update && sudo apt upgrade -y

echo "## CHECKING FOR AND INSTALLING SNAP PACKAGE UPDATES"
sudo snap refresh

echo "## CHECKING FOR AND INSTALLING FLATPAK PACKAGE UPDATES"
sudo flatpak update

echo "## UPDATES CHECKED!"
echo "## DONE"
