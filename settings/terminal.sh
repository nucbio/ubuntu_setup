#!/bin/bash

# Make alacritty default terminal emulator
sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty
# Alacritty configuration
cp $UBUNTU_SETUP_DIR/configs/alacritty/alacritty.toml ~/.local/share/alacritty/

# Tmux configuration
cp $UBUNTU_SETUP_DIR/configs/tmux/.tmux.conf ~/

# Nvim configuration
cp -r ${UBUNTU_SETUP_DIR}/configs/nvim ~/.config
