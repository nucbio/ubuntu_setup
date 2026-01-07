#!/bin/bash

BASH_SETUP_DIR=${UBUNTU_SETUP_DIR}/configs/bash
BASH_LOCAL_DIR=$HOME/.bashrc.d

# Check if directory already exists and abort if it does
if [ -d "$BASH_LOCAL_DIR" ]; then
    echo "Error: Directory $BASH_LOCAL_DIR already exists. Aborting installation." >&2
    exit 1
fi

# Create the directory
mkdir -p "$BASH_LOCAL_DIR"

# Copy files from common directory
if [ -d "${BASH_SETUP_DIR}/bashrc.d/common" ]; then
    cp "${BASH_SETUP_DIR}/bashrc.d/common"/*.sh "$BASH_LOCAL_DIR/"
else
    echo "Error: Source directory ${BASH_SETUP_DIR}/bashrc.d/common not found." >&2
    exit 1
fi

# Copy additional files for local computers
if [[ "$INSTALL_OPT" == "Home" || "$INSTALL_OPT" == "Work" ]]; then
    if [ -d "${BASH_SETUP_DIR}/bashrc.d/ws" ]; then
        cp "${BASH_SETUP_DIR}/bashrc.d/ws"/*.sh "$BASH_LOCAL_DIR/"
    else
        echo "Warning: Source directory ${BASH_SETUP_DIR}/bashrc.d/ws not found." >&2
    fi
fi

# Copy additional files for servers
if [[ "$INSTALL_OPT" == "Bio" ]]; then
    if [ -d "${BASH_SETUP_DIR}/bashrc.d/ws" ]; then
        cp "${BASH_SETUP_DIR}/bashrc.d/ws"/*.sh "$BASH_LOCAL_DIR/"
    else
        echo "Warning: Source directory ${BASH_SETUP_DIR}/bashrc.d/ws not found." >&2
    fi
fi

# Sort out Unique files

# Create startup directory and move files starting with "start"
mkdir -p "$BASH_LOCAL_DIR/startup"
if compgen -G "$BASH_LOCAL_DIR/start*" > /dev/null; then
    mv "$BASH_LOCAL_DIR"/start* "$BASH_LOCAL_DIR/startup/"
fi

# Backup existing .bashrc and move new one from .bashrc.d
if [ -f "$HOME/.bashrc" ]; then
    cp "$HOME/.bashrc" "$HOME/.bashrc.backup.$(date +%Y%m%d_%H%M%S)"
    echo "Existing .bashrc backed up to ~/.bashrc.backup.$(date +%Y%m%d_%H%M%S)"
fi

if [ -f "$BASH_LOCAL_DIR/.bashrc" ]; then
    mv "$BASH_LOCAL_DIR/.bashrc" "$HOME/.bashrc"
    echo ".bashrc file moved from $BASH_LOCAL_DIR to home directory"
else
    echo "Warning: .bashrc file not found in $BASH_LOCAL_DIR" >&2
fi

echo "Bash configuration files copied successfully to $BASH_LOCAL_DIR"
