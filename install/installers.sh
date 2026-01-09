#!/bin/bash

# printf "\n\nUPDATE-UPGRAGE\n"
sudo apt update -y && sudo apt upgrade -y

# printf "\n\nINSTALL INSTALLERS\n"
# Curl
sudo apt install -y curl 

# Git
sudo apt install -y git

# Unzip
sudo apt install -y unzip

# Flatpak
sudo apt install -y flatpak
sudo apt install -y gnome-software-plugin-flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

sudo apt install -y dconf-editor
sudo apt install -y gdebi
sudo apt install -y alien  # rpm to deb converter
