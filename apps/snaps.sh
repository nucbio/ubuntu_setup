#!/bin/bash
  
  sudo snap install gimp
  sudo snap install inkscape
  sudo snap install vlc

  sudo snap install code  --classic # Visual Studio Code
  sudo snap install cmake --classic
  sudo snap install alacritty --classic
  sudo snap install tmux  --classic
  sudo snap install nvim  --classic

if [[ "$INSTALL_OPT" == "Home" ]]; then
  sudo snap install gnome-chess
  sudo snap install kigo # go game
  sudo snap install newsflash
  sudo snap install audacity
fi

if [[ "$INSTALL_OPT" != "Bio-WS" ]]; then
  sudo snap install zoom-client
  sudo snap install zotero-snap
  sudo snap install obsidian --classic
  sudo snap install telegram-desktop
fi
