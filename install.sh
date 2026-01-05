#!/usr/bin/bash

set -e

REPO_URL="https://github.com/nucbio/ubuntu-setup.git"
INSTALL_DIR="$HOME/.ubuntu-setup"

echo "Starting Ubuntu setup..."

# Clone or update repo
if [ -d "$INSTALL_DIR" ]; then
    git -C "$INSTALL_DIR" pull
else
    git clone "$REPO_URL" "$INSTALL_DIR"
fi

cd "$INSTALL_DIR"

# Run installers in order
bash packages/apt.sh
#bash packages/snap.sh
#bash packages/pip.sh
#bash packages/optional.sh

# Apply dotfiles
#bash scripts/common.sh

echo "Setup complete. Please reboot."
