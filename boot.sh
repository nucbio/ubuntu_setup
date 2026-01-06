#!/bin/bash

set -e

echo "Ubuntu-setup is for fresh Ubuntu 24.04LTS Gnome Desktop installations only!"

REPO="https://github.com/nucbio/ubuntu_setup/archive/refs/heads/main.zip"
UBUNTU_SETUP_DIR="$HOME/.local/share/ubuntu-setup"

echo "Starting Ubuntu setup..."

# Remove existing directory if it exists
if [ -d "$UBUNTU_SETUP_DIR" ]; then
    echo "Removing existing installation..."
    rm -rf "$UBUNTU_SETUP_DIR"
fi

if ! command -v wget > /dev/null 2>&1; then
    echo "Error: wget is not available. Installing it now..."
    sudo apt update && sudo apt install -y wget
fi

echo "Downloading repository with wget..."
wget "$REPO" -O /tmp/ubuntu-setup.zip

unzip -q /tmp/ubuntu-setup.zip -d /tmp/
mv /tmp/ubuntu_setup-main "$UBUNTU_SETUP_DIR"
rm /tmp/ubuntu-setup.zip

echo "Installation starting..."
source $UBUNTU_SETUP_DIR/install.sh
