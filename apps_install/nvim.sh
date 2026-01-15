#!/bin/bash

sudo snap install nvim  --classic

# Nvim configuration
#Install from github
git clone https://github.com/nucbio/nvim-config.git $HOME/.config/nvim
#cp -r ~/.local/share/ubuntu-setup/configs/nvim ~/.config/
