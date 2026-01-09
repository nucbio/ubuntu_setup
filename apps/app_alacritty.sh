#!/bin/bash

sudo apt install alacritty -y

# Alacritty configuration
mkdir -p ~/.config/alacritty/
cp ${UBUNTU_SETUP_DIR}/configs/alacritty/alacritty.toml ~/.config/alacritty/

# Make alacritty default terminal emulator
sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty
