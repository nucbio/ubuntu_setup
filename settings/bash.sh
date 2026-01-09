#!/bin/bash

BASH_SETUP_DIR=${UBUNTU_SETUP_DIR}/configs/bashrc.d
BASH_LOCAL_DIR=$HOME/.bashrc.d

# Check if directory already exists and abort if it does
if [ -d "$BASH_LOCAL_DIR" ]; then
    echo "Error: Directory $BASH_LOCAL_DIR already exists. Aborting installation." >&2
    exit 1
fi

# Create the directory
mkdir -p "$BASH_LOCAL_DIR"

# Copy files from common directory
cp "${BASH_SETUP_DIR}/common"/*.sh "$BASH_LOCAL_DIR/"

# Copy additional files for local pcs
if [[ "$INSTALL_OPT" == "Home" || "$INSTALL_OPT" == "Work" ]]; then
  cp "${BASH_SETUP_DIR}/local"/*.sh "$BASH_LOCAL_DIR/"
fi

# Copy additional files for ws
if [[ "$INSTALL_OPT" == "Home" ]]; then
  cp "${BASH_SETUP_DIR}/home"/*.sh "$BASH_LOCAL_DIR/"
fi

# Copy additional files for ws
if [[ "$INSTALL_OPT" == "Bio" ]]; then
  cp "${BASH_SETUP_DIR}/ws"/*.sh "$BASH_LOCAL_DIR/"
fi

# Create startup directory and move files starting with "start"
mkdir -p "$BASH_LOCAL_DIR/startup"
if compgen -G "$BASH_LOCAL_DIR/start_*.sh" > /dev/null; then
    mv "$BASH_LOCAL_DIR"/start_*.sh "$BASH_LOCAL_DIR/startup/"
fi

# Backup existing .bashrc and move new one from .bashrc.d
if [ -f "$HOME/.bashrc" ]; then
    cp "$HOME/.bashrc" "$HOME/.bashrc.backup.$(date +%Y%m%d_%H%M%S)"
    echo "Existing .bashrc backed up to ~/.bashrc.backup.$(date +%Y%m%d_%H%M%S)"
fi

# Add custom .bashrc
mv "$BASH_SETUP_DIR/.bashrc" "$HOME/.bashrc"

