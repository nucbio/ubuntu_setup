#!/bin/bash

# Make alacritty default terminal emulator
sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty
# Alacritty configuration
cp ~/.local/share/ubuntu_setup/configs/alacritty/alacritty.toml ~/.local/share/alacritty/

# Tmux configuration
cp ~/.local/share/ubuntu_setup/configs/tmux/.tmux.conf ~/

# Nvim configuration
cp -r ~/.local/share/ubuntu_setup/configs/nvim ~/.config
