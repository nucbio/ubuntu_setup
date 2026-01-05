#!/usr/bin/bash

set -e

REPO_URL="https://github.com/nucbio/ubuntu-setup/archive/refs/heads/main.zip"
INSTALL_DIR="$HOME/.ubuntu-setup"

echo "Starting Ubuntu setup..."

# Remove existing directory if it exists
if [ -d "$INSTALL_DIR" ]; then
    echo "Removing existing installation..."
    rm -rf "$INSTALL_DIR"
fi

if ! command -v wget > /dev/null 2>&1; then
    echo "Error: wget is not available. Installing it now..."
    sudo apt update && sudo apt install -y wget
fi

echo "Downloading repository with wget..."
wget "$REPO_URL" -O /tmp/ubuntu-setup.zip

unzip -q /tmp/ubuntu-setup.zip -d /tmp/
mv /tmp/ubuntu_setup-main "$INSTALL_DIR"
rm /tmp/ubuntu-setup.zip

cd "$INSTALL_DIR"

# Run installers in order
bash packages/apt.sh
#bash packages/snap.sh
#bash packages/pip.sh
#bash packages/optional.sh

# Apply dotfiles
#bash scripts/common.sh

echo "Setup complete. Please reboot."
